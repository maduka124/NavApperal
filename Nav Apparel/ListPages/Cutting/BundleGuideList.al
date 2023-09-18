page 50666 "Bundle Guide List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BundleGuideHeader;
    CardPageId = "Bundle Guide Card";
    SourceTableView = sorting("BundleGuideNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("BundleGuideNo."; Rec."BundleGuideNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Guide No';
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("LaySheetNo."; rec."LaySheetNo.")
                {
                    ApplicationArea = All;
                    Caption = 'LaySheet No';
                }

                field("Component Group"; Rec."Component Group")
                {
                    ApplicationArea = All;
                }

                field("Cut No"; Rec."Cut No New")
                {
                    ApplicationArea = All;
                    Caption = 'Cut No';
                }

                field("Bundle Rule"; Rec."Bundle Rule")
                {
                    ApplicationArea = All;
                }

                field("Bundle Method"; Rec."Bundle Method")
                {
                    ApplicationArea = All;
                }

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }

                field("Created User"; Rec."Created User")
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
        UserRec: Record "User Setup";
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());
        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then
            rec.SetFilter("Factory Code", '=%1', UserRec."Factory Code");
    end;


    trigger OnAfterGetRecord()
    var
        StyleMasterRec: Record "Style Master";
        UserSetupRec: Record "User Setup";
    begin
        StyleMasterRec.Reset();
        StyleMasterRec.SetRange("No.", rec."Style No.");
        if StyleMasterRec.FindSet() then
            Buyer := StyleMasterRec."Buyer Name"
        else
            Buyer := '';

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then begin
            if UserSetupRec."Factory Code" <> '' then begin
                if rec."Factory Code" <> UserSetupRec."Factory Code" then
                    Error('You are not authorized to view other factory details.');
            END;
        end;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BundleGuideLineRec: Record BundleGuideLine;
        UserRec: Record "User Setup";
        LaySheetRec: Record LaySheetHeader;
    begin
        // Done By sachith on 03/04/23
        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

        BundleGuideLineRec.reset();
        BundleGuideLineRec.SetRange("BundleGuideNo.", Rec."BundleGuideNo.");
        BundleGuideLineRec.DeleteAll();

        LaySheetRec.reset();
        LaySheetRec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetRec.FindSet() then begin
            LaySheetRec."BundleGuideNo." := '';
            LaySheetRec.Modify();
        end;
    end;

    var
        Buyer: Text[200];

}