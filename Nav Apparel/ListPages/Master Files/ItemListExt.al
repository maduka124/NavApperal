pageextension 50639 ItemListExt extends "Item List"
{
    layout
    {
        addlast(Control1)
        {
            field("Sub Category Name"; Rec."Sub Category Name")
            {
                ApplicationArea = ALL;
                Caption = 'Sub Category';
            }

            field("Color Name"; Rec."Color Name")
            {
                ApplicationArea = ALL;
                Caption = 'Color';
            }

            field("Size Range No."; Rec."Size Range No.")
            {
                ApplicationArea = ALL;
                Caption = 'Size Range';
            }

            field(Article; Rec.Article)
            {
                ApplicationArea = ALL;
            }

            field("Dimension Width"; Rec."Dimension Width")
            {
                ApplicationArea = ALL;
            }

            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = ALL;
            }

            field("EstimateBOM Item"; Rec."EstimateBOM Item")
            {
                ApplicationArea = ALL;
                Caption = 'EstimateBOM Item (Y/N)';
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
        end;

    end;
}