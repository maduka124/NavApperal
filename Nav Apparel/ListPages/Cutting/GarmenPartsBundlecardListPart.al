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
                begin
                    // GMTPartRec.Reset();
                    // GMTPartRec.DeleteAll();

                    GMTPart2Rec.Reset();
                    GMTPart2Rec.SetFilter(Select, '=%1', true);
                    if GMTPart2Rec.FindSet() then begin
                        repeat
                        GMTPartRec.Reset();
                            GMTPartRec.SetRange("No.", Rec.No);
                            GMTPartRec.SetRange(BundleCardNo, Rec.BundleCardNo);
                            if not GMTPartRec.FindSet() then begin
                                repeat
                                    GMTPartRec.Init();
                                    GMTPartRec."No." := Rec.No;
                                    GMTPartRec.Description := Rec.Description;
                                    GMTPartRec.BundleCardNo := Rec.BundleCardNo;
                                    GMTPartRec.Insert();
                                    GMTPart2Rec.Select := false;
                                    GMTPart2Rec.Modify();
                                    CurrPage.Update();
                                until GMTPartRec.Next() = 0;
                            end
                            else begin
                                GMTPart2Rec.Select := false;
                                GMTPart2Rec.Modify();
                                CurrPage.Update();
                                Error('Record already exists');
                            end;
                        until GMTPart2Rec.Next() = 0;
                    end;

                end;
            }
        }
    }
}