namespace ALProject.ALProject;

page 123456741 DimensionWochentag
{
    ApplicationArea = All;
    Caption = 'DimensionWochentag';
    PageType = List;
    SourceTable = DimensionWochentag;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Wochentag_ID; Rec.Wochentag_ID)
                {
                    ToolTip = 'Specifies the value of the Wochentag_ID field.';
                }
                field(Wochentag; Rec.Wochentag)
                {
                    ToolTip = 'Specifies the value of the Wochentag field.';
                }
            }
        }
    }

    var
        cou1: Codeunit DimensionWochentag;

    trigger OnOpenPage()
    begin
        cou1.Run(Rec)
    end;
}
