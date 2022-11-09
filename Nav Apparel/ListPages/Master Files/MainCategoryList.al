page 71012616 "Main Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Main Category";
    CardPageId = "Main Category Card";
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
                    Caption = 'Main Category No';
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                }

                field("Master Category Name"; "Master Category Name")
                {
                    ApplicationArea = All;
                }

                field("Inv. Posting Group Code"; "Inv. Posting Group Code")
                {
                    ApplicationArea = All;
                }

                field("Prod. Posting Group Code"; "Prod. Posting Group Code")
                {
                    ApplicationArea = All;
                }

                field(DimensionOnly; DimensionOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Only';
                }

                field(SewingJobOnly; SewingJobOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Only';
                }

                field(LOTTracking; LOTTracking)
                {
                    ApplicationArea = All;
                    Caption = 'LOT Tracking';
                }

                field("Style Related"; "Style Related")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}