page 50688 AWQualityCheck
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AWQualityCheckHeader;
    CardPageId = QCHeaderCardAW;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'AW Quality Check No';
                }

                field("Job Card No"; "Job Card No")
                {
                    ApplicationArea = All;
                }

                field("Sample Req No"; "Sample Req No")
                {
                    ApplicationArea = All;
                }

                field(CustomerName; CustomerName)
                {
                    ApplicationArea = All;
                    Caption = 'Customer';
                }

                field("Req date"; "Req date")
                {
                    ApplicationArea = All;
                }

                field("QC AW Date"; "QC AW Date")
                {
                    ApplicationArea = All;
                    Caption = 'AW QC Date';
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        AWQualityCheckLineRec: Record AWQualityCheckLine;
    begin
        AWQualityCheckLineRec.Reset();
        AWQualityCheckLineRec.SetRange(No, "No.");
        if AWQualityCheckLineRec.FindSet() then
            AWQualityCheckLineRec.DeleteAll();
    end;

}