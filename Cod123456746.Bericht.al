namespace ALProject.ALProject;

codeunit 123456746 Bericht
{
    TableNo = Bericht;

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
        first: Boolean;
        EmployeeID: Code[20];
        primary: Integer;

    begin
        recBericht.DeleteAll();
        primary := 1;


        //Mitarbeiter rausfiltern die PROD angehören
        recDimMitarbeiter.SetFilter(Abteilung, 'PROD');
        if recDimMitarbeiter.FindSet() then
            repeat
                filteredMitarbeiter.Add(recDimMitarbeiter.Mitarbeiter_ID);
            until recDimMitarbeiter.Next() = 0;

        //Filterstring erstellen
        filterString := '';
        first := true;

        foreach EmployeeID in filteredMitarbeiter do begin
            if filterString <> '' then
                filterString := filterString + '|';
            filterString := filterString + EmployeeID;
        end;

        recPSFT.SetFilter(Mitarbeiter_ID, filterString);

        //Alle Datensätze welche zu dem Filter passen
        if recPSFT.FindSet() then begin
            repeat
                recBericht.Init();

                //Get The Month
                MonthText := COPYSTR(recPSFT.Monat_Jahr_ID, 1, STRPOS(recPSFT.Monat_Jahr_ID, '/') - 1);
                YearText := COPYSTR(recPSFT.Monat_Jahr_ID, STRPOS(recPSFT.Monat_Jahr_ID, '/') + 1);
                EVALUATE(Year, YearText);

                //Insert Values
                recBericht.Jahr := Year;
                recBericht.MonatJahrID := recPSFT.Monat_Jahr_ID;
                recBericht.Monat := MonthText;
                recBericht.Abteilung := 'PROD';
                recBericht.GrundID := recPSFT.Grund_ID;
                recBericht.ID := primary;
                primary += 1;
                recBericht.Insert()

            until recPSFT.Next() = 0;
        end;
    end;
}
