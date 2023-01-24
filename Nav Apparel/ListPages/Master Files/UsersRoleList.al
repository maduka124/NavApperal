page 51144 "Users Role List"
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
                    Caption = 'Worker ID';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Worker Type';
                }
            }
        }
    }
}