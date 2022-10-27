page 50663 "Cutting Progress ListPart"
{
    PageType = ListPart;
    SourceTable = CuttingProgressLine;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Role ID"; "Role ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Roll ID';
                }

                field("Supplier Batch No."; "Supplier Batch No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Shade; Shade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Width Tag"; "Width Tag")
                {
                    ApplicationArea = All;
                    Caption = 'Tag Width';
                    Editable = false;
                }

                field("Width Act"; "Width Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Width';
                    Editable = false;
                }

                field("Length Tag"; "Length Tag")
                {
                    ApplicationArea = All;
                    Caption = 'Tag Length';
                    Editable = false;
                }

                field("Length Act"; "Length Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Length';
                    Editable = false;
                }

                field("Length Allocated"; "Length Allocated")
                {
                    ApplicationArea = All;
                    Caption = 'Allocated Length';
                    Editable = false;
                }

                field("Planned Plies"; "Planned Plies")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Actual Plies"; "Actual Plies")
                {
                    ApplicationArea = All;

                    trigger onvalidate()
                    var

                    begin


                    end;
                }
            }
        }
    }
}