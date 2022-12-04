page 50648 "Print Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Print Type";
    CardPageId = "Print Type Card";
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
                    Caption = 'Print Type No';
                }

                field("Print Type Name"; Rec."Print Type Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}