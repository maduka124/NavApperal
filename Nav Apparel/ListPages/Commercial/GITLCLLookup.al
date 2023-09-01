page 51409 "GIT Baseon LC Lookup"
{
    PageType = List;
    SourceTable = GITBaseonLC;
    SourceTableView = sorting("B2B LC No.", "ContractLC No") order(ascending);
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("ContractLC No"; Rec."ContractLC No")
                {
                    ApplicationArea = All;
                }

                field("B2B LC No."; Rec."B2B LC No.")
                {
                    ApplicationArea = All;
                    Caption = 'B2B LC No';
                }

                field("B2B LC Value"; Rec."B2B LC Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}