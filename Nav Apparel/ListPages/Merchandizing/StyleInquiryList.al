page 51066 "Style Inquiry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Style Master";
    CardPageId = "Style Inquiry Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {

            repeater(General)
            {
                Editable = false;

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Style Display Name"; rec."Style Display Name")
                {
                    ApplicationArea = All;
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field("Size Range Name"; rec."Size Range Name")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range';
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                }

                field("Lead Time"; rec."Lead Time")
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }

                field("Production File Handover Date"; rec."Production File Handover Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        //StyleRec: Record "Style Master";
        StylePORec: Record "Style Master PO";
        SpecialOpRec: Record "Special Operation Style";
    begin
        if rec.Status = rec.status::Confirmed then
            Error('Style already confirmed. Cannot delete.')
        else begin

            // StyleRec.SetRange("No.", "No.");
            // if StyleRec.FindSet() then
            //     StyleRec.DeleteAll();

            SpecialOpRec.SetRange("Style No.", rec."No.");
            if SpecialOpRec.FindSet() then
                SpecialOpRec.DeleteAll();

            StylePORec.SetRange("Style No.", rec."No.");
            if StylePORec.FindSet() then
                StylePORec.DeleteAll();


        end;
    end;


    trigger OnOpenPage()
    var
        LoginDetails: Record LoginDetails;
    begin

        // LoginDetails.Reset();
        // LoginDetails.SetRange(SessionID, SessionId());

        // if LoginDetails.FindSet() then begin
        //     SetFilter(LoggedBy, LoginDetails.UserID);
        // end
        // else begin
        //     Message(format(SessionId()));
        //     Error('Invalid SessionID');
        // end;


    end;

}