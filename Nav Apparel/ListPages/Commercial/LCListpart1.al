page 51353 "LC ListPart 1"
{
    PageType = ListPart;
    SourceTable = "LC Style";
    SourceTableView = where("Assign LC No" = filter(= ''));
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
            action(Add)
            {
                ApplicationArea = All;
                Image = Add;

                trigger OnAction()
                var
                    LCStyle: Record "LC Style";
                    LCStyleRec3: Record "LC Style 2";
                    StyleMasterRec: Record "Style Master";
                    LCStyle2Rec: Record "LC Style 2";
                    LCMasterRec: Record LCMaster;
                    Line: BigInteger;
                begin
                    Line := 0;
                    LCStyleRec3.Reset();
                    LCStyleRec3.SetRange("LC No", Rec."LC No");
                    if LCStyleRec3.FindLast() then begin
                        Line := LCStyleRec3."Line No";
                    end;

                    LCStyle.Reset();
                    LCStyle.SetFilter(Select, '=%1', true);
                    if LCStyle.FindSet() then begin
                        repeat
                            LCStyle2Rec.Init();
                            Line += 1;
                            LCStyle2Rec."Line No" := Line;
                            LCStyle2Rec."No." := LCStyle."No.";
                            LCStyle2Rec."Style No." := LCStyle."style No.";
                            LCStyle2Rec."Style Name" := LCStyle."Style Name";
                            LCStyle2Rec."Buyer No." := LCStyle."Buyer No.";
                            LCStyle2Rec.Qty := LCStyle.Qty;
                            LCStyle2Rec."Created User" := LCStyle."Created User";
                            LCStyle2Rec."Assign LC No" := LCStyle."LC No";
                            LCStyle2Rec."LC No" := LCStyle."LC No";
                            LCStyle2Rec.Insert();

                            LCMasterRec.Reset();
                            LCMasterRec.SetRange(Contract, Rec."No.");
                            if LCMasterRec.FindSet() then begin
                                LCStyle."Assign LC No" := LCMasterRec."No.";
                                CurrPage.Update();
                            end;

                            LCStyle.Select := false;
                            LCStyle.Modify();

                        until LCStyle.Next() = 0;

                    end;

                    // LCStyle.Reset();
                    // LCStyle.SetRange("Buyer No.", Rec."Buyer No.");
                    // LCStyle.SetFilter(Select, '=%1', true);
                    // if LCStyle.FindSet() then begin
                    //     LCStyle.ModifyAll(Select, false);
                    // end;


                end;
            }




            // action(Remove)
            // {
            //     ApplicationArea = All;
            //     Image = RemoveLine;

            //     trigger OnAction()
            //     var
            //         BomRec: Record BOM;
            //         "StyleMasterRec": Record "Style Master";
            //         "Contract/LCMasterRec": Record "Contract/LCMaster";
            //         "Contract/LCStyleRec": Record "Contract/LCStyle";
            //         CodeUnitNav: Codeunit NavAppCodeUnit;
            //         "B2BLC%": Decimal;
            //         CodeUnit2Nav: Codeunit NavAppCodeUnit2;
            //         Status: Boolean;
            //         POLineRec: Record "Purchase Line";
            //         B2BLCRec: Record B2BLCMaster;
            //         PIRec: Record "PI Details Header";
            //         PIPoDetails: Record "PI Po Details";
            //     begin
            //         //validate Style before remove
            //         Status := false;

            //         BomRec.Reset();
            //         BomRec.SetRange("Style No.", Rec."Style No.");
            //         if BomRec.FindSet() then begin
            //             Error('Cannot delete Style. This Style added to the Bom');
            //         end;

            //         "Contract/LCStyleRec".Reset();
            //         "Contract/LCStyleRec".SetRange("No.", Rec."No.");
            //         "Contract/LCStyleRec".SetFilter(Select, '=%1', true);

            //         if "Contract/LCStyleRec".FindSet() then begin
            //             repeat

            //                 //Get Vender PO for the style
            //                 POLineRec.Reset();
            //                 POLineRec.SetFilter("Document Type", '=%1', POLineRec."Document Type"::Order);
            //                 POLineRec.SetRange(StyleNo, "Contract/LCStyleRec"."Style No.");
            //                 if POLineRec.FindSet() then begin
            //                     repeat

            //                         //Get LCContract No
            //                         "Contract/LCMasterRec".Reset();
            //                         "Contract/LCMasterRec".SetRange("No.", Rec."No.");

            //                         if "Contract/LCMasterRec".FindSet() then begin

            //                             //Get B2B Lc for contract no
            //                             B2BLCRec.Reset();
            //                             B2BLCRec.SetRange(LCContractNo, "Contract/LCMasterRec"."Contract No");
            //                             if B2BLCRec.FindSet() then begin
            //                                 repeat

            //                                     //Get PI details for B2B no
            //                                     PIRec.Reset();
            //                                     PIRec.SetRange(B2BNo, B2BLCRec."No.");
            //                                     if PIRec.FindSet() then begin
            //                                         repeat

            //                                             //Check for Po No
            //                                             PIPoDetails.Reset();
            //                                             PIPoDetails.SetRange("PO No.", POLineRec."Document No.");
            //                                             PIPoDetails.SetRange("PI No.", PIRec."No.");
            //                                             if PIPoDetails.FindSet() then
            //                                                 Status := true;

            //                                         until PIRec.Next() = 0;
            //                                     end;

            //                                 until B2BLCRec.Next() = 0;
            //                             end;
            //                         end;

            //                     until POLineRec.Next() = 0;
            //                 end;

            //             until "Contract/LCStyleRec".Next() = 0;
            //         end;

            //         if Status = true then
            //             Error('Cannot delete Style. Vendor POs have been attached to PIs.');


            //         "Contract/LCStyleRec".Reset();
            //         "Contract/LCStyleRec".SetRange("No.", Rec."No.");
            //         "Contract/LCStyleRec".SetFilter(Select, '=%1', true);

            //         if "Contract/LCStyleRec".FindSet() then begin
            //             repeat
            //                 //Update Purchase order pi no
            //                 // Done By Sachith on 18/05/23 add if condition to StylemasterRec
            //                 StyleMasterRec.Reset();
            //                 StyleMasterRec.SetRange("No.", "Contract/LCStyleRec"."Style No.");
            //                 if StyleMasterRec.FindSet() then begin
            //                     StyleMasterRec.Select := false;
            //                     StyleMasterRec.AssignedContractNo := '';
            //                     StyleMasterRec.Modify();
            //                 end;

            //             until "Contract/LCStyleRec".Next() = 0;
            //         end;

            //         //Delete from line table
            //         "Contract/LCStyleRec".Reset();
            //         "Contract/LCStyleRec".SetRange("No.", Rec."No.");
            //         "Contract/LCStyleRec".SetFilter(Select, '=%1', true);
            //         "Contract/LCStyleRec".DeleteAll();

            //         CodeUnitNav.CalQty(Rec."No.");

            //         //Calculate B2BLC %
            //         "B2BLC%" := CodeUnit2Nav.CalB2BLC_Perccentage(Rec."No.");
            //         "Contract/LCMasterRec".Reset();
            //         "Contract/LCMasterRec".SetRange("No.", Rec."No.");
            //         "Contract/LCMasterRec".FindSet();
            //         "Contract/LCMasterRec".BBLC := "B2BLC%";
            //         "Contract/LCMasterRec".Modify();

            //         CurrPage.Update();
            //     end;
            // }
        }
    }


}