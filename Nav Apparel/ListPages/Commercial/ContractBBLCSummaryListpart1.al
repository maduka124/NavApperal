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
                field("Beneficiary Name"; Rec."Beneficiary Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field("B2B LC No"; Rec."B2B LC No")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Value"; Rec."B2B LC Value")
                {
                    ApplicationArea = All;
                }

                field("Opening Date"; Rec."Opening Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}