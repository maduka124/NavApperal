page 50676 GRNGRNListPart
{
    PageType = List;
    Caption = 'GRN List';
    SourceTable = "Purch. Rcpt. Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'GRN';
                }
                field(VendorName; VendorName)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Caption = 'UOM';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        VendorRec: Record Vendor;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;
        VendorRec.Reset();
        VendorRec.SetRange("No.", Rec."Buy-from Vendor No.");
        if VendorRec.FindFirst() then begin
            VendorName := VendorRec.Name;
        end;

    end;

    var
        VendorName: Text[100];
}