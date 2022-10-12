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

        field(204; "Brand"; Text[100])
        {

        }

        field(205; "Purchase Year"; Date)
        {

        }

        field(206; "Model"; Text[100])
        {

        }

        field(207; "Factory"; Text[100])
        {
            TableRelation = Location.Name;
        }

        field(208; "Factory Code"; code[20])
        {
            TableRelation = Location.Name;
        }
    }
}

