page 50652 WashingMachineTypeCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = WashingMachineType;
    Caption = 'Machine Type Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(code; rec.code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}