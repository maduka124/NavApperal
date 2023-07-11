page 51333 "PO Complete List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Style Master";
    SourceTableView = sorting("No.") order(descending) where(Status = filter(Confirmed));
    CardPageId = POCompleteCard;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
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
            }
        }
    }


    // trigger OnOpenPage()
    // var
    //     LoginRec: Page "Login Card";
    //     LoginSessionsRec: Record LoginSessions;
    //     UserSetupRec: Record "User Setup";
    // begin

    //     //Check whether user logged in or not
    //     LoginSessionsRec.Reset();
    //     LoginSessionsRec.SetRange(SessionID, SessionId());

    //     if not LoginSessionsRec.FindSet() then begin  //not logged in
    //         Clear(LoginRec);
    //         LoginRec.LookupMode(true);
    //         LoginRec.RunModal();
    //     end;


    //     UserSetupRec.Reset();
    //     UserSetupRec.SetRange("User ID", UserId);

    //     if UserSetupRec.FindSet() then begin
    //         if UserSetupRec."Merchandizer All Group" = false then begin
    //             if UserSetupRec."Merchandizer Group Name" = '' then
    //                 Error('Merchandiser Group Name has not set up for the user : %1', UserId)
    //             else
    //                 rec.SetFilter("Merchandizer Group Name", '=%1', UserSetupRec."Merchandizer Group Name");
    //         end
    //     end
    //     else
    //         Error('Cannot find user details in user setup table');


    // end;


    // trigger OnDeleteRecord(): Boolean
    // var
    // // StyleMasterPORec: Record "Style Master PO";
    // begin
    //     //StyleMasterPORec.SetRange("Style No.", "No.");
    //     //StyleMasterPORec.DeleteAll();
    //     Error('Style already confirmed. Cannot delete.');

    // end;

    trigger OnAfterGetRecord()
    var
        // UserSetupRec: Record "User Setup";
        LCContractRec: Record "Contract/LCMaster";
    begin
        // UserSetupRec.Reset();
        // UserSetupRec.SetRange("User ID", UserId);

        // if UserSetupRec.FindSet() then begin
        //     if UserSetupRec."Merchandizer All Group" = false then begin
        //         if rec."Merchandizer Group Name" <> '' then begin
        //             if rec."Merchandizer Group Name" <> UserSetupRec."Merchandizer Group Name" then
        //                 Error('You are not authorized to view other Merchandiser Group information.');
        //         END;
        //     END;
        // end;

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