page 51273 BundleCardGMTPartListPart2
{
    PageType = ListPart;
    SourceTable = GarmentPartsBundleCard2Right;
    SourceTableView = sorting(Description) order(ascending);
    Caption = 'Selected Garment Parts';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Rec."Select")
                {
                    ApplicationArea = All;

                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'GMT Part No';

                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Remove)
            {
                ApplicationArea = All;
                Image = RemoveLine;

                trigger OnAction()
                var
                    GMTPartRec: Record GarmentPartsBundleCard2Right;
                begin
                    GMTPartRec.Reset();
                    GMTPartRec.SetRange(BundleCardNo, Rec.BundleCardNo);
                    GMTPartRec.SetRange(Select, true);
                    if GMTPartRec.FindSet() then
                        GMTPartRec.DeleteAll()
                    else
                        Error('Please select a record.');
                end;
            }
        }
    }
}