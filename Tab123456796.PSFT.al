table 123456748 PSFT
{
    Caption = 'PSFT';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Monat_Jahr_ID; Text[10])
        {
            Caption = 'Monat_Jahr_ID';
            DataClassification = ToBeClassified;
            TableRelation = DimensionZeit.Monat_Jahr_ID;
        }
        field(2; Grund_ID; Text[12])
        {
            Caption = 'GrundID';
            DataClassification = ToBeClassified;
            TableRelation = DimensionGrund.Grund_ID;
        }
        field(3; Mitarbeiter_ID; Code[20])
        {
            Caption = 'MitarbeiterID';
            DataClassification = ToBeClassified;
            TableRelation = DimensionMitarbeiter.Mitarbeiter_ID;
        }
        field(4; Wochentag_ID; Integer)
        {
            Caption = 'WochentagID';
            DataClassification = ToBeClassified;
            TableRelation = DimensionWochentag.Wochentag_ID;
        }
        field(6; Abwesenheitstage; Integer)
        {
            Caption = 'Abwesenheitstage';
            DataClassification = ToBeClassified;
        }
        field(7; KrankeMontage; Integer)
        {
            Caption = 'KrankeMontage';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Monat_Jahr_ID, Grund_ID, Mitarbeiter_ID, Wochentag_ID)
        {
            Clustered = true;
        }
    }
}
