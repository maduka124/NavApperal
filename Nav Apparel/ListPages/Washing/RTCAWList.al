page 50748 RTCAWHeaderList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = RTCAWCard;
    SourceTable = RTCAWHeader;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No';
                }

                field("JoB Card No"; "JoB Card No")
                {
                    ApplicationArea = all;
                }

                field("Req No"; "Req No")
                {
                    ApplicationArea = all;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = all;
                }

                field(CustomerName; CustomerName)
                {
                    ApplicationArea = all;
                    Caption = 'Customer';
                }

                field("Gate Pass"; "Gate Pass")
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

        if status = Status::Posted then
            Error('Entry already posted. Cannot delete.');

        RTCAWLineRec.Reset();
        RTCAWLineRec.SetRange("No.", "No.");
        if RTCAWLineRec.FindSet() then
            RTCAWLineRec.DeleteAll();

    end;

}