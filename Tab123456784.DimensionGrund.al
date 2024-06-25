table 123456740 DimensionGrund
{
    Caption = 'DimensionGrund';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Grund_ID; Integer)
        {
            Caption = 'Grund_ID';
        }
        field(2; Grund; Text[12])
        {
            Caption = 'Grund';
        }
    }
    keys
    {
        key(PK; Grund_ID)
        {
            Clustered = true;
        }
    }
}
