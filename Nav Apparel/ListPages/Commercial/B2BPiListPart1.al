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
                field(Select; Select)
                {
                    ApplicationArea = All;
                }

                field("PI No"; "PI No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PI Date"; "PI Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PI Value"; "PI Value")
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
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    B2BLCPIRec: Record "B2BLCPI";
                    B2BNo1: Code[20];
                begin

                    PIHeaderRec.Reset();
                    PIHeaderRec.SetCurrentKey("Supplier No.");
                    PIHeaderRec.SetRange("Supplier No.", "Supplier No.");
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

                            //Update PI Header with  B2Bno
                            PIHeaderRec.AssignedB2BNo := B2BNo1;
                            PIHeaderRec.Modify();

                        until PIHeaderRec.Next() = 0;

                    end;

                    //Update Select as false
                    PIHeaderRec.Reset();
                    PIHeaderRec.SetRange("Supplier No.", "Supplier No.");
                    PIHeaderRec.SetFilter(Select, '=%1', true);

                    if PIHeaderRec.FindSet() then begin
                        PIHeaderRec.ModifyAll(Select, false);
                    end;

                    CodeUnitNav.CalQtyB2B(B2BNo1);
                    CurrPage.Update();
                end;
            }
        }
    }
}