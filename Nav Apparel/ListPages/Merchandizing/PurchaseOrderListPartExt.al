pageextension 71012832 PurchaseOrderListExt extends "Purchase Order Subform"
{
    layout
    {
        // modify(Control1)
        // {
        //     Editable = EditableGB;
        // }

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
                Editable = EditableGB;

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
                Editable = EditableGB;
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    var
        PurchaseOrderRec: Record "Purchase Header";
    begin
        PurchaseOrderRec.get("Document Type", "Document No.");

        if PurchaseOrderRec.Status = PurchaseOrderRec.Status::Released then
            EditableGb := false
        else
            EditableGb := true;
    end;

    var
        EditableGB: Boolean;
}