page 50840 "Plan Lines - Search List"
{
    PageType = list;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Style No.", "Lot No.", "Line No.") order(ascending);
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Caption = 'Planned History - Search';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                }

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Line';
                }

                field(StartDateTime; rec.StartDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date/Time';
                }

                field(FinishDateTime; rec.FinishDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Finish Date/Time';
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                    Caption = 'No of Machines';
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Efficiency';
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                }

                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
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