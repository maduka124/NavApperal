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

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Group ID"; Rec."Group ID")
                {
                    ApplicationArea = All;
                }

                field("Component Group"; Rec."Component Group")
                {
                    ApplicationArea = All;
                }

                field("Cut No"; Rec."Cut No")
                {
                    ApplicationArea = All;
                }

                field("Bundle Rule"; Rec."Bundle Rule")
                {
                    ApplicationArea = All;
                }

                field("Bundle Method"; Rec."Bundle Method")
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
        BundleGuideLineRec: Record BundleGuideLine;
    begin
        BundleGuideLineRec.reset();
        BundleGuideLineRec.SetRange("BundleGuideNo.", Rec."BundleGuideNo.");
        BundleGuideLineRec.DeleteAll();
    end;

}