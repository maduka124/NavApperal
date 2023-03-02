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

            field(StyleName; rec.StyleName)
            {
                ApplicationArea = all;
                Caption = 'Style';
                Editable = EditableGB1;
            }
        }
    }


    // trigger OnAfterGetRecord()
    // var
    //     PurchaseOrderRec: Record "Purchase Header";
    // begin
    //     PurchaseOrderRec.Reset();
    //     PurchaseOrderRec.SetRange("No.", rec."Document No.");
    //     PurchaseOrderRec.SetFilter("Document Type", '=%1', PurchaseOrderRec."Document Type"::Order);
    //     if PurchaseOrderRec.FindSet() then begin

    //         if PurchaseOrderRec.Status = PurchaseOrderRec.Status::Released then begin
    //             EditableGB1 := false;
    //             // VisibleGB1 := true;
    //         end
    //         else begin
    //             EditableGB1 := true;
    //             // VisibleGB1 := false;
    //         end;

    //     end;
    // end;


    // trigger OnAfterGetRecord()
    // var
    //     PurchaseOrderRec: Record "Purchase Header";
    //     UserRec: Record "User Setup";
    // begin
    //     PurchaseOrderRec.get(rec."Document Type", rec."Document No.");

    //     if PurchaseOrderRec.Status = PurchaseOrderRec.Status::Released then
    //         EditableGB1 := false
    //     else
    //         EditableGB1 := true;
    //     UserRec.Reset();
    //     UserRec.SetRange(SystemCreatedBy, Rec.SystemCreatedBy);
    //     if UserRec.FindSet() then begin
    //         Rec."Shortcut Dimension 2 Code" := UserRec."Cost Center";
    //     end;
    // end;

    var
        EditableGB1: Boolean;
        VisibleGB1: Boolean;
}