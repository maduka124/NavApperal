page 51049 "My Task Completed"
{
    PageType = ListPart;
    SourceTable = "Dependency Style Line";
    SourceTableView = where(Complete = filter(true));
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Action User"; rec."Action User")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Garment Type';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Action Description"; rec."Action Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Date"; rec."Plan Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Complete; rec.Complete)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("MK Critical"; rec."MK Critical")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Department; rec.Department)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Revise; rec.Revise)
                {
                    ApplicationArea = All;
                    Editable = false;
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

        rec.SetRange("Action User", UserId);

    end;
}