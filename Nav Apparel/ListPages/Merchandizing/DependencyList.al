page 51041 "Dependency"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Dependency;
    CardPageId = "Dependency Card";
    SourceTableView = sorting("No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Buyer No."; rec."Buyer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Dependency; rec.Dependency)
                {
                    ApplicationArea = All;
                    Caption = 'Dependency Group Name';
                }
            }
        }
    }
}