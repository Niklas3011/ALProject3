codeunit 123456748 PSFT
{
    TableNo = PSFT; // Ensure this corresponds to your PSFT table ID

    trigger OnRun()
    var
        recGrund: Record DimensionGrund;
        recZeit: Record DimensionZeit;
        recMitarbeiter: Record DimensionMitarbeiter;
        recWochentag: Record DimensionWochentag;
        recPSFT: Record PSFT;
        recAbsence: Record "Employee Absence";
        Abwesenheitstage_data: Integer;
        KrankeMontage_data: Integer;
        Year: Integer;
        Month: Integer;
        NewDate: Date;
        EndDate: Date;
        MonthText: Text;
        YearText: Text;
        DayOfWeek: Integer;
        Calendar: Record "Base Calendar Change";
        base: Record "Base Calendar";
        custom: Record "Customized Calendar Change";
        IsNonWorkingDay: Boolean;
        CU7600: Codeunit "Calendar Management";
        CompanyInformation: Record "Company Information";
    begin
        recPSFT.DeleteAll();
        CompanyInformation.get();
        CU7600.SetSource(CompanyInformation, custom);
        if recZeit.FindFirst() then begin
            repeat
                if recGrund.FindFirst() then begin
                    repeat
                        if recMitarbeiter.FindFirst() then begin
                            repeat
                                if recWochentag.FindFirst() then begin
                                    repeat
                                        recPSFT.Init();
                                        recPSFT.Grund_ID := recGrund.Grund_ID;
                                        recPSFT.Mitarbeiter_ID := recMitarbeiter.Mitarbeiter_ID;
                                        recPSFT.Monat_Jahr_ID := recZeit.Monat_Jahr_ID;
                                        recPSFT.Wochentag_ID := recWochentag.Wochentag_ID;
                                        recPSFT.Insert();
                                    until recWochentag.Next() = 0;
                                end;
                            until recMitarbeiter.Next() = 0;
                        end;
                    until recGrund.Next() = 0;
                end;
            until recZeit.Next() = 0;
        end;
        base.Get('DE'); // Ensure 'DE' corresponds to the correct base calendar code

        if recPSFT.FindSet() then begin
            repeat
                // Calculate facts
                recAbsence.SetFilter("Employee No.", recPSFT.Mitarbeiter_ID);
                recAbsence.SetFilter("Cause of Absence Code", recPSFT.Grund_ID);

                // Determine the period
                MonthText := COPYSTR(recPSFT.Monat_Jahr_ID, 1, STRPOS(recPSFT.Monat_Jahr_ID, '/') - 1);
                YearText := COPYSTR(recPSFT.Monat_Jahr_ID, STRPOS(recPSFT.Monat_Jahr_ID, '/') + 1);

                // Convert text to date
                EVALUATE(Month, MonthText);
                EVALUATE(Year, YearText);
                NewDate := DMY2Date(1, Month, Year);
                EndDate := CALCDATE('<+1M-1D>', NewDate);

                recAbsence.SETRANGE("From Date", NewDate, EndDate);
                Abwesenheitstage_data := 0;
                KrankeMontage_data := 0;

                if recAbsence.FindSet() then begin
                    repeat
                        DayOfWeek := Date2DWY(recAbsence."From Date", 1);
                        if DayOfWeek = recPSFT.Wochentag_ID then begin

                            if not CU7600.IsNonworkingDay(recAbsence."From Date", custom) then begin
                                Abwesenheitstage_data += 1;
                                if recPSFT.Wochentag_ID = 1 then begin
                                    if recPSFT.Grund_ID = 'KRANK' then begin
                                        KrankeMontage_data += 1;
                                    end;

                                end;
                            end;
                        end;
                    until recAbsence.Next() = 0;
                end;
                recPSFT.Abwesenheitstage := Abwesenheitstage_data;
                recPSFT.KrankeMontage := KrankeMontage_data;
                if not recPSFT.Modify() then
                    Error('Update failed for PSFT');
            until recPSFT.Next() = 0;
        end;

    end;
}

