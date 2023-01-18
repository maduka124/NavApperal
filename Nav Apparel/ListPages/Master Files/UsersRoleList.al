page 51215 "Users Role List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = UserRoles;
    CardPageId = "User Roles Card";
    Caption = 'User Role';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Role ID';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Role Description';
                }
            }
        }
    }
}