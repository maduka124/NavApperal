page 50784 "Maning Levels Listpart1"
{
    PageType = ListPart;
    SourceTable = "NavApp Planning Lines";
    Editable = false;
    Caption = 'Planned Lines';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Resource  No."; "Resource No.")
                {
                    ApplicationArea = All;
                    Caption = 'Planned Lines No';
                }

                field("Resource Name"; "Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Planned Line Name';
                }
            }
        }
    }
}