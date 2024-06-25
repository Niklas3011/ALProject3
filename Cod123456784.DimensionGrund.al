namespace ALProject.ALProject;

using Microsoft.HumanResources.Absence;

codeunit 123456740 DimensionGrund
{
    TableNo = DimensionGrund;

    trigger OnRun()
    var
        dimGrund: Record DimensionGrund;
        recAbsence: Record "Cause of Absence";
        PK: Integer;
    begin
        dimGrund.DeleteAll();
        PK := 1;
        if recAbsence.FindFirst() then
            repeat
                dimGrund.Grund := recAbsence.Description;
                dimGrund.Grund_ID := PK;
                PK += 1;
                if not dimGrund.INSERT then
                    Message('Insert funktioniert nicht');
            until dimGrund.NEXT = 0;
    end;

}
