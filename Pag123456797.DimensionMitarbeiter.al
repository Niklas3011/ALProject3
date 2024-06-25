namespace ALProject.ALProject;

page 123456744 DimensionMitarbeiter
{
    ApplicationArea = All;
    Caption = 'DimensionMitarbeiter';
    PageType = List;
    SourceTable = DimensionMitarbeiter;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Mitarbeiter_ID; Rec.Mitarbeiter_ID)
                {
                    ToolTip = 'Specifies the value of the Mitarbeiter_ID field.';
                }
                field(Vorname; Rec.Vorname)
                {
                    ToolTip = 'Specifies the value of the Vorname field.';
                }
                field(Nachname; Rec.Nachname)
                {
                    ToolTip = 'Specifies the value of the Nachname field.';
                }
                field(Abteilung; Rec.Abteilung)
                {
                    ToolTip = 'Specifies the value of the Abteilung field.';
                }
            }
        }
    }

    var
        cou1: Codeunit DimensionMitarbeiter;

    trigger OnOpenPage()
    begin
        cou1.Run(Rec)
    end;
}
