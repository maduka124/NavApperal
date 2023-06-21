page 50504 "Style Master Contract ListPart"
{
    PageType = ListPart;
    SourceTable = "Style Master";
    SourceTableView = where(Status = filter(Confirmed), AssignedContractNo = filter(''));
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
                }

                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Order Qty"; Rec."Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    "StyleMasterRec": Record "Style Master";
                    "Contract/LCStyleRec": Record "Contract/LCStyle";
                    "Contract/LCMasterRec": Record "Contract/LCMaster";
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    CodeUnit2Nav: Codeunit NavAppCodeUnit2;
                    ContractNo1: Code[20];
                    "B2BLC%": Decimal;
                begin
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetCurrentKey("Buyer No.");
                    StyleMasterRec.SetRange("Buyer No.", Rec."Buyer No.");
                    StyleMasterRec.SetFilter(Select, '=%1', true);
                    if StyleMasterRec.FindSet() then begin

                        repeat
                            //add new po to the PI
                            ContractNo1 := StyleMasterRec.ContractNo;
                            "Contract/LCStyleRec".Init();
                            "Contract/LCStyleRec"."No." := StyleMasterRec.ContractNo;
                            "Contract/LCStyleRec"."style No." := StyleMasterRec."No.";
                            "Contract/LCStyleRec"."Style Name" := StyleMasterRec."Style No.";
                            "Contract/LCStyleRec"."Buyer No." := StyleMasterRec."Buyer No.";
                            "Contract/LCStyleRec".Qty := StyleMasterRec."Order Qty";
                            "Contract/LCStyleRec"."Created User" := UserId;
                            "Contract/LCStyleRec".Insert();

                            //Update Style master contractno
                            StyleMasterRec.AssignedContractNo := Rec.ContractNo;
                            StyleMasterRec.Modify();

                        until StyleMasterRec.Next() = 0;

                    end;

                    //Update Select as false
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("Buyer No.", Rec."Buyer No.");
                    StyleMasterRec.SetFilter(Select, '=%1', true);

                    if StyleMasterRec.FindSet() then begin
                        StyleMasterRec.ModifyAll(Select, false);
                    end;

                    CodeUnitNav.CalQty(ContractNo1);

                    //Calculate B2BLC %
                    "B2BLC%" := CodeUnit2Nav.CalB2BLC_Perccentage(ContractNo1);
                    "Contract/LCMasterRec".Reset();
                    "Contract/LCMasterRec".SetRange("No.", ContractNo1);
                    "Contract/LCMasterRec".FindSet();
                    "Contract/LCMasterRec".BBLC := "B2BLC%";
                    "Contract/LCMasterRec".Modify();

                    CurrPage.Update();
                end;
            }
        }
    }
}