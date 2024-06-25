table 123456743 PSFT
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
        field(2; Grund_ID; Integer)
        {
            Caption = 'GrundID';
            DataClassification = ToBeClassified;
            TableRelation = DimensionGrund.Grund_ID;
        }
        field(3; Mitarbeiter_ID; Code[20])
        {
            Caption = 'MitarbeiterID';
            DataClassification = ToBeClassified;
            TableRelation = Dimension_Mitarbeiter.Mitarbeiter_ID;
        }
        field(4; Wochentag_ID; Code[10])
        {
            Caption = 'WochentagID';
            DataClassification = ToBeClassified;
            TableRelation = DimensionWochentag.Wochentag_ID;
        }
        field(5; Kranke_Tage; Integer)
        {
            Caption = 'Kranke_Tage';
            DataClassification = ToBeClassified;
        }
        field(6; Kranke_Montage; Integer)
        {
            Caption = 'Kranke_Montage';
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
