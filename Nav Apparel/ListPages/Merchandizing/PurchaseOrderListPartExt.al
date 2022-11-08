pageextension 71012832 PurchaseOrderListExt extends "Purchase Order Subform"
{
    layout
    {
        modify("Location Code")
        {
            ShowMandatory = true;
        }

        addafter(Description)
        {
            field("Buyer Name"; "Buyer Name")
            {
                ApplicationArea = all;
                Caption = 'Buyer';

                trigger OnValidate()
                var
                    BuyerRec: Record Customer;
                begin
                    BuyerRec.Reset();
                    BuyerRec.SetRange(Name, "Buyer Name");
                    if BuyerRec.FindSet() then
                        "Buyer No." := BuyerRec."No.";
                end;
            }

            field(StyleName; StyleName)
            {
                ApplicationArea = all;
                Caption = 'Style';
            }
        }
    }
}