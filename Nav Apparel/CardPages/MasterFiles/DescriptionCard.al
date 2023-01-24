page 51218 "Description Card"
{
    PageType = Card;
    SourceTable = Description;
    UsageCategory = Tasks;
    Caption = 'Description';


    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var

                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
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


            }


        }
    }



}