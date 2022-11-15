page 50728 WorkCenterList
{
    PageType = List;
    Caption = 'Work Center List';
    SourceTable = "Work Center";
    SourceTableView = where("Linked To Service Item" = filter(true));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Name; Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Select; Select)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}