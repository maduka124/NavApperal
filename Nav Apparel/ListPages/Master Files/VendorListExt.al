pageextension 51150 VendorListExt extends "Vendor List"
{

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
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

    //Done By Sachith On 29/03/23
    trigger OnDeleteRecord(): Boolean
    var
        BOMEstimateLineRec: Record "BOM Estimate Line";
    begin

        BOMEstimateLineRec.Reset();
        BOMEstimateLineRec.SetRange("Supplier No.", Rec."No.");

        if BOMEstimateLineRec.FindSet() then
            Error('Cannot delete.this vendor use in estimate bom');
    end;
}