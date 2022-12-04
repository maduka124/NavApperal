page 71012854 "User List"
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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }

                field("UserID Secondary"; "UserID Secondary")
                {
                    ApplicationArea = All;
                    Caption = 'Secondary UserID';
                }

                field("User Name"; "User Name")
                {
                    ApplicationArea = All;
                }

                field(SessionID; SessionID)
                {
                    ApplicationArea = All;
                }

                field(LastLoginDateTime; LastLoginDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Last Login Date Time';
                }

                field(Active; Active)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}