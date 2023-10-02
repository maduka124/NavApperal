page 51399 "Cheque Printed"
{
    ApplicationArea = All;
    Caption = 'Cheque Printed';
    PageType = List;
    SourceTable = "Gen. Journal Line";
    UsageCategory = Lists;
    SourceTableView = sorting("Document No.");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Cheque printed"; Rec."Cheque printed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}
