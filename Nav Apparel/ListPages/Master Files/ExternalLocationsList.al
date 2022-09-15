page 50789 ExternalLocationsList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ExternalLocations;
    CardPageId = "ExternalLocations Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }

                field("Location Name"; "Location Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}