page 51216 "User Roles Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = UserRoles;
    Caption = 'Worker Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Worker Type ID';
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    Caption = 'Worker Type';
                    ApplicationArea = All;
                }
            }
        }
    }
}