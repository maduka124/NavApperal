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
                field(Select; Select)
                {
                    ApplicationArea = All;
                }

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Order Qty"; "Order Qty")
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
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    ContractNo1: Code[20];
                begin

                    StyleMasterRec.Reset();
                    StyleMasterRec.SetCurrentKey("Buyer No.");
                    StyleMasterRec.SetRange("Buyer No.", "Buyer No.");
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
                            StyleMasterRec.AssignedContractNo := ContractNo;
                            StyleMasterRec.Modify();

                        until StyleMasterRec.Next() = 0;

                    end;

                    //Update Select as false
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("Buyer No.", "Buyer No.");
                    StyleMasterRec.SetFilter(Select, '=%1', true);

                    if StyleMasterRec.FindSet() then begin
                        StyleMasterRec.ModifyAll(Select, false);
                    end;


                    CodeUnitNav.CalQty(ContractNo1);
                    CurrPage.Update();
                end;
            }
        }
    }
}