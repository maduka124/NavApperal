page 51066 "Style Inquiry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Style Master";
    CardPageId = "Style Inquiry Card";
    SourceTableView = sorting("No.") order(descending);
    ShowFilter = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style No';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(AssignedContractNoVar; AssignedContractNoVar)
                {
                    ApplicationArea = All;
                    Caption = 'LC/Contract No';
                }

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style Description';
                }

                field("Style Display Name"; rec."Style Display Name")
                {
                    ApplicationArea = All;
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
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
        LCContractRec: Record "Contract/LCMaster";
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

        //Get LC Contract No
        LCContractRec.Reset();
        LCContractRec.SetRange("No.", rec.AssignedContractNo);
        if LCContractRec.FindSet() then
            AssignedContractNoVar := LCContractRec."Contract No"
        else
            AssignedContractNoVar := '';
    end;

    var
        AssignedContractNoVar: Text[100];

}