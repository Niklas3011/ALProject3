namespace ALProject.ALProject;

page 123456743 PSFT
{
    ApplicationArea = All;
    Caption = 'PSFT';
    PageType = List;
    SourceTable = PSFT;

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
                field(Mitarbeiter_ID; Rec.Mitarbeiter_ID)
                {
                    ToolTip = 'Specifies the value of the MitarbeiterID field.';
                }
                field(Grund_ID; Rec.Grund_ID)
                {
                    ToolTip = 'Specifies the value of the GrundID field.';
                }
                field(Wochentag_ID; Rec.Wochentag_ID)
                {
                    ToolTip = 'Specifies the value of the WochentagID field.';
                }
                field(Kranke_Montage; Rec.Kranke_Montage)
                {
                    ToolTip = 'Jebote';
                }
                field(Kranke_Tage; Rec.Kranke_Tage)
                {
                    ToolTip = 'blyat';
                }
            }
        }
    }

    var
        cou1: Codeunit PSFT;

    trigger OnOpenPage()
    begin
        cou1.Run(Rec)
    end;
}
