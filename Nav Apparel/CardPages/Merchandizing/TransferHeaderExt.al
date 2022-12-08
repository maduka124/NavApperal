pageextension 50632 TransferHeaderExt extends "Transfer Order"
{
    layout
    {
        addlast(General)
        {
            field("Style No."; rec."Style No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            // field("Style Name"; rec."Style Name")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
            // field(PO; rec.PO)
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            // }
        }

        // modify("Transfer-from")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         LoginSessionsRec: Record LoginSessions;
        //         LoginRec: Page "Login Card";
        //     begin
        //         //Check whether user logged in or not
        //         LoginSessionsRec.Reset();
        //         LoginSessionsRec.SetRange(SessionID, SessionId());

        //         if not LoginSessionsRec.FindSet() then begin  //not logged in
        //             Clear(LoginRec);
        //             LoginRec.LookupMode(true);
        //             LoginRec.RunModal();

        //             LoginSessionsRec.Reset();
        //             LoginSessionsRec.SetRange(SessionID, SessionId());
        //             LoginSessionsRec.FindSet();
        //             rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        //         end
        //         else begin   //logged in
        //             rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        //         end;
        //     end;
        // }

        // modify("Transfer-to Name")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         LoginSessionsRec: Record LoginSessions;
        //         LoginRec: Page "Login Card";
        //     begin
        //         //Check whether user logged in or not
        //         LoginSessionsRec.Reset();
        //         LoginSessionsRec.SetRange(SessionID, SessionId());

        //         if not LoginSessionsRec.FindSet() then begin  //not logged in
        //             Clear(LoginRec);
        //             LoginRec.LookupMode(true);
        //             LoginRec.RunModal();

        //             LoginSessionsRec.Reset();
        //             LoginSessionsRec.SetRange(SessionID, SessionId());
        //             LoginSessionsRec.FindSet();
        //             rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        //         end
        //         else begin   //logged in
        //             rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        //         end;
        //     end;
        // }


    }

    actions
    {
        // Add changes to page actions here
        modify("&Print")
        {
            Visible = false;
        }

        addafter("P&osting")
        {
            action("Transfer Order Report")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    myInt: Integer;
                    TransferHeaderReport: Report TransferOrderCardPageReport;
                begin
                    TransferHeaderReport.Set_Value(rec."No.");
                    TransferHeaderReport.RunModal();
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
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

            LoginSessionsRec.Reset();
            LoginSessionsRec.SetRange(SessionID, SessionId());
            if LoginSessionsRec.FindSet() then
                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        end
        else begin   //logged in
            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        end;

    end;


    trigger OnModifyRecord(): Boolean
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

            LoginSessionsRec.Reset();
            LoginSessionsRec.SetRange(SessionID, SessionId());
            if LoginSessionsRec.FindSet() then
                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        end
        else begin   //logged in
            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        end;

    end;

}
