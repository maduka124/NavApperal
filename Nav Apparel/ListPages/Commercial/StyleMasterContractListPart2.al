page 50505 "StyleMasterContract ListPart 2"
{
    PageType = ListPart;
    SourceTable = "Contract/LCStyle";
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
                Image = RemoveLine;

                trigger OnAction()
                var
                    "StyleMasterRec": Record "Style Master";
                    "Contract/LCMasterRec": Record "Contract/LCMaster";
                    "Contract/LCStyleRec": Record "Contract/LCStyle";
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    "B2BLC%": Decimal;
                    CodeUnit2Nav: Codeunit NavAppCodeUnit2;
                begin

                    "Contract/LCStyleRec".Reset();
                    "Contract/LCStyleRec".SetRange("No.", Rec."No.");
                    "Contract/LCStyleRec".SetFilter(Select, '=%1', true);

                    if "Contract/LCStyleRec".FindSet() then begin
                        repeat
                            //Update Purchase order pi no
                            StyleMasterRec.Reset();
                            StyleMasterRec.SetRange("No.", "Contract/LCStyleRec"."Style No.");
                            StyleMasterRec.FindSet();
                            StyleMasterRec.Select := false;
                            StyleMasterRec.AssignedContractNo := '';
                            StyleMasterRec.Modify();
                        until "Contract/LCStyleRec".Next() = 0;
                    end;

                    //Delete from line table
                    "Contract/LCStyleRec".Reset();
                    "Contract/LCStyleRec".SetRange("No.", Rec."No.");
                    "Contract/LCStyleRec".SetFilter(Select, '=%1', true);
                    "Contract/LCStyleRec".DeleteAll();

                    CodeUnitNav.CalQty(Rec."No.");

                    //Calculate B2BLC %
                    "B2BLC%" := CodeUnit2Nav.CalB2BLC_Perccentage(Rec."No.");
                    "Contract/LCMasterRec".Reset();
                    "Contract/LCMasterRec".SetRange("No.", Rec."No.");
                    "Contract/LCMasterRec".FindSet();
                    "Contract/LCMasterRec".BBLC := "B2BLC%";
                    "Contract/LCMasterRec".Modify();

                    CurrPage.Update();
                end;
            }
        }
    }


}