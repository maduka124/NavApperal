page 50793 "ContractBBLC Summary ListPart1"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "B2BLCMaster";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Beneficiary Name"; "Beneficiary Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field("B2B LC No"; "B2B LC No")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Value"; "B2B LC Value")
                {
                    ApplicationArea = All;
                }

                field("Opening Date"; "Opening Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; "Expiry Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}