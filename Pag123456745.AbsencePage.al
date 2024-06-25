namespace ALProject.ALProject;

using Microsoft.HumanResources.Absence;

page 123456745 AbsencePage
{
    ApplicationArea = All;
    Caption = 'AbsencePage';
    PageType = List;
    SourceTable = "Employee Absence";
    UsageCategory = None;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ToolTip = 'Specifies a cause of absence code to define the type of absence.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the absence.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies a number for the employee.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("From Date"; Rec."From Date")
                {
                    ToolTip = 'Specifies the first day of the employee''s absence registered on this line.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity associated with absences, in hours or days.';
                }
                field("To Date"; Rec."To Date")
                {
                    ToolTip = 'Specifies the last day of the employee''s absence registered on this line.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
            }
        }
    }
}
