namespace ALProject.ALProject;

page 123456746 Bericht
{
    ApplicationArea = All;
    Caption = 'Bericht';
    PageType = Card;
    SourceTable = Bericht;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Abteilung; Rec.Abteilung)
                {
                    ToolTip = 'Specifies the value of the Abteilung field.';
                }
                field(Grund; Rec.GrundID)
                {
                    ToolTip = 'Specifies the value of the Grund field.';
                }
                field(Jahr; Rec.Jahr)
                {
                    ToolTip = 'Specifies the value of the Jahr field.';
                }
                field(Monat; Rec.Monat)
                {
                    ToolTip = 'Specifies the value of the Monat field.';
                }
                field(ArbeitstageMontags; Rec.ArbeitstageMontags)
                {
                    ToolTip = 'Specifies the value of the ArbeitstageMontags field.';
                }
                field(KrankeTageAmMontag; Rec.KrankheitstageMontag)
                {
                    ToolTip = 'Specifies the value of the KrankheitstageMontag field.';
                }
                field(KrankenstandMontag; Rec.KrankenstandMontag)
                {
                    ToolTip = 'Specifies the value of the KrankenstandMontag field.';
                }
            }
        }
    }
    var
        cou1: Codeunit Bericht;

    trigger OnOpenPage()
    begin
        cou1.Run(Rec)
    end;
}
