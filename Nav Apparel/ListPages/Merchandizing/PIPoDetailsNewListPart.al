page 51357 "PI Po Details ListPart 1 New"
{
    PageType = ListPart;
    SourceTable = PIPODetails1;
    SourceTableView = where("Assigned PI No." = filter(''), Status = filter(Released));
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; rec.Select)
                {
                    ApplicationArea = All;
                }

                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field("PO Value"; Rec."PO Value")
                {
                    ApplicationArea = All;
                    Caption = 'PO Value';
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
                    Pipo2Rec: Record PIPODetails1;
                    Pipo1Rec: Record PIPODetails1;
                    PurchaseHeaderRec: Record "Purchase Header";
                    PIDetailsHeadRec: Record "PI Details Header";
                    PIPOItemDetRec: Record "PI Po Item Details";
                    PIPODetailsRec: Record "PI Po Details";
                    NavAppCodeUnitRec: Codeunit NavAppCodeUnit;
                    TotalValue: Decimal;
                    TotPOValue: Decimal;
                begin

                    Pipo1Rec.Reset();
                    Pipo1Rec.SetCurrentKey("Buy-from Vendor No.");
                    Pipo1Rec.SetRange("Buy-from Vendor No.", rec."Buy-from Vendor No.");
                    Pipo1Rec.SetFilter(Select, '=%1', true);
                    if Pipo1Rec.FindSet() then begin
                        repeat
                            //add new po to the PI
                            PIPODetailsRec.Init();
                            PIPODetailsRec."PI No." := Pipo1Rec."PI No.";
                            PIPODetailsRec."PO No." := Pipo1Rec."PO No.";
                            PIPODetailsRec."Line No" := Pipo1Rec."Line No";
                            PIPODetailsRec."PO Value" := Pipo1Rec."PO Value";
                            PIPODetailsRec."Created Date" := WorkDate();
                            PIPODetailsRec."Created User" := UserId;
                            PIPODetailsRec.Insert();

                            Pipo1Rec."Assigned PI No." := Pipo1Rec."PI No.";
                            Pipo1Rec.Modify();

                        until Pipo1Rec.Next() = 0;
                        CurrPage.Update();

                        PurchaseHeaderRec.Reset();
                        PurchaseHeaderRec.SetCurrentKey("Buy-from Vendor No.");
                        PurchaseHeaderRec.SetRange("Buy-from Vendor No.", rec."Buy-from Vendor No.");
                        PurchaseHeaderRec.SetFilter(Select, '=%1', true);
                        if PurchaseHeaderRec.FindSet() then begin

                            //Update Purchase order pi no
                            PurchaseHeaderRec."Assigned PI No." := Pipo1Rec."PI No.";
                            PurchaseHeaderRec.Modify();
                        end;
                    end
                    else
                        Error('Select records.');



                    //Update Select as false
                    Pipo1Rec.Reset();
                    Pipo1Rec.SetRange("Buy-from Vendor No.", rec."Buy-from Vendor No.");
                    Pipo1Rec.SetFilter(Select, '=%1', true);
                    if Pipo1Rec.FindSet() then
                        repeat
                            Pipo1Rec.ModifyAll(Select, false);
                        until Pipo1Rec.Next() = 0;

                    //Update PO_PI_Item table
                    NavAppCodeUnitRec.Update_PI_PO_Items(rec."PI No.");

                    // calculate Total Items Value and Update Header Value
                    PIPOItemDetRec.Reset();
                    PIPOItemDetRec.SetRange("PI No.", rec."PI No.");

                    if PIPOItemDetRec.FindSet() then
                        repeat
                            TotalValue += PIPOItemDetRec.Value;
                        until PIPOItemDetRec.Next() = 0;


                    // PIPODetailsRec.Reset();
                    PIPODetailsRec.SetRange("PI No.", rec."PI No.");

                    if PIPODetailsRec.FindSet() then begin
                        repeat
                            TotPOValue += PIPODetailsRec."PO Value";
                        until PIPODetailsRec.Next() = 0;
                    end;

                    PIDetailsHeadRec.Reset();
                    PIDetailsHeadRec.SetRange("No.", rec."PI No.");
                    PIDetailsHeadRec.FindSet();
                    PIDetailsHeadRec."PI Value" := TotalValue;
                    PIDetailsHeadRec."PO Total" := TotPOValue;
                    PIDetailsHeadRec.Modify();

                    CurrPage.Update();
                end;
            }
        }
    }
}