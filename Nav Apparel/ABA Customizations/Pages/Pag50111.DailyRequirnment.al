page 50111 "Daily Requirement"
{
    Caption = 'Daily Requirnment';
    PageType = ListPart;
    SourceTable = "Item Journal Line";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = Suite;
    LinksAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Order No."; Rec."Order No.")
                {
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
            }
        }
    }
}
