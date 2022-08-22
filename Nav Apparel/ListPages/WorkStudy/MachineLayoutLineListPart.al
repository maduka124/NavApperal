page 50482 "Machine Layout Listpart"
{
    PageType = ListPart;
    SourceTable = "Machine Layout Line1";
    SourceTableView = where("WP No" = filter(0));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field(Code; Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Op Code';
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Machine Name"; "Machine Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Machine';
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Minutes; Minutes)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Target; Target)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}