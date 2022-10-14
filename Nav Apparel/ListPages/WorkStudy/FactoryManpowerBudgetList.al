page 50814 "Factory Manpower Budget List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FactoryManpowerBudgetHeader;
    SourceTableView = sorting(Date, "Factory Name") order(descending);
    CardPageId = "Factory Manpower Budget Card";
    Caption = 'Factory Manpower Budget List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                }

                field(Date; Date)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
    begin
        ManpowBudLineRec.Reset();
        ManpowBudLineRec.SetRange("No.", "No.");
        if ManpowBudLineRec.FindSet() then begin
            ManpowBudLineRec.DeleteAll();
        end;
    end;
}