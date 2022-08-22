page 50756 JobCardList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Production Order";
    CardPageId = "Firm Planned Prod. Order";
    Caption = 'Job Card/Production Order';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Job Card/Prod. Order No';
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                }

                field(Color; Color)
                {
                    ApplicationArea = All;
                }

                field("Wash Type"; "Wash Type")
                {
                    ApplicationArea = All;
                }

                field(Fabric; Fabric)
                {
                    ApplicationArea = All;
                }

                field("Gament Type"; "Gament Type")
                {
                    ApplicationArea = All;
                }

                field("Sample/Bulk"; "Sample/Bulk")
                {
                    ApplicationArea = All;
                }

                field("Machine Type"; "Machine Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}