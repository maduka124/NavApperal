page 71012742 "Create User Card"
{
    PageType = Card;
    SourceTable = LoginDetails;
    Caption = 'User Creation';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }

                field("UserID Secondary"; "UserID Secondary")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LoginDetailsRec: Record LoginDetails;
                    begin
                        LoginDetailsRec.Reset();
                        LoginDetailsRec.SetRange("UserID Secondary", "UserID Secondary");

                        if LoginDetailsRec.FindSet() then
                            Error('UserID Secondary already exists.');
                    end;
                }

                field("User Name"; "User Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Pw; Pw)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}