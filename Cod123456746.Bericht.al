namespace ALProject.ALProject;

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
        recDimMitarbeiter: Record DimensionMitarbeiter;
        filteredMitarbeiter: List of [Code[20]];
        filterString: Text;
        EmployeeID: Code[20];
        TempAggregatedBericht: Record Bericht temporary;
        IsFound: Boolean;

    begin
        recBericht.DeleteAll();

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

                IsFound := recBericht.Get(recPSFT.Grund_ID, recPSFT.Monat_Jahr_ID, 'PROD');
                if IsFound then begin
                    recBericht.KrankheitstageMontag += recPSFT.Abwesenheitstage;
                    recBericht.Modify();
                end else begin
                    recBericht.GrundID := recPSFT.Grund_ID;
                    recBericht.MonatJahrID := recPSFT.Monat_Jahr_ID; // Ensure this is set
                    recBericht.Jahr := Year;
                    recBericht.Monat := MonthText;
                    recBericht.Abteilung := 'PROD';
                    recBericht.KrankheitstageMontag := recPSFT.Abwesenheitstage;
                    recBericht.Insert();
                end;
            until recPSFT.Next() = 0;
        end;
    end;
}