page 50527 "GIT Baseon LC List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GITBaseonLC;
    CardPageId = "GIT Baseon LC Card";
    Editable = false;
    SourceTableView = sorting("GITLCNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("GITLCNo."; "GITLCNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Suppler Name"; "Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field("ContractLC No"; "ContractLC No")
                {
                    ApplicationArea = All;
                }

                field("B2B LC No."; "B2B LC No.")
                {
                    ApplicationArea = All;
                    Caption = 'B2B LC No';
                }

                field("B2B LC Value"; "B2B LC Value")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Balance"; "B2B LC Balance")
                {
                    ApplicationArea = All;
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
        GITBaseonLCLineRec: Record GITBaseonLCLine;
    begin
        GITBaseonLCLineRec.SetRange("GITLCNo.", "GITLCNo.");
        GITBaseonLCLineRec.DeleteAll();
    end;
}