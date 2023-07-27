page 51372 StyleChangeListPart
{
    PageType = ListPart;
    SourceTable = StyleChangeLine;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Resource No."; rec."Resource No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                    StyleExpr = StyleExprTxt;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'No of Style Changes';
                    StyleExpr = StyleExprTxt;
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    var
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
    begin  
        StyleExprTxt := ChangeColor.ChangeStyleChange(Rec);
        // Rec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
    end;


    trigger OnOpenPage()
    var
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
    begin
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());
        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            LoginSessionsRec.Reset();
            LoginSessionsRec.SetRange(SessionID, SessionId());
            LoginSessionsRec.FindSet();
            //Rec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
        end;
    end;
    

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}