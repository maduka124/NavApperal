page 51065 StyleColorList
{
    PageType = List;
    SourceTable = StyleColor;
    //SourceTableView = where("User ID" = field(user));
    SourceTableView = sorting("User ID", "Color No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Color No."; rec."Color No.")
                {
                    ApplicationArea = All;
                    Caption = 'Color Code';
                }

                field(Color; rec.Color)
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