page 50748 RTCAWHeaderList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = RTCAWCard;
    SourceTable = RTCAWHeader;
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
                    Caption = 'Document No';
                }

                field("JoB Card No"; rec."JoB Card No")
                {
                    ApplicationArea = all;
                }

                field("Req No"; rec."Req No")
                {
                    ApplicationArea = all;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = all;
                }

                field(CustomerName; rec.CustomerName)
                {
                    ApplicationArea = all;
                    Caption = 'Customer';
                }

                field("Gate Pass"; rec."Gate Pass")
                {
                    ApplicationArea = all;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        RTCAWLineRec: Record RTCAWLine;
    begin

        if rec.status = rec.Status::Posted then
            Error('Entry already posted. Cannot delete.');

        RTCAWLineRec.Reset();
        RTCAWLineRec.SetRange("No.", rec."No.");
        if RTCAWLineRec.FindSet() then
            RTCAWLineRec.DeleteAll();

    end;

}