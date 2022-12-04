page 51042 "Dependency Parameters"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Dependency Parameters";
    CardPageId = "Dependency Parameters Card";
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
                    Caption = 'Seq No';
                }
                field("Dependency Group"; rec."Dependency Group")
                {
                    ApplicationArea = All;
                }

                field("Action Type"; rec."Action Type")
                {
                    ApplicationArea = All;
                }

                field("Action Description"; rec."Action Description")
                {
                    ApplicationArea = All;
                }

                field("Gap Days"; rec."Gap Days")
                {
                    ApplicationArea = All;
                }

                field(Department; rec.Department)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}