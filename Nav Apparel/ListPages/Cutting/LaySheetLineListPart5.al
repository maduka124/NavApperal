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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Docket; Rec.Docket)
                {
                    ApplicationArea = All;
                }

                field(Marker; Rec.Marker)
                {
                    ApplicationArea = All;
                }

                field(Issuing; Rec.Issuing)
                {
                    ApplicationArea = All;
                }

                field(Laying; Rec.Laying)
                {
                    ApplicationArea = All;
                }

                field(Cutting; Rec.Cutting)
                {
                    ApplicationArea = All;
                }

                field(Return; Rec.Return)
                {
                    ApplicationArea = All;
                }

                field(Bundling; Rec.Bundling)
                {
                    ApplicationArea = All;
                }

                field(Dispatch; Rec.Dispatch)
                {
                    ApplicationArea = All;
                }
            }
        }
    }



}