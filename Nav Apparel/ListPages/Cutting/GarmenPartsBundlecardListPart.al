page 51272 BundleCardGMTPartListPart
{
    PageType = ListPart;
    SourceTable = GarmentPartsBundleCard;
    Caption = 'Available Garment Parts';
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

                    GMTpart1Rec: Record GarmentPartsBundleCard;
                    GMTpart2Rec: Record GarmentPartsBundleCard2;

                begin
                    // GMTPartRec.Reset();
                    // GMTPartRec.DeleteAll();

                    GMTpart1Rec.Reset();
                    GMTpart1Rec.SetCurrentKey(No);
                    GMTpart1Rec.SetRange(Select, true);

                    if GMTpart1Rec.FindSet() then begin
                        repeat
                            GMTpart2Rec.Reset();
                            GMTpart2Rec.SetRange("No.", GMTpart1Rec.No);
                            GMTpart2Rec.SetRange(BundleCardNo, GMTpart1Rec.BundleCardNo);
                            if not GMTpart2Rec.FindSet() then begin
                                GMTpart2Rec.Init();
                                GMTpart2Rec."No." := GMTpart1Rec.No;
                                GMTpart2Rec.BundleCardNo := GMTpart1Rec.BundleCardNo;
                                GMTpart2Rec.Description := GMTpart1Rec.Description;
                                GMTpart2Rec.Insert();

                                GMTpart1Rec.Select := false;
                                GMTpart1Rec.Modify();
                                CurrPage.Update();
                            end;
                        until GMTpart1Rec.Next() = 0;
                    end
                    else
                        Error('Record Already exist');
                end;
            }
        }
    }
}