page 51352 "LC Master List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LCMaster;
    CardPageId = "LC Master Card";
    Editable = false;
    SourceTableView = sorting("No.") order(descending);
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("LC No"; Rec."LC No")
                {
                    ApplicationArea = All;
                    Caption = 'LC No';
                }
                field("Contract Value"; Rec."Contract Value")
                {
                    ApplicationArea = All;
                    Caption = 'Master LC Value';
                }
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = All;
                    Caption = 'Contract No';
                }
                field("UD No"; Rec."UD No")
                {
                    ApplicationArea = All;
                }
                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field(Season; Rec.Season)
                {
                    ApplicationArea = All;
                }

                field(Factory; Rec.Factory)
                {
                    ApplicationArea = All;
                }

                field("B2B Payment Type"; Rec."B2B Payment Type")
                {
                    ApplicationArea = All;
                }

                field(BBLC; Rec.BBLC)
                {
                    ApplicationArea = All;
                }

                field("Opening Date"; Rec."Opening Date")
                {
                    ApplicationArea = All;
                }

                field("Amend Date"; Rec."Amend Date")
                {
                    ApplicationArea = All;
                }

                field("Last Shipment Date"; Rec."Last Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }

                field("Status of LC"; Rec."Status of LC")
                {
                    ApplicationArea = All;
                }

                field("Payment Terms (Days)"; Rec."Payment Terms (Days)")
                {
                    ApplicationArea = All;
                }
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


    trigger OnDeleteRecord(): Boolean
    var
        "Contract/LCMasterRec": Record "Contract/LCMaster";
        "Contract/LCStyleRec": Record "Contract/LCStyle";
        "Contract CommisionRec": Record "Contract Commision";
    begin

        "Contract/LCStyleRec".Reset();
        "Contract/LCStyleRec".SetRange("No.", Rec."No.");

        if "Contract/LCStyleRec".FindSet() then
            Error('Styles addded to the Contract. Contract cannot be deleted.')
        else begin
            // "Contract/LCMasterRec".SetRange("No.", Rec."No.");
            // "Contract/LCMasterRec".DeleteAll();

            "Contract CommisionRec".SetRange("No.", Rec."No.");
            "Contract CommisionRec".DeleteAll();
        end;
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