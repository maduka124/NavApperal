page 51180 AwaitingPiforB2BLC
{
    PageType = ListPart;
    SourceTable = AwaitingPIs;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                }

                field("PI No"; Rec."PI No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("PI No New"; Rec."PI No New")
                {
                    ApplicationArea = All;
                    Caption = 'PI No';
                }

                field("PI Date"; Rec."PI Date")
                {
                    ApplicationArea = All;
                }

                field("PI Value"; Rec."PI Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}