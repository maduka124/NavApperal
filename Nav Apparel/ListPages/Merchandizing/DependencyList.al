page 71012801 "Dependency"
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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }

                field("Buyer No."; "Buyer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Dependency; Dependency)
                {
                    ApplicationArea = All;
                    Caption = 'Dependency Group Name';
                }
            }
        }
    }
}