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

                field("FabReqNo."; Rec."FabReqNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fab. Req. No';
                }

                field("Plan Date"; Rec."Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Cut No."; Rec."Cut No New")
                {
                    ApplicationArea = All;
                    Caption = 'Cut No';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Group ID"; Rec."Group ID")
                {
                    ApplicationArea = All;
                    Caption = 'Sew. Job Group';
                }

                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                }

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

                field("Fab Direction"; Rec."Fab Direction")
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

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');


        //Check in the cutting progress
        CutProRec.Reset();
        CutProRec.SetRange(LaySheetNo, Rec."LaySheetNo.");

        if CutProRec.FindSet() then begin
            Message('Cannot delete. Lay Sheet No already used in the Cutting Progress No : %1', CutProRec."CutProNo.");
            exit(false);
        end;


        //Check in the Lay SHeet
        BundleGuideRec.Reset();
        BundleGuideRec.SetRange("Style No.", Rec."Style No.");
        BundleGuideRec.SetRange("Color No", Rec."Color No.");
        BundleGuideRec.SetRange("Group ID", Rec."Group ID");
        BundleGuideRec.SetRange("Component Group", Rec."Component Group Code");
        BundleGuideRec.SetRange("Cut No New", Rec."Cut No New");

        if BundleGuideRec.FindSet() then begin
            Message('Cannot delete. Lay Sheet details already used in the Bundle Guide No : %1', BundleGuideRec."BundleGuideNo.");
            exit(false);
        end;



        LaySheetLine1Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine1Rec.DeleteAll();

        LaySheetLine2Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine2Rec.DeleteAll();

        LaySheetLine3Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine3Rec.DeleteAll();

        LaySheetLine4Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine4Rec.DeleteAll();

        LaySheetLine5Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine5Rec.DeleteAll();
    end;


}