pageextension 51056 PurchaseOrderListExt extends "Purchase Order Subform"
{
    layout
    {
        movefirst(Control1; "Line No.")

        modify("Line No.")
        {
            Visible = true;
        }

        modify("No.")
        {
            Editable = EditableGB1;

        }
        addafter("Quantity Received")
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = all;
            }
        }
        modify(Type)
        {
            Caption = 'Type';
            Editable = EditableGB1;

            // trigger OnBeforeValidate()
            // var
            // begin
            //     if EditableGB1 = false then
            //         Error('Cannot change Type');

            // end;
        }

        modify("Item Reference No.")
        {
            Editable = EditableGB1;
        }


        modify(Description)
        {
            Editable = EditableGB1;
        }


        modify("Bin Code")
        {
            Editable = EditableGB1;
        }

        modify(Quantity)
        {
            Editable = EditableGB1;
        }

        modify("Location Code")
        {
            ShowMandatory = true;
            Editable = EditableGB1;
        }

        modify("Unit of Measure Code")
        {
            Editable = EditableGB1;
        }

        modify("Direct Unit Cost")
        {
            Editable = EditableGB1;
        }

        modify("Line Amount")
        {
            Editable = EditableGB1;
        }

        modify("Promised Receipt Date")
        {
            Editable = EditableGB1;
        }

        modify("Planned Receipt Date")
        {
            Editable = EditableGB1;
        }

        modify("Expected Receipt Date")
        {
            Editable = EditableGB1;
        }

        modify("Shortcut Dimension 1 Code")
        {
            Editable = EditableGB1;
        }

        modify("Shortcut Dimension 2 Code")
        {
            Editable = false;
        }

        addafter(Description)
        {
            field("Buyer Name"; rec."Buyer Name")
            {
                ApplicationArea = all;
                Caption = 'Buyer';
                Editable = EditableGB1;

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

            field(StyleNo; rec.StyleNo)
            {
                ApplicationArea = all;
                Caption = 'Style No';
                Editable = EditableGB1;
            }

            field(StyleName; rec.StyleName)
            {
                ApplicationArea = all;
                Caption = 'Style Name';
                Editable = EditableGB1;
            }

            field(Lot; rec.Lot)
            {
                ApplicationArea = all;
                Caption = 'LOT';
                Editable = EditableGB1;
            }

            field(PONo; rec.PONo)
            {
                ApplicationArea = all;
                Caption = 'PO No';
                Editable = EditableGB1;
            }
        }
    }


    trigger OnOpenPage()
    var
        PurchaseOrderRec: Record "Purchase Header";
    begin
        if rec."Document No." <> '' then begin
            PurchaseOrderRec.get(rec."Document Type"::Order, rec."Document No.");

            if PurchaseOrderRec.Status = PurchaseOrderRec.Status::Released then
                EditableGB1 := false
            else
                EditableGB1 := true;
        end
        else
            EditableGB1 := true;
    end;


    trigger OnAfterGetRecord()
    var
        PurchaseOrderRec: Record "Purchase Header";
    begin
        PurchaseOrderRec.get(rec."Document Type"::Order, rec."Document No.");

        if PurchaseOrderRec.Status = PurchaseOrderRec.Status::Released then
            EditableGB1 := false
        else
            EditableGB1 := true;
    end;

    var
        EditableGB1: Boolean;
}