page 51230 ServiceScheduleListPart
{
    PageType = ListPart;
    Caption = 'Service Schedule List Part';
    SourceTable = ServiceScheduleLine;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; rec.Select)
                {
                    ApplicationArea = All;
                }

                field("Part No"; rec."Part No")
                {
                    ApplicationArea = All;
                    Caption = 'Part No';
                    Editable = false;
                }

                field("Part Name"; rec."Part Name")
                {
                    ApplicationArea = All;
                    Caption = 'Part Name';
                    Editable = false;
                }

                field("Unit N0."; rec."Unit N0.")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                }
            }
        }
    }

}