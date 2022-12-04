page 50449 "Needle Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = NeedleType;
    CardPageId = "Needle Type Card";
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
                    Caption = 'Needle Type No';
                }

                field("Needle Description"; rec."Needle Description")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}