page 71012708 "Dependency Parameters"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Dependency Parameters";
    CardPageId = "Dependency Parameters Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }
                field("Dependency Group"; "Dependency Group")
                {
                    ApplicationArea = All;
                }

                field("Action Type"; "Action Type")
                {
                    ApplicationArea = All;
                }

                field("Action Description"; "Action Description")
                {
                    ApplicationArea = All;
                }

                field("Gap Days"; "Gap Days")
                {
                    ApplicationArea = All;
                }

                field(Department; Department)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}