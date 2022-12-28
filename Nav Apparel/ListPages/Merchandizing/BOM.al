page 51022 "BOM"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = BOM;
    SourceTableView = sorting(No) order(descending);
    CardPageId = "BOM Card";
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("No."; rec."No")
                {
                    ApplicationArea = All;
                    Caption = 'BOM No';
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

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        BOMPOSelectionRec: Record BOMPOSelection;
        BOMLineEstRec: Record "BOM Line Estimate";
        BOMLineRec: Record "BOM Line";
        BOMRec: Record BOM;
        BOMAUTORec: Record "BOM Line AutoGen";
        BOMAUTOProdBOMRec: Record "BOM Line AutoGen ProdBOM";
    begin

        BOMAUTOProdBOMRec.Insert();
        BOMAUTOProdBOMRec.SetRange("No.", rec.No);

        if BOMAUTOProdBOMRec.FindSet() then
            Error('"Write TO MRP" process has been completed. You cannot delete the BOM.');


        BOMPOSelectionRec.SetRange("BOM No.", rec."No");
        BOMPOSelectionRec.DeleteAll();

        BOMLineEstRec.SetRange("No.", rec."No");
        BOMLineEstRec.DeleteAll();

        BOMLineRec.SetRange("No.", rec."No");
        BOMLineRec.DeleteAll();

        BOMAUTORec.SetRange("No.", rec."No");
        BOMAUTORec.DeleteAll();

        BOMRec.SetRange("No", rec."No");
        BOMRec.DeleteAll();
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