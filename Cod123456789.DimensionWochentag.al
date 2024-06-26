namespace ALProject.ALProject;
using System.Utilities;

codeunit 123456741 DimensionWochentag
{
    TableNo = DimensionWochentag;

    trigger OnRun()
    var
        dimRec: Record DimensionWochentag;
        dateRec: Record Date;
        Start: Date;
        Ende: Date;
        PK: Integer;

    begin
        dimRec.DeleteAll();
        dateRec.Init();
        dateRec.SetRange("Period Start", DMY2Date(30, 12, 2019), DMY2Date(3, 1, 2020));
        PK := 1;
        if dateRec.FindFirst() then begin
            repeat
                dimRec.Init();
                dimRec.Wochentag := dateRec."Period Name";
                dimRec.Wochentag_ID := PK;
                PK += 1;
                if not dimRec.Insert() then
                    Message('Insert funktioniert nicht');
                if dimRec.Wochentag = 'Freitag' then
                    exit;
            until dateRec.Next() = 0;
        end;
    end;
}
