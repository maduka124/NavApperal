page 71012819 "YY Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "YY Type";
    CardPageId = "YY Type Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'YY Type No';
                }

                field("YY Type Desc"; "YY Type Desc")
                {
                    ApplicationArea = All;
                    Caption = 'YY Type Description';
                }
            }
        }
    }
}