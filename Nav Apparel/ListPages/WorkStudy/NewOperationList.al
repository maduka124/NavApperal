page 50455 "New Operation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "New Operation";
    CardPageId = "New Operation Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Item Type Name"; rec."Item Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item Type';
                }

                field("Garment Part Name"; rec."Garment Part Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Part';
                }
                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                }

                field("Target Per Hour"; rec."Target Per Hour")
                {
                    ApplicationArea = All;
                }

                field("Seam Length"; rec."Seam Length")
                {
                    ApplicationArea = All;
                }

                field(Grade; rec.Grade)
                {
                    ApplicationArea = All;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Machine Name"; rec."Machine Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine';
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