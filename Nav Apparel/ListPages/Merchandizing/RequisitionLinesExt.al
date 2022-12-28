pageextension 51057 RequisitionLinesExt extends "Planning Worksheet"
{

    layout
    {
        addbefore("No.")
        {
            field("Main Category"; Rec."Main Category")
            {
                ApplicationArea = ALL;
            }
        }

        addafter("No.")
        {
            field(Description1; Rec.Description)
            {
                ApplicationArea = ALL;
                Caption = 'Description';
            }

            field(StyleName; Rec.StyleName)
            {
                ApplicationArea = ALL;
                Caption = 'Style';
            }

            field(PONo; Rec.PONo)
            {
                ApplicationArea = ALL;
                Caption = 'PO';
            }

            field(Lot; Rec.Lot)
            {
                ApplicationArea = ALL;
            }
        }

        modify(Description)
        {
            Visible = false;
        }

        modify("Vendor No.")
        {
            Visible = true;
        }

        modify("Location Code")
        {
            Visible = true;
        }

        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }

        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
    }


    actions
    {
        addlast("F&unctions")
        {
            action("Select All")
            {
                Caption = 'Select All';
                Image = SelectMore;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ReqRec: Record "Requisition Line";
                begin
                    ReqRec.Reset();
                    ReqRec.SetRange(StyleName, Rec.StyleName);

                    if ReqRec.FindSet() then begin
                        repeat
                            ReqRec."Accept Action Message" := true;
                            ReqRec.Modify();
                        until ReqRec.Next() = 0;
                    end;

                    CurrPage.Update();
                end;
            }

            action("De-Select All")
            {
                Caption = 'De-Select All';
                Image = RemoveLine;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ReqRec: Record "Requisition Line";
                begin
                    ReqRec.Reset();
                    //ReqRec.SetRange("No.", "No.");
                    ReqRec.FindSet();

                    repeat
                        ReqRec."Accept Action Message" := false;
                        ReqRec.Modify();
                    until ReqRec.Next() = 0;

                    CurrPage.Update();
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserSetupRec: Record "User Setup";
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


        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then begin
            if UserSetupRec."Merchandizer All Group" = false then begin
                if UserSetupRec."Merchandizer Group Name" = '' then
                    Error('Merchandiser Group Name has not set up for the user : %1', UserId)
                else
                    rec.SetFilter("Merchandizer Group Name", '=%1', UserSetupRec."Merchandizer Group Name");
            end
        end
        else
            Error('Cannot find user details in user setup table');


    end;


    trigger OnAfterGetRecord()
    var
        UserSetupRec: Record "User Setup";
    begin
        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then begin
            if UserSetupRec."Merchandizer All Group" = false then begin
                if rec."Merchandizer Group Name" <> '' then begin
                    if rec."Merchandizer Group Name" <> UserSetupRec."Merchandizer Group Name" then
                        Error('You are not authorized to view other Merchandiser Group information.');
                END;
            END;
        end;
    end;
}