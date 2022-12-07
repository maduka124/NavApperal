page 50961 "Marker Category Card"
{
    PageType = Card;
    SourceTable = MarkerCategory;
    Caption = 'Marker Category';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Marker Category No';
                }
                field("Marker Category"; rec."Marker Category")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        MarkerCategoryRec: Record MarkerCategory;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        MarkerCategoryRec.Reset();
                        MarkerCategoryRec.SetRange("Marker Category", rec."Marker Category");
                        if MarkerCategoryRec.FindSet() then
                            Error('Marker Category Name already exists.');


                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                    end;
                }
            }
        }
    }
}