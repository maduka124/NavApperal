page 51273 BundleCardGMTPartListPart2
{
    PageType = ListPart;
    SourceTable = GarmentPartsBundleCard2;
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
                    GMTPartRec: Record GarmentPartsBundleCard2;
                begin
                    GMTPartRec.Reset();
                    // GMTPartRec.SetRange("No.", Rec."No.");
                    GMTPartRec.SetCurrentKey("No.");
                    GMTPartRec.SetRange(Select, true);
                    if GMTPartRec.FindSet() then
                        repeat
                            GMTPartRec.DeleteAll();
                        until GMTPartRec.Next() = 0;
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