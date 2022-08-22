page 50336 "Planning Queue List"
{
    PageType = ListPart;
    SourceTable = 50332;
    sourceTableView = where("Resource No" = filter(''));
    Caption = 'Planning Queue';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("TGTSEWFIN Date"; "TGTSEWFIN Date")
                {
                    ApplicationArea = All;
                }

                field("Resource No"; "Resource No")
                {
                    ApplicationArea = All;
                }

                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                    //TableRelation = "Style Master"."No.";
                }
            }
        }
    }  
}