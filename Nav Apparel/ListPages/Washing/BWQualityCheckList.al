page 50742 BWQualityCheckList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BWQualityCheckHeader;
    CardPageId = BWQualityCheck;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'B/W Quality Check No';
                }

                field("Sample Req No"; "Sample Req No")
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
        BWqualityCheckLine2Rec.SetRange(No, "No.");

        if BWqualityCheckLine2Rec.FindSet() then
            BWqualityCheckLine2Rec.DeleteAll();
    end;
}