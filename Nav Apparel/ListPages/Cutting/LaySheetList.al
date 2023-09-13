page 50651 "Lay Sheet List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LaySheetHeader;
    CardPageId = LaySheetCard;
    SourceTableView = sorting("LaySheetNo.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("LaySheetNo."; Rec."LaySheetNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Lay Sheet No';
                }

                // field("FabReqNo."; Rec."FabReqNo.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Fab. Req. No';
                // }

                // field("Plan Date"; Rec."Plan Date")
                // {
                //     ApplicationArea = All;
                // }

                field("Buyer Name"; rec."Buyer Name")
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

                field("Cut No."; Rec."Cut No New")
                {
                    ApplicationArea = All;
                    Caption = 'Cut No';
                }

                // field("Group ID"; Rec."Group ID")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Sew. Job Group';
                // }

                // field(Color; Rec.Color)
                // {
                //     ApplicationArea = All;
                // }

                field("Component Group Name"; Rec."Component Group Name")
                {
                    ApplicationArea = All;
                    Caption = 'Component Group';
                }

                field("Marker Name"; Rec."Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                // field("Fab Direction"; Rec."Fab Direction")
                // {
                //     ApplicationArea = All;
                // }
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

        // rec.SetCurrentKey("LaySheetNo.");
        // rec.Ascending(false);

    end;


    trigger OnAfterGetRecord()
    var
        UserSetupRec: Record "User Setup";
    begin
        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then begin
            if UserSetupRec."Factory Code" <> '' then begin
                if rec."Factory Code" <> '' then begin
                    if rec."Factory Code" <> UserSetupRec."Factory Code" then
                        Error('You are not authorized to view other factory details.');
                end;
            END;
        end;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        LaySheetLine1Rec: Record LaySheetLine1;
        LaySheetLine2Rec: Record LaySheetLine2;
        LaySheetLine3Rec: Record LaySheetLine3;
        LaySheetLine4Rec: Record LaySheetLine4;
        LaySheetLine5Rec: Record LaySheetLine5;
        CutProRec: Record CuttingProgressHeader;
        BundleGuideRec: Record BundleGuideHeader;
        UserRec: Record "User Setup";
    begin

        //Done By sachith on 06/04/23      
        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');


        // //Check in the cutting progress
        // CutProRec.Reset();
        // CutProRec.SetRange(LaySheetNo, Rec."LaySheetNo.");
        // if CutProRec.FindSet() then begin
        //     Message('Cannot delete. Lay Sheet No already used in the Cutting Progress No : %1', CutProRec."CutProNo.");
        //     exit(false);
        // end;


        //Check in the Lay SHeet
        BundleGuideRec.Reset();
        BundleGuideRec.SetRange("Style No.", rec."Style No.");
        BundleGuideRec.SetRange("Color No", rec."Color No.");
        // BundleGuideRec.SetRange("Group ID", rec."Group ID");
        BundleGuideRec.SetRange("Component Group", rec."Component Group Code");
        BundleGuideRec.SetRange("Cut No New", rec."Cut No New");

        if BundleGuideRec.FindSet() then begin
            Message('Cannot delete. Lay Sheet details already used in the Bundle Guide No : %1', BundleGuideRec."BundleGuideNo.");
            exit(false);
        end;


        LaySheetLine1Rec.Reset();
        LaySheetLine1Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine1Rec.FindSet() then
            LaySheetLine1Rec.DeleteAll();

        LaySheetLine2Rec.Reset();
        LaySheetLine2Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine2Rec.FindSet() then
            LaySheetLine2Rec.DeleteAll();

        LaySheetLine3Rec.Reset();
        LaySheetLine3Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine3Rec.FindSet() then
            LaySheetLine3Rec.DeleteAll();

        LaySheetLine4Rec.Reset();
        LaySheetLine4Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine4Rec.FindSet() then
            LaySheetLine4Rec.DeleteAll();

        LaySheetLine5Rec.Reset();
        LaySheetLine5Rec.SetRange("LaySheetNo.", rec."LaySheetNo.");
        if LaySheetLine5Rec.FindSet() then
            LaySheetLine5Rec.DeleteAll();
    end;


}