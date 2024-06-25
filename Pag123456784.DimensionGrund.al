namespace ALProject.ALProject;

page 123456740 DimensionGrund
{
    ApplicationArea = All;
    Caption = 'DimensionGrund';
    PageType = List;
    SourceTable = DimensionGrund;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Grund_ID; Rec.Grund_ID)
                {
                    ToolTip = 'Specifies the value of the Grund_ID field.';
                }
                field(Grund; Rec.Grund)
                {
                    ToolTip = 'Specifies the value of the Grund field.';
                }
            }
        }
    }

    var
        cou1: Codeunit DimensionGrund;

    trigger OnOpenPage()
    begin
        cou1.Run(Rec)
    end;
}
