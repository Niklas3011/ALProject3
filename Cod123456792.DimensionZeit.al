namespace ALProject.ALProject;
using System.Utilities;

codeunit 123456742 DimensionZeit
{
    TableNo = DimensionZeit;

    trigger OnRun()
    var
        dateRec: Record Date;
        dimRec: Record DimensionZeit;
        Start: Date;
        Ende: Date;
        Month: Integer;
        Year: Integer;
        ConcatenatedText: Text;
    begin
        dimRec.DeleteAll();
        Start := 20240623D;
        Ende := 20190101D;
        dateRec.SetRange("Period Start", Start, Ende);

        if dateRec.FindSet() then begin
            repeat
                dimRec.INIT;

                Year := DATE2DMY(dateRec."Period Start", 3);
                Month := Date2DMY(dateRec."Period Start", 2);

                ConcatenatedText := FORMAT(Month) + FORMAT(Year);

                dimRec.Monat_Jahr_ID := ConcatenatedText;
                dimRec.Jahr := Year;
                dimRec.Monat := Month;

                dimRec.INSERT(true);
            until dateRec.NEXT = 0;
        end
    end;

}
