table 123456746 Bericht
{
    Caption = 'Bericht';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; GrundID; Text[12])
        {
            Caption = 'GrundID';
        }
        field(2; MonatJahrID; Text[10])
        {
            Caption = 'MonatJahrID';
        }
        field(3; Jahr; Integer)
        {
            Caption = 'Jahr';
        }
        field(4; Monat; Text[20])
        {
            Caption = 'Monat';
        }
        field(5; Abteilung; Text[20])
        {
            Caption = 'Abteilung';
        }
        field(6; ArbeitstageMontags; Integer)
        {
            Caption = 'ArbeitstageMontags';
        }
        field(7; KrankheitstageMontag; Integer)
        {
            Caption = 'KrankheitstageMontag';
        }
        field(8; KrankenstandMontag; Integer)
        {
            Caption = 'KrankenstandMontag';
        }
        field(9; ID; Integer)
        {
            Caption = 'ID';
        }
    }
    keys
    {
        key(PK; GrundID, MonatJahrID, ID)
        {
            Clustered = true;
        }
    }
}
