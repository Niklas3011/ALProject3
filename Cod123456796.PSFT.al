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
        recMitarbeiter: Record Dimension_Mitarbeiter;
        recWochentag: Record DimensionWochentag;
        recPSFT: Record PSFT;
        recAbsence: Record "Employee Absence";
        recDate: Record Date;
        krankeMontage: Integer;
        krankeTage: Integer;
        Year: Integer;
        Month: Integer;
        NewDate: Date;
        ConcatenatedText: Text;
        MonthText: Text;
        YearText: Text;
        checkDay: Boolean;
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

        if recPSFT.FindFirst() then begin
            repeat
                //Fakten berechnen
                recAbsence.SETRANGE("Employee No.", recPSFT.Mitarbeiter_ID);
                recAbsence.SETRANGE("Cause of Absence Code", 'KRANK');

                //Get the Date from the Key
                MonthText := COPYSTR(recPSFT.Monat_Jahr_ID, 1, 2);
                YearText := COPYSTR(recPSFT.Monat_Jahr_ID, 3);
                EVALUATE(Month, MonthText);
                EVALUATE(Year, YearText);
                NewDate := DMY2Date(1, Month, Year);
                recAbsence.SETRANGE("From Date", NewDate);


                if recAbsence.FindFirst() then begin
                    repeat
                        //Kranke Tage berechnen
                        krankeTage += recAbsence.Quantity;

                        //Kranke Montage berechnen
                        recDate.SETRANGE("Period Start", recAbsence."From Date");
                        if recDate.FindFirst() then begin
                            if recDate."Period Name" = 'Montag' then begin
                                krankeMontage += 1;
                            end
                        end;
                    until recAbsence.Next() = 0;
                end;

                //Fakten eintragen
                recPSFT.Kranke_Montage := krankeMontage;
                recPSFT.Kranke_Tage := krankeTage;
            until recPSFT.Next() = 0;
        end;
    end;

}
