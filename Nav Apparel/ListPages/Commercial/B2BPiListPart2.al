page 50525 "B2B PI ListPart2"
{
    PageType = ListPart;
    SourceTable = "B2BLCPI";
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

                field("PI No."; Rec."PI No.")
                {
                    ApplicationArea = All;
                }

                field("PI Date"; Rec."PI Date")
                {
                    ApplicationArea = All;
                }

                field("PI Value"; Rec."PI Value")
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
                    PIHeaderRec: Record "PI Details Header";
                    PIPORec: Record "PI Po Details";
                    POHeaderRec: Record "Purchase Header";
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    B2BLCPIRec: Record "B2BLCPI";
                    B2BRec: Record B2BLCMaster;
                    B2B1Rec: Record B2BLCMaster;
                    "LC/ContractNo": Code[20];
                    "Tot B2B LC Opened (Value)": Decimal;
                begin

                    B2BLCPIRec.Reset();
                    B2BLCPIRec.SetRange("B2BNo.", Rec."B2BNo.");
                    B2BLCPIRec.SetFilter(Select, '=%1', true);

                    if B2BLCPIRec.FindSet() then begin
                        repeat
                            //Update Purchase order pi no
                            PIHeaderRec.Reset();
                            PIHeaderRec.SetRange("No.", B2BLCPIRec."PI No.");
                            PIHeaderRec.FindSet();
                            PIHeaderRec.Select := false;
                            PIHeaderRec.AssignedB2BNo := '';
                            PIHeaderRec.Modify();

                            //Get All POs in the PI
                            PIPORec.Reset();
                            PIPORec.SetRange("PI No.", B2BLCPIRec."PI No.");
                            if PIPORec.FindSet() then
                                repeat
                                    //Update LCContarct No in the PO
                                    POHeaderRec.Reset();
                                    POHeaderRec.SetRange("No.", PIPORec."PO No.");
                                    if POHeaderRec.FindSet() then begin
                                        POHeaderRec."LC/Contract No." := '';
                                        POHeaderRec.Modify();
                                    end;
                                until PIPORec.Next() = 0;

                        until B2BLCPIRec.Next() = 0;
                    end
                    else
                        Error('Select records.');

                    //Delete from line table
                    B2BLCPIRec.Reset();
                    B2BLCPIRec.SetRange("B2BNo.", Rec."B2BNo.");
                    B2BLCPIRec.SetFilter(Select, '=%1', true);
                    if B2BLCPIRec.FindSet() then
                        B2BLCPIRec.DeleteAll();

                    CodeUnitNav.CalQtyB2B(Rec."B2BNo.");
                    CurrPage.Update();


                    //Calculate B2B LC opened  and %
                    B2BRec.Reset();
                    B2BRec.SetRange("No.", Rec."B2BNo.");
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