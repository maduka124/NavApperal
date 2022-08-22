page 71012631 "Print Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Print Type";
    CardPageId = "Print Type Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Print Type No';
                }

                field("Print Type Name"; "Print Type Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}