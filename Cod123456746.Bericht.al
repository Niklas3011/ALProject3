namespace ALProject.ALProject;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.Calendar;

codeunit 123456746 Bericht
{
    TableNo = 123456746; // Ensure this matches your table number

    trigger OnRun()

    var
        recBericht: Record Bericht;
        recPSFT: Record PSFT;
        recMitarbeiter: Record DimensionMitarbeiter;
        MonthText: Text;
        YearText: Text;
        Year: Integer;
        Month: Integer;
        recDimMitarbeiter: Record DimensionMitarbeiter;
        filteredMitarbeiter: List of [Code[20]];
        filterString: Text;
        EmployeeID: Code[20];
        TempAggregatedBericht: Record Bericht temporary;
        IsFound: Boolean;
        CompanyInformation: Record "Company Information";
        CU7600: Codeunit "Calendar Management";
        custom: Record "Customized Calendar Change";
        StartDate: Date;
        EndDate: Date;
        Workingdays: Integer;
        CurrentDate: Date;
        DayOfWeek: Integer;
        IsNonWorkingDay: Boolean;
        krankenstandDecimal: Decimal;

    begin
        recBericht.DeleteAll();
        CompanyInformation.get();
        CU7600.SetSource(CompanyInformation, custom);

        // Mitarbeiter rausfiltern die PROD angehören
        recDimMitarbeiter.SetFilter(Abteilung, 'PROD');
        if recDimMitarbeiter.FindSet() then
            repeat
                filteredMitarbeiter.Add(recDimMitarbeiter.Mitarbeiter_ID);
            until recDimMitarbeiter.Next() = 0;

        // Ensure filteredMitarbeiter is not empty
        if filteredMitarbeiter.Count() = 0 then
            exit;

        // Filterstring erstellen
        filterString := '';
        foreach EmployeeID in filteredMitarbeiter do begin
            if filterString <> '' then
                filterString := filterString + '|';
            filterString := filterString + EmployeeID;
        end;

        recPSFT.SetFilter(Mitarbeiter_ID, filterString);

        // Alle Datensätze welche zu dem Filter passen
        if recPSFT.FindSet() then begin
            repeat
                // Get the month and year
                recBericht.Init();
                MonthText := COPYSTR(recPSFT.Monat_Jahr_ID, 1, STRPOS(recPSFT.Monat_Jahr_ID, '/') - 1);
                YearText := COPYSTR(recPSFT.Monat_Jahr_ID, STRPOS(recPSFT.Monat_Jahr_ID, '/') + 1);
                EVALUATE(Year, YearText);
                Evaluate(Month, MonthText);

                //Aus dem Calendar die Soll Arbeitstage für den Montag rausziehen
                //1/2022 

                Workingdays := 0;
                StartDate := DMY2Date(1, Month, Year);
                EndDate := CALCDATE('<+1M-1D>', StartDate);
                CurrentDate := StartDate;

                while CurrentDate <= EndDate do begin
                    DayOfWeek := DATE2DWY(CurrentDate, 1);

                    // Check if the day is Monday (Monday is represented by 1)
                    if DayOfWeek = 1 then begin
                        // Check if it's a working day
                        IsNonWorkingDay := CU7600.IsNonWorkingDay(CurrentDate, custom);
                        if not IsNonWorkingDay then begin
                            Workingdays := Workingdays + 1;
                        end;
                    end;

                    // Move to the next day
                    CurrentDate := CurrentDate + 1;
                end;
                IsFound := recBericht.Get(recPSFT.Grund_ID, recPSFT.Monat_Jahr_ID, 'PROD');
                if IsFound then begin
                    recBericht.KrankeMontage += recPSFT.KrankeMontage;
                    recBericht.Modify();
                end else begin
                    recBericht.GrundID := recPSFT.Grund_ID;
                    recBericht.MonatJahrID := recPSFT.Monat_Jahr_ID; // Ensure this is set
                    recBericht.Jahr := Year;
                    recBericht.Monat := MonthText;
                    recBericht.Abteilung := 'PROD';
                    recBericht.KrankeMontage := recPSFT.KrankeMontage;
                    recBericht.ArbeitstageMontags := Workingdays;
                    recBericht.KrankeMontage := 3;
                    recBericht.Insert();
                end;
            until recPSFT.Next() = 0;
        end;
        recBericht.Reset();
        if recBericht.FindSet() then begin
            repeat
                krankenstandDecimal := (recBericht.KrankeMontage / recBericht.ArbeitstageMontags) * 100;
                recBericht.KrankenstandMontag := FORMAT(krankenstandDecimal, 2) + '%';
                recBericht.Modify();
            until recBericht.Next() = 0;
        end;
    end;
}