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
                dimGrund.Init(); // Initialize the record variable
                dimGrund.Grund := recAbsence.Description;
                dimGrund.Grund_ID := PK;
                if not dimGrund.Insert() then
                    Message('Insert funktioniert nicht'); // Display error message if insert fails
                PK += 1; // Increment primary key

            until recAbsence.Next() = 0; // Move to the next record in Cause of Absence
        end;
    end;

}
