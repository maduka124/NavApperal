page 50538 "GIT Baseon PI List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GITBaseonPI;
    CardPageId = "GIT Baseon PI Card";
    Editable = false;
    SourceTableView = sorting("GITPINo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("GITPINo."; Rec."GITPINo.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Suppler Name"; Rec."Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                }

                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                }

                field("Invoice Value"; Rec."Invoice Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        GITBaseonPILineRec: Record GITBaseonPILine;
        GITPIPIRec: Record GITPIPI;
    begin
        GITBaseonPILineRec.Reset();
        GITBaseonPILineRec.SetRange("GITPINo.", Rec."GITPINo.");
        GITBaseonPILineRec.DeleteAll();

        GITPIPIRec.Reset();
        GITPIPIRec.SetRange("GITPINo.", Rec."GITPINo.");
        GITPIPIRec.DeleteAll();
    end;
}