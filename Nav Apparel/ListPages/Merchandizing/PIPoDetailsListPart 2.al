page 71012791 "PI Po Details ListPart 2"
{
    PageType = ListPart;
    SourceTable = "PI Po Details";
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

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
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
                    PurchaseHeaderRec: Record "Purchase Header";
                    PIDetailsHeadRec: Record "PI Details Header";
                    PIPOItemDetRec: Record "PI Po Item Details";
                    PIPODetailsRec: Record "PI Po Details";
                    NavAppCodeUnitRec: Codeunit NavAppCodeUnit;
                    TotalValue: Decimal;
                begin

                    PIPODetailsRec.Reset();
                    PIPODetailsRec.SetRange("PI No.", "PI No.");
                    PIPODetailsRec.SetFilter(Select, '=%1', true);

                    if PIPODetailsRec.FindSet() then begin
                        repeat
                            //Update Purchase order pi no
                            PurchaseHeaderRec.Reset();
                            PurchaseHeaderRec.SetRange("No.", PIPODetailsRec."PO No.");
                            if PurchaseHeaderRec.FindSet() then begin
                                PurchaseHeaderRec."Assigned PI No." := '';
                                PurchaseHeaderRec.Modify();
                            end;
                        until PIPODetailsRec.Next() = 0;
                    end
                    else
                        Error('Select records.');


                    //Delete from line table
                    PIPODetailsRec.Reset();
                    PIPODetailsRec.SetRange("PI No.", "PI No.");
                    PIPODetailsRec.SetFilter(Select, '=%1', true);
                    PIPODetailsRec.DeleteAll();

                    NavAppCodeUnitRec.Update_PI_PO_Items("PI No.");

                    //calculate Total Items Value and Update Header Value
                    PIPOItemDetRec.Reset();
                    PIPOItemDetRec.SetRange("PI No.", "PI No.");

                    if PIPOItemDetRec.FindSet() then
                        repeat
                            TotalValue += PIPOItemDetRec.Value;
                        until PIPOItemDetRec.Next() = 0;

                    PIDetailsHeadRec.Reset();
                    PIDetailsHeadRec.SetRange("No.", "PI No.");
                    PIDetailsHeadRec.FindSet();
                    PIDetailsHeadRec."PI Value" := TotalValue;
                    PIDetailsHeadRec.Modify();

                    CurrPage.Update();
                end;
            }
        }
    }

}