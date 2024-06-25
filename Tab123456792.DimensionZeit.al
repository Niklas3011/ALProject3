table 123456742 DimensionZeit
{
    Caption = 'DimensionZeit';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Monat_Jahr_ID; Text[10])
        {
            Caption = 'Monat_Jahr_ID';
        }
        field(2; Monat; Integer)
        {
            Caption = 'Monat';
        }
        field(3; Jahr; Integer)
        {
            Caption = 'Jahr';
        }
    }
    keys
    {
        key(PK; Monat_Jahr_ID)
        {
            Clustered = true;
        }
    }
}
