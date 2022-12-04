page 50756 JobCardList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Production Order";
    CardPageId = "Firm Planned Prod. Order";
    Caption = 'Job Card/Production Order';
    SourceTableView = sorting(Status, "No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Job Card/Prod. Order No';
                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field(Color; rec.Color)
                {
                    ApplicationArea = All;
                }

                field("Wash Type"; rec."Wash Type")
                {
                    ApplicationArea = All;
                }

                field(Fabric; rec.Fabric)
                {
                    ApplicationArea = All;
                }

                field("Gament Type"; rec."Gament Type")
                {
                    ApplicationArea = All;
                }

                field("Sample/Bulk"; rec."Sample/Bulk")
                {
                    ApplicationArea = All;
                }

                field("Machine Type"; rec."Machine Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}