page 51272 BundleCardGMTPartListPart
{
    PageType = ListPart;
    SourceTable = GarmentPartsBundleCard;
    Caption = 'Available Garment Parts';

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

                field("No."; Rec.No)
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
            action(Add)
            {
                ApplicationArea = All;
                Image = Add;

                trigger OnAction()
                var
                    GMTPartRec: Record GarmentPartsBundleCard2;
                    GMTPart2Rec: Record GarmentPartsBundleCard;
                // GMTpart1Rec: Record GarmentPartsBundleCard;
                // GMTpart2Rec: Record GarmentPartsBundleCard2;

                begin
                    // GMTPartRec.Reset();
                    // GMTPartRec.DeleteAll();

                    // GMTpart1Rec.Reset();
                    // GMTpart1Rec.SetCurrentKey(No);
                    // GMTpart1Rec.SetRange(Select, true);

                    // if GMTpart1Rec.FindSet() then begin
                    //     repeat
                    //         GMTpart2Rec.Reset();
                    //         GMTpart2Rec.SetRange("No.", GMTpart1Rec.No);
                    //         GMTpart2Rec.SetRange(BundleCardNo, GMTpart1Rec.BundleCardNo);
                    //         if not GMTpart2Rec.FindSet() then begin
                    //             GMTpart2Rec.Init();
                    //             GMTpart2Rec."No." := GMTpart1Rec.No;
                    //             GMTpart2Rec.BundleCardNo := GMTpart1Rec.BundleCardNo;
                    //             GMTpart2Rec.Description := GMTpart1Rec.Description;
                    //             GMTpart2Rec.Insert();

                    //             GMTpart1Rec.Select := false;
                    //             GMTpart1Rec.Modify();
                    //             CurrPage.Update();
                    //         end;
                    //     until GMTpart1Rec.Next() = 0;
                    // end;
                    // Error('Select GMTpart');

                    GMTPart2Rec.Reset();
                    GMTPart2Rec.SetFilter(Select, '=%1', GMTPart2Rec.Select);
                    if GMTPart2Rec.FindSet() then begin
                        repeat
                            GMTPartRec.Reset();
                            GMTPartRec.SetRange("No.", Rec.No);
                            GMTPartRec.SetRange(BundleCardNo, Rec.BundleCardNo);
                            if not GMTPartRec.FindSet() then begin
                                GMTPartRec.Init();
                                GMTPartRec."No." := Rec.No;
                                GMTPartRec.Description := Rec.Description;
                                GMTPartRec.BundleCardNo := Rec.BundleCardNo;
                                GMTPartRec.Insert();

                                GMTPart2Rec.Select := false;
                                GMTPart2Rec.Modify();
                                CurrPage.Update();
                            end;
                        // else begin
                        //     GMTPart2Rec.Select := false;
                        //     GMTPart2Rec.Modify();
                        //     CurrPage.Update();
                        //     Error('Record already exists');
                        // end;
                        until GMTPart2Rec.Next() = 0;
                        // Error('Select garment part');
                    end;

                end;
            }
        }
    }
}