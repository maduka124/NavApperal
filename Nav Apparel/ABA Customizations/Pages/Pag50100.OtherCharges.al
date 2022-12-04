page 50100 "Other Charges"
{
    Caption = 'Other Charges';
    PageType = ListPart;
    SourceTable = "Other Charges";
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Charge No."; Rec."Item Charge No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}
