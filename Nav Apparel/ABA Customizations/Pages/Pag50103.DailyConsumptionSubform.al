page 50103 "Daily Consumption Subform"
{
    Caption = 'Daily Consumption Subform';
    PageType = ListPart;
    SourceTable = "Daily Consumption Line";
    InsertAllowed = false;
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Order Quantity"; Rec."Order Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Issued Quantity"; Rec."Issued Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Balance Quantity"; Rec."Balance Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Daily Consumption"; Rec."Daily Consumption")
                {
                    ApplicationArea = All;
                    Caption = 'Required Quantity';
                }
            }
        }
    }
}
