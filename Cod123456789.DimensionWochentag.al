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

    begin
        dimRec.DeleteAll();
        Start := 20240623D;
        Ende := 20190101D;
        dateRec.SetRange("Period Start", Start, Ende); // Filter for dates after 02.2023

        if dateRec.FindSet() then begin
            repeat
                // Process each record
                dimRec.INIT;
                dimRec.Wochentag := dateRec."Period Name"; // Replace 'EntryDate' with actual field name from 'Date' table

                // Assign other fields as needed
                dimRec.INSERT(true);
            until dateRec.NEXT = 0;
        end;
    end;
}
