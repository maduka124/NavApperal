page 51052 "Proforma Invoice Details List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PI Details Header";
    CardPageId = "PI Details Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Doc No';
                }

                field("PI No"; rec."PI No")
                {
                    ApplicationArea = All;
                }

                field("PI Date"; rec."PI Date")
                {
                    ApplicationArea = All;
                }

                field("PI Value"; rec."PI Value")
                {
                    ApplicationArea = All;
                }

                field("Supplier Name"; rec."Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field("Payment Mode Name"; rec."Payment Mode Name")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Mode';
                }

                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
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
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        PIPoDetailsRec: Record "PI Po Details";
        PIPoItemsDetailsRec: Record "PI Po Item Details";
    begin
        PIPoDetailsRec.SetRange("PI No.", rec."PI No");
        PIPoDetailsRec.DeleteAll();

        PIPoItemsDetailsRec.SetRange("PI No.", rec."PI No");
        PIPoItemsDetailsRec.DeleteAll();
    end;


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