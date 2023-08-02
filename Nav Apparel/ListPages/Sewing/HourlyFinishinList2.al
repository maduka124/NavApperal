page 51380 "HourlyFinishingListStyle"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "NavApp Prod Plans Details";



    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Factory No."; Rec."Factory No.")
                {
                    ApplicationArea = All;
                }
                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style Name';
                }
            }
        }
    }




   
}