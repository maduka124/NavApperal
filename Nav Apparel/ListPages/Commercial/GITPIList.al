page 50538 "GIT Baseon PI List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GITBaseonPI;
    CardPageId = "GIT Baseon PI Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("GITPINo."; "GITPINo.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Suppler Name"; "Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field("Invoice No"; "Invoice No")
                {
                    ApplicationArea = All;
                }

                field("Invoice Date"; "Invoice Date")
                {
                    ApplicationArea = All;
                }

                field("Invoice Value"; "Invoice Value")
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
        GITBaseonPILineRec.SetRange("GITPINo.", "GITPINo.");
        GITBaseonPILineRec.DeleteAll();

        GITPIPIRec.Reset();
        GITPIPIRec.SetRange("GITPINo.", "GITPINo.");
        GITPIPIRec.DeleteAll();
    end;
}