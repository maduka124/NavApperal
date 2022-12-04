page 50780 "Costing Planning Para Card"
{
    PageType = Card;
    SourceTable = CostingPlanningParaHeader;
    Caption = 'Costing Planning Parameter Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; rec.No)
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                    Editable = true;
                }
            }

            group("SMV 1 - 16 Min")
            {
                part("Costing Plan Para Listpart1"; "Costing Plan Para Listpart1")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = field("No");
                }
            }

            group("SMV 17 - 20 Min")
            {
                part("Costing Plan Para Listpart2"; "Costing Plan Para Listpart2")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = field("No");
                }
            }

            group("SMV 21 - 30 Min")
            {
                part("Costing Plan Para Listpart3"; "Costing Plan Para Listpart3")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = field("No");
                }
            }

            group("SMV 31 - 100 Min")
            {
                part("Costing Plan Para Listpart4"; "Costing Plan Para Listpart4")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = field("No");
                }
            }
        }
    }

    trigger OnOpenPage()
    var

    begin
        CurrPage.Editable(true);
    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
        if Get_Count() = 1 then
            Error('You cannot put more than one item');
    end;


    procedure Get_Count(): Integer
    var
        CostPlannParaHeadRec: Record CostingPlanningParaHeader;
    begin
        CostPlannParaHeadRec.Reset();
        CostPlannParaHeadRec.SetFilter("No", '<>%1', rec."No");
        if CostPlannParaHeadRec.FindSet() then
            exit(CostPlannParaHeadRec.Count)
        else
            exit(0);
    end;
}