page 50789 ExternalLocationsList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ExternalLocations;
    CardPageId = "ExternalLocations Card";
    SourceTableView = sorting("Location Code") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }

                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}