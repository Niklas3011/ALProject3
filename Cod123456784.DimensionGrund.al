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
        if recAbsence.FindSet() then begin
            repeat
                dimGrund.Init();
                dimGrund.Grund := recAbsence.Description;
                dimGrund.Grund_ID := recAbsence.Code;
                if not dimGrund.Insert() then
                    Message('Insert funktioniert nicht');
                PK += 1;

            until recAbsence.Next() = 0;
        end;
    end;

}
