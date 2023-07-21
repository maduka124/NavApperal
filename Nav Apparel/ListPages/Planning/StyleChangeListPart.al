page 51372 StyleChangeListPart
{
    PageType = ListPart;
    SourceTable = StyleChangeLine;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Resource No."; rec."Resource No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'No of Style Changes';
                }
            }
        }
    }
}