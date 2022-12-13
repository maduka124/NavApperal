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
                    Caption = 'Ful Name';
                }

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

    trigger OnAfterGetRecord()
    var
        LoginSessionRec: Record LoginSessions;
    begin
        LoginSessionRec.Reset();
        LoginSessionRec.SetRange("Secondary UserID", rec."UserID Secondary");
        LoginSessionRec.SetCurrentKey("Created DateTime");
        LoginSessionRec.Ascending(true);
        if LoginSessionRec.FindLast() then
            rec.LastLoginDateTime := LoginSessionRec."Created DateTime";
    end;
}