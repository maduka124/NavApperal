tableextension 50725 "Service Item Extension" extends "Service Item"
{
    fields
    {
        field(200; "Service due date"; Date)
        {
        }

        field(201; "Work center Code"; Code[20])

        {
        }

        field(202; "Work center Name"; text[50])
        {
            TableRelation = "Work Center".Name;
            ValidateTableRelation = false;
        }

        field(203; "Service Period"; Option)
        {
            OptionCaption = ''',1 Week,2 Weeks,3 Weeks,1 Month,2 Months,3 Months';
            OptionMembers = "''","1 Week","2 Weeks","3 Weeks","1 Month","2 Months","3 Months";
        }
    }
}

