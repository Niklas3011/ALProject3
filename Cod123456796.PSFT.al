namespace ALProject.ALProject;
using Microsoft.HumanResources.Absence;
using System.Utilities;

codeunit 123456743 PSFT
{
    TableNo = PSFT;

    trigger OnRun()

    var
        recGrund: Record DimensionGrund;
        recZeit: Record DimensionZeit;
        recMitarbeiter: Record DimensionMitarbeiter;
        recWochentag: Record DimensionWochentag;
        recPSFT: Record PSFT;
        recAbsence: Record "Employee Absence";
        recDate: Record Date;
        Abwesenheitstage_data: Integer;
        Year: Integer;
        Month: Integer;
        NewDate: Date;
        EndDate: Date;
        MonthText: Text;
        YearText: Text;
        FirstOfMonth: Date;
        LastOfMonth: Date;
        DayOfWeek: Integer;
    begin
        recPSFT.DeleteAll();
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

        if recPSFT.FindSet() then begin
            repeat
                //Fakten berechnen
                recAbsence.Init();
                recAbsence.SetFilter("Employee No.", recPSFT.Mitarbeiter_ID);
                recAbsence.SetFilter("Cause of Absence Code", recPSFT.Grund_ID);

                //Zeitraum bestimmen
                MonthText := COPYSTR(recPSFT.Monat_Jahr_ID, 1, STRPOS(recPSFT.Monat_Jahr_ID, '/') - 1);
                YearText := COPYSTR(recPSFT.Monat_Jahr_ID, STRPOS(recPSFT.Monat_Jahr_ID, '/') + 1);

                //Get the Date from the Key
                EVALUATE(Month, MonthText);
                EVALUATE(Year, YearText);
                NewDate := DMY2Date(1, Month, Year);
                EndDate := CALCDATE('<+1M-1D>', NewDate);

                recAbsence.SETRANGE("From Date", NewDate, EndDate);
                Abwesenheitstage_data := 0;


                if recAbsence.FindSet() then begin
                    repeat
                        DayOfWeek := Date2DWY(recAbsence."From Date", 1);
                        if DayOfWeek = recPSFT.Wochentag_ID then
                            Abwesenheitstage_data += 1;
                    until recAbsence.Next() = 0;
                end;
                recPSFT.Abwesenheitstage := Abwesenheitstage_data;

                if not recPSFT.Modify() then
                    Error('Update failed for PSFT');
            //Fakten eintragen
            until recPSFT.Next() = 0;
        end;
    end;
}