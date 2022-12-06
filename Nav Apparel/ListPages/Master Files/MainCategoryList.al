page 50641 "Main Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Main Category";
    CardPageId = "Main Category Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category No';
                }

                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                }

                field("Master Category Name"; Rec."Master Category Name")
                {
                    ApplicationArea = All;
                }

                field("Inv. Posting Group Code"; Rec."Inv. Posting Group Code")
                {
                    ApplicationArea = All;
                }

                field("Prod. Posting Group Code"; Rec."Prod. Posting Group Code")
                {
                    ApplicationArea = All;
                }

                field("No Series"; Rec."No Series")
                {
                    ApplicationArea = All;
                }

                field(DimensionOnly; Rec.DimensionOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Only';
                }

                field(SewingJobOnly; Rec.SewingJobOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Only';
                }

                field(LOTTracking; Rec.LOTTracking)
                {
                    ApplicationArea = All;
                    Caption = 'LOT Tracking';
                }

                field("General Issuing"; rec."General Issuing")
                {
                    ApplicationArea = All;
                }

                field("Style Related"; Rec."Style Related")
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
}