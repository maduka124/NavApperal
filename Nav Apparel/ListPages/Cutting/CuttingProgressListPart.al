page 51000 "Cutting Progress ListPart"
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
                field("Role ID"; Rec."Role ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Roll ID';
                }

                field("Supplier Batch No."; Rec."Supplier Batch No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Shade; Rec.Shade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Width Tag"; Rec."Width Tag")
                {
                    ApplicationArea = All;
                    Caption = 'Tag Width';
                    Editable = false;
                }

                field("Width Act"; Rec."Width Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Width';
                    Editable = false;
                }

                field("Length Tag"; Rec."Length Tag")
                {
                    ApplicationArea = All;
                    Caption = 'Tag Length';
                    Editable = false;
                }

                field("Length Act"; Rec."Length Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Length';
                    Editable = false;
                }

                field("Length Allocated"; Rec."Length Allocated")
                {
                    ApplicationArea = All;
                    Caption = 'Allocated Length';
                    Editable = false;
                }

                field("Planned Plies"; Rec."Planned Plies")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Actual Plies"; Rec."Actual Plies")
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