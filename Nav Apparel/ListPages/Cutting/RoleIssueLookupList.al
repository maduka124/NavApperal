page 50826 RoleIssueLookupList
{
    PageType = List;
    Caption = 'Role Issue No Lookup List';
    SourceTable = RoleIssuingNoteHeader;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("RoleIssuNo."; Rec."RoleIssuNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Roll Issue No';
                }

                field("Req No."; Rec."Req No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Fab Req No';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }
            }
        }
    }
}