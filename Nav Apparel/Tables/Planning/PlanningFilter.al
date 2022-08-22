
table 50759 PlanningFilter
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FactoryNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "FactoryName"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name;
            ValidateTableRelation = false;
        }

        field(3; "StyleNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "StyleName"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

    }

    // keys
    // {
    //     key(PK; "No.")
    //     {
    //         Clustered = true;
    //     }
    // }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "No.", Day1, Day2, Day3, Day4, Day5, Day6, Day7)
    //     {

    //     }
    // } 


}
