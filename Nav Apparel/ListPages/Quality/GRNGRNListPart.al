page 50676 GRNGRNListPart
{
    PageType = List;
    Caption = 'GRN List';
    SourceTable = "Purch. Rcpt. Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'GRN';
                }
            }
        }
    }
}