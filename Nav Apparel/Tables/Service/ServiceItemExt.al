tableextension 50725 "Service Item Extension" extends "Service Item"
{
    fields
    {
        field(50001; "Service due date"; Date)
        {
        }

        field(50002; "Work center Code"; Code[20])

        {
        }

        field(50003; "Work center Name"; text[50])  //Not using
        {
            TableRelation = "Work Center".Name;
            ValidateTableRelation = false;
        }

        field(50004; "Service Period"; Option)
        {
            OptionCaption = ''',1 Week,2 Weeks,3 Weeks,1 Month,2 Months,3 Months';
            OptionMembers = "''","1 Week","2 Weeks","3 Weeks","1 Month","2 Months","3 Months";
        }

        field(50005; "Brand"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Brand."Brand Name";
            ValidateTableRelation = false;
        }

        field(50006; "Purchase Year"; Date)
        {

        }

        field(50007; "Model"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Model."Model Name";
            ValidateTableRelation = false;
        }

        field(50008; "Factory"; Text[100])
        {

        }

        field(50009; "Factory Code"; code[20])
        {
            DataClassification = ToBeClassified;
            //CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(50010; "Location Code"; code[20])
        {
        }

        field(50011; "Location"; Text[100])
        {
            TableRelation = "Work Center".Name where("Factory No." = field("Factory Code"));
            ValidateTableRelation = false;
        }

        field(50012; "Machine Category Code"; code[20])
        {
        }

        field(50013; "Machine Category"; Text[100])
        {
            TableRelation = "Machine Master"."Machine Description";
        }

        field(50014; "Ownership Code"; code[20])
        {
        }

        field(50015; "Ownership"; Text[100])
        {
            TableRelation = Location.Name;
        }

        field(50016; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(50017; "Asset Number"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50018; "Motor Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50019; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}


