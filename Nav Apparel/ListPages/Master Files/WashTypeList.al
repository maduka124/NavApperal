page 51012 "Wash Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Wash Type";
    CardPageId = "Wash Type Card";
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
                    Caption = 'Wash Type No';
                }

                field("Wash Type Name"; Rec."Wash Type Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}