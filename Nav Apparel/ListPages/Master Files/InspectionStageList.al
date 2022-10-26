page 71012612 "Inspection Stage List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = InspectionStage;
    CardPageId = "Inspection Stage Card";
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
                    Caption = 'Inspection Stage No';
                }

                field("Inspection Stage"; "Inspection Stage")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}