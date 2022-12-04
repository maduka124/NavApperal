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
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("TGTSEWFIN Date"; rec."TGTSEWFIN Date")
                {
                    ApplicationArea = All;
                }

                field("Resource No"; rec."Resource No")
                {
                    ApplicationArea = All;
                }

                field("Start Date"; rec."Start Date")
                {
                    ApplicationArea = All;
                    //TableRelation = "Style Master"."No.";
                }
            }
        }
    }
}