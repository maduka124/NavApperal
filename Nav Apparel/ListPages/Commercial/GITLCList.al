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
                field("GITLCNo."; Rec."GITLCNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Suppler Name"; Rec."Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field("ContractLC No"; Rec."ContractLC No")
                {
                    ApplicationArea = All;
                }

                field("B2B LC No."; Rec."B2B LC No.")
                {
                    ApplicationArea = All;
                    Caption = 'B2B LC No';
                }

                field("B2B LC Value"; Rec."B2B LC Value")
                {
                    ApplicationArea = All;
                }

                field("B2B LC Balance"; Rec."B2B LC Balance")
                {
                    ApplicationArea = All;
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
        GITBaseonLCLineRec: Record GITBaseonLCLine;
    begin
        GITBaseonLCLineRec.SetRange("GITLCNo.", Rec."GITLCNo.");
        GITBaseonLCLineRec.DeleteAll();
    end;
}