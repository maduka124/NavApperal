page 51043 "Dependency Style"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Dependency Style Header";
    CardPageId = "Dependency Style Header Card";
    SourceTableView = sorting("No.") order(descending);
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("Style Name."; rec."Style Name.")
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

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }

                field("Min X-Fac Date"; rec."Min X-Fac Date")
                {
                    ApplicationArea = All;
                }

                field(BPCD; rec.BPCD)
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
            if UserSetupRec."Merchandizer Group Name" = '' then
                Error('Merchandiser Group Name has not set up for the user : %1', UserId)
            else
                rec.SetFilter("Merchandizer Group Name", '=%1', UserSetupRec."Merchandizer Group Name")
        end
        else
            Error('Cannot find user details in user setup table');

    end;


    trigger OnDeleteRecord(): Boolean
    var
        DependencyStyleLineRec: Record "Dependency Style Line";
        DepeStyleHeaderRec: Record "Dependency Style Header";
    begin
        DepeStyleHeaderRec.Reset();
        DepeStyleHeaderRec.SetRange("No.", rec."No.");
        DepeStyleHeaderRec.DeleteAll();

        DependencyStyleLineRec.Reset();
        DependencyStyleLineRec.SetRange("Style No.", rec."No.");
        DependencyStyleLineRec.DeleteAll();

    end;


    trigger OnAfterGetRecord()
    var
        UserSetupRec: Record "User Setup";
    begin
        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then begin
            if rec."Merchandizer Group Name" <> '' then begin
                if rec."Merchandizer Group Name" <> UserSetupRec."Merchandizer Group Name" then
                    Error('You are not authorized to view other Merchandiser Group information.');
            END;
        end;
    end;
}