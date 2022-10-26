page 50655 "Lay Sheet Line4"
{
    PageType = ListPart;
    SourceTable = LaySheetLine4;
    SourceTableView = sorting("LaySheetNo.", "Line No.");
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Shade; Shade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Batch; Batch)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Role ID"; "Role ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ticket Length"; "Ticket Length")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Allocated Qty"; "Allocated Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Planned Plies"; "Planned Plies")
                {
                    ApplicationArea = All;
                }

                field("Actual Plies"; "Actual Plies")
                {
                    ApplicationArea = All;
                }

                field(Damages; Damages)
                {
                    ApplicationArea = All;
                }

                field(Joints; Joints)
                {
                    ApplicationArea = All;
                }

                field(Ends; Ends)
                {
                    ApplicationArea = All;
                }

                field("Shortage +"; "Shortage +")
                {
                    ApplicationArea = All;
                }

                field("Shortage -"; "Shortage -")
                {
                    ApplicationArea = All;
                }

                field("Binding Length"; "Binding Length")
                {
                    ApplicationArea = All;
                }
                field(Comments; Comments)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}