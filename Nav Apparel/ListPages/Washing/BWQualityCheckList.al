page 50742 BWQualityCheckList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BWQualityCheckHeader;
    CardPageId = BWQualityCheck;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'B/W Quality Check No';
                }

                field("Sample Req No";rec. "Sample Req No")
                {
                    ApplicationArea = All;

                }

                field("BW QC Date"; rec."BW QC Date")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        BWqualityCheckLine2Rec: Record BWQualityLine2;
    begin
        BWqualityCheckLine2Rec.Reset();
        BWqualityCheckLine2Rec.SetRange(No, rec."No.");

        if BWqualityCheckLine2Rec.FindSet() then
            BWqualityCheckLine2Rec.DeleteAll();
    end;
}