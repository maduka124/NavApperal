page 50978 "Create User Card"
{
    PageType = Card;
    SourceTable = LoginDetails;
    Caption = 'User Creation';
    //AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                // field("No."; rec."No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                field("Secondary UserID"; rec."Secondary UserID")
                {
                    ApplicationArea = All;
                    Caption = 'Secondary User ID';

                    trigger OnValidate()
                    var
                        LoginDetailsRec: Record LoginDetails;
                    begin
                        LoginDetailsRec.Reset();
                        LoginDetailsRec.SetRange("Secondary UserID", rec."Secondary UserID");

                        if LoginDetailsRec.FindSet() then
                            Error('Secondary User ID already exists.');
                    end;
                }

                field("User Name"; rec."User Name")
                {
                    ApplicationArea = All;
                }

                field(Pw; rec.Pw)
                {
                    ApplicationArea = All;
                    Caption = 'Password';
                }

                field(Password; Password)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    Caption = 'Re Enter Password';

                    trigger OnValidate()
                    var
                    begin
                        if rec.pw <> Password then
                            Error('Password mismatch.');
                    end;
                }

                field(Active; rec.Active)
                {
                    ApplicationArea = All;
                    Caption = 'Active Status';
                }
            }
        }
    }

    var
        Password: Text[50];
}