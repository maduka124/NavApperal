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
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Op Code';
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Machine Name"; rec."Machine Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Machine';
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Minutes; rec.Minutes)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Target; rec.Target)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}