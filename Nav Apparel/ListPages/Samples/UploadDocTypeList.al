page 50416 "Upload Document Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Upload Document Type";
    CardPageId = "Upload Document Type Card";
    SourceTableView = sorting("Doc No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Doc No."; "Doc No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type No';
                }

                field("Doc Name"; "Doc Name")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type Name';
                }
            }
        }
    }
}