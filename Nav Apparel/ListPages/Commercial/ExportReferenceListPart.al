page 51243 "Export Ref ListPart"
{
    PageType = ListPart;
    SourceTable = ExportReferenceLine;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Invoice No"; rec."Invoice No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Invoice Date"; rec."Invoice Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Inv Value"; rec."Inv Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Fty Inv No."; rec."Fty Inv No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}