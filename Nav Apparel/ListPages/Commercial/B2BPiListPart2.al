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
                field(Select; Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("PI No."; "PI No.")
                {
                    ApplicationArea = All;
                }

                field("PI Date"; "PI Date")
                {
                    ApplicationArea = All;
                }

                field("PI Value"; "PI Value")
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
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    B2BLCPIRec: Record "B2BLCPI";
                    B2BRec: Record B2BLCMaster;
                    B2B1Rec: Record B2BLCMaster;
                    "LC/ContractNo": Code[20];
                    "Tot B2B LC Opened (Value)": Decimal;
                begin

                    B2BLCPIRec.Reset();
                    B2BLCPIRec.SetRange("B2BNo.", "B2BNo.");
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
                        until B2BLCPIRec.Next() = 0;
                    end
                    else
                        Error('Select records.');

                    //Delete from line table
                    B2BLCPIRec.Reset();
                    B2BLCPIRec.SetRange("B2BNo.", "B2BNo.");
                    B2BLCPIRec.SetFilter(Select, '=%1', true);
                    if B2BLCPIRec.FindSet() then
                        B2BLCPIRec.DeleteAll();

                    CodeUnitNav.CalQtyB2B("B2BNo.");
                    CurrPage.Update();


                    //Calculate B2B LC opened  and %
                    B2BRec.Reset();
                    B2BRec.SetRange("No.", "B2BNo.");
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