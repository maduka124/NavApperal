pageextension 51159 ReleasedProdExt extends "Released Production Orders"
{
    layout
    {
        addafter("Source No.")
        {
            field("Style Name"; Rec."Style Name")
            {
                ApplicationArea = All;
            }
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = All;
            }
            field(PO; Rec.PO)
            {
                ApplicationArea = All;
            }
            field(POQty; POQty)
            {
                ApplicationArea = All;
                Caption = 'Order Qty';
            }
            field(FinishQty; FinishQty)
            {
                ApplicationArea = All;
                Caption = 'Finish Qty';
            }
            field(ShipQty; ShipQty)
            {
                ApplicationArea = All;
                Caption = 'Ship Qty';
            }

        }
    }
    trigger OnAfterGetRecord()
    var
        StylePoRec: Record "Style Master PO";
        SalesInvHRec: Record "Sales Invoice Header";
        SalesInvLineRec: Record "Sales Invoice Line";
    begin
        POQty := 0;
        FinishQty := 0;
        ShipQty := 0;
        StylePoRec.Reset();
        StylePoRec.SetRange("Style No.", Rec."Style No.");
        StylePoRec.SetRange("PO No.", Rec.PO);
        StylePoRec.SetRange("Lot No.", Rec."Lot No.");
        if StylePoRec.FindSet() then begin
            repeat
                POQty += StylePoRec.Qty;
                FinishQty += StylePoRec."Poly Bag";
                ShipQty += StylePoRec."Actual Shipment Qty";
            until StylePoRec.Next() = 0;
        end;
        // ShipQty := 0;
        // SalesInvHRec.Reset();
        // SalesInvHRec.SetRange("Style No", Rec."Style No.");
        // SalesInvHRec.SetRange("PO No", Rec.PO);
        // SalesInvHRec.SetRange(Lot, Rec."Lot No.");
        // if SalesInvHRec.FindSet() then begin
        //     SalesInvLineRec.Reset();
        //     SalesInvLineRec.SetRange("Document No.", SalesInvHRec."No.");
        //     SalesInvLineRec.SetRange(Type, SalesInvLineRec.Type::Item);
        //     if SalesInvLineRec.FindSet() then begin
        //         repeat
        //             ShipQty += SalesInvLineRec.Quantity;
        //         until SalesInvLineRec.Next() = 0;
        //     end;
        // end;
    end;

    trigger OnOpenPage()
    var
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;

    end;

    var
        POQty: Integer;
        FinishQty: Integer;
        ShipQty: Integer;
}