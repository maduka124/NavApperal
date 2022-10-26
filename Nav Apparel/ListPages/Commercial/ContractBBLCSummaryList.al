page 50792 "Contract BBLC Summary List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Contract/LCMaster";
    CardPageId = ContractBBLCSummaryCard;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Contract No"; "Contract No")
                {
                    ApplicationArea = All;
                    Caption = 'LC/Contract No';
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}