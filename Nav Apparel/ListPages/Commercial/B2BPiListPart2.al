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
                    end;

                    //Delete from line table
                    B2BLCPIRec.Reset();
                    B2BLCPIRec.SetRange("B2BNo.", "B2BNo.");
                    B2BLCPIRec.SetFilter(Select, '=%1', true);
                    B2BLCPIRec.DeleteAll();

                    CodeUnitNav.CalQtyB2B("B2BNo.");
                    CurrPage.Update();
                end;
            }
        }
    }


}