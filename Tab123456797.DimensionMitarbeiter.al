namespace ALProject.ALProject;

table 123456744 DimensionMitarbeiter
{
    Caption = 'DimensionMitarbeiter';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Mitarbeiter_ID; Code[20])
        {
            Caption = 'Mitarbeiter_ID';
        }
        field(2; Vorname; Text[20])
        {
            Caption = 'Vorname';
        }
        field(3; Nachname; Text[20])
        {
            Caption = 'Nachname';
        }
        field(4; Abteilung; Text[20])
        {
            Caption = 'Abteilung';
        }
    }
    keys
    {
        key(PK; Mitarbeiter_ID)
        {
            Clustered = true;
        }
    }
}
