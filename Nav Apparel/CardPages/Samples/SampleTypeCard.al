page 50619 "Sample Type Card"
{
    PageType = Card;
    SourceTable = "Sample Type";
    Caption = 'Sample Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type No';
                }

                field("Sample Type Name"; rec."Sample Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SampleTypeRec: Record "Sample Type";
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

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;


                        SampleTypeRec.Reset();
                        SampleTypeRec.SetRange("Sample Type Name", rec."Sample Type Name");
                        if SampleTypeRec.FindSet() then
                            Error('Sample Type already exists.');
                    end;
                }

                field("Lead Time"; rec."Lead Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}