page 71012845 ModelList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Model;
    CardPageId = "Model Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Model No';
                }

                field("Model Name"; "Model Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}