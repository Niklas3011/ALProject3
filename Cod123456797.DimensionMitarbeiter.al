namespace ALProject.ALProject;
using Microsoft.HumanResources.Employee;

codeunit 123456744 DimensionMitarbeiter
{
    TableNo = Dimension_Mitarbeiter;

    trigger OnRun()
    begin
        dimRec.DeleteAll();
        if empRec.FindFirst() then
            repeat
                dimRec.Mitarbeiter_ID := empRec."No.";
                dimRec.Nachname := empRec."Last Name";
                dimRec.Vorname := empRec."First Name";
                dimRec.Abteilung := empRec."Global Dimension 1 Code";

                if not dimRec.INSERT then
                    Message('Insert funktioniert nicht');

            until empRec.NEXT = 0;

    end;

    var
        empRec: Record Employee;
        dimRec: Record Dimension_Mitarbeiter;
}
