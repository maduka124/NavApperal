page 50743 BWQualityCheckline1
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Washing Sample Requsition Line";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No."; "Line No.")
                {
                    Caption = 'Seq No';
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Fabric Description"; "Fabric Description")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Req Qty"; "Req Qty")
                {
                    Caption = 'Req. Qty';
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }
}