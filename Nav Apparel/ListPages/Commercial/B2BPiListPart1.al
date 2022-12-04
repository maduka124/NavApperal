page 50523 "B2B PI ListPart1"
{
    PageType = ListPart;
    SourceTable = "PI Details Header";
    SourceTableView = where(AssignedB2BNo = filter(''));
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

                field("PI No"; Rec."PI No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PI Date"; Rec."PI Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PI Value"; Rec."PI Value")
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
                    PIHeaderRec: Record "PI Details Header";
                    PIPORec: Record "PI Po Details";
                    POHeaderRec: Record "Purchase Header";
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    B2BLCPIRec: Record "B2BLCPI";
                    B2BNo1: Code[20];
                    B2BRec: Record B2BLCMaster;
                    B2B1Rec: Record B2BLCMaster;
                    "LC/ContractNo": Code[20];
                    "LC/ContractNo1": Code[20];
                    "Tot B2B LC Opened (Value)": Decimal;
                begin
                    CurrPage.Update();

                    PIHeaderRec.Reset();
                    PIHeaderRec.SetCurrentKey("Supplier No.");
                    PIHeaderRec.SetRange("Supplier No.", Rec."Supplier No.");
                    PIHeaderRec.SetFilter(Select, '=%1', true);

                    if PIHeaderRec.FindSet() then begin

                        repeat

                            B2BNo1 := PIHeaderRec.B2BNo;
                            B2BLCPIRec.Init();
                            B2BLCPIRec."B2BNo." := PIHeaderRec.B2BNo;
                            B2BLCPIRec."Suppler No." := PIHeaderRec."Supplier No.";
                            B2BLCPIRec."PI No." := PIHeaderRec."No.";
                            B2BLCPIRec."PI Date" := PIHeaderRec."PI Date";
                            B2BLCPIRec."PI Value" := PIHeaderRec."PI Value";
                            B2BLCPIRec."Created User" := UserId;
                            B2BLCPIRec.Insert();

                            //Get LC/ContractNo
                            B2B1Rec.Reset();
                            B2B1Rec.SetRange("No.", PIHeaderRec.B2BNo);
                            if B2B1Rec.FindSet() then
                                "LC/ContractNo1" := B2B1Rec."LC/Contract No.";

                            //Get All POs in the PI
                            PIPORec.Reset();
                            PIPORec.SetRange("PI No.", PIHeaderRec."No.");
                            if PIPORec.FindSet() then
                                repeat
                                    //Update LCContarct No in the PO
                                    POHeaderRec.Reset();
                                    POHeaderRec.SetRange("No.", PIPORec."PO No.");
                                    if POHeaderRec.FindSet() then begin
                                        POHeaderRec."LC/Contract No." := "LC/ContractNo1";
                                        POHeaderRec.Modify();
                                    end;
                                until PIPORec.Next() = 0;


                            //Update PI Header with  B2Bno
                            PIHeaderRec.AssignedB2BNo := B2BNo1;
                            PIHeaderRec.Modify();

                        until PIHeaderRec.Next() = 0;

                    end
                    else
                        Error('Select records.');

                    //Update Select as false
                    PIHeaderRec.Reset();
                    PIHeaderRec.SetRange("Supplier No.", Rec."Supplier No.");
                    PIHeaderRec.SetFilter(Select, '=%1', true);

                    if PIHeaderRec.FindSet() then begin
                        PIHeaderRec.ModifyAll(Select, false);
                    end;

                    CodeUnitNav.CalQtyB2B(B2BNo1);
                    CurrPage.Update();


                    //Calculate B2B LC opened  and %
                    B2BRec.Reset();
                    B2BRec.SetRange("No.", B2BNo1);
                    if B2BRec.FindSet() then begin
                        "LC/ContractNo" := B2BRec."LC/Contract No.";

                        B2B1Rec.Reset();
                        B2B1Rec.SetRange("LC/Contract No.", "LC/ContractNo");

                        if B2B1Rec.FindSet() then begin
                            repeat
                                "Tot B2B LC Opened (Value)" += B2B1Rec."B2B LC Value";
                            until B2B1Rec.Next() = 0;
                        end;

                        B2BRec."B2B LC Opened (Value)" := "Tot B2B LC Opened (Value)";
                        B2BRec."B2B LC Opened (%)" := ("Tot B2B LC Opened (Value)" / B2BRec."LC Value") * 100;
                        B2BRec.Balance := B2BRec."B2B LC Limit" - "Tot B2B LC Opened (Value)";
                        B2BRec.Modify();
                    end
                    else
                        Error('Error in calculating (B2B LC Opened Value)');
                end;
            }
        }
    }
}