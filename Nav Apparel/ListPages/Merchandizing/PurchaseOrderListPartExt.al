pageextension 71012832 PurchaseOrderListExt extends "Purchase Order Subform"
{
    layout
    {
        modify("No.")
        {
            Editable = EditableGB;
        }

        modify(Type)
        {
            Caption = 'Type';
            Editable = EditableGB;

            // trigger OnBeforeValidate()
            // var
            // begin
            //     if EditableGB = false then
            //         Error('Cannot change Type');

            // end;
        }

        modify("Item Reference No.")
        {
            Editable = EditableGB;
        }


        modify(Description)
        {
            Editable = EditableGB;
        }


        modify("Bin Code")
        {
            Editable = EditableGB;
        }

        modify(Quantity)
        {
            Editable = EditableGB;
        }

        modify("Location Code")
        {
            ShowMandatory = true;
            Editable = EditableGB;
        }

        modify("Unit of Measure Code")
        {
            Editable = EditableGB;
        }

        modify("Direct Unit Cost")
        {
            Editable = EditableGB;
        }

        modify("Line Amount")
        {
            Editable = EditableGB;
        }

        modify("Promised Receipt Date")
        {
            Editable = EditableGB;
        }

        modify("Planned Receipt Date")
        {
            Editable = EditableGB;
        }

        modify("Expected Receipt Date")
        {
            Editable = EditableGB;
        }

        modify("Shortcut Dimension 1 Code")
        {
            Editable = EditableGB;
        }


        addafter(Description)
        {
            field("Buyer Name"; rec."Buyer Name")
            {
                ApplicationArea = all;
                Caption = 'Buyer';
                Editable = EditableGB;

                trigger OnValidate()
                var
                    BuyerRec: Record Customer;
                begin
                    BuyerRec.Reset();
                    BuyerRec.SetRange(Name, rec."Buyer Name");
                    if BuyerRec.FindSet() then
                        rec."Buyer No." := BuyerRec."No.";
                end;
            }

            field(StyleName; rec.StyleName)
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
        PurchaseOrderRec.get(rec."Document Type", rec."Document No.");

        if PurchaseOrderRec.Status = PurchaseOrderRec.Status::Released then
            EditableGb := false
        else
            EditableGb := true;
    end;


    trigger OnAfterGetRecord()
    var
        PurchaseOrderRec: Record "Purchase Header";
    begin
        PurchaseOrderRec.get(rec."Document Type", rec."Document No.");

        if PurchaseOrderRec.Status = PurchaseOrderRec.Status::Released then
            EditableGb := false
        else
            EditableGb := true;
    end;

    var
        EditableGB: Boolean;
}