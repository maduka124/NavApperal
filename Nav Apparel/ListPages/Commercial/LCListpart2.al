page 51355 "LC ListPart 2"
{
    PageType = ListPart;
    SourceTable = "LC Style 2";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Qty"; Rec."Qty")
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
                Image = Delete;

                trigger OnAction()
                var
                    LCStyle2Rec: Record "LC Style 2";
                    LCMasterRec: Record LCMaster;
                    LCStyle: Record "LC Style";
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    ContractNo1: Code[20];
                    "B2BLC%": Decimal;
                    CodeUnit2Nav: Codeunit NavAppCodeUnit2;
                begin
                    LCStyle2Rec.Reset();
                    LCStyle2Rec.SetFilter(Select, '=%1', true);
                    if LCStyle2Rec.FindSet() then begin
                        repeat
                            ContractNo1 := Rec."LC No";
                            LCStyle.Reset();
                            LCStyle.SetRange("Style No.", LCStyle2Rec."Style No.");
                            if LCStyle.FindSet() then begin
                                LCStyle."Assign LC No" := '';
                                LCStyle.Modify();
                            end;

                            LCStyle2Rec.Delete();

                        until LCStyle2Rec.Next() = 0;
                        CurrPage.Update();
                    end;
                    CodeUnitNav.CalQtyMasterLC(ContractNo1);

                    //Calculate B2BLC %
                    "B2BLC%" := CodeUnit2Nav.CalB2BLC_PerccentageMasterLC(ContractNo1);
                    LCMasterRec.Reset();
                    LCMasterRec.SetRange("No.", ContractNo1);
                    LCMasterRec.FindSet();
                    LCMasterRec.BBLC := "B2BLC%";
                    LCMasterRec.Modify();

                    CurrPage.Update();
                end;
            }





        }
    }


}