page 51011 "User List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LoginDetails;
    CardPageId = "Create User Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("UserID Secondary"; Rec."UserID Secondary")
                {
                    ApplicationArea = All;
                    Caption = 'Secondary UserID';
                }

                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }

                // field(SessionID; Rec.SessionID)
                // {
                //     ApplicationArea = All;
                // }

                field(LastLoginDateTime; Rec.LastLoginDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Last Login Date Time';
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}