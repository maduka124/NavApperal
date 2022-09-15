page 50790 "ExternalLocations Card"
{
    PageType = Card;
    SourceTable = ExternalLocations;
    Caption = 'External Locations';

    layout
    {
        area(Content)
        {
            group(General)
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