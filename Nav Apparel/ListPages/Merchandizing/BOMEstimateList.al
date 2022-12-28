page 51026 "Estimate BOM"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "BOM Estimate";
    CardPageId = "BOM Estimate Card";
    SourceTableView = sorting("No.") order(descending);
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'BOM Estimate No';
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

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                // field("Main Category Name"; "Main Category Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Main Category';
                // }

                // field(Revision; Revision)
                // {
                //     ApplicationArea = All;
                // }

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }

                field("Currency No."; rec."Currency No.")
                {
                    ApplicationArea = All;
                    Caption = 'Currency';
                }

                field("Material Cost Doz."; rec."Material Cost Doz.")
                {
                    ApplicationArea = All;
                }
                field("Material Cost Pcs."; rec."Material Cost Pcs.")
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
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
        BOMEstimateRec: Record "BOM Estimate";
        BOMLineEstRec: Record "BOM Estimate Line";
    begin
        BOMEstimateRec.SetRange("No.", rec."No.");
        BOMEstimateRec.DeleteAll();

        BOMLineEstRec.SetRange("No.", rec."No.");
        BOMLineEstRec.DeleteAll();
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