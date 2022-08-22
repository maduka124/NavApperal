page 50657 "Lay Sheet Line5"
{
    PageType = ListPart;
    SourceTable = LaySheetLine5;
    SourceTableView = sorting("LaySheetNo.", Type);
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Docket; Docket)
                {
                    ApplicationArea = All;
                }

                field(Marker; Marker)
                {
                    ApplicationArea = All;
                }

                field(Issuing; Issuing)
                {
                    ApplicationArea = All;
                }

                field(Laying; Laying)
                {
                    ApplicationArea = All;
                }

                field(Cutting; Cutting)
                {
                    ApplicationArea = All;
                }

                field(Return; Return)
                {
                    ApplicationArea = All;
                }

                field(Bundling; Bundling)
                {
                    ApplicationArea = All;
                }

                field(Dispatch; Dispatch)
                {
                    ApplicationArea = All;
                }
            }
        }
    }



}