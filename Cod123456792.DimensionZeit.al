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
        Start := DMY2Date(1, 1, 2020);
        Ende := DMY2Date(31, 12, 2025);
        dateRec.Init();
        dateRec.SetRange("Period Type", dateRec."Period Type"::Month);
        dateRec.SetRange("Period Start", Start, Ende);


        if dateRec.FindSet() then begin
            repeat
                dimRec.INIT;

                Year := DATE2DMY(dateRec."Period Start", 3);
                Month := Date2DMY(dateRec."Period Start", 2);

                ConcatenatedText := FORMAT(Month) + '/' + FORMAT(Year);

                dimRec.Monat_Jahr_ID := ConcatenatedText;
                dimRec.Jahr := Year;
                dimRec.Monat := Month;

                if not dimRec.Insert() then
                    Message('Insert funktioniert nicht');
            until dateRec.Next() = 0;
        end
    end;

}
