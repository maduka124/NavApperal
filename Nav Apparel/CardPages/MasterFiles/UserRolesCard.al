page 51216 "User Roles Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = UserRoles;
    Caption = 'User Role';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Role ID';
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    Caption = 'Role Description';
                    ApplicationArea = All;
                }
            }
        }
    }
}