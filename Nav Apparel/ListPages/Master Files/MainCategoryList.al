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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category No';
                }

                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                }

                field("Master Category Name"; Rec."Master Category Name")
                {
                    ApplicationArea = All;
                }

                field("Inv. Posting Group Code"; Rec."Inv. Posting Group Code")
                {
                    ApplicationArea = All;
                }

                field("Prod. Posting Group Code"; Rec."Prod. Posting Group Code")
                {
                    ApplicationArea = All;
                }

                field("No Series"; Rec."No Series")
                {
                    ApplicationArea = All;
                }

                field(DimensionOnly; Rec.DimensionOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Only';
                }

                field(SewingJobOnly; Rec.SewingJobOnly)
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Only';
                }

                field(LOTTracking; Rec.LOTTracking)
                {
                    ApplicationArea = All;
                    Caption = 'LOT Tracking';
                }

                field("Style Related"; Rec."Style Related")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}