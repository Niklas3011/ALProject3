namespace ALProject.ALProject;

page 123456742 DimensionZeit
{
    ApplicationArea = All;
    Caption = 'DimensionZeit';
    PageType = List;
    SourceTable = DimensionZeit;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Monat_Jahr_ID; Rec.Monat_Jahr_ID)
                {
                    ToolTip = 'Specifies the value of the Monat_Jahr_ID field.';
                }
                field(Monat; Rec.Monat)
                {
                    ToolTip = 'Specifies the value of the Monat field.';
                }
                field(Jahr; Rec.Jahr)
                {
                    ToolTip = 'Specifies the value of the Jahr field.';
                }
            }
        }
    }

    var
        cou1: Codeunit DimensionZeit;

    trigger OnOpenPage()
    begin
        cou1.Run(Rec)
    end;
}
