page 51273 BundleCardGMTPartListPart2
{
    PageType = ListPart;
    SourceTable = GarmentPartsBundleCard2;
    Caption = 'Selected Garment Parts';

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
                    GMTPartRec: Record GarmentPartsBundleCard2;
                begin
                    GMTPartRec.Reset();
                    GMTPartRec.SetRange("No.", Rec."No.");
                    GMTPartRec.SetFilter(Select, '=%1', true);
                    if GMTPartRec.FindSet() then
                        GMTPartRec.DeleteAll();

                end;
            }

            // action("Bundle Card Report")
            // {
            //     ApplicationArea = all;
            //     Image = Report;
            // }
        }
    }
}