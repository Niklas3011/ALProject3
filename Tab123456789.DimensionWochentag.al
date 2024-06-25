table 123456741 DimensionWochentag
{
    Caption = 'DimensionWochentag';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Wochentag_ID; Code[1])
        {
            Caption = 'Wochentag_ID';
        }
        field(2; Wochentag; Text[20])
        {
            Caption = 'Wochentag';
        }
    }
    keys
    {
        key(PK; Wochentag_ID)
        {
            Clustered = true;
        }
    }
}
