page 50983 "Assortment Card"
{
    PageType = Card;
    SourceTable = "Style Master";
    Caption = 'Assortment Details';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Store';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Brand';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                    Editable = false;
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Order Qty (Style)';
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Style Master PO"."Lot No." where("Style No." = field("No."));

                    trigger OnValidate()
                    var
                        StylePORec: Record "Style Master PO";
                    begin

                        //CurrPage.SaveRecord();
                        CurrPage.Update(true);
                        StylePORec.Reset();
                        StylePORec.SetRange("Style No.", rec."No.");
                        StylePORec.SetRange("Lot No.", rec."Lot No.");

                        if StylePORec.FindSet() then begin
                            rec."PO No" := StylePORec."PO No.";
                            POTotal := StylePORec.Qty;
                        end
                        else
                            POTotal := 0;

                        CurrPage.Update(true);
                    end;
                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(POTotal; POTotal)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO Total';
                }

                field("Pack No"; rec."Pack No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }

            group("GMT Color Information")
            {
                part("AssoColourSizeListPart"; "AssoColourSizeListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No."), Type = filter(1);
                }
            }

            group("Size Information")
            {
                part("AssoInSeamListPart"; AssoInSeamListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
                }
            }

            group("Pack/Country Size Ratio")
            {
                part("AssoPackCountryListPart"; AssoPackCountryListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
                    UpdatePropagation = Both;
                }
            }

            group("Color Size Ratio")
            {
                part("AssorColorSizeRatioListPart"; AssorColorSizeRatioListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
                    //SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No."), "Pack No" = field("Pack No");
                }
            }

            group("Quantity Breakdown")
            {
                part("AssorColorSizeRatioListPart2"; AssorColorSizeRatioListPart2)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
                    //SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No."), "Pack No" = field("Pack No");
                    Editable = false;
                }
            }

            // group("Size Color Wise Price")
            // {
            //     part("AssorColorSizeRatiPricListPart"; AssorColorSizeRatiPricListPart)
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No.");
            //         //SubPageLink = "Style No." = FIELD("No."), "Lot No." = FIELD("Lot No."), "Pack No" = field("Pack No");
            //     }
            // }
        }
    }


    actions
    {
        area(Processing)
        {
            // action("Adjust Sales Orders")
            // {
            //     Caption = 'Adjust Sales Orders';
            //     Image = CreateJobSalesInvoice;
            //     ApplicationArea = All;

            //     trigger OnAction();
            //     var
            //         AssortDetailRec: Record AssorColorSizeRatio;
            //         AssortDetail1Rec: Record AssorColorSizeRatio;
            //         BOMLineAutoGenRec: Record "BOM Line AutoGen";
            //         BOMPOSelectionRec: Record BOMPOSelection;
            //         StyleMasterPORec: Record "Style Master PO";
            //         BOMLineEstimateRec: Record "BOM Line Estimate";
            //         AutoGenRec: Record "BOM Line AutoGen";
            //         BLERec: Record "BOM Line Estimate";
            //         SalesLineRec1: Record "Sales Line";
            //         SalesHeaderRec: Record "Sales Header";
            //         ProOrderHedRec: Record "Production Order";
            //         ProOrderLineRec: Record "Prod. Order Line";
            //         CodeUnitNavApp: Codeunit NavAppCodeUnit;
            //         BOMRec: Record BOM;
            //         ProOrderNo: Code[20];
            //         LineNo: BigInteger;
            //         Description: Text[500];
            //         Qty: Decimal;
            //         StatusGB: Integer;
            //         Count: Integer;
            //         Mode: Text[20];
            //         Total: Decimal;
            //         ConvFactor: Decimal;
            //         UOMRec: Record "Unit of Measure";
            //         BLE1Rec: Record "BOM Line Estimate";
            //         BOMLine1Rec: Record "BOM Line";  //For Color
            //         BOMLine2Rec: Record "BOM Line";  //For Size
            //         BOMLine3Rec: Record "BOM Line";  //For country
            //         BOMLine4Rec: Record "BOM Line";  //For Item PO
            //         BLAutoGenNewRec: Record "BOM Line AutoGen";
            //         BLAutoGenPrBOMRec: Record "BOM Line AutoGen ProdBOM";
            //         AssortDetailsRec: Record AssorColorSizeRatioView;
            //         AssortDetails1Rec: Record AssorColorSizeRatioView;
            //         BOMPOSelecRec: Record BOMPOSelection;
            //         ItemMasterRec: Record Item;
            //         Value: Decimal;
            //         Requirment: Decimal;
            //         SubTotal: Decimal;
            //         SubCat: Code[20];
            //         SubCatDesc: Text[250];
            //     begin
            //         LineNo := 0;
            //         Description := '';
            //         Mode := '';

            //         //Check for the BOM
            //         BOMRec.Reset();
            //         BOMRec.SetRange("Style No.", rec."No.");
            //         if not BOMRec.FindSet() then
            //             Error('You have not created a BOM for this Style.');

            //         //Check for the Auto gen line
            //         BOMLineAutoGenRec.Reset();
            //         BOMLineAutoGenRec.SetRange("No.", BOMRec.No);
            //         if not BOMLineAutoGenRec.FindSet() then
            //             Error('You have not yet run "Auto Generate" in BOM : %1. Cannot proceed.', BOMRec.No);

            //         //Check for Write to MRP status
            //         BOMLineAutoGenRec.Reset();
            //         BOMLineAutoGenRec.SetRange("No.", BOMRec.No);
            //         BOMLineAutoGenRec.SetFilter("Included in PO", '=%1', true);
            //         if not BOMLineAutoGenRec.FindSet() then
            //             Error('You have not yet run "Write to MRP Process" in BOM : %1. Cannot proceed.', BOMRec.No);

            //         //Add BOM POSeletion record                   
            //         StyleMasterPORec.Reset();
            //         StyleMasterPORec.SetRange("Style No.", rec."No.");
            //         StyleMasterPORec.SetRange("lot No.", rec."Lot No.");
            //         StyleMasterPORec.FindSet();

            //         //Check new po or Not
            //         BOMPOSelectionRec.Reset();
            //         BOMPOSelectionRec.SetRange("BOM No.", BOMRec."No");
            //         BOMPOSelectionRec.SetRange("Lot No.", rec."Lot No.");
            //         if not BOMPOSelectionRec.FindSet() then begin
            //             Mode := 'NEW';                                                  //insert PO details                                                                                
            //             BOMPOSelectionRec.Init();
            //             BOMPOSelectionRec."BOM No." := BOMRec."No";
            //             BOMPOSelectionRec."Style No." := rec."No.";
            //             BOMPOSelectionRec."Lot No." := StyleMasterPORec."Lot No.";
            //             BOMPOSelectionRec."PO No." := StyleMasterPORec."PO No.";
            //             BOMPOSelectionRec.Qty := StyleMasterPORec.Qty;
            //             BOMPOSelectionRec.Mode := StyleMasterPORec.Mode;
            //             BOMPOSelectionRec."Ship Date" := StyleMasterPORec."Ship Date";
            //             BOMPOSelectionRec.Selection := true;
            //             BOMPOSelectionRec."Created User" := UserId;
            //             BOMPOSelectionRec."Created Date" := WorkDate();
            //             BOMPOSelectionRec.Insert();
            //         end
            //         else begin
            //             //Check existing PO qty and update
            //             if BOMPOSelectionRec.Qty <> StyleMasterPORec.Qty then begin        // old PO , Qty changed
            //                 BOMPOSelectionRec.Qty := StyleMasterPORec.Qty;
            //                 BOMPOSelectionRec.Modify();
            //                 Mode := 'EDITQ';
            //             end
            //             else                                                              // old PO , Qty same but assortment changed
            //                 Mode := 'EDITA';
            //         end;


            //         //Update Style Total in BOM
            //         Total := 0;
            //         BOMPOSelectionRec.Reset();
            //         BOMPOSelectionRec.SetRange("BOM No.", BOMRec."No");
            //         BOMPOSelectionRec.SetRange(Selection, true);

            //         if BOMPOSelectionRec.FindSet() then begin
            //             repeat
            //                 Total += BOMPOSelectionRec.Qty;
            //             until BOMPOSelectionRec.Next() = 0;
            //         end;

            //         BOMRec.ModifyAll(Quantity, Total);

            //         //Update BOM Estimate Line Qty
            //         BOMLineEstimateRec.Reset();
            //         BOMLineEstimateRec.SetRange("No.", BOMRec."No");
            //         BOMLineEstimateRec.FindSet();
            //         BOMLineEstimateRec.ModifyAll("GMT Qty", Total);


            //         /////////////////////////////////////////////Add Sencitivity
            //         ColorSensitivity(BOMRec.No);
            //         SizeSensitivity(BOMRec.No);
            //         CountrySensitivity(BOMRec.No);
            //         ItemPOSensitivity(BOMRec.No);


            //         ////////////////////////////////////////////Auto Generate
            //         BLERec.Reset();
            //         BLERec.SetRange("No.", BOMRec."No");
            //         Total := 0;
            //         SubTotal := 0;
            //         LineNo := 0;
            //         Value := 0;
            //         Requirment := 0;

            //         if Mode <> 'NEW' then begin
            //             //Delete existing records
            //             BLAutoGenNewRec.Reset();
            //             BLAutoGenNewRec.SetRange("No.", BOMRec."No");
            //             BLAutoGenNewRec.SetRange("Lot No.", rec."Lot No.");
            //             BLAutoGenNewRec.SetFilter("Included in PO", '=%1', false);
            //             if BLAutoGenNewRec.FindSet() then
            //                 repeat
            //                     BLAutoGenPrBOMRec.Reset();
            //                     BLAutoGenPrBOMRec.SetRange("No.", BOMRec."No");
            //                     BLAutoGenPrBOMRec.SetRange("Line No.", BLAutoGenNewRec."Line No.");
            //                     BLAutoGenPrBOMRec.SetRange("Item No.", BLAutoGenNewRec."Item No.");
            //                     if BLAutoGenPrBOMRec.FindSet() then
            //                         BLAutoGenPrBOMRec.Delete();

            //                     BLAutoGenNewRec.Delete();
            //                 until BLAutoGenNewRec.Next() = 0;
            //         end;

            //         if BLERec.FindSet() then begin
            //             repeat

            //                 SubCat := '';
            //                 SubCatDesc := '';

            //                 if BLERec."Color Sensitive" = false then begin
            //                     Message('Color Sensitivity not selected. Cannot proceed.');
            //                     exit;
            //                 end;

            //                 if BLERec."Supplier No." = '' then begin
            //                     Error('Supplier is empty. Cannot proceed.');
            //                     exit;
            //                 end;

            //                 ItemMasterRec.Reset();
            //                 ItemMasterRec.SetRange("No.", BLERec."Item No.");

            //                 if ItemMasterRec.FindSet() then begin
            //                     SubCat := ItemMasterRec."Sub Category No.";
            //                     SubCatDesc := ItemMasterRec."Sub Category Name";
            //                 end
            //                 else
            //                     Error('Sub Category is blank for the item : %1', BLERec."Item Name");


            //                 //Get Max Lineno
            //                 BLAutoGenNewRec.Reset();
            //                 BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                 BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                 //BLE1Rec.SetRange("Placement of GMT", BLERec."Placement of GMT");

            //                 if BLAutoGenNewRec.FindLast() then
            //                     LineNo := BLAutoGenNewRec."Line No.";


            //                 //Color, Size, Country and PO
            //                 if BLERec."Color Sensitive" and BLERec."Size Sensitive" and BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

            //                     //Color filter
            //                     BOMLine1Rec.Reset();
            //                     BOMLine1Rec.SetRange("No.", BOMRec.No);
            //                     //BOMLine1Rec.SetRange("Lot No.", rec."Lot No.");
            //                     BOMLine1Rec.SetRange(Type, 1);
            //                     BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine1Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine1Rec.FindSet() then begin

            //                         repeat

            //                             //Size filter
            //                             BOMLine2Rec.Reset();
            //                             BOMLine2Rec.SetRange("No.", BOMRec.No);
            //                             BOMLine2Rec.SetRange(Type, 2);
            //                             BOMLine2Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                             BOMLine2Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                             BOMLine2Rec.SetFilter(Select, '=%1', true);

            //                             if BOMLine2Rec.FindSet() then begin
            //                                 repeat

            //                                     BOMPOSelecRec.Reset();
            //                                     BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                                     BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                                     BOMPOSelecRec.SetRange(Selection, true);

            //                                     if BOMPOSelecRec.FindSet() then begin

            //                                         repeat

            //                                             //Item po filter
            //                                             BOMLine4Rec.Reset();
            //                                             BOMLine4Rec.SetRange("No.", BOMRec.No);
            //                                             BOMLine4Rec.SetRange(Type, 4);
            //                                             BOMLine4Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                                             BOMLine4Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                                             BOMLine4Rec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                             BOMLine4Rec.SetRange(Select, true);

            //                                             if BOMLine4Rec.FindSet() then begin
            //                                                 repeat

            //                                                     //Country filter
            //                                                     BOMLine3Rec.Reset();
            //                                                     BOMLine3Rec.SetRange("No.", BOMRec.No);
            //                                                     BOMLine3Rec.SetRange(Type, 3);
            //                                                     BOMLine3Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                                                     BOMLine3Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                                                     BOMLine3Rec.SetRange(Select, true);

            //                                                     if BOMLine3Rec.FindSet() then begin

            //                                                         repeat

            //                                                             //Insert new line
            //                                                             AssortDetailsRec.Reset();
            //                                                             AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                                             AssortDetailsRec.SetRange("Lot No.", BOMLine4Rec."lot No.");
            //                                                             AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");
            //                                                             AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                                             if AssortDetailsRec.FindSet() then begin

            //                                                                 //Find the correct column for the GMT size
            //                                                                 AssortDetails1Rec.Reset();
            //                                                                 AssortDetails1Rec.SetRange("Style No.", rec."No.");
            //                                                                 AssortDetails1Rec.SetRange("Lot No.", BOMLine4Rec."lot No.");
            //                                                                 AssortDetails1Rec.SetRange("Colour No", '*');
            //                                                                 AssortDetails1Rec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                                                 AssortDetails1Rec.FindSet();

            //                                                                 FOR Count := 1 TO 64 DO begin

            //                                                                     case Count of
            //                                                                         1:
            //                                                                             if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."1");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         2:
            //                                                                             if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."2");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         3:
            //                                                                             if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."3");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         4:
            //                                                                             if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."4");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         5:
            //                                                                             if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."5");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         6:
            //                                                                             if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."6");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         7:
            //                                                                             if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."7");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         8:
            //                                                                             if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."8");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         9:
            //                                                                             if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."9");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         10:
            //                                                                             if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."10");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         11:
            //                                                                             if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."11");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         12:
            //                                                                             if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."12");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         13:
            //                                                                             if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."13");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         14:
            //                                                                             if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."14");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         15:
            //                                                                             if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."15");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         16:
            //                                                                             if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."16");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         17:
            //                                                                             if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."17");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         18:
            //                                                                             if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."18");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         19:
            //                                                                             if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."19");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         20:
            //                                                                             if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."20");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         21:
            //                                                                             if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."21");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         22:
            //                                                                             if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."22");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         23:
            //                                                                             if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."23");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         24:
            //                                                                             if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."24");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         25:
            //                                                                             if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."25");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         26:
            //                                                                             if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."26");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         27:
            //                                                                             if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."27");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         28:
            //                                                                             if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."28");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         29:
            //                                                                             if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."29");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         30:
            //                                                                             if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."30");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         31:
            //                                                                             if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."31");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         32:
            //                                                                             if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."32");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         33:
            //                                                                             if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."33");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         34:
            //                                                                             if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."34");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         35:
            //                                                                             if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."35");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         36:
            //                                                                             if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."36");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         37:
            //                                                                             if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."37");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         38:
            //                                                                             if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."38");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         39:
            //                                                                             if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."39");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         40:
            //                                                                             if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."40");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         41:
            //                                                                             if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."41");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         42:
            //                                                                             if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."42");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         43:
            //                                                                             if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."43");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         44:
            //                                                                             if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."44");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         45:
            //                                                                             if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."45");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         46:
            //                                                                             if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."46");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         47:
            //                                                                             if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."47");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         48:
            //                                                                             if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."48");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         49:
            //                                                                             if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."49");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         50:
            //                                                                             if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."50");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         51:
            //                                                                             if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."51");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         52:
            //                                                                             if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."52");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         53:
            //                                                                             if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."53");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         54:
            //                                                                             if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."54");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         55:
            //                                                                             if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."55");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         56:
            //                                                                             if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."56");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         57:
            //                                                                             if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."57");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         58:
            //                                                                             if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."58");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         59:
            //                                                                             if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."59");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         60:
            //                                                                             if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."60");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         61:
            //                                                                             if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."61");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         62:
            //                                                                             if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."62");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         63:
            //                                                                             if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."63");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         64:
            //                                                                             if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(Total, AssortDetailsRec."64");
            //                                                                                 break;
            //                                                                             end;
            //                                                                     end;
            //                                                                 end;

            //                                                                 LineNo += 1;
            //                                                                 Value := 0;
            //                                                                 Requirment := 0;

            //                                                                 UOMRec.Reset();
            //                                                                 UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                                                 UOMRec.FindSet();
            //                                                                 ConvFactor := UOMRec."Converion Parameter";

            //                                                                 //Check whether already "po raised"items are there, then do not insert
            //                                                                 BLAutoGenNewRec.Reset();
            //                                                                 BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                                                 BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                                                 BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                                                 BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
            //                                                                 // BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
            //                                                                 BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
            //                                                                 BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                                                 BLAutoGenNewRec.SetRange(PO, BOMLine4Rec."PO No.");
            //                                                                 BLAutoGenNewRec.SetRange("Lot No.", BOMLine4Rec."Lot No.");
            //                                                                 BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                                                 BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
            //                                                                 BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                                                 if Not BLAutoGenNewRec.FindSet() then begin
            //                                                                     if Total <> 0 then begin

            //                                                                         BLAutoGenNewRec.Init();
            //                                                                         BLAutoGenNewRec."No." := BOMRec.No;
            //                                                                         BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                                         BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                                         BLAutoGenNewRec."Line No." := LineNo;
            //                                                                         BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                                         BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                                         BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                                         BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                                         BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                                         BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                                         BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
            //                                                                         BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
            //                                                                         BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                                         BLAutoGenNewRec.Type := BLERec.Type;
            //                                                                         BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                                         BLAutoGenNewRec.WST := BLERec.WST;
            //                                                                         BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                                         BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                                         BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                                         BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                                         BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                                         BLAutoGenNewRec."Created User" := UserId;
            //                                                                         BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                                         BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                                         BLAutoGenNewRec."Size Sensitive" := false;
            //                                                                         BLAutoGenNewRec."Color Sensitive" := false;
            //                                                                         BLAutoGenNewRec."Country Sensitive" := false;
            //                                                                         BLAutoGenNewRec."PO Sensitive" := false;
            //                                                                         BLAutoGenNewRec.Reconfirm := false;
            //                                                                         BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                                         BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
            //                                                                         BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
            //                                                                         BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
            //                                                                         BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
            //                                                                         BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
            //                                                                         BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
            //                                                                         BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
            //                                                                         BLAutoGenNewRec.PO := BOMLine4Rec."PO No.";
            //                                                                         BLAutoGenNewRec."Lot No." := BOMLine4Rec."Lot No.";
            //                                                                         BLAutoGenNewRec."GMT Qty" := Total;
            //                                                                         BLAutoGenNewRec."Include in PO" := true;

            //                                                                         if BLERec.Type = BLERec.Type::Pcs then
            //                                                                             Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                                         else
            //                                                                             if BLERec.Type = BLERec.Type::Doz then
            //                                                                                 Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;


            //                                                                         if (ConvFactor <> 0) then
            //                                                                             Requirment := Requirment / ConvFactor;

            //                                                                         //Requirment := Round(Requirment, 1);

            //                                                                         if Requirment < 0 then
            //                                                                             Requirment := 1;

            //                                                                         Value := Requirment * BLERec.Rate;

            //                                                                         BLAutoGenNewRec.Requirment := Requirment;
            //                                                                         BLAutoGenNewRec.Value := Value;

            //                                                                         BLAutoGenNewRec.Insert();

            //                                                                         //Insert into AutoGenPRBOM
            //                                                                         InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                                         Total := 0;
            //                                                                     end;
            //                                                                 end;

            //                                                             end;

            //                                                         until BOMLine3Rec.Next() = 0;

            //                                                     end;

            //                                                 until BOMLine4Rec.Next() = 0;
            //                                             end;
            //                                         until BOMPOSelecRec.Next() = 0;
            //                                     end;
            //                                 until BOMLine2Rec.Next() = 0;
            //                             end;
            //                         until BOMLine1Rec.Next() = 0;
            //                     end;

            //                 end;

            //                 //Color, Size and Country
            //                 if BLERec."Color Sensitive" and BLERec."Size Sensitive" and BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

            //                     //Color filter
            //                     BOMLine1Rec.Reset();
            //                     BOMLine1Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine1Rec.SetRange(Type, 1);
            //                     BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine1Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine1Rec.FindSet() then begin

            //                         repeat

            //                             //Size filter
            //                             BOMLine2Rec.Reset();
            //                             BOMLine2Rec.SetRange("No.", BOMRec.No);
            //                             BOMLine2Rec.SetRange(Type, 2);
            //                             BOMLine2Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                             BOMLine2Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                             BOMLine2Rec.SetFilter(Select, '=%1', true);

            //                             if BOMLine2Rec.FindSet() then begin
            //                                 repeat

            //                                     //PO filter
            //                                     BOMPOSelecRec.Reset();
            //                                     BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                                     BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                                     BOMPOSelecRec.SetRange(Selection, true);

            //                                     if BOMPOSelecRec.FindSet() then begin
            //                                         repeat

            //                                             //Country filter
            //                                             BOMLine3Rec.Reset();
            //                                             BOMLine3Rec.SetRange("No.", BOMRec.No);
            //                                             BOMLine3Rec.SetRange(Type, 3);
            //                                             BOMLine3Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                                             BOMLine3Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                                             BOMLine3Rec.SetRange(Select, true);

            //                                             if BOMLine3Rec.FindSet() then begin

            //                                                 repeat

            //                                                     //Insert new line
            //                                                     AssortDetailsRec.Reset();
            //                                                     AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                                     AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                                     AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");
            //                                                     AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                                     if AssortDetailsRec.FindSet() then begin

            //                                                         //Find the correct column for the GMT size
            //                                                         AssortDetails1Rec.Reset();
            //                                                         AssortDetails1Rec.SetRange("Style No.", rec."No.");
            //                                                         AssortDetails1Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                                         AssortDetails1Rec.SetRange("Colour No", '*');
            //                                                         AssortDetails1Rec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                                         AssortDetails1Rec.FindSet();

            //                                                         FOR Count := 1 TO 64 DO begin

            //                                                             case Count of
            //                                                                 1:
            //                                                                     if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."1");
            //                                                                         break;
            //                                                                     end;
            //                                                                 2:
            //                                                                     if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."2");
            //                                                                         break;
            //                                                                     end;
            //                                                                 3:
            //                                                                     if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."3");
            //                                                                         break;
            //                                                                     end;
            //                                                                 4:
            //                                                                     if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."4");
            //                                                                         break;
            //                                                                     end;
            //                                                                 5:
            //                                                                     if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."5");
            //                                                                         break;
            //                                                                     end;
            //                                                                 6:
            //                                                                     if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."6");
            //                                                                         break;
            //                                                                     end;
            //                                                                 7:
            //                                                                     if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."7");
            //                                                                         break;
            //                                                                     end;
            //                                                                 8:
            //                                                                     if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."8");
            //                                                                         break;
            //                                                                     end;
            //                                                                 9:
            //                                                                     if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."9");
            //                                                                         break;
            //                                                                     end;
            //                                                                 10:
            //                                                                     if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."10");
            //                                                                         break;
            //                                                                     end;
            //                                                                 11:
            //                                                                     if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."11");
            //                                                                         break;
            //                                                                     end;
            //                                                                 12:
            //                                                                     if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."12");
            //                                                                         break;
            //                                                                     end;
            //                                                                 13:
            //                                                                     if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."13");
            //                                                                         break;
            //                                                                     end;
            //                                                                 14:
            //                                                                     if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."14");
            //                                                                         break;
            //                                                                     end;
            //                                                                 15:
            //                                                                     if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."15");
            //                                                                         break;
            //                                                                     end;
            //                                                                 16:
            //                                                                     if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."16");
            //                                                                         break;
            //                                                                     end;
            //                                                                 17:
            //                                                                     if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."17");
            //                                                                         break;
            //                                                                     end;
            //                                                                 18:
            //                                                                     if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."18");
            //                                                                         break;
            //                                                                     end;
            //                                                                 19:
            //                                                                     if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."19");
            //                                                                         break;
            //                                                                     end;
            //                                                                 20:
            //                                                                     if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."20");
            //                                                                         break;
            //                                                                     end;
            //                                                                 21:
            //                                                                     if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."21");
            //                                                                         break;
            //                                                                     end;
            //                                                                 22:
            //                                                                     if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."22");
            //                                                                         break;
            //                                                                     end;
            //                                                                 23:
            //                                                                     if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."23");
            //                                                                         break;
            //                                                                     end;
            //                                                                 24:
            //                                                                     if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."24");
            //                                                                         break;
            //                                                                     end;
            //                                                                 25:
            //                                                                     if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."25");
            //                                                                         break;
            //                                                                     end;
            //                                                                 26:
            //                                                                     if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."26");
            //                                                                         break;
            //                                                                     end;
            //                                                                 27:
            //                                                                     if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."27");
            //                                                                         break;
            //                                                                     end;
            //                                                                 28:
            //                                                                     if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."28");
            //                                                                         break;
            //                                                                     end;
            //                                                                 29:
            //                                                                     if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."29");
            //                                                                         break;
            //                                                                     end;
            //                                                                 30:
            //                                                                     if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."30");
            //                                                                         break;
            //                                                                     end;
            //                                                                 31:
            //                                                                     if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."31");
            //                                                                         break;
            //                                                                     end;
            //                                                                 32:
            //                                                                     if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."32");
            //                                                                         break;
            //                                                                     end;
            //                                                                 33:
            //                                                                     if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."33");
            //                                                                         break;
            //                                                                     end;
            //                                                                 34:
            //                                                                     if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."34");
            //                                                                         break;
            //                                                                     end;
            //                                                                 35:
            //                                                                     if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."35");
            //                                                                         break;
            //                                                                     end;
            //                                                                 36:
            //                                                                     if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."36");
            //                                                                         break;
            //                                                                     end;
            //                                                                 37:
            //                                                                     if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."37");
            //                                                                         break;
            //                                                                     end;
            //                                                                 38:
            //                                                                     if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."38");
            //                                                                         break;
            //                                                                     end;
            //                                                                 39:
            //                                                                     if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."39");
            //                                                                         break;
            //                                                                     end;
            //                                                                 40:
            //                                                                     if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."40");
            //                                                                         break;
            //                                                                     end;
            //                                                                 41:
            //                                                                     if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."41");
            //                                                                         break;
            //                                                                     end;
            //                                                                 42:
            //                                                                     if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."42");
            //                                                                         break;
            //                                                                     end;
            //                                                                 43:
            //                                                                     if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."43");
            //                                                                         break;
            //                                                                     end;
            //                                                                 44:
            //                                                                     if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."44");
            //                                                                         break;
            //                                                                     end;
            //                                                                 45:
            //                                                                     if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."45");
            //                                                                         break;
            //                                                                     end;
            //                                                                 46:
            //                                                                     if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."46");
            //                                                                         break;
            //                                                                     end;
            //                                                                 47:
            //                                                                     if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."47");
            //                                                                         break;
            //                                                                     end;
            //                                                                 48:
            //                                                                     if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."48");
            //                                                                         break;
            //                                                                     end;
            //                                                                 49:
            //                                                                     if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."49");
            //                                                                         break;
            //                                                                     end;
            //                                                                 50:
            //                                                                     if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."50");
            //                                                                         break;
            //                                                                     end;
            //                                                                 51:
            //                                                                     if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."51");
            //                                                                         break;
            //                                                                     end;
            //                                                                 52:
            //                                                                     if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."52");
            //                                                                         break;
            //                                                                     end;
            //                                                                 53:
            //                                                                     if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."53");
            //                                                                         break;
            //                                                                     end;
            //                                                                 54:
            //                                                                     if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."54");
            //                                                                         break;
            //                                                                     end;
            //                                                                 55:
            //                                                                     if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."55");
            //                                                                         break;
            //                                                                     end;
            //                                                                 56:
            //                                                                     if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."56");
            //                                                                         break;
            //                                                                     end;
            //                                                                 57:
            //                                                                     if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."57");
            //                                                                         break;
            //                                                                     end;
            //                                                                 58:
            //                                                                     if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."58");
            //                                                                         break;
            //                                                                     end;
            //                                                                 59:
            //                                                                     if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."59");
            //                                                                         break;
            //                                                                     end;
            //                                                                 60:
            //                                                                     if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."60");
            //                                                                         break;
            //                                                                     end;
            //                                                                 61:
            //                                                                     if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."61");
            //                                                                         break;
            //                                                                     end;
            //                                                                 62:
            //                                                                     if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."62");
            //                                                                         break;
            //                                                                     end;
            //                                                                 63:
            //                                                                     if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."63");
            //                                                                         break;
            //                                                                     end;
            //                                                                 64:
            //                                                                     if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(Total, AssortDetailsRec."64");
            //                                                                         break;
            //                                                                     end;
            //                                                             end;
            //                                                         end;

            //                                                         LineNo += 1;
            //                                                         Value := 0;
            //                                                         Requirment := 0;

            //                                                         UOMRec.Reset();
            //                                                         UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                                         UOMRec.FindSet();
            //                                                         ConvFactor := UOMRec."Converion Parameter";

            //                                                         //Check whether already "po raised"items are there, then do not insert
            //                                                         BLAutoGenNewRec.Reset();
            //                                                         BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                                         BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                                         BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                                         BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
            //                                                         //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
            //                                                         BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
            //                                                         BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                                         BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                                         BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                                         BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                                         BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
            //                                                         BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                                         if Not BLAutoGenNewRec.FindSet() then begin
            //                                                             if Total <> 0 then begin

            //                                                                 BLAutoGenNewRec.Init();
            //                                                                 BLAutoGenNewRec."No." := BOMRec.No;
            //                                                                 BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                                 BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                                 BLAutoGenNewRec."Line No." := LineNo;
            //                                                                 BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                                 BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                                 BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                                 BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                                 BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                                 BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                                 BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
            //                                                                 BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
            //                                                                 BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                                 BLAutoGenNewRec.Type := BLERec.Type;
            //                                                                 BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                                 BLAutoGenNewRec.WST := BLERec.WST;
            //                                                                 BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                                 BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                                 BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                                 BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                                 BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                                 BLAutoGenNewRec."Created User" := UserId;
            //                                                                 BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                                 BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                                 BLAutoGenNewRec."Size Sensitive" := false;
            //                                                                 BLAutoGenNewRec."Color Sensitive" := false;
            //                                                                 BLAutoGenNewRec."Country Sensitive" := false;
            //                                                                 BLAutoGenNewRec."PO Sensitive" := false;
            //                                                                 BLAutoGenNewRec.Reconfirm := false;
            //                                                                 BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                                 BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
            //                                                                 BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
            //                                                                 BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
            //                                                                 BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
            //                                                                 BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
            //                                                                 BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
            //                                                                 BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
            //                                                                 BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                                 BLAutoGenNewRec."Lot No." := BOMPOSelecRec."Lot No.";
            //                                                                 BLAutoGenNewRec."GMT Qty" := Total;
            //                                                                 BLAutoGenNewRec."Include in PO" := true;

            //                                                                 if BLERec.Type = BLERec.Type::Pcs then
            //                                                                     Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                                 else
            //                                                                     if BLERec.Type = BLERec.Type::Doz then
            //                                                                         Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                                 if (ConvFactor <> 0) then
            //                                                                     Requirment := Requirment / ConvFactor;

            //                                                                 //Requirment := Round(Requirment, 1);

            //                                                                 if Requirment < 0 then
            //                                                                     Requirment := 1;

            //                                                                 Value := Requirment * BLERec.Rate;

            //                                                                 BLAutoGenNewRec.Requirment := Requirment;
            //                                                                 BLAutoGenNewRec.Value := Value;

            //                                                                 BLAutoGenNewRec.Insert();

            //                                                                 //Insert into AutoGenPRBOM
            //                                                                 InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                                 Total := 0;
            //                                                             end;
            //                                                         end;
            //                                                     end;

            //                                                 until BOMLine3Rec.Next() = 0;
            //                                             end;

            //                                         until BOMPOSelecRec.Next() = 0;
            //                                     end;
            //                                 until BOMLine2Rec.Next() = 0;
            //                             end;
            //                         until BOMLine1Rec.Next() = 0;
            //                     end;
            //                 end;

            //                 //Color and Size
            //                 if BLERec."Color Sensitive" and BLERec."Size Sensitive" and not BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

            //                     //Color filter
            //                     BOMLine1Rec.Reset();
            //                     BOMLine1Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine1Rec.SetRange(Type, 1);
            //                     BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine1Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine1Rec.FindSet() then begin

            //                         repeat

            //                             //Size filter
            //                             BOMLine2Rec.Reset();
            //                             BOMLine2Rec.SetRange("No.", BOMRec.No);
            //                             BOMLine2Rec.SetRange(Type, 2);
            //                             BOMLine2Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                             BOMLine2Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                             BOMLine2Rec.SetFilter(Select, '=%1', true);

            //                             if BOMLine2Rec.FindSet() then begin
            //                                 repeat

            //                                     //PO filter
            //                                     BOMPOSelecRec.Reset();
            //                                     BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                                     BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                                     BOMPOSelecRec.SetRange(Selection, true);

            //                                     if BOMPOSelecRec.FindSet() then begin
            //                                         repeat

            //                                             //Insert new line
            //                                             AssortDetailsRec.Reset();
            //                                             AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                             AssortDetailsRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                             AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");

            //                                             if AssortDetailsRec.FindSet() then begin

            //                                                 //Find the correct column for the GMT size
            //                                                 AssortDetails1Rec.Reset();
            //                                                 AssortDetails1Rec.SetRange("Style No.", rec."No.");
            //                                                 AssortDetails1Rec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                                 AssortDetails1Rec.SetRange("Colour No", '*');

            //                                                 AssortDetails1Rec.FindSet();

            //                                                 FOR Count := 1 TO 64 DO begin

            //                                                     case Count of
            //                                                         1:
            //                                                             if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."1");
            //                                                                 break;
            //                                                             end;
            //                                                         2:
            //                                                             if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."2");
            //                                                                 break;
            //                                                             end;
            //                                                         3:
            //                                                             if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."3");
            //                                                                 break;
            //                                                             end;
            //                                                         4:
            //                                                             if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."4");
            //                                                                 break;
            //                                                             end;
            //                                                         5:
            //                                                             if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."5");
            //                                                                 break;
            //                                                             end;
            //                                                         6:
            //                                                             if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."6");
            //                                                                 break;
            //                                                             end;
            //                                                         7:
            //                                                             if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."7");
            //                                                                 break;
            //                                                             end;
            //                                                         8:
            //                                                             if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."8");
            //                                                                 break;
            //                                                             end;
            //                                                         9:
            //                                                             if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."9");
            //                                                                 break;
            //                                                             end;
            //                                                         10:
            //                                                             if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."10");
            //                                                                 break;
            //                                                             end;
            //                                                         11:
            //                                                             if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."11");
            //                                                                 break;
            //                                                             end;
            //                                                         12:
            //                                                             if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."12");
            //                                                                 break;
            //                                                             end;
            //                                                         13:
            //                                                             if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."13");
            //                                                                 break;
            //                                                             end;
            //                                                         14:
            //                                                             if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."14");
            //                                                                 break;
            //                                                             end;
            //                                                         15:
            //                                                             if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."15");
            //                                                                 break;
            //                                                             end;
            //                                                         16:
            //                                                             if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."16");
            //                                                                 break;
            //                                                             end;
            //                                                         17:
            //                                                             if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."17");
            //                                                                 break;
            //                                                             end;
            //                                                         18:
            //                                                             if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."18");
            //                                                                 break;
            //                                                             end;
            //                                                         19:
            //                                                             if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."19");
            //                                                                 break;
            //                                                             end;
            //                                                         20:
            //                                                             if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."20");
            //                                                                 break;
            //                                                             end;
            //                                                         21:
            //                                                             if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."21");
            //                                                                 break;
            //                                                             end;
            //                                                         22:
            //                                                             if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."22");
            //                                                                 break;
            //                                                             end;
            //                                                         23:
            //                                                             if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."23");
            //                                                                 break;
            //                                                             end;
            //                                                         24:
            //                                                             if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."24");
            //                                                                 break;
            //                                                             end;
            //                                                         25:
            //                                                             if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."25");
            //                                                                 break;
            //                                                             end;
            //                                                         26:
            //                                                             if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."26");
            //                                                                 break;
            //                                                             end;
            //                                                         27:
            //                                                             if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."27");
            //                                                                 break;
            //                                                             end;
            //                                                         28:
            //                                                             if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."28");
            //                                                                 break;
            //                                                             end;
            //                                                         29:
            //                                                             if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."29");
            //                                                                 break;
            //                                                             end;
            //                                                         30:
            //                                                             if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."30");
            //                                                                 break;
            //                                                             end;
            //                                                         31:
            //                                                             if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."31");
            //                                                                 break;
            //                                                             end;
            //                                                         32:
            //                                                             if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."32");
            //                                                                 break;
            //                                                             end;
            //                                                         33:
            //                                                             if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."33");
            //                                                                 break;
            //                                                             end;
            //                                                         34:
            //                                                             if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."34");
            //                                                                 break;
            //                                                             end;
            //                                                         35:
            //                                                             if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."35");
            //                                                                 break;
            //                                                             end;
            //                                                         36:
            //                                                             if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."36");
            //                                                                 break;
            //                                                             end;
            //                                                         37:
            //                                                             if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."37");
            //                                                                 break;
            //                                                             end;
            //                                                         38:
            //                                                             if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."38");
            //                                                                 break;
            //                                                             end;
            //                                                         39:
            //                                                             if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."39");
            //                                                                 break;
            //                                                             end;
            //                                                         40:
            //                                                             if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."40");
            //                                                                 break;
            //                                                             end;
            //                                                         41:
            //                                                             if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."41");
            //                                                                 break;
            //                                                             end;
            //                                                         42:
            //                                                             if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."42");
            //                                                                 break;
            //                                                             end;
            //                                                         43:
            //                                                             if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."43");
            //                                                                 break;
            //                                                             end;
            //                                                         44:
            //                                                             if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."44");
            //                                                                 break;
            //                                                             end;
            //                                                         45:
            //                                                             if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."45");
            //                                                                 break;
            //                                                             end;
            //                                                         46:
            //                                                             if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."46");
            //                                                                 break;
            //                                                             end;
            //                                                         47:
            //                                                             if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."47");
            //                                                                 break;
            //                                                             end;
            //                                                         48:
            //                                                             if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."48");
            //                                                                 break;
            //                                                             end;
            //                                                         49:
            //                                                             if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."49");
            //                                                                 break;
            //                                                             end;
            //                                                         50:
            //                                                             if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."50");
            //                                                                 break;
            //                                                             end;
            //                                                         51:
            //                                                             if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."51");
            //                                                                 break;
            //                                                             end;
            //                                                         52:
            //                                                             if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."52");
            //                                                                 break;
            //                                                             end;
            //                                                         53:
            //                                                             if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."53");
            //                                                                 break;
            //                                                             end;
            //                                                         54:
            //                                                             if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."54");
            //                                                                 break;
            //                                                             end;
            //                                                         55:
            //                                                             if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."55");
            //                                                                 break;
            //                                                             end;
            //                                                         56:
            //                                                             if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."56");
            //                                                                 break;
            //                                                             end;
            //                                                         57:
            //                                                             if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."57");
            //                                                                 break;
            //                                                             end;
            //                                                         58:
            //                                                             if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."58");
            //                                                                 break;
            //                                                             end;
            //                                                         59:
            //                                                             if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."59");
            //                                                                 break;
            //                                                             end;
            //                                                         60:
            //                                                             if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."60");
            //                                                                 break;
            //                                                             end;
            //                                                         61:
            //                                                             if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."61");
            //                                                                 break;
            //                                                             end;
            //                                                         62:
            //                                                             if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."62");
            //                                                                 break;
            //                                                             end;
            //                                                         63:
            //                                                             if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."63");
            //                                                                 break;
            //                                                             end;
            //                                                         64:
            //                                                             if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(Total, AssortDetailsRec."64");
            //                                                                 break;
            //                                                             end;
            //                                                     end;
            //                                                 end;

            //                                                 LineNo += 1;
            //                                                 Value := 0;
            //                                                 Requirment := 0;

            //                                                 UOMRec.Reset();
            //                                                 UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                                 UOMRec.FindSet();
            //                                                 ConvFactor := UOMRec."Converion Parameter";

            //                                                 //Check whether already "po raised"items are there, then do not insert
            //                                                 BLAutoGenNewRec.Reset();
            //                                                 BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                                 BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                                 BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                                 BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
            //                                                 //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
            //                                                 BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
            //                                                 BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                                 BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                                 BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                                 BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                                 BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
            //                                                 BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                                 if Not BLAutoGenNewRec.FindSet() then begin
            //                                                     if Total <> 0 then begin

            //                                                         BLAutoGenNewRec.Init();
            //                                                         BLAutoGenNewRec."No." := BOMRec.No;
            //                                                         BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                         BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                         BLAutoGenNewRec."Line No." := LineNo;
            //                                                         BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                         BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                         BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                         BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                         BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                         BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                         BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
            //                                                         BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
            //                                                         BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                         BLAutoGenNewRec.Type := BLERec.Type;
            //                                                         BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                         BLAutoGenNewRec.WST := BLERec.WST;
            //                                                         BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                         BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                         BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                         BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                         BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                         BLAutoGenNewRec."Created User" := UserId;
            //                                                         BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                         BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                         BLAutoGenNewRec."Size Sensitive" := false;
            //                                                         BLAutoGenNewRec."Color Sensitive" := false;
            //                                                         BLAutoGenNewRec."Country Sensitive" := false;
            //                                                         BLAutoGenNewRec."PO Sensitive" := false;
            //                                                         BLAutoGenNewRec.Reconfirm := false;
            //                                                         BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                         BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
            //                                                         BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
            //                                                         BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
            //                                                         BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
            //                                                         BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
            //                                                         BLAutoGenNewRec."Country No." := '';
            //                                                         BLAutoGenNewRec."Country Name" := '';
            //                                                         BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                         BLAutoGenNewRec."Lot No." := BOMPOSelecRec."Lot No.";
            //                                                         BLAutoGenNewRec."GMT Qty" := Total;
            //                                                         BLAutoGenNewRec."Include in PO" := true;

            //                                                         if BLERec.Type = BLERec.Type::Pcs then
            //                                                             Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                         else
            //                                                             if BLERec.Type = BLERec.Type::Doz then
            //                                                                 Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                         if (ConvFactor <> 0) then
            //                                                             Requirment := Requirment / ConvFactor;

            //                                                         //Requirment := Round(Requirment, 1);

            //                                                         if Requirment < 0 then
            //                                                             Requirment := 1;

            //                                                         Value := Requirment * BLERec.Rate;

            //                                                         BLAutoGenNewRec.Requirment := Requirment;
            //                                                         BLAutoGenNewRec.Value := Value;

            //                                                         BLAutoGenNewRec.Insert();

            //                                                         //Insert into AutoGenPRBOM
            //                                                         InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                         Total := 0;
            //                                                     end;
            //                                                 end;

            //                                             end;

            //                                         until BOMPOSelecRec.Next() = 0;
            //                                     end;
            //                                 until BOMLine2Rec.Next() = 0;
            //                             end;
            //                         until BOMLine1Rec.Next() = 0;
            //                     end;

            //                 end;

            //                 //Color Only
            //                 if BLERec."Color Sensitive" and not BLERec."Size Sensitive" and not BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

            //                     BOMLine1Rec.Reset();
            //                     BOMLine1Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine1Rec.SetRange(Type, 1);
            //                     BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine1Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine1Rec.FindSet() then begin
            //                         repeat

            //                             BOMPOSelecRec.Reset();
            //                             BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                             BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                             BOMPOSelecRec.SetRange(Selection, true);

            //                             if BOMPOSelecRec.FindSet() then begin
            //                                 repeat

            //                                     AssortDetailsRec.Reset();
            //                                     AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                     AssortDetailsRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                     AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");

            //                                     if AssortDetailsRec.FindSet() then begin
            //                                         Total := AssortDetailsRec.Total;
            //                                         LineNo += 1;
            //                                         Value := 0;
            //                                         Requirment := 0;

            //                                         UOMRec.Reset();
            //                                         UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                         UOMRec.FindSet();
            //                                         ConvFactor := UOMRec."Converion Parameter";

            //                                         //Check whether already "po raised"items are there, then do not insert
            //                                         BLAutoGenNewRec.Reset();
            //                                         BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                         BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                         BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                         BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
            //                                         //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
            //                                         BLAutoGenNewRec.SetRange("GMT Size Name", '');
            //                                         BLAutoGenNewRec.SetRange("Country No.", '');
            //                                         BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                         BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                         BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                         BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
            //                                         BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                         if Not BLAutoGenNewRec.FindSet() then begin
            //                                             if Total <> 0 then begin

            //                                                 BLAutoGenNewRec.Init();
            //                                                 BLAutoGenNewRec."No." := BOMRec.No;
            //                                                 BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                 BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                 BLAutoGenNewRec."Line No." := LineNo;
            //                                                 BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                 BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                 BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                 BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                 BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                 BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                 BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
            //                                                 BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
            //                                                 BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                 BLAutoGenNewRec.Type := BLERec.Type;
            //                                                 BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                 BLAutoGenNewRec.WST := BLERec.WST;
            //                                                 BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                 BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                 BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                 BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                 BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                 BLAutoGenNewRec."Created User" := UserId;
            //                                                 BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                 BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                 BLAutoGenNewRec."Size Sensitive" := false;
            //                                                 BLAutoGenNewRec."Color Sensitive" := false;
            //                                                 BLAutoGenNewRec."Country Sensitive" := false;
            //                                                 BLAutoGenNewRec."PO Sensitive" := false;
            //                                                 BLAutoGenNewRec.Reconfirm := false;
            //                                                 BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                 BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
            //                                                 BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
            //                                                 BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
            //                                                 BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
            //                                                 BLAutoGenNewRec."GMT Size Name" := '';
            //                                                 BLAutoGenNewRec."Country No." := '';
            //                                                 BLAutoGenNewRec."Country Name" := '';
            //                                                 BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                 BLAutoGenNewRec."Lot No." := BOMPOSelecRec."Lot No.";
            //                                                 BLAutoGenNewRec."GMT Qty" := Total;
            //                                                 BLAutoGenNewRec."Include in PO" := true;

            //                                                 if BLERec.Type = BLERec.Type::Pcs then
            //                                                     Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                 else
            //                                                     if BLERec.Type = BLERec.Type::Doz then
            //                                                         Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                 if (ConvFactor <> 0) then
            //                                                     Requirment := Requirment / ConvFactor;

            //                                                 //Requirment := Round(Requirment, 1);

            //                                                 if Requirment < 0 then
            //                                                     Requirment := 1;

            //                                                 Value := Requirment * BLERec.Rate;

            //                                                 BLAutoGenNewRec.Requirment := Requirment;
            //                                                 BLAutoGenNewRec.Value := Value;

            //                                                 BLAutoGenNewRec.Insert();

            //                                                 //Insert into AutoGenPRBOM
            //                                                 InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                             end;
            //                                         end;
            //                                     end;

            //                                 until BOMPOSelecRec.Next() = 0;
            //                             end;

            //                         until BOMLine1Rec.Next() = 0;
            //                     end;

            //                 end;

            //                 //Size Only
            //                 if not BLERec."Color Sensitive" and BLERec."Size Sensitive" and not BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

            //                     //Size filter
            //                     BOMLine2Rec.Reset();
            //                     BOMLine2Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine2Rec.SetRange(Type, 2);
            //                     BOMLine2Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine2Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine2Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine2Rec.FindSet() then begin
            //                         repeat

            //                             //PO filter
            //                             BOMPOSelecRec.Reset();
            //                             BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                             BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                             BOMPOSelecRec.SetRange(Selection, true);

            //                             if BOMPOSelecRec.FindSet() then begin

            //                                 repeat

            //                                     //Insert new line
            //                                     AssortDetailsRec.Reset();
            //                                     AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                     AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."Lot No.");

            //                                     if AssortDetailsRec.FindSet() then begin

            //                                         repeat

            //                                             if AssortDetailsRec."Colour No" <> '*' then begin

            //                                                 //Find the correct column for the GMT size
            //                                                 AssortDetails1Rec.Reset();
            //                                                 AssortDetails1Rec.SetRange("Style No.", rec."No.");
            //                                                 AssortDetails1Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                                 AssortDetails1Rec.SetRange("Colour No", '*');

            //                                                 AssortDetails1Rec.FindSet();
            //                                                 SubTotal := 0;

            //                                                 FOR Count := 1 TO 64 DO begin

            //                                                     case Count of
            //                                                         1:
            //                                                             if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."1");
            //                                                                 break;
            //                                                             end;
            //                                                         2:
            //                                                             if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."2");
            //                                                                 break;
            //                                                             end;
            //                                                         3:
            //                                                             if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."3");
            //                                                                 break;
            //                                                             end;
            //                                                         4:
            //                                                             if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."4");
            //                                                                 break;
            //                                                             end;
            //                                                         5:
            //                                                             if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."5");
            //                                                                 break;
            //                                                             end;
            //                                                         6:
            //                                                             if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."6");
            //                                                                 break;
            //                                                             end;
            //                                                         7:
            //                                                             if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."7");
            //                                                                 break;
            //                                                             end;
            //                                                         8:
            //                                                             if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."8");
            //                                                                 break;
            //                                                             end;
            //                                                         9:
            //                                                             if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."9");
            //                                                                 break;
            //                                                             end;
            //                                                         10:
            //                                                             if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."10");
            //                                                                 break;
            //                                                             end;
            //                                                         11:
            //                                                             if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."11");
            //                                                                 break;
            //                                                             end;
            //                                                         12:
            //                                                             if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."12");
            //                                                                 break;
            //                                                             end;
            //                                                         13:
            //                                                             if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."13");
            //                                                                 break;
            //                                                             end;
            //                                                         14:
            //                                                             if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."14");
            //                                                                 break;
            //                                                             end;
            //                                                         15:
            //                                                             if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."15");
            //                                                                 break;
            //                                                             end;
            //                                                         16:
            //                                                             if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."16");
            //                                                                 break;
            //                                                             end;
            //                                                         17:
            //                                                             if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."17");
            //                                                                 break;
            //                                                             end;
            //                                                         18:
            //                                                             if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."18");
            //                                                                 break;
            //                                                             end;
            //                                                         19:
            //                                                             if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."19");
            //                                                                 break;
            //                                                             end;
            //                                                         20:
            //                                                             if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."20");
            //                                                                 break;
            //                                                             end;
            //                                                         21:
            //                                                             if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."21");
            //                                                                 break;
            //                                                             end;
            //                                                         22:
            //                                                             if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."22");
            //                                                                 break;
            //                                                             end;
            //                                                         23:
            //                                                             if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."23");
            //                                                                 break;
            //                                                             end;
            //                                                         24:
            //                                                             if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."24");
            //                                                                 break;
            //                                                             end;
            //                                                         25:
            //                                                             if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."25");
            //                                                                 break;
            //                                                             end;
            //                                                         26:
            //                                                             if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."26");
            //                                                                 break;
            //                                                             end;
            //                                                         27:
            //                                                             if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."27");
            //                                                                 break;
            //                                                             end;
            //                                                         28:
            //                                                             if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."28");
            //                                                                 break;
            //                                                             end;
            //                                                         29:
            //                                                             if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."29");
            //                                                                 break;
            //                                                             end;
            //                                                         30:
            //                                                             if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."30");
            //                                                                 break;
            //                                                             end;
            //                                                         31:
            //                                                             if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."31");
            //                                                                 break;
            //                                                             end;
            //                                                         32:
            //                                                             if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."32");
            //                                                                 break;
            //                                                             end;
            //                                                         33:
            //                                                             if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."33");
            //                                                                 break;
            //                                                             end;
            //                                                         34:
            //                                                             if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."34");
            //                                                                 break;
            //                                                             end;
            //                                                         35:
            //                                                             if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."35");
            //                                                                 break;
            //                                                             end;
            //                                                         36:
            //                                                             if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."36");
            //                                                                 break;
            //                                                             end;
            //                                                         37:
            //                                                             if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."37");
            //                                                                 break;
            //                                                             end;
            //                                                         38:
            //                                                             if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."38");
            //                                                                 break;
            //                                                             end;
            //                                                         39:
            //                                                             if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."39");
            //                                                                 break;
            //                                                             end;
            //                                                         40:
            //                                                             if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."40");
            //                                                                 break;
            //                                                             end;
            //                                                         41:
            //                                                             if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."41");
            //                                                                 break;
            //                                                             end;
            //                                                         42:
            //                                                             if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."42");
            //                                                                 break;
            //                                                             end;
            //                                                         43:
            //                                                             if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."43");
            //                                                                 break;
            //                                                             end;
            //                                                         44:
            //                                                             if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."44");
            //                                                                 break;
            //                                                             end;
            //                                                         45:
            //                                                             if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."45");
            //                                                                 break;
            //                                                             end;
            //                                                         46:
            //                                                             if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."46");
            //                                                                 break;
            //                                                             end;
            //                                                         47:
            //                                                             if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."47");
            //                                                                 break;
            //                                                             end;
            //                                                         48:
            //                                                             if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."48");
            //                                                                 break;
            //                                                             end;
            //                                                         49:
            //                                                             if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."49");
            //                                                                 break;
            //                                                             end;
            //                                                         50:
            //                                                             if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."50");
            //                                                                 break;
            //                                                             end;
            //                                                         51:
            //                                                             if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."51");
            //                                                                 break;
            //                                                             end;
            //                                                         52:
            //                                                             if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."52");
            //                                                                 break;
            //                                                             end;
            //                                                         53:
            //                                                             if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."53");
            //                                                                 break;
            //                                                             end;
            //                                                         54:
            //                                                             if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."54");
            //                                                                 break;
            //                                                             end;
            //                                                         55:
            //                                                             if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."55");
            //                                                                 break;
            //                                                             end;
            //                                                         56:
            //                                                             if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."56");
            //                                                                 break;
            //                                                             end;
            //                                                         57:
            //                                                             if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."57");
            //                                                                 break;
            //                                                             end;
            //                                                         58:
            //                                                             if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."58");
            //                                                                 break;
            //                                                             end;
            //                                                         59:
            //                                                             if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."59");
            //                                                                 break;
            //                                                             end;
            //                                                         60:
            //                                                             if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."60");
            //                                                                 break;
            //                                                             end;
            //                                                         61:
            //                                                             if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."61");
            //                                                                 break;
            //                                                             end;
            //                                                         62:
            //                                                             if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."62");
            //                                                                 break;
            //                                                             end;
            //                                                         63:
            //                                                             if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."63");
            //                                                                 break;
            //                                                             end;
            //                                                         64:
            //                                                             if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                 Evaluate(SubTotal, AssortDetailsRec."64");
            //                                                                 break;
            //                                                             end;
            //                                                     end;
            //                                                 end;

            //                                                 Total += SubTotal;
            //                                             end;

            //                                         until AssortDetailsRec.Next() = 0;

            //                                         LineNo += 1;
            //                                         Value := 0;
            //                                         Requirment := 0;

            //                                         UOMRec.Reset();
            //                                         UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                         UOMRec.FindSet();
            //                                         ConvFactor := UOMRec."Converion Parameter";

            //                                         //Check whether already "po raised"items are there, then do not insert
            //                                         BLAutoGenNewRec.Reset();
            //                                         BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                         BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                         BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                         BLAutoGenNewRec.SetRange("Item Color No.", BOMLine2Rec."Item Color No.");
            //                                         BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
            //                                         BLAutoGenNewRec.SetRange("Country No.", '');
            //                                         BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                         BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                         BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                         BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
            //                                         BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                         if Not BLAutoGenNewRec.FindSet() then begin
            //                                             if Total <> 0 then begin

            //                                                 BLAutoGenNewRec.Init();
            //                                                 BLAutoGenNewRec."No." := BOMRec.No;
            //                                                 BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                 BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                 BLAutoGenNewRec."Line No." := LineNo;
            //                                                 BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                 BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                 BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                 BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                 BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                 BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                 BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
            //                                                 BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
            //                                                 BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                 BLAutoGenNewRec.Type := BLERec.Type;
            //                                                 BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                 BLAutoGenNewRec.WST := BLERec.WST;
            //                                                 BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                 BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                 BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                 BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                 BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                 BLAutoGenNewRec."Created User" := UserId;
            //                                                 BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                 BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                 BLAutoGenNewRec."Size Sensitive" := false;
            //                                                 BLAutoGenNewRec."Color Sensitive" := false;
            //                                                 BLAutoGenNewRec."Country Sensitive" := false;
            //                                                 BLAutoGenNewRec."PO Sensitive" := false;
            //                                                 BLAutoGenNewRec.Reconfirm := false;
            //                                                 BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                 BLAutoGenNewRec."GMT Color No." := BOMLine2Rec."GMT Color No.";
            //                                                 BLAutoGenNewRec."GMT Color Name" := BOMLine2Rec."GMT Color Name.";
            //                                                 BLAutoGenNewRec."Item Color No." := BOMLine2Rec."Item Color No.";
            //                                                 BLAutoGenNewRec."Item Color Name" := BOMLine2Rec."Item Color Name.";
            //                                                 BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
            //                                                 BLAutoGenNewRec."Country No." := '';
            //                                                 BLAutoGenNewRec."Country Name" := '';
            //                                                 BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                 BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
            //                                                 BLAutoGenNewRec."GMT Qty" := Total;
            //                                                 BLAutoGenNewRec."Include in PO" := true;

            //                                                 if BLERec.Type = BLERec.Type::Pcs then
            //                                                     Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                 else
            //                                                     if BLERec.Type = BLERec.Type::Doz then
            //                                                         Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                 if (ConvFactor <> 0) then
            //                                                     Requirment := Requirment / ConvFactor;

            //                                                 //Requirment := Round(Requirment, 1);

            //                                                 if Requirment < 0 then
            //                                                     Requirment := 1;

            //                                                 Value := Requirment * BLERec.Rate;

            //                                                 BLAutoGenNewRec.Requirment := Requirment;
            //                                                 BLAutoGenNewRec.Value := Value;

            //                                                 BLAutoGenNewRec.Insert();

            //                                                 //Insert into AutoGenPRBOM
            //                                                 InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                 Total := 0;

            //                                             end;
            //                                         end;
            //                                     end;

            //                                 until BOMPOSelecRec.Next() = 0;
            //                             end;
            //                         until BOMLine2Rec.Next() = 0;
            //                     end;
            //                 end;

            //                 //Size and country
            //                 if not BLERec."Color Sensitive" and BLERec."Size Sensitive" and BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

            //                     //Size filter
            //                     BOMLine2Rec.Reset();
            //                     BOMLine2Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine2Rec.SetRange(Type, 2);
            //                     BOMLine2Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine2Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine2Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine2Rec.FindSet() then begin
            //                         repeat

            //                             //PO filter
            //                             BOMPOSelecRec.Reset();
            //                             BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                             BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                             BOMPOSelecRec.SetRange(Selection, true);

            //                             if BOMPOSelecRec.FindSet() then begin

            //                                 repeat

            //                                     //Country filter
            //                                     BOMLine3Rec.Reset();
            //                                     BOMLine3Rec.SetRange("No.", BOMRec.No);
            //                                     BOMLine3Rec.SetRange(Type, 3);
            //                                     BOMLine3Rec.SetRange("Item No.", BOMLine2Rec."Item No.");
            //                                     BOMLine3Rec.SetRange(Placement, BOMLine2Rec."Placement");
            //                                     BOMLine3Rec.SetRange(Select, true);

            //                                     if BOMLine3Rec.FindSet() then begin

            //                                         repeat

            //                                             //Insert new line
            //                                             AssortDetailsRec.Reset();
            //                                             AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                             AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                             AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                             if AssortDetailsRec.FindSet() then begin

            //                                                 repeat

            //                                                     if AssortDetailsRec."Colour No" <> '*' then begin

            //                                                         //Find the correct column for the GMT size
            //                                                         AssortDetails1Rec.Reset();
            //                                                         AssortDetails1Rec.SetRange("Style No.", rec."No.");
            //                                                         AssortDetails1Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                                         AssortDetails1Rec.SetRange("Country Code", BOMLine3Rec."Country Code");
            //                                                         AssortDetails1Rec.SetRange("Colour No", '*');

            //                                                         AssortDetails1Rec.FindSet();
            //                                                         SubTotal := 0;

            //                                                         FOR Count := 1 TO 64 DO begin

            //                                                             case Count of
            //                                                                 1:
            //                                                                     if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."1");
            //                                                                         break;
            //                                                                     end;
            //                                                                 2:
            //                                                                     if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."2");
            //                                                                         break;
            //                                                                     end;
            //                                                                 3:
            //                                                                     if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."3");
            //                                                                         break;
            //                                                                     end;
            //                                                                 4:
            //                                                                     if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."4");
            //                                                                         break;
            //                                                                     end;
            //                                                                 5:
            //                                                                     if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."5");
            //                                                                         break;
            //                                                                     end;
            //                                                                 6:
            //                                                                     if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."6");
            //                                                                         break;
            //                                                                     end;
            //                                                                 7:
            //                                                                     if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."7");
            //                                                                         break;
            //                                                                     end;
            //                                                                 8:
            //                                                                     if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."8");
            //                                                                         break;
            //                                                                     end;
            //                                                                 9:
            //                                                                     if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."9");
            //                                                                         break;
            //                                                                     end;
            //                                                                 10:
            //                                                                     if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."10");
            //                                                                         break;
            //                                                                     end;
            //                                                                 11:
            //                                                                     if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."11");
            //                                                                         break;
            //                                                                     end;
            //                                                                 12:
            //                                                                     if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."12");
            //                                                                         break;
            //                                                                     end;
            //                                                                 13:
            //                                                                     if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."13");
            //                                                                         break;
            //                                                                     end;
            //                                                                 14:
            //                                                                     if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."14");
            //                                                                         break;
            //                                                                     end;
            //                                                                 15:
            //                                                                     if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."15");
            //                                                                         break;
            //                                                                     end;
            //                                                                 16:
            //                                                                     if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."16");
            //                                                                         break;
            //                                                                     end;
            //                                                                 17:
            //                                                                     if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."17");
            //                                                                         break;
            //                                                                     end;
            //                                                                 18:
            //                                                                     if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."18");
            //                                                                         break;
            //                                                                     end;
            //                                                                 19:
            //                                                                     if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."19");
            //                                                                         break;
            //                                                                     end;
            //                                                                 20:
            //                                                                     if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."20");
            //                                                                         break;
            //                                                                     end;
            //                                                                 21:
            //                                                                     if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."21");
            //                                                                         break;
            //                                                                     end;
            //                                                                 22:
            //                                                                     if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."22");
            //                                                                         break;
            //                                                                     end;
            //                                                                 23:
            //                                                                     if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."23");
            //                                                                         break;
            //                                                                     end;
            //                                                                 24:
            //                                                                     if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."24");
            //                                                                         break;
            //                                                                     end;
            //                                                                 25:
            //                                                                     if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."25");
            //                                                                         break;
            //                                                                     end;
            //                                                                 26:
            //                                                                     if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."26");
            //                                                                         break;
            //                                                                     end;
            //                                                                 27:
            //                                                                     if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."27");
            //                                                                         break;
            //                                                                     end;
            //                                                                 28:
            //                                                                     if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."28");
            //                                                                         break;
            //                                                                     end;
            //                                                                 29:
            //                                                                     if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."29");
            //                                                                         break;
            //                                                                     end;
            //                                                                 30:
            //                                                                     if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."30");
            //                                                                         break;
            //                                                                     end;
            //                                                                 31:
            //                                                                     if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."31");
            //                                                                         break;
            //                                                                     end;
            //                                                                 32:
            //                                                                     if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."32");
            //                                                                         break;
            //                                                                     end;
            //                                                                 33:
            //                                                                     if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."33");
            //                                                                         break;
            //                                                                     end;
            //                                                                 34:
            //                                                                     if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."34");
            //                                                                         break;
            //                                                                     end;
            //                                                                 35:
            //                                                                     if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."35");
            //                                                                         break;
            //                                                                     end;
            //                                                                 36:
            //                                                                     if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."36");
            //                                                                         break;
            //                                                                     end;
            //                                                                 37:
            //                                                                     if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."37");
            //                                                                         break;
            //                                                                     end;
            //                                                                 38:
            //                                                                     if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."38");
            //                                                                         break;
            //                                                                     end;
            //                                                                 39:
            //                                                                     if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."39");
            //                                                                         break;
            //                                                                     end;
            //                                                                 40:
            //                                                                     if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."40");
            //                                                                         break;
            //                                                                     end;
            //                                                                 41:
            //                                                                     if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."41");
            //                                                                         break;
            //                                                                     end;
            //                                                                 42:
            //                                                                     if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."42");
            //                                                                         break;
            //                                                                     end;
            //                                                                 43:
            //                                                                     if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."43");
            //                                                                         break;
            //                                                                     end;
            //                                                                 44:
            //                                                                     if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."44");
            //                                                                         break;
            //                                                                     end;
            //                                                                 45:
            //                                                                     if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."45");
            //                                                                         break;
            //                                                                     end;
            //                                                                 46:
            //                                                                     if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."46");
            //                                                                         break;
            //                                                                     end;
            //                                                                 47:
            //                                                                     if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."47");
            //                                                                         break;
            //                                                                     end;
            //                                                                 48:
            //                                                                     if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."48");
            //                                                                         break;
            //                                                                     end;
            //                                                                 49:
            //                                                                     if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."49");
            //                                                                         break;
            //                                                                     end;
            //                                                                 50:
            //                                                                     if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."50");
            //                                                                         break;
            //                                                                     end;
            //                                                                 51:
            //                                                                     if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."51");
            //                                                                         break;
            //                                                                     end;
            //                                                                 52:
            //                                                                     if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."52");
            //                                                                         break;
            //                                                                     end;
            //                                                                 53:
            //                                                                     if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."53");
            //                                                                         break;
            //                                                                     end;
            //                                                                 54:
            //                                                                     if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."54");
            //                                                                         break;
            //                                                                     end;
            //                                                                 55:
            //                                                                     if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."55");
            //                                                                         break;
            //                                                                     end;
            //                                                                 56:
            //                                                                     if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."56");
            //                                                                         break;
            //                                                                     end;
            //                                                                 57:
            //                                                                     if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."57");
            //                                                                         break;
            //                                                                     end;
            //                                                                 58:
            //                                                                     if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."58");
            //                                                                         break;
            //                                                                     end;
            //                                                                 59:
            //                                                                     if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."59");
            //                                                                         break;
            //                                                                     end;
            //                                                                 60:
            //                                                                     if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."60");
            //                                                                         break;
            //                                                                     end;
            //                                                                 61:
            //                                                                     if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."61");
            //                                                                         break;
            //                                                                     end;
            //                                                                 62:
            //                                                                     if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."62");
            //                                                                         break;
            //                                                                     end;
            //                                                                 63:
            //                                                                     if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."63");
            //                                                                         break;
            //                                                                     end;
            //                                                                 64:
            //                                                                     if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."64");
            //                                                                         break;
            //                                                                     end;
            //                                                             end;
            //                                                         end;

            //                                                         Total += SubTotal;
            //                                                     end;

            //                                                 until AssortDetailsRec.Next() = 0;

            //                                                 LineNo += 1;
            //                                                 Value := 0;
            //                                                 Requirment := 0;

            //                                                 UOMRec.Reset();
            //                                                 UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                                 UOMRec.FindSet();
            //                                                 ConvFactor := UOMRec."Converion Parameter";

            //                                                 //Check whether already "po raised"items are there, then do not insert
            //                                                 BLAutoGenNewRec.Reset();
            //                                                 BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                                 BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                                 BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                                 BLAutoGenNewRec.SetRange("Item Color No.", BOMLine2Rec."Item Color No.");
            //                                                 BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
            //                                                 BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                                 BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                                 BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                                 BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                                 BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
            //                                                 BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                                 if Not BLAutoGenNewRec.FindSet() then begin
            //                                                     if Total <> 0 then begin

            //                                                         BLAutoGenNewRec.Init();
            //                                                         BLAutoGenNewRec."No." := BOMRec.No;
            //                                                         BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                         BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                         BLAutoGenNewRec."Line No." := LineNo;
            //                                                         BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                         BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                         BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                         BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                         BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                         BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                         BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
            //                                                         BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
            //                                                         BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                         BLAutoGenNewRec.Type := BLERec.Type;
            //                                                         BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                         BLAutoGenNewRec.WST := BLERec.WST;
            //                                                         BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                         BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                         BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                         BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                         BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                         BLAutoGenNewRec."Created User" := UserId;
            //                                                         BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                         BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                         BLAutoGenNewRec."Size Sensitive" := false;
            //                                                         BLAutoGenNewRec."Color Sensitive" := false;
            //                                                         BLAutoGenNewRec."Country Sensitive" := false;
            //                                                         BLAutoGenNewRec."PO Sensitive" := false;
            //                                                         BLAutoGenNewRec.Reconfirm := false;
            //                                                         BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                         BLAutoGenNewRec."GMT Color No." := BOMLine2Rec."GMT Color No.";
            //                                                         BLAutoGenNewRec."GMT Color Name" := BOMLine2Rec."GMT Color Name.";
            //                                                         BLAutoGenNewRec."Item Color No." := BOMLine2Rec."Item Color No.";
            //                                                         BLAutoGenNewRec."Item Color Name" := BOMLine2Rec."Item Color Name.";
            //                                                         BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
            //                                                         BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
            //                                                         BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
            //                                                         BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                         BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
            //                                                         BLAutoGenNewRec."GMT Qty" := Total;
            //                                                         BLAutoGenNewRec."Include in PO" := true;

            //                                                         if BLERec.Type = BLERec.Type::Pcs then
            //                                                             Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                         else
            //                                                             if BLERec.Type = BLERec.Type::Doz then
            //                                                                 Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                         if (ConvFactor <> 0) then
            //                                                             Requirment := Requirment / ConvFactor;

            //                                                         //Requirment := Round(Requirment, 1);

            //                                                         if Requirment < 0 then
            //                                                             Requirment := 1;

            //                                                         Value := Requirment * BLERec.Rate;

            //                                                         BLAutoGenNewRec.Requirment := Requirment;
            //                                                         BLAutoGenNewRec.Value := Value;

            //                                                         BLAutoGenNewRec.Insert();

            //                                                         //Insert into AutoGenPRBOM
            //                                                         InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                         Total := 0;

            //                                                     end;
            //                                                 end;
            //                                             end;

            //                                         until BOMLine3Rec.Next() = 0;
            //                                     end;
            //                                 until BOMPOSelecRec.Next() = 0;
            //                             end;
            //                         until BOMLine2Rec.Next() = 0;
            //                     end;
            //                 end;

            //                 //country only
            //                 if not BLERec."Color Sensitive" and not BLERec."Size Sensitive" and BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

            //                     //PO filter
            //                     BOMPOSelecRec.Reset();
            //                     BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                     BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                     BOMPOSelecRec.SetRange(Selection, true);

            //                     if BOMPOSelecRec.FindSet() then begin

            //                         repeat

            //                             //Country filter
            //                             BOMLine3Rec.Reset();
            //                             BOMLine3Rec.SetRange("No.", BOMRec.No);
            //                             BOMLine3Rec.SetRange(Type, 3);
            //                             BOMLine3Rec.SetRange("Item No.", BLERec."Item No.");
            //                             BOMLine3Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                             BOMLine3Rec.SetRange(Select, true);

            //                             if BOMLine3Rec.FindSet() then begin

            //                                 repeat

            //                                     //Insert new line
            //                                     AssortDetailsRec.Reset();
            //                                     AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                     AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                     AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                     if AssortDetailsRec.FindSet() then begin

            //                                         repeat
            //                                             if AssortDetailsRec."Colour No" <> '*' then begin
            //                                                 Total += AssortDetailsRec.Total;
            //                                             end;
            //                                         until AssortDetailsRec.Next() = 0;

            //                                         LineNo += 1;
            //                                         Value := 0;
            //                                         Requirment := 0;

            //                                         UOMRec.Reset();
            //                                         UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                         UOMRec.FindSet();
            //                                         ConvFactor := UOMRec."Converion Parameter";

            //                                         //Check whether already "po raised"items are there, then do not insert
            //                                         BLAutoGenNewRec.Reset();
            //                                         BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                         BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                         BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                         BLAutoGenNewRec.SetRange("Item Color No.", BOMLine3Rec."Item Color No.");
            //                                         BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine3Rec."GMR Size Name");
            //                                         BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                         BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                         BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                         BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                         BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
            //                                         BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                         if Not BLAutoGenNewRec.FindSet() then begin
            //                                             if Total <> 0 then begin

            //                                                 BLAutoGenNewRec.Init();
            //                                                 BLAutoGenNewRec."No." := BOMRec.No;
            //                                                 BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                 BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                 BLAutoGenNewRec."Line No." := LineNo;
            //                                                 BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                 BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                 BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                 BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                 BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                 BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                 BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
            //                                                 BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
            //                                                 BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                 BLAutoGenNewRec.Type := BLERec.Type;
            //                                                 BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                 BLAutoGenNewRec.WST := BLERec.WST;
            //                                                 BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                 BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                 BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                 BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                 BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                 BLAutoGenNewRec."Created User" := UserId;
            //                                                 BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                 BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                 BLAutoGenNewRec."Size Sensitive" := false;
            //                                                 BLAutoGenNewRec."Color Sensitive" := false;
            //                                                 BLAutoGenNewRec."Country Sensitive" := false;
            //                                                 BLAutoGenNewRec."PO Sensitive" := false;
            //                                                 BLAutoGenNewRec.Reconfirm := false;
            //                                                 BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                 BLAutoGenNewRec."GMT Color No." := BOMLine3Rec."GMT Color No.";
            //                                                 BLAutoGenNewRec."GMT Color Name" := BOMLine3Rec."GMT Color Name.";
            //                                                 BLAutoGenNewRec."Item Color No." := BOMLine3Rec."Item Color No.";
            //                                                 BLAutoGenNewRec."Item Color Name" := BOMLine3Rec."Item Color Name.";
            //                                                 BLAutoGenNewRec."GMT Size Name" := BOMLine3Rec."GMR Size Name";
            //                                                 BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
            //                                                 BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
            //                                                 BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                 BLAutoGenNewRec."Lot No." := BOMPOSelecRec."Lot No.";
            //                                                 BLAutoGenNewRec."GMT Qty" := Total;
            //                                                 BLAutoGenNewRec."Include in PO" := true;

            //                                                 if BLERec.Type = BLERec.Type::Pcs then
            //                                                     Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                 else
            //                                                     if BLERec.Type = BLERec.Type::Doz then
            //                                                         Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                 if (ConvFactor <> 0) then
            //                                                     Requirment := Requirment / ConvFactor;

            //                                                 //Requirment := Round(Requirment, 1);

            //                                                 if Requirment < 0 then
            //                                                     Requirment := 1;

            //                                                 Value := Requirment * BLERec.Rate;

            //                                                 BLAutoGenNewRec.Requirment := Requirment;
            //                                                 BLAutoGenNewRec.Value := Value;

            //                                                 BLAutoGenNewRec.Insert();

            //                                                 //Insert into AutoGenPRBOM
            //                                                 InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                 Total := 0;
            //                                             end;
            //                                         end;

            //                                     end;

            //                                 until BOMLine3Rec.Next() = 0;
            //                             end;
            //                         until BOMPOSelecRec.Next() = 0;
            //                     end;

            //                 end;

            //                 //Color and Country
            //                 if BLERec."Color Sensitive" and not BLERec."Size Sensitive" and BLERec."Country Sensitive" and not BLERec."PO Sensitive" then begin

            //                     //Color filter
            //                     BOMLine1Rec.Reset();
            //                     BOMLine1Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine1Rec.SetRange(Type, 1);
            //                     BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine1Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine1Rec.FindSet() then begin

            //                         repeat

            //                             //PO filter
            //                             BOMPOSelecRec.Reset();
            //                             BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                             BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                             BOMPOSelecRec.SetRange(Selection, true);

            //                             if BOMPOSelecRec.FindSet() then begin
            //                                 repeat

            //                                     //Country filter
            //                                     BOMLine3Rec.Reset();
            //                                     BOMLine3Rec.SetRange("No.", BOMRec.No);
            //                                     BOMLine3Rec.SetRange(Type, 3);
            //                                     BOMLine3Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                                     BOMLine3Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                                     BOMLine3Rec.SetRange(Select, true);

            //                                     if BOMLine3Rec.FindSet() then begin

            //                                         repeat

            //                                             //Insert new line
            //                                             AssortDetailsRec.Reset();
            //                                             AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                             AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                             AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");
            //                                             AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                             if AssortDetailsRec.FindSet() then begin

            //                                                 Total := AssortDetailsRec.Total;
            //                                                 LineNo += 1;
            //                                                 Value := 0;
            //                                                 Requirment := 0;

            //                                                 UOMRec.Reset();
            //                                                 UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                                 UOMRec.FindSet();
            //                                                 ConvFactor := UOMRec."Converion Parameter";

            //                                                 //Check whether already "po raised"items are there, then do not insert
            //                                                 BLAutoGenNewRec.Reset();
            //                                                 BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                                 BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                                 BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                                 BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
            //                                                 //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
            //                                                 BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine1Rec."GMR Size Name");
            //                                                 BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                                 BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                                 BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                                 BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                                 BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
            //                                                 BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                                 if Not BLAutoGenNewRec.FindSet() then begin
            //                                                     if Total <> 0 then begin

            //                                                         BLAutoGenNewRec.Init();
            //                                                         BLAutoGenNewRec."No." := BOMRec.No;
            //                                                         BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                         BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                         BLAutoGenNewRec."Line No." := LineNo;
            //                                                         BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                         BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                         BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                         BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                         BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                         BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                         BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
            //                                                         BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
            //                                                         BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                         BLAutoGenNewRec.Type := BLERec.Type;
            //                                                         BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                         BLAutoGenNewRec.WST := BLERec.WST;
            //                                                         BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                         BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                         BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                         BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                         BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                         BLAutoGenNewRec."Created User" := UserId;
            //                                                         BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                         BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                         BLAutoGenNewRec."Size Sensitive" := false;
            //                                                         BLAutoGenNewRec."Color Sensitive" := false;
            //                                                         BLAutoGenNewRec."Country Sensitive" := false;
            //                                                         BLAutoGenNewRec."PO Sensitive" := false;
            //                                                         BLAutoGenNewRec.Reconfirm := false;
            //                                                         BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                         BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
            //                                                         BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
            //                                                         BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
            //                                                         BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
            //                                                         BLAutoGenNewRec."GMT Size Name" := BOMLine1Rec."GMR Size Name";
            //                                                         BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
            //                                                         BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
            //                                                         BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                         BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
            //                                                         BLAutoGenNewRec."GMT Qty" := Total;
            //                                                         BLAutoGenNewRec."Include in PO" := true;

            //                                                         if BLERec.Type = BLERec.Type::Pcs then
            //                                                             Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                         else
            //                                                             if BLERec.Type = BLERec.Type::Doz then
            //                                                                 Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                         if (ConvFactor <> 0) then
            //                                                             Requirment := Requirment / ConvFactor;

            //                                                         //Requirment := Round(Requirment, 1);

            //                                                         if Requirment < 0 then
            //                                                             Requirment := 1;

            //                                                         Value := Requirment * BLERec.Rate;

            //                                                         BLAutoGenNewRec.Requirment := Requirment;
            //                                                         BLAutoGenNewRec.Value := Value;

            //                                                         BLAutoGenNewRec.Insert();

            //                                                         //Insert into AutoGenPRBOM
            //                                                         InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                         Total := 0;
            //                                                     end;
            //                                                 end;

            //                                             end;

            //                                         until BOMLine3Rec.Next() = 0;
            //                                     end;

            //                                 until BOMPOSelecRec.Next() = 0;
            //                             end;

            //                         until BOMLine1Rec.Next() = 0;
            //                     end;
            //                 end;

            //                 //PO only
            //                 if not BLERec."Color Sensitive" and not BLERec."Size Sensitive" and not BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

            //                     //PO filter
            //                     BOMPOSelecRec.Reset();
            //                     BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                     BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                     BOMPOSelecRec.SetRange(Selection, true);

            //                     if BOMPOSelecRec.FindSet() then begin
            //                         repeat

            //                             //Item po filter
            //                             BOMLine4Rec.Reset();
            //                             BOMLine4Rec.SetRange("No.", BOMRec.No);
            //                             BOMLine4Rec.SetRange(Type, 4);
            //                             BOMLine4Rec.SetRange("Item No.", BLERec."Item No.");
            //                             BOMLine4Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                             BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                             BOMLine4Rec.SetRange(Select, true);

            //                             if BOMLine4Rec.FindSet() then begin

            //                                 //Insert new line
            //                                 AssortDetailsRec.Reset();
            //                                 AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                 AssortDetailsRec.SetRange("lot No.", BOMLine4Rec."lot No.");

            //                                 if AssortDetailsRec.FindSet() then begin

            //                                     repeat
            //                                         if AssortDetailsRec."Colour No" <> '*' then
            //                                             Total += AssortDetailsRec.Total;
            //                                     until AssortDetailsRec.Next() = 0;


            //                                     LineNo += 1;
            //                                     Value := 0;
            //                                     Requirment := 0;

            //                                     UOMRec.Reset();
            //                                     UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                     UOMRec.FindSet();
            //                                     ConvFactor := UOMRec."Converion Parameter";

            //                                     //Check whether already "po raised"items are there, then do not insert
            //                                     BLAutoGenNewRec.Reset();
            //                                     BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                     BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                     BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                     //BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
            //                                     BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
            //                                     BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
            //                                     BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                     BLAutoGenNewRec.SetRange(PO, BOMLine4Rec."PO No.");
            //                                     BLAutoGenNewRec.SetRange("Lot No.", BOMLine4Rec."Lot No.");
            //                                     BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                     BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
            //                                     BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                     if Not BLAutoGenNewRec.FindSet() then begin
            //                                         if Total <> 0 then begin

            //                                             BLAutoGenNewRec.Init();
            //                                             BLAutoGenNewRec."No." := BOMRec.No;
            //                                             BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                             BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                             BLAutoGenNewRec."Line No." := LineNo;
            //                                             BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                             BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                             BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                             BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                             BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                             BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                             BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
            //                                             BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
            //                                             BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                             BLAutoGenNewRec.Type := BLERec.Type;
            //                                             BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                             BLAutoGenNewRec.WST := BLERec.WST;
            //                                             BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                             BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                             BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                             BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                             BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                             BLAutoGenNewRec."Created User" := UserId;
            //                                             BLAutoGenNewRec."Created Date" := WorkDate();
            //                                             BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                             BLAutoGenNewRec."Size Sensitive" := false;
            //                                             BLAutoGenNewRec."Color Sensitive" := false;
            //                                             BLAutoGenNewRec."Country Sensitive" := false;
            //                                             BLAutoGenNewRec."PO Sensitive" := false;
            //                                             BLAutoGenNewRec.Reconfirm := false;
            //                                             BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                             BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
            //                                             BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
            //                                             BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
            //                                             BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
            //                                             BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
            //                                             BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
            //                                             BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
            //                                             BLAutoGenNewRec.PO := BOMLine4Rec."PO No.";
            //                                             BLAutoGenNewRec."Lot No." := BOMLine4Rec."lot No.";
            //                                             BLAutoGenNewRec."GMT Qty" := Total;
            //                                             BLAutoGenNewRec."Include in PO" := true;

            //                                             if BLERec.Type = BLERec.Type::Pcs then
            //                                                 Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                             else
            //                                                 if BLERec.Type = BLERec.Type::Doz then
            //                                                     Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                             if (ConvFactor <> 0) then
            //                                                 Requirment := Requirment / ConvFactor;

            //                                             //Requirment := Round(Requirment, 1);

            //                                             if Requirment < 0 then
            //                                                 Requirment := 1;

            //                                             Value := Requirment * BLERec.Rate;

            //                                             BLAutoGenNewRec.Requirment := Requirment;
            //                                             BLAutoGenNewRec.Value := Value;

            //                                             BLAutoGenNewRec.Insert();

            //                                             //Insert into AutoGenPRBOM
            //                                             InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                             Total := 0;
            //                                         end;
            //                                     end;
            //                                 end;
            //                             end;
            //                         until BOMPOSelecRec.Next() = 0;
            //                     end;
            //                 end;

            //                 //Size and PO
            //                 if not BLERec."Color Sensitive" and BLERec."Size Sensitive" and not BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

            //                     //Size filter
            //                     BOMLine2Rec.Reset();
            //                     BOMLine2Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine2Rec.SetRange(Type, 2);
            //                     BOMLine2Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine2Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine2Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine2Rec.FindSet() then begin

            //                         repeat

            //                             //PO filter
            //                             BOMPOSelecRec.Reset();
            //                             BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                             BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                             BOMPOSelecRec.SetRange(Selection, true);

            //                             if BOMPOSelecRec.FindSet() then begin

            //                                 repeat

            //                                     //Item po filter
            //                                     BOMLine4Rec.Reset();
            //                                     BOMLine4Rec.SetRange("No.", BOMRec.No);
            //                                     BOMLine4Rec.SetRange(Type, 4);
            //                                     BOMLine4Rec.SetRange("Item No.", BOMLine2Rec."Item No.");
            //                                     BOMLine4Rec.SetRange(Placement, BOMLine2Rec."Placement");
            //                                     BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                     BOMLine4Rec.SetRange(Select, true);

            //                                     if BOMLine4Rec.FindSet() then begin

            //                                         repeat

            //                                             //Insert new line
            //                                             AssortDetailsRec.Reset();
            //                                             AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                             AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");

            //                                             if AssortDetailsRec.FindSet() then begin

            //                                                 repeat

            //                                                     if AssortDetailsRec."Colour No" <> '*' then begin

            //                                                         //Find the correct column for the GMT size
            //                                                         AssortDetails1Rec.Reset();
            //                                                         AssortDetails1Rec.SetRange("Style No.", rec."No.");
            //                                                         AssortDetails1Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                                         AssortDetails1Rec.SetRange("Colour No", '*');

            //                                                         AssortDetails1Rec.FindSet();

            //                                                         FOR Count := 1 TO 64 DO begin

            //                                                             case Count of
            //                                                                 1:
            //                                                                     if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."1");
            //                                                                         break;
            //                                                                     end;
            //                                                                 2:
            //                                                                     if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."2");
            //                                                                         break;
            //                                                                     end;
            //                                                                 3:
            //                                                                     if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."3");
            //                                                                         break;
            //                                                                     end;
            //                                                                 4:
            //                                                                     if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."4");
            //                                                                         break;
            //                                                                     end;
            //                                                                 5:
            //                                                                     if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."5");
            //                                                                         break;
            //                                                                     end;
            //                                                                 6:
            //                                                                     if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."6");
            //                                                                         break;
            //                                                                     end;
            //                                                                 7:
            //                                                                     if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."7");
            //                                                                         break;
            //                                                                     end;
            //                                                                 8:
            //                                                                     if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."8");
            //                                                                         break;
            //                                                                     end;
            //                                                                 9:
            //                                                                     if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."9");
            //                                                                         break;
            //                                                                     end;
            //                                                                 10:
            //                                                                     if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."10");
            //                                                                         break;
            //                                                                     end;
            //                                                                 11:
            //                                                                     if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."11");
            //                                                                         break;
            //                                                                     end;
            //                                                                 12:
            //                                                                     if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."12");
            //                                                                         break;
            //                                                                     end;
            //                                                                 13:
            //                                                                     if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."13");
            //                                                                         break;
            //                                                                     end;
            //                                                                 14:
            //                                                                     if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."14");
            //                                                                         break;
            //                                                                     end;
            //                                                                 15:
            //                                                                     if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."15");
            //                                                                         break;
            //                                                                     end;
            //                                                                 16:
            //                                                                     if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."16");
            //                                                                         break;
            //                                                                     end;
            //                                                                 17:
            //                                                                     if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."17");
            //                                                                         break;
            //                                                                     end;
            //                                                                 18:
            //                                                                     if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."18");
            //                                                                         break;
            //                                                                     end;
            //                                                                 19:
            //                                                                     if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."19");
            //                                                                         break;
            //                                                                     end;
            //                                                                 20:
            //                                                                     if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."20");
            //                                                                         break;
            //                                                                     end;
            //                                                                 21:
            //                                                                     if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."21");
            //                                                                         break;
            //                                                                     end;
            //                                                                 22:
            //                                                                     if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."22");
            //                                                                         break;
            //                                                                     end;
            //                                                                 23:
            //                                                                     if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."23");
            //                                                                         break;
            //                                                                     end;
            //                                                                 24:
            //                                                                     if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."24");
            //                                                                         break;
            //                                                                     end;
            //                                                                 25:
            //                                                                     if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."25");
            //                                                                         break;
            //                                                                     end;
            //                                                                 26:
            //                                                                     if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."26");
            //                                                                         break;
            //                                                                     end;
            //                                                                 27:
            //                                                                     if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."27");
            //                                                                         break;
            //                                                                     end;
            //                                                                 28:
            //                                                                     if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."28");
            //                                                                         break;
            //                                                                     end;
            //                                                                 29:
            //                                                                     if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."29");
            //                                                                         break;
            //                                                                     end;
            //                                                                 30:
            //                                                                     if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."30");
            //                                                                         break;
            //                                                                     end;
            //                                                                 31:
            //                                                                     if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."31");
            //                                                                         break;
            //                                                                     end;
            //                                                                 32:
            //                                                                     if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."32");
            //                                                                         break;
            //                                                                     end;
            //                                                                 33:
            //                                                                     if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."33");
            //                                                                         break;
            //                                                                     end;
            //                                                                 34:
            //                                                                     if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."34");
            //                                                                         break;
            //                                                                     end;
            //                                                                 35:
            //                                                                     if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."35");
            //                                                                         break;
            //                                                                     end;
            //                                                                 36:
            //                                                                     if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."36");
            //                                                                         break;
            //                                                                     end;
            //                                                                 37:
            //                                                                     if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."37");
            //                                                                         break;
            //                                                                     end;
            //                                                                 38:
            //                                                                     if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."38");
            //                                                                         break;
            //                                                                     end;
            //                                                                 39:
            //                                                                     if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."39");
            //                                                                         break;
            //                                                                     end;
            //                                                                 40:
            //                                                                     if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."40");
            //                                                                         break;
            //                                                                     end;
            //                                                                 41:
            //                                                                     if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."41");
            //                                                                         break;
            //                                                                     end;
            //                                                                 42:
            //                                                                     if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."42");
            //                                                                         break;
            //                                                                     end;
            //                                                                 43:
            //                                                                     if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."43");
            //                                                                         break;
            //                                                                     end;
            //                                                                 44:
            //                                                                     if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."44");
            //                                                                         break;
            //                                                                     end;
            //                                                                 45:
            //                                                                     if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."45");
            //                                                                         break;
            //                                                                     end;
            //                                                                 46:
            //                                                                     if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."46");
            //                                                                         break;
            //                                                                     end;
            //                                                                 47:
            //                                                                     if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."47");
            //                                                                         break;
            //                                                                     end;
            //                                                                 48:
            //                                                                     if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."48");
            //                                                                         break;
            //                                                                     end;
            //                                                                 49:
            //                                                                     if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."49");
            //                                                                         break;
            //                                                                     end;
            //                                                                 50:
            //                                                                     if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."50");
            //                                                                         break;
            //                                                                     end;
            //                                                                 51:
            //                                                                     if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."51");
            //                                                                         break;
            //                                                                     end;
            //                                                                 52:
            //                                                                     if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."52");
            //                                                                         break;
            //                                                                     end;
            //                                                                 53:
            //                                                                     if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."53");
            //                                                                         break;
            //                                                                     end;
            //                                                                 54:
            //                                                                     if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."54");
            //                                                                         break;
            //                                                                     end;
            //                                                                 55:
            //                                                                     if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."55");
            //                                                                         break;
            //                                                                     end;
            //                                                                 56:
            //                                                                     if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."56");
            //                                                                         break;
            //                                                                     end;
            //                                                                 57:
            //                                                                     if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."57");
            //                                                                         break;
            //                                                                     end;
            //                                                                 58:
            //                                                                     if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."58");
            //                                                                         break;
            //                                                                     end;
            //                                                                 59:
            //                                                                     if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."59");
            //                                                                         break;
            //                                                                     end;
            //                                                                 60:
            //                                                                     if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."60");
            //                                                                         break;
            //                                                                     end;
            //                                                                 61:
            //                                                                     if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."61");
            //                                                                         break;
            //                                                                     end;
            //                                                                 62:
            //                                                                     if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."62");
            //                                                                         break;
            //                                                                     end;
            //                                                                 63:
            //                                                                     if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."63");
            //                                                                         break;
            //                                                                     end;
            //                                                                 64:
            //                                                                     if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                         Evaluate(SubTotal, AssortDetailsRec."64");
            //                                                                         break;
            //                                                                     end;
            //                                                             end;
            //                                                         end;

            //                                                         Total += SubTotal;

            //                                                     end;

            //                                                 until AssortDetailsRec.Next() = 0;

            //                                                 LineNo += 1;
            //                                                 Value := 0;
            //                                                 Requirment := 0;

            //                                                 UOMRec.Reset();
            //                                                 UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                                 UOMRec.FindSet();
            //                                                 ConvFactor := UOMRec."Converion Parameter";

            //                                                 //Check whether already "po raised"items are there, then do not insert
            //                                                 BLAutoGenNewRec.Reset();
            //                                                 BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                                 BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                                 BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                                 BLAutoGenNewRec.SetRange("Item Color No.", BOMLine2Rec."Item Color No.");
            //                                                 BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
            //                                                 BLAutoGenNewRec.SetRange("Country No.", BOMLine2Rec."Country Code");
            //                                                 BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                                 BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                                 BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                                 BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
            //                                                 BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                                 if Not BLAutoGenNewRec.FindSet() then begin
            //                                                     if Total <> 0 then begin

            //                                                         BLAutoGenNewRec.Init();
            //                                                         BLAutoGenNewRec."No." := BOMRec.No;
            //                                                         BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                         BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                         BLAutoGenNewRec."Line No." := LineNo;
            //                                                         BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                         BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                         BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                         BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                         BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                         BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                         BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
            //                                                         BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
            //                                                         BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                         BLAutoGenNewRec.Type := BLERec.Type;
            //                                                         BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                         BLAutoGenNewRec.WST := BLERec.WST;
            //                                                         BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                         BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                         BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                         BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                         BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                         BLAutoGenNewRec."Created User" := UserId;
            //                                                         BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                         BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                         BLAutoGenNewRec."Size Sensitive" := false;
            //                                                         BLAutoGenNewRec."Color Sensitive" := false;
            //                                                         BLAutoGenNewRec."Country Sensitive" := false;
            //                                                         BLAutoGenNewRec."PO Sensitive" := false;
            //                                                         BLAutoGenNewRec.Reconfirm := false;
            //                                                         BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                         BLAutoGenNewRec."GMT Color No." := BOMLine2Rec."GMT Color No.";
            //                                                         BLAutoGenNewRec."GMT Color Name" := BOMLine2Rec."GMT Color Name.";
            //                                                         BLAutoGenNewRec."Item Color No." := BOMLine2Rec."Item Color No.";
            //                                                         BLAutoGenNewRec."Item Color Name" := BOMLine2Rec."Item Color Name.";
            //                                                         BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
            //                                                         BLAutoGenNewRec."Country No." := BOMLine2Rec."Country Code";
            //                                                         BLAutoGenNewRec."Country Name" := BOMLine2Rec."Country Name";
            //                                                         BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                         BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
            //                                                         BLAutoGenNewRec."GMT Qty" := Total;
            //                                                         BLAutoGenNewRec."Include in PO" := true;

            //                                                         if BLERec.Type = BLERec.Type::Pcs then
            //                                                             Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                         else
            //                                                             if BLERec.Type = BLERec.Type::Doz then
            //                                                                 Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                         if (ConvFactor <> 0) then
            //                                                             Requirment := Requirment / ConvFactor;

            //                                                         //Requirment := Round(Requirment, 1);

            //                                                         if Requirment < 0 then
            //                                                             Requirment := 1;

            //                                                         Value := Requirment * BLERec.Rate;

            //                                                         BLAutoGenNewRec.Requirment := Requirment;
            //                                                         BLAutoGenNewRec.Value := Value;

            //                                                         BLAutoGenNewRec.Insert();

            //                                                         //Insert into AutoGenPRBOM
            //                                                         InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                         Total := 0;
            //                                                     end;
            //                                                 end;

            //                                             end;

            //                                         until BOMLine4Rec.Next() = 0;
            //                                     end;
            //                                 until BOMPOSelecRec.Next() = 0;
            //                             end;
            //                         until BOMLine2Rec.Next() = 0;
            //                     end;
            //                 end;

            //                 //Color and PO
            //                 if BLERec."Color Sensitive" and not BLERec."Size Sensitive" and not BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

            //                     //color filter
            //                     BOMLine1Rec.Reset();
            //                     BOMLine1Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine1Rec.SetRange(Type, 1);
            //                     BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine1Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine1Rec.FindSet() then begin

            //                         repeat

            //                             //PO filter
            //                             BOMPOSelecRec.Reset();
            //                             BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                             BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                             BOMPOSelecRec.SetRange(Selection, true);

            //                             if BOMPOSelecRec.FindSet() then begin

            //                                 repeat

            //                                     //Item po filter
            //                                     BOMLine4Rec.Reset();
            //                                     BOMLine4Rec.SetRange("No.", BOMRec.No);
            //                                     BOMLine4Rec.SetRange(Type, 4);
            //                                     BOMLine4Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                                     BOMLine4Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                                     BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                     BOMLine4Rec.SetRange(Select, true);

            //                                     if BOMLine4Rec.FindSet() then begin

            //                                         repeat

            //                                             //Insert new line
            //                                             AssortDetailsRec.Reset();
            //                                             AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                             AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                             AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");

            //                                             if AssortDetailsRec.FindSet() then begin
            //                                                 //Message(Format(Total));
            //                                                 repeat

            //                                                     if AssortDetailsRec."Colour No" <> '*' then begin
            //                                                         Total += AssortDetailsRec.Total;
            //                                                     end;

            //                                                 until AssortDetailsRec.Next() = 0;

            //                                             end;

            //                                             LineNo += 1;
            //                                             Value := 0;
            //                                             Requirment := 0;

            //                                             UOMRec.Reset();
            //                                             UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                             UOMRec.FindSet();
            //                                             ConvFactor := UOMRec."Converion Parameter";

            //                                             //Check whether already "po raised"items are there, then do not insert
            //                                             BLAutoGenNewRec.Reset();
            //                                             BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                             BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                             BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                             BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
            //                                             //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
            //                                             BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine1Rec."GMR Size Name");
            //                                             BLAutoGenNewRec.SetRange("Country No.", BOMLine1Rec."Country Code");
            //                                             BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                             BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                             BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                             BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
            //                                             BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                             if Not BLAutoGenNewRec.FindSet() then begin
            //                                                 if Total <> 0 then begin

            //                                                     BLAutoGenNewRec.Init();
            //                                                     BLAutoGenNewRec."No." := BOMRec.No;
            //                                                     BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                     BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                     BLAutoGenNewRec."Line No." := LineNo;
            //                                                     BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                     BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                     BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                     BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                     BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                     BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                     BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
            //                                                     BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
            //                                                     BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                     BLAutoGenNewRec.Type := BLERec.Type;
            //                                                     BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                     BLAutoGenNewRec.WST := BLERec.WST;
            //                                                     BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                     BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                     BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                     BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                     BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                     BLAutoGenNewRec."Created User" := UserId;
            //                                                     BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                     BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                     BLAutoGenNewRec."Size Sensitive" := false;
            //                                                     BLAutoGenNewRec."Color Sensitive" := false;
            //                                                     BLAutoGenNewRec."Country Sensitive" := false;
            //                                                     BLAutoGenNewRec."PO Sensitive" := false;
            //                                                     BLAutoGenNewRec.Reconfirm := false;
            //                                                     BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                     BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
            //                                                     BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
            //                                                     BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
            //                                                     BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
            //                                                     BLAutoGenNewRec."GMT Size Name" := BOMLine1Rec."GMR Size Name";
            //                                                     BLAutoGenNewRec."Country No." := BOMLine1Rec."Country Code";
            //                                                     BLAutoGenNewRec."Country Name" := BOMLine1Rec."Country Name";
            //                                                     BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                     BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
            //                                                     BLAutoGenNewRec."GMT Qty" := Total;
            //                                                     BLAutoGenNewRec."Include in PO" := true;

            //                                                     if BLERec.Type = BLERec.Type::Pcs then
            //                                                         Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                     else
            //                                                         if BLERec.Type = BLERec.Type::Doz then
            //                                                             Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                     if (ConvFactor <> 0) then
            //                                                         Requirment := Requirment / ConvFactor;

            //                                                     //Requirment := Round(Requirment, 1);

            //                                                     if Requirment < 0 then
            //                                                         Requirment := 1;

            //                                                     Value := Requirment * BLERec.Rate;

            //                                                     BLAutoGenNewRec.Requirment := Requirment;
            //                                                     BLAutoGenNewRec.Value := Value;

            //                                                     BLAutoGenNewRec.Insert();

            //                                                     //Insert into AutoGenPRBOM
            //                                                     InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                     Total := 0;
            //                                                 end;
            //                                             end;

            //                                         until BOMLine4Rec.Next() = 0;
            //                                     end;

            //                                 until BOMPOSelecRec.Next() = 0;
            //                             end;
            //                         until BOMLine1Rec.Next() = 0;
            //                     end;
            //                 end;

            //                 //Color,size and PO
            //                 if BLERec."Color Sensitive" and BLERec."Size Sensitive" and not BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

            //                     //color filter
            //                     BOMLine1Rec.Reset();
            //                     BOMLine1Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine1Rec.SetRange(Type, 1);
            //                     BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine1Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine1Rec.FindSet() then begin

            //                         repeat

            //                             //Size filter
            //                             BOMLine2Rec.Reset();
            //                             BOMLine2Rec.SetRange("No.", BOMRec.No);
            //                             BOMLine2Rec.SetRange(Type, 2);
            //                             BOMLine2Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                             BOMLine2Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                             BOMLine2Rec.SetFilter(Select, '=%1', true);

            //                             if BOMLine2Rec.FindSet() then begin

            //                                 repeat

            //                                     //PO filter
            //                                     BOMPOSelecRec.Reset();
            //                                     BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                                     BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                                     BOMPOSelecRec.SetRange(Selection, true);

            //                                     if BOMPOSelecRec.FindSet() then begin

            //                                         repeat

            //                                             //Item po filter
            //                                             BOMLine4Rec.Reset();
            //                                             BOMLine4Rec.SetRange("No.", BOMRec.No);
            //                                             BOMLine4Rec.SetRange(Type, 4);
            //                                             BOMLine4Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                                             BOMLine4Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                                             BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                             BOMLine4Rec.SetRange(Select, true);

            //                                             if BOMLine4Rec.FindSet() then begin

            //                                                 repeat

            //                                                     //Insert new line
            //                                                     AssortDetailsRec.Reset();
            //                                                     AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                                     AssortDetailsRec.SetRange("lot No.", BOMLine4Rec."lot No.");
            //                                                     AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");

            //                                                     if AssortDetailsRec.FindSet() then begin

            //                                                         repeat

            //                                                             //Find the correct column for the GMT size
            //                                                             AssortDetails1Rec.Reset();
            //                                                             AssortDetails1Rec.SetRange("Style No.", rec."No.");
            //                                                             AssortDetails1Rec.SetRange("lot No.", BOMLine4Rec."lot No.");
            //                                                             AssortDetails1Rec.SetRange("Colour No", '*');

            //                                                             AssortDetails1Rec.FindSet();

            //                                                             FOR Count := 1 TO 64 DO begin
            //                                                                 case Count of
            //                                                                     1:
            //                                                                         if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."1");
            //                                                                             break;
            //                                                                         end;
            //                                                                     2:
            //                                                                         if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."2");
            //                                                                             break;
            //                                                                         end;
            //                                                                     3:
            //                                                                         if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."3");
            //                                                                             break;
            //                                                                         end;
            //                                                                     4:
            //                                                                         if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."4");
            //                                                                             break;
            //                                                                         end;
            //                                                                     5:
            //                                                                         if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."5");
            //                                                                             break;
            //                                                                         end;
            //                                                                     6:
            //                                                                         if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."6");
            //                                                                             break;
            //                                                                         end;
            //                                                                     7:
            //                                                                         if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."7");
            //                                                                             break;
            //                                                                         end;
            //                                                                     8:
            //                                                                         if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."8");
            //                                                                             break;
            //                                                                         end;
            //                                                                     9:
            //                                                                         if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."9");
            //                                                                             break;
            //                                                                         end;
            //                                                                     10:
            //                                                                         if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."10");
            //                                                                             break;
            //                                                                         end;
            //                                                                     11:
            //                                                                         if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."11");
            //                                                                             break;
            //                                                                         end;
            //                                                                     12:
            //                                                                         if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."12");
            //                                                                             break;
            //                                                                         end;
            //                                                                     13:
            //                                                                         if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."13");
            //                                                                             break;
            //                                                                         end;
            //                                                                     14:
            //                                                                         if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."14");
            //                                                                             break;
            //                                                                         end;
            //                                                                     15:
            //                                                                         if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."15");
            //                                                                             break;
            //                                                                         end;
            //                                                                     16:
            //                                                                         if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."16");
            //                                                                             break;
            //                                                                         end;
            //                                                                     17:
            //                                                                         if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."17");
            //                                                                             break;
            //                                                                         end;
            //                                                                     18:
            //                                                                         if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."18");
            //                                                                             break;
            //                                                                         end;
            //                                                                     19:
            //                                                                         if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."19");
            //                                                                             break;
            //                                                                         end;
            //                                                                     20:
            //                                                                         if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."20");
            //                                                                             break;
            //                                                                         end;
            //                                                                     21:
            //                                                                         if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."21");
            //                                                                             break;
            //                                                                         end;
            //                                                                     22:
            //                                                                         if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."22");
            //                                                                             break;
            //                                                                         end;
            //                                                                     23:
            //                                                                         if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."23");
            //                                                                             break;
            //                                                                         end;
            //                                                                     24:
            //                                                                         if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."24");
            //                                                                             break;
            //                                                                         end;
            //                                                                     25:
            //                                                                         if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."25");
            //                                                                             break;
            //                                                                         end;
            //                                                                     26:
            //                                                                         if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."26");
            //                                                                             break;
            //                                                                         end;
            //                                                                     27:
            //                                                                         if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."27");
            //                                                                             break;
            //                                                                         end;
            //                                                                     28:
            //                                                                         if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."28");
            //                                                                             break;
            //                                                                         end;
            //                                                                     29:
            //                                                                         if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."29");
            //                                                                             break;
            //                                                                         end;
            //                                                                     30:
            //                                                                         if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."30");
            //                                                                             break;
            //                                                                         end;
            //                                                                     31:
            //                                                                         if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."31");
            //                                                                             break;
            //                                                                         end;
            //                                                                     32:
            //                                                                         if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."32");
            //                                                                             break;
            //                                                                         end;
            //                                                                     33:
            //                                                                         if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."33");
            //                                                                             break;
            //                                                                         end;
            //                                                                     34:
            //                                                                         if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."34");
            //                                                                             break;
            //                                                                         end;
            //                                                                     35:
            //                                                                         if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."35");
            //                                                                             break;
            //                                                                         end;
            //                                                                     36:
            //                                                                         if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."36");
            //                                                                             break;
            //                                                                         end;
            //                                                                     37:
            //                                                                         if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."37");
            //                                                                             break;
            //                                                                         end;
            //                                                                     38:
            //                                                                         if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."38");
            //                                                                             break;
            //                                                                         end;
            //                                                                     39:
            //                                                                         if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."39");
            //                                                                             break;
            //                                                                         end;
            //                                                                     40:
            //                                                                         if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."40");
            //                                                                             break;
            //                                                                         end;
            //                                                                     41:
            //                                                                         if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."41");
            //                                                                             break;
            //                                                                         end;
            //                                                                     42:
            //                                                                         if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."42");
            //                                                                             break;
            //                                                                         end;
            //                                                                     43:
            //                                                                         if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."43");
            //                                                                             break;
            //                                                                         end;
            //                                                                     44:
            //                                                                         if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."44");
            //                                                                             break;
            //                                                                         end;
            //                                                                     45:
            //                                                                         if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."45");
            //                                                                             break;
            //                                                                         end;
            //                                                                     46:
            //                                                                         if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."46");
            //                                                                             break;
            //                                                                         end;
            //                                                                     47:
            //                                                                         if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."47");
            //                                                                             break;
            //                                                                         end;
            //                                                                     48:
            //                                                                         if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."48");
            //                                                                             break;
            //                                                                         end;
            //                                                                     49:
            //                                                                         if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."49");
            //                                                                             break;
            //                                                                         end;
            //                                                                     50:
            //                                                                         if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."50");
            //                                                                             break;
            //                                                                         end;
            //                                                                     51:
            //                                                                         if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."51");
            //                                                                             break;
            //                                                                         end;
            //                                                                     52:
            //                                                                         if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."52");
            //                                                                             break;
            //                                                                         end;
            //                                                                     53:
            //                                                                         if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."53");
            //                                                                             break;
            //                                                                         end;
            //                                                                     54:
            //                                                                         if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."54");
            //                                                                             break;
            //                                                                         end;
            //                                                                     55:
            //                                                                         if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."55");
            //                                                                             break;
            //                                                                         end;
            //                                                                     56:
            //                                                                         if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."56");
            //                                                                             break;
            //                                                                         end;
            //                                                                     57:
            //                                                                         if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."57");
            //                                                                             break;
            //                                                                         end;
            //                                                                     58:
            //                                                                         if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."58");
            //                                                                             break;
            //                                                                         end;
            //                                                                     59:
            //                                                                         if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."59");
            //                                                                             break;
            //                                                                         end;
            //                                                                     60:
            //                                                                         if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."60");
            //                                                                             break;
            //                                                                         end;
            //                                                                     61:
            //                                                                         if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."61");
            //                                                                             break;
            //                                                                         end;
            //                                                                     62:
            //                                                                         if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."62");
            //                                                                             break;
            //                                                                         end;
            //                                                                     63:
            //                                                                         if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."63");
            //                                                                             break;
            //                                                                         end;
            //                                                                     64:
            //                                                                         if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                             Evaluate(SubTotal, AssortDetailsRec."64");
            //                                                                             break;
            //                                                                         end;
            //                                                                 end;
            //                                                             end;
            //                                                             Total += SubTotal;

            //                                                         until AssortDetailsRec.Next() = 0;
            //                                                     end;

            //                                                     LineNo += 1;
            //                                                     Value := 0;
            //                                                     Requirment := 0;

            //                                                     UOMRec.Reset();
            //                                                     UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                                     UOMRec.FindSet();
            //                                                     ConvFactor := UOMRec."Converion Parameter";

            //                                                     //Check whether already "po raised"items are there, then do not insert
            //                                                     BLAutoGenNewRec.Reset();
            //                                                     BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                                     BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                                     BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                                     BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
            //                                                     //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
            //                                                     BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
            //                                                     BLAutoGenNewRec.SetRange("Country No.", BOMLine1Rec."Country Code");
            //                                                     BLAutoGenNewRec.SetRange(PO, BOMLine4Rec."PO No.");
            //                                                     BLAutoGenNewRec.SetRange("Lot No.", BOMLine4Rec."Lot No.");
            //                                                     BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                                     BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
            //                                                     BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                                     if Not BLAutoGenNewRec.FindSet() then begin
            //                                                         if Total <> 0 then begin

            //                                                             BLAutoGenNewRec.Init();
            //                                                             BLAutoGenNewRec."No." := BOMRec.No;
            //                                                             BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                             BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                             BLAutoGenNewRec."Line No." := LineNo;
            //                                                             BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                             BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                             BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                             BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                             BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                             BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                             BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
            //                                                             BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
            //                                                             BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                             BLAutoGenNewRec.Type := BLERec.Type;
            //                                                             BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                             BLAutoGenNewRec.WST := BLERec.WST;
            //                                                             BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                             BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                             BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                             BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                             BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                             BLAutoGenNewRec."Created User" := UserId;
            //                                                             BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                             BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                             BLAutoGenNewRec."Size Sensitive" := false;
            //                                                             BLAutoGenNewRec."Color Sensitive" := false;
            //                                                             BLAutoGenNewRec."Country Sensitive" := false;
            //                                                             BLAutoGenNewRec."PO Sensitive" := false;
            //                                                             BLAutoGenNewRec.Reconfirm := false;
            //                                                             BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                             BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
            //                                                             BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
            //                                                             BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
            //                                                             BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
            //                                                             BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
            //                                                             BLAutoGenNewRec."Country No." := BOMLine1Rec."Country Code";
            //                                                             BLAutoGenNewRec."Country Name" := BOMLine1Rec."Country Name";
            //                                                             BLAutoGenNewRec.PO := BOMLine4Rec."PO No.";
            //                                                             BLAutoGenNewRec."Lot No." := BOMLine4Rec."lot No.";
            //                                                             BLAutoGenNewRec."GMT Qty" := Total;
            //                                                             BLAutoGenNewRec."Include in PO" := true;

            //                                                             if BLERec.Type = BLERec.Type::Pcs then
            //                                                                 Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                             else
            //                                                                 if BLERec.Type = BLERec.Type::Doz then
            //                                                                     Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                             if (ConvFactor <> 0) then
            //                                                                 Requirment := Requirment / ConvFactor;

            //                                                             //Requirment := Round(Requirment, 1);

            //                                                             if Requirment < 0 then
            //                                                                 Requirment := 1;

            //                                                             Value := Requirment * BLERec.Rate;

            //                                                             BLAutoGenNewRec.Requirment := Requirment;
            //                                                             BLAutoGenNewRec.Value := Value;

            //                                                             BLAutoGenNewRec.Insert();

            //                                                             //Insert into AutoGenPRBOM
            //                                                             InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                             Total := 0;
            //                                                         end;
            //                                                     end;

            //                                                 until BOMLine4Rec.Next() = 0;
            //                                             end;
            //                                         until BOMPOSelecRec.Next() = 0;
            //                                     end;
            //                                 until BOMLine2Rec.Next() = 0;
            //                             end;
            //                         until BOMLine1Rec.Next() = 0;
            //                     end;
            //                 end;

            //                 //Color,country and PO
            //                 if BLERec."Color Sensitive" and not BLERec."Size Sensitive" and BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

            //                     //color filter
            //                     BOMLine1Rec.Reset();
            //                     BOMLine1Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine1Rec.SetRange(Type, 1);
            //                     BOMLine1Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine1Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine1Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine1Rec.FindSet() then begin

            //                         repeat

            //                             //Country filter
            //                             BOMLine3Rec.Reset();
            //                             BOMLine3Rec.SetRange("No.", BOMRec.No);
            //                             BOMLine3Rec.SetRange(Type, 3);
            //                             BOMLine3Rec.SetRange("Item No.", BLERec."Item No.");
            //                             BOMLine3Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                             BOMLine3Rec.SetRange(Select, true);
            //                             BOMLine3Rec.SetFilter(Select, '=%1', true);

            //                             if BOMLine3Rec.FindSet() then begin

            //                                 repeat

            //                                     //PO filter
            //                                     BOMPOSelecRec.Reset();
            //                                     BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                                     BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                                     BOMPOSelecRec.SetRange(Selection, true);

            //                                     if BOMPOSelecRec.FindSet() then begin

            //                                         repeat

            //                                             //Item po filter
            //                                             BOMLine4Rec.Reset();
            //                                             BOMLine4Rec.SetRange("No.", BOMRec.No);
            //                                             BOMLine4Rec.SetRange(Type, 4);
            //                                             BOMLine4Rec.SetRange("Item No.", BOMLine1Rec."Item No.");
            //                                             BOMLine4Rec.SetRange(Placement, BOMLine1Rec."Placement");
            //                                             BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                             BOMLine4Rec.SetRange(Select, true);

            //                                             if BOMLine4Rec.FindSet() then begin

            //                                                 repeat

            //                                                     //Insert new line
            //                                                     AssortDetailsRec.Reset();
            //                                                     AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                                     AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                                     AssortDetailsRec.SetRange("Colour No", BOMLine1Rec."GMT Color No.");
            //                                                     AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                                     if AssortDetailsRec.FindSet() then begin
            //                                                         repeat
            //                                                             if AssortDetailsRec."Colour No" <> '*' then begin
            //                                                                 Total += AssortDetailsRec.Total;
            //                                                             end;
            //                                                         until AssortDetailsRec.Next() = 0;
            //                                                     end;

            //                                                     LineNo += 1;
            //                                                     Value := 0;
            //                                                     Requirment := 0;

            //                                                     UOMRec.Reset();
            //                                                     UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                                     UOMRec.FindSet();
            //                                                     ConvFactor := UOMRec."Converion Parameter";

            //                                                     //Check whether already "po raised"items are there, then do not insert
            //                                                     BLAutoGenNewRec.Reset();
            //                                                     BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                                     BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                                     BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                                     BLAutoGenNewRec.SetRange("GMT Color No.", BOMLine1Rec."GMT Color No.");
            //                                                     //BLAutoGenNewRec.SetRange("Item Color No.", BOMLine1Rec."Item Color No.");
            //                                                     BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine1Rec."GMR Size Name");
            //                                                     BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                                     BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                                     BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                                     BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                                     BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
            //                                                     BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                                     if Not BLAutoGenNewRec.FindSet() then begin
            //                                                         if Total <> 0 then begin

            //                                                             BLAutoGenNewRec.Init();
            //                                                             BLAutoGenNewRec."No." := BOMRec.No;
            //                                                             BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                             BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                             BLAutoGenNewRec."Line No." := LineNo;
            //                                                             BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                             BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                             BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                             BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                             BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                             BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                             BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
            //                                                             BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
            //                                                             BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                             BLAutoGenNewRec.Type := BLERec.Type;
            //                                                             BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                             BLAutoGenNewRec.WST := BLERec.WST;
            //                                                             BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                             BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                             BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                             BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                             BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                             BLAutoGenNewRec."Created User" := UserId;
            //                                                             BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                             BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                             BLAutoGenNewRec."Size Sensitive" := false;
            //                                                             BLAutoGenNewRec."Color Sensitive" := false;
            //                                                             BLAutoGenNewRec."Country Sensitive" := false;
            //                                                             BLAutoGenNewRec."PO Sensitive" := false;
            //                                                             BLAutoGenNewRec.Reconfirm := false;
            //                                                             BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                             BLAutoGenNewRec."GMT Color No." := BOMLine1Rec."GMT Color No.";
            //                                                             BLAutoGenNewRec."GMT Color Name" := BOMLine1Rec."GMT Color Name.";
            //                                                             BLAutoGenNewRec."Item Color No." := BOMLine1Rec."Item Color No.";
            //                                                             BLAutoGenNewRec."Item Color Name" := BOMLine1Rec."Item Color Name.";
            //                                                             BLAutoGenNewRec."GMT Size Name" := BOMLine1Rec."GMR Size Name";
            //                                                             BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
            //                                                             BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
            //                                                             BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                             BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
            //                                                             BLAutoGenNewRec."GMT Qty" := Total;
            //                                                             BLAutoGenNewRec."Include in PO" := true;

            //                                                             if BLERec.Type = BLERec.Type::Pcs then
            //                                                                 Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                             else
            //                                                                 if BLERec.Type = BLERec.Type::Doz then
            //                                                                     Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                             if (ConvFactor <> 0) then
            //                                                                 Requirment := Requirment / ConvFactor;

            //                                                             //Requirment := Round(Requirment, 1);

            //                                                             if Requirment < 0 then
            //                                                                 Requirment := 1;

            //                                                             Value := Requirment * BLERec.Rate;

            //                                                             BLAutoGenNewRec.Requirment := Requirment;
            //                                                             BLAutoGenNewRec.Value := Value;

            //                                                             BLAutoGenNewRec.Insert();

            //                                                             //Insert into AutoGenPRBOM
            //                                                             InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                             Total := 0;
            //                                                         end;
            //                                                     end;

            //                                                 until BOMLine4Rec.Next() = 0;
            //                                             end;
            //                                         until BOMPOSelecRec.Next() = 0;
            //                                     end;

            //                                 until BOMLine3Rec.Next() = 0;
            //                             end;

            //                         until BOMLine1Rec.Next() = 0;
            //                     end;
            //                 end;

            //                 //country and PO
            //                 if not BLERec."Color Sensitive" and not BLERec."Size Sensitive" and BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

            //                     //Country filter
            //                     BOMLine3Rec.Reset();
            //                     BOMLine3Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine3Rec.SetRange(Type, 3);
            //                     BOMLine3Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine3Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine3Rec.SetRange(Select, true);

            //                     if BOMLine3Rec.FindSet() then begin

            //                         repeat

            //                             //PO filter
            //                             BOMPOSelecRec.Reset();
            //                             BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                             BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                             BOMPOSelecRec.SetRange(Selection, true);

            //                             if BOMPOSelecRec.FindSet() then begin

            //                                 repeat

            //                                     //Item po filter
            //                                     BOMLine4Rec.Reset();
            //                                     BOMLine4Rec.SetRange("No.", BOMRec.No);
            //                                     BOMLine4Rec.SetRange(Type, 4);
            //                                     BOMLine4Rec.SetRange("Item No.", BLERec."Item No.");
            //                                     BOMLine4Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                                     BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                     BOMLine4Rec.SetRange(Select, true);

            //                                     if BOMLine4Rec.FindSet() then begin

            //                                         repeat

            //                                             //Insert new line
            //                                             AssortDetailsRec.Reset();
            //                                             AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                             AssortDetailsRec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                             AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                             if AssortDetailsRec.FindSet() then begin
            //                                                 repeat
            //                                                     if AssortDetailsRec."Colour No" <> '*' then begin
            //                                                         Total += AssortDetailsRec.Total;
            //                                                     end;
            //                                                 until AssortDetailsRec.Next() = 0;
            //                                             end;

            //                                             LineNo += 1;
            //                                             Value := 0;
            //                                             Requirment := 0;

            //                                             UOMRec.Reset();
            //                                             UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                             UOMRec.FindSet();
            //                                             ConvFactor := UOMRec."Converion Parameter";

            //                                             //Check whether already "po raised"items are there, then do not insert
            //                                             BLAutoGenNewRec.Reset();
            //                                             BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                             BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                             BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                             BLAutoGenNewRec.SetRange("Item Color No.", BOMLine3Rec."Item Color No.");
            //                                             BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine3Rec."GMR Size Name");
            //                                             BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                             BLAutoGenNewRec.SetRange(PO, BOMPOSelecRec."PO No.");
            //                                             BLAutoGenNewRec.SetRange("Lot No.", BOMPOSelecRec."Lot No.");
            //                                             BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                             BLAutoGenNewRec.SetRange("Dimension No.", BLERec."Dimension No.");
            //                                             BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                             if Not BLAutoGenNewRec.FindSet() then begin
            //                                                 if Total <> 0 then begin

            //                                                     BLAutoGenNewRec.Init();
            //                                                     BLAutoGenNewRec."No." := BOMRec.No;
            //                                                     BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                     BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                     BLAutoGenNewRec."Line No." := LineNo;
            //                                                     BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                     BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                     BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                     BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                     BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                     BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                     BLAutoGenNewRec."Dimension No." := BLERec."Dimension No.";
            //                                                     BLAutoGenNewRec."Dimension Name." := BLERec."Dimension Name.";
            //                                                     BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                     BLAutoGenNewRec.Type := BLERec.Type;
            //                                                     BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                     BLAutoGenNewRec.WST := BLERec.WST;
            //                                                     BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                     BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                     BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                     BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                     BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                     BLAutoGenNewRec."Created User" := UserId;
            //                                                     BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                     BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                     BLAutoGenNewRec."Size Sensitive" := false;
            //                                                     BLAutoGenNewRec."Color Sensitive" := false;
            //                                                     BLAutoGenNewRec."Country Sensitive" := false;
            //                                                     BLAutoGenNewRec."PO Sensitive" := false;
            //                                                     BLAutoGenNewRec.Reconfirm := false;
            //                                                     BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                     BLAutoGenNewRec."GMT Color No." := BOMLine3Rec."GMT Color No.";
            //                                                     BLAutoGenNewRec."GMT Color Name" := BOMLine3Rec."GMT Color Name.";
            //                                                     BLAutoGenNewRec."Item Color No." := BOMLine3Rec."Item Color No.";
            //                                                     BLAutoGenNewRec."Item Color Name" := BOMLine3Rec."Item Color Name.";
            //                                                     BLAutoGenNewRec."GMT Size Name" := BOMLine3Rec."GMR Size Name";
            //                                                     BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
            //                                                     BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
            //                                                     BLAutoGenNewRec.PO := BOMPOSelecRec."PO No.";
            //                                                     BLAutoGenNewRec."Lot No." := BOMPOSelecRec."lot No.";
            //                                                     BLAutoGenNewRec."GMT Qty" := Total;
            //                                                     BLAutoGenNewRec."Include in PO" := true;

            //                                                     if BLERec.Type = BLERec.Type::Pcs then
            //                                                         Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                     else
            //                                                         if BLERec.Type = BLERec.Type::Doz then
            //                                                             Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                     if (ConvFactor <> 0) then
            //                                                         Requirment := Requirment / ConvFactor;

            //                                                     //Requirment := Round(Requirment, 1);

            //                                                     if Requirment < 0 then
            //                                                         Requirment := 1;

            //                                                     Value := Requirment * BLERec.Rate;

            //                                                     BLAutoGenNewRec.Requirment := Requirment;
            //                                                     BLAutoGenNewRec.Value := Value;

            //                                                     BLAutoGenNewRec.Insert();

            //                                                     //Insert into AutoGenPRBOM
            //                                                     InsertAutoGenProdBOM(BLERec."Item No.", LineNo);

            //                                                     Total := 0;
            //                                                 end;
            //                                             end;

            //                                         until BOMLine4Rec.Next() = 0;
            //                                     end;
            //                                 until BOMPOSelecRec.Next() = 0;
            //                             end;

            //                         until BOMLine3Rec.Next() = 0;
            //                     end;


            //                 end;

            //                 //Size, Country and PO
            //                 if not BLERec."Color Sensitive" and BLERec."Size Sensitive" and BLERec."Country Sensitive" and BLERec."PO Sensitive" then begin

            //                     //Size filter
            //                     BOMLine2Rec.Reset();
            //                     BOMLine2Rec.SetRange("No.", BOMRec.No);
            //                     BOMLine2Rec.SetRange(Type, 2);
            //                     BOMLine2Rec.SetRange("Item No.", BLERec."Item No.");
            //                     BOMLine2Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                     BOMLine2Rec.SetFilter(Select, '=%1', true);

            //                     if BOMLine2Rec.FindSet() then begin

            //                         repeat
            //                             //Country filter
            //                             BOMLine3Rec.Reset();
            //                             BOMLine3Rec.SetRange("No.", BOMRec.No);
            //                             BOMLine3Rec.SetRange(Type, 3);
            //                             BOMLine3Rec.SetRange("Item No.", BLERec."Item No.");
            //                             BOMLine3Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                             BOMLine3Rec.SetRange(Select, true);

            //                             if BOMLine3Rec.FindSet() then begin

            //                                 repeat

            //                                     //PO filter
            //                                     BOMPOSelecRec.Reset();
            //                                     BOMPOSelecRec.SetRange("BOM No.", BOMRec.No);
            //                                     BOMPOSelecRec.SetRange("Lot No.", rec."Lot No.");
            //                                     BOMPOSelecRec.SetRange(Selection, true);

            //                                     if BOMPOSelecRec.FindSet() then begin

            //                                         repeat

            //                                             //Item po filter
            //                                             BOMLine4Rec.Reset();
            //                                             BOMLine4Rec.SetRange("No.", BOMRec.No);
            //                                             BOMLine4Rec.SetRange(Type, 4);
            //                                             BOMLine4Rec.SetRange("Item No.", BLERec."Item No.");
            //                                             BOMLine4Rec.SetRange(Placement, BLERec."Placement of GMT");
            //                                             BOMLine4Rec.SetRange("lot No.", BOMPOSelecRec."lot No.");
            //                                             BOMLine4Rec.SetRange(Select, true);

            //                                             if BOMLine4Rec.FindSet() then begin

            //                                                 repeat

            //                                                     //Insert new line
            //                                                     AssortDetailsRec.Reset();
            //                                                     AssortDetailsRec.SetRange("Style No.", rec."No.");
            //                                                     AssortDetailsRec.SetRange("lot No.", BOMLine4Rec."lot No.");
            //                                                     AssortDetailsRec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                                     if AssortDetailsRec.FindSet() then begin

            //                                                         repeat

            //                                                             if AssortDetailsRec."Colour No" <> '*' then begin

            //                                                                 //Find the correct column for the GMT size
            //                                                                 AssortDetails1Rec.Reset();
            //                                                                 AssortDetails1Rec.SetRange("Style No.", rec."No.");
            //                                                                 AssortDetails1Rec.SetRange("lot No.", BOMLine4Rec."lot No.");
            //                                                                 AssortDetails1Rec.SetRange("Colour No", '*');
            //                                                                 AssortDetails1Rec.SetRange("Country Code", BOMLine3Rec."Country Code");

            //                                                                 AssortDetails1Rec.FindSet();

            //                                                                 FOR Count := 1 TO 64 DO begin

            //                                                                     case Count of
            //                                                                         1:
            //                                                                             if AssortDetails1Rec."1" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."1");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         2:
            //                                                                             if AssortDetails1Rec."2" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."2");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         3:
            //                                                                             if AssortDetails1Rec."3" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."3");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         4:
            //                                                                             if AssortDetails1Rec."4" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."4");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         5:
            //                                                                             if AssortDetails1Rec."5" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."5");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         6:
            //                                                                             if AssortDetails1Rec."6" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."6");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         7:
            //                                                                             if AssortDetails1Rec."7" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."7");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         8:
            //                                                                             if AssortDetails1Rec."8" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."8");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         9:
            //                                                                             if AssortDetails1Rec."9" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."9");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         10:
            //                                                                             if AssortDetails1Rec."10" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."10");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         11:
            //                                                                             if AssortDetails1Rec."11" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."11");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         12:
            //                                                                             if AssortDetails1Rec."12" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."12");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         13:
            //                                                                             if AssortDetails1Rec."13" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."13");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         14:
            //                                                                             if AssortDetails1Rec."14" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."14");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         15:
            //                                                                             if AssortDetails1Rec."15" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."15");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         16:
            //                                                                             if AssortDetails1Rec."16" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."16");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         17:
            //                                                                             if AssortDetails1Rec."17" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."17");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         18:
            //                                                                             if AssortDetails1Rec."18" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."18");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         19:
            //                                                                             if AssortDetails1Rec."19" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."19");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         20:
            //                                                                             if AssortDetails1Rec."20" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."20");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         21:
            //                                                                             if AssortDetails1Rec."21" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."21");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         22:
            //                                                                             if AssortDetails1Rec."22" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."22");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         23:
            //                                                                             if AssortDetails1Rec."23" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."23");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         24:
            //                                                                             if AssortDetails1Rec."24" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."24");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         25:
            //                                                                             if AssortDetails1Rec."25" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."25");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         26:
            //                                                                             if AssortDetails1Rec."26" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."26");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         27:
            //                                                                             if AssortDetails1Rec."27" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."27");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         28:
            //                                                                             if AssortDetails1Rec."28" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."28");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         29:
            //                                                                             if AssortDetails1Rec."29" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."29");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         30:
            //                                                                             if AssortDetails1Rec."30" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."30");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         31:
            //                                                                             if AssortDetails1Rec."31" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."31");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         32:
            //                                                                             if AssortDetails1Rec."32" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."32");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         33:
            //                                                                             if AssortDetails1Rec."33" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."33");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         34:
            //                                                                             if AssortDetails1Rec."34" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."34");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         35:
            //                                                                             if AssortDetails1Rec."35" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."35");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         36:
            //                                                                             if AssortDetails1Rec."36" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."36");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         37:
            //                                                                             if AssortDetails1Rec."37" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."37");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         38:
            //                                                                             if AssortDetails1Rec."38" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."38");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         39:
            //                                                                             if AssortDetails1Rec."39" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."39");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         40:
            //                                                                             if AssortDetails1Rec."40" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."40");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         41:
            //                                                                             if AssortDetails1Rec."41" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."41");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         42:
            //                                                                             if AssortDetails1Rec."42" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."42");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         43:
            //                                                                             if AssortDetails1Rec."43" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."43");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         44:
            //                                                                             if AssortDetails1Rec."44" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."44");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         45:
            //                                                                             if AssortDetails1Rec."45" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."45");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         46:
            //                                                                             if AssortDetails1Rec."46" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."46");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         47:
            //                                                                             if AssortDetails1Rec."47" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."47");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         48:
            //                                                                             if AssortDetails1Rec."48" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."48");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         49:
            //                                                                             if AssortDetails1Rec."49" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."49");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         50:
            //                                                                             if AssortDetails1Rec."50" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."50");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         51:
            //                                                                             if AssortDetails1Rec."51" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."51");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         52:
            //                                                                             if AssortDetails1Rec."52" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."52");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         53:
            //                                                                             if AssortDetails1Rec."53" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."53");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         54:
            //                                                                             if AssortDetails1Rec."54" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."54");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         55:
            //                                                                             if AssortDetails1Rec."55" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."55");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         56:
            //                                                                             if AssortDetails1Rec."56" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."56");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         57:
            //                                                                             if AssortDetails1Rec."57" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."57");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         58:
            //                                                                             if AssortDetails1Rec."58" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."58");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         59:
            //                                                                             if AssortDetails1Rec."59" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."59");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         60:
            //                                                                             if AssortDetails1Rec."60" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."60");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         61:
            //                                                                             if AssortDetails1Rec."61" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."61");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         62:
            //                                                                             if AssortDetails1Rec."62" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."62");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         63:
            //                                                                             if AssortDetails1Rec."63" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."63");
            //                                                                                 break;
            //                                                                             end;
            //                                                                         64:
            //                                                                             if AssortDetails1Rec."64" = BOMLine2Rec."GMR Size Name" then begin
            //                                                                                 Evaluate(subTotal, AssortDetailsRec."64");
            //                                                                                 break;
            //                                                                             end;
            //                                                                     end;

            //                                                                     total += SubTotal;
            //                                                                     SubTotal := 0;

            //                                                                 end;

            //                                                             end;

            //                                                         until AssortDetailsRec.Next() = 0;



            //                                                         LineNo += 1;
            //                                                         Value := 0;
            //                                                         Requirment := 0;

            //                                                         UOMRec.Reset();
            //                                                         UOMRec.SetRange(Code, BLERec."Unit N0.");
            //                                                         UOMRec.FindSet();
            //                                                         ConvFactor := UOMRec."Converion Parameter";

            //                                                         //Check whether already "po raised"items are there, then do not insert
            //                                                         BLAutoGenNewRec.Reset();
            //                                                         BLAutoGenNewRec.SetRange("No.", BOMRec.No);
            //                                                         BLAutoGenNewRec.SetRange("Item No.", BLERec."Item No.");
            //                                                         BLAutoGenNewRec.SetRange("Placement of GMT", BLERec."Placement of GMT");
            //                                                         BLAutoGenNewRec.SetRange("Item Color No.", BOMLine2Rec."Item Color No.");
            //                                                         BLAutoGenNewRec.SetRange("GMT Size Name", BOMLine2Rec."GMR Size Name");
            //                                                         BLAutoGenNewRec.SetRange("Country No.", BOMLine3Rec."Country Code");
            //                                                         BLAutoGenNewRec.SetRange(PO, BOMLine4Rec."PO No.");
            //                                                         BLAutoGenNewRec.SetRange("Lot No.", BOMLine4Rec."Lot No.");
            //                                                         BLAutoGenNewRec.SetRange("Article No.", BLERec."Article No.");
            //                                                         BLAutoGenNewRec.SetRange("Dimension No.", BOMLine2Rec."Dimension No.");
            //                                                         BLAutoGenNewRec.SetRange("Supplier No.", BLERec."Supplier No.");

            //                                                         if Not BLAutoGenNewRec.FindSet() then begin
            //                                                             if Total <> 0 then begin

            //                                                                 BLAutoGenNewRec.Init();
            //                                                                 BLAutoGenNewRec."No." := BOMRec.No;
            //                                                                 BLAutoGenNewRec."Item No." := BLERec."Item No.";
            //                                                                 BLAutoGenNewRec."Item Name" := BLERec."Item Name";
            //                                                                 BLAutoGenNewRec."Line No." := LineNo;
            //                                                                 BLAutoGenNewRec."Main Category No." := BLERec."Main Category No.";
            //                                                                 BLAutoGenNewRec."Main Category Name" := BLERec."Main Category Name";
            //                                                                 BLAutoGenNewRec."Sub Category No." := SubCat;
            //                                                                 BLAutoGenNewRec."Sub Category Name" := SubCatDesc;
            //                                                                 BLAutoGenNewRec."Article No." := BLERec."Article No.";
            //                                                                 BLAutoGenNewRec."Article Name." := BLERec."Article Name.";
            //                                                                 BLAutoGenNewRec."Dimension No." := BOMLine2Rec."Dimension No.";
            //                                                                 BLAutoGenNewRec."Dimension Name." := BOMLine2Rec."Dimension Name";
            //                                                                 BLAutoGenNewRec."Unit N0." := BLERec."Unit N0.";
            //                                                                 BLAutoGenNewRec.Type := BLERec.Type;
            //                                                                 BLAutoGenNewRec.Consumption := BLERec.Consumption;
            //                                                                 BLAutoGenNewRec.WST := BLERec.WST;
            //                                                                 BLAutoGenNewRec.Rate := BLERec.Rate;
            //                                                                 BLAutoGenNewRec."Supplier No." := BLERec."Supplier No.";
            //                                                                 BLAutoGenNewRec."Supplier Name." := BLERec."Supplier Name.";
            //                                                                 BLAutoGenNewRec.AjstReq := BLERec.AjstReq;
            //                                                                 BLAutoGenNewRec.Qty := BLERec.Qty;
            //                                                                 BLAutoGenNewRec."Created User" := UserId;
            //                                                                 BLAutoGenNewRec."Created Date" := WorkDate();
            //                                                                 BLAutoGenNewRec."Stock Bal" := BLERec."Stock Bal";
            //                                                                 BLAutoGenNewRec."Size Sensitive" := false;
            //                                                                 BLAutoGenNewRec."Color Sensitive" := false;
            //                                                                 BLAutoGenNewRec."Country Sensitive" := false;
            //                                                                 BLAutoGenNewRec."PO Sensitive" := false;
            //                                                                 BLAutoGenNewRec.Reconfirm := false;
            //                                                                 BLAutoGenNewRec."Placement of GMT" := BLERec."Placement of GMT";
            //                                                                 BLAutoGenNewRec."GMT Color No." := BOMLine2Rec."GMT Color No.";
            //                                                                 BLAutoGenNewRec."GMT Color Name" := BOMLine2Rec."GMT Color Name.";
            //                                                                 BLAutoGenNewRec."Item Color No." := BOMLine2Rec."Item Color No.";
            //                                                                 BLAutoGenNewRec."Item Color Name" := BOMLine2Rec."Item Color Name.";
            //                                                                 BLAutoGenNewRec."GMT Size Name" := BOMLine2Rec."GMR Size Name";
            //                                                                 BLAutoGenNewRec."Country No." := BOMLine3Rec."Country Code";
            //                                                                 BLAutoGenNewRec."Country Name" := BOMLine3Rec."Country Name";
            //                                                                 BLAutoGenNewRec.PO := BOMLine4Rec."PO No.";
            //                                                                 BLAutoGenNewRec."Lot No." := BOMLine4Rec."Lot No.";
            //                                                                 BLAutoGenNewRec."GMT Qty" := Total;
            //                                                                 BLAutoGenNewRec."Include in PO" := true;

            //                                                                 if BLERec.Type = BLERec.Type::Pcs then
            //                                                                     Requirment := (BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100
            //                                                                 else
            //                                                                     if BLERec.Type = BLERec.Type::Doz then
            //                                                                         Requirment := ((BLERec.Consumption * Total) + (BLERec.Consumption * Total) * BLERec.WST / 100) / 12;

            //                                                                 if (ConvFactor <> 0) then
            //                                                                     Requirment := Requirment / ConvFactor;

            //                                                                 //Requirment := Round(Requirment, 1);

            //                                                                 if Requirment < 0 then
            //                                                                     Requirment := 1;

            //                                                                 Value := Requirment * BLERec.Rate;

            //                                                                 BLAutoGenNewRec.Requirment := Requirment;
            //                                                                 BLAutoGenNewRec.Value := Value;

            //                                                                 BLAutoGenNewRec.Insert();

            //                                                                 //Insert into AutoGenPRBOM
            //                                                                 InsertAutoGenProdBOM(BLERec."Item No.", LineNo);
            //                                                                 Total := 0;
            //                                                             end;
            //                                                         end;
            //                                                     end;

            //                                                 until BOMLine4Rec.Next() = 0;

            //                                             end;

            //                                         until BOMPOSelecRec.Next() = 0;

            //                                     end;

            //                                 until BOMLine3Rec.Next() = 0;

            //                             end;

            //                         until BOMLine2Rec.Next() = 0;

            //                     end;

            //                 end;
            //             //end;

            //             until BLERec.Next() = 0;
            //         end;


            //         //////////////////////////////////////Write to MRP
            //         BOMLineAutoGenRec.Reset();
            //         BOMLineAutoGenRec.SetRange("No.", BOMRec.No);
            //         BOMLineAutoGenRec.SetFilter("Include in PO", '=%1', true);
            //         BOMLineAutoGenRec.SetFilter("Included in PO", '=%1', false);
            //         if not BOMLineAutoGenRec.FindSet() then
            //             Error('Records not selected for processing.');


            //         //Delete Old Sales order line
            //         AssortDetailRec.Reset();
            //         AssortDetailRec.SetRange("Style No.", rec."No.");
            //         AssortDetailRec.SetRange("lot No.", rec."Lot No.");
            //         AssortDetailRec.SetFilter("Colour Name", '<>%1', '*');
            //         if AssortDetailRec.FindSet() then begin

            //             if AssortDetailRec.SalesOrderNo <> '' then begin
            //                 SalesLineRec1.Reset();
            //                 SalesLineRec1.SetRange("Document No.", AssortDetailRec.SalesOrderNo);
            //                 SalesLineRec1.SetFilter("Document Type", '=%1', SalesLineRec1."Document Type"::Order);
            //                 if SalesLineRec1.Findset() then
            //                     SalesLineRec1.DeleteAll();
            //             end;
            //         end;


            //         AssortDetailRec.Reset();
            //         AssortDetailRec.SetRange("Style No.", rec."No.");
            //         AssortDetailRec.SetRange("lot No.", rec."Lot No.");
            //         AssortDetailRec.SetFilter("Colour Name", '<>%1', '*');

            //         if AssortDetailRec.FindSet() then begin
            //             repeat
            //                 StatusGB := 0;
            //                 FOR Count := 1 TO 64 DO begin
            //                     Qty := 0;

            //                     case Count of
            //                         1:
            //                             if (AssortDetailRec."1" <> '') and (AssortDetailRec."1" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."1";
            //                                     Evaluate(Qty, AssortDetailRec."1");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."1");
            //                                 end;

            //                                 break;
            //                             end;
            //                         2:
            //                             if (AssortDetailRec."2" <> '') and (AssortDetailRec."2" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."2";
            //                                     Evaluate(Qty, AssortDetailRec."2");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."2");
            //                                 end;

            //                                 break;
            //                             end;
            //                         3:
            //                             if (AssortDetailRec."3" <> '') and (AssortDetailRec."3" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."3";
            //                                     Evaluate(Qty, AssortDetailRec."3");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."3");
            //                                 end;

            //                                 break;
            //                             end;
            //                         4:
            //                             if (AssortDetailRec."4" <> '') and (AssortDetailRec."4" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."4";
            //                                     Evaluate(Qty, AssortDetailRec."4");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."4");
            //                                 end;

            //                                 break;
            //                             end;
            //                         5:
            //                             if (AssortDetailRec."5" <> '') and (AssortDetailRec."5" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."5";
            //                                     Evaluate(Qty, AssortDetailRec."5");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."5");
            //                                 end;

            //                                 break;
            //                             end;
            //                         6:
            //                             if (AssortDetailRec."6" <> '') and (AssortDetailRec."6" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."6";
            //                                     Evaluate(Qty, AssortDetailRec."6");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."6");
            //                                 end;

            //                                 break;
            //                             end;
            //                         7:
            //                             if (AssortDetailRec."7" <> '') and (AssortDetailRec."7" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."7";
            //                                     Evaluate(Qty, AssortDetailRec."7");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."7");
            //                                 end;

            //                                 break;
            //                             end;
            //                         8:
            //                             if (AssortDetailRec."8" <> '') and (AssortDetailRec."8" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."8";
            //                                     Evaluate(Qty, AssortDetailRec."8");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."8");
            //                                 end;

            //                                 break;
            //                             end;
            //                         9:
            //                             if (AssortDetailRec."9" <> '') and (AssortDetailRec."9" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."9";
            //                                     Evaluate(Qty, AssortDetailRec."9");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."9");
            //                                 end;

            //                                 break;
            //                             end;
            //                         10:
            //                             if (AssortDetailRec."10" <> '') and (AssortDetailRec."10" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."10";
            //                                     Evaluate(Qty, AssortDetailRec."10");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."10");
            //                                 end;

            //                                 break;
            //                             end;
            //                         11:
            //                             if (AssortDetailRec."11" <> '') and (AssortDetailRec."11" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."11";
            //                                     Evaluate(Qty, AssortDetailRec."11");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."11");
            //                                 end;

            //                                 break;
            //                             end;
            //                         12:
            //                             if (AssortDetailRec."12" <> '') and (AssortDetailRec."12" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."12";
            //                                     Evaluate(Qty, AssortDetailRec."12");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."12");
            //                                 end;

            //                                 break;
            //                             end;
            //                         13:
            //                             if (AssortDetailRec."13" <> '') and (AssortDetailRec."13" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."13";
            //                                     Evaluate(Qty, AssortDetailRec."13");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."13");
            //                                 end;

            //                                 break;
            //                             end;
            //                         14:
            //                             if (AssortDetailRec."14" <> '') and (AssortDetailRec."14" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."14";
            //                                     Evaluate(Qty, AssortDetailRec."14");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."14");
            //                                 end;

            //                                 break;
            //                             end;
            //                         15:
            //                             if (AssortDetailRec."15" <> '') and (AssortDetailRec."15" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."15";
            //                                     Evaluate(Qty, AssortDetailRec."15");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."15");
            //                                 end;

            //                                 break;
            //                             end;
            //                         16:
            //                             if (AssortDetailRec."16" <> '') and (AssortDetailRec."16" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."16";
            //                                     Evaluate(Qty, AssortDetailRec."16");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."16");
            //                                 end;

            //                                 break;
            //                             end;
            //                         17:
            //                             if (AssortDetailRec."17" <> '') and (AssortDetailRec."17" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."17";
            //                                     Evaluate(Qty, AssortDetailRec."17");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."17");
            //                                 end;

            //                                 break;
            //                             end;
            //                         18:
            //                             if (AssortDetailRec."18" <> '') and (AssortDetailRec."18" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."18";
            //                                     Evaluate(Qty, AssortDetailRec."18");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."18");
            //                                 end;

            //                                 break;
            //                             end;
            //                         19:
            //                             if (AssortDetailRec."19" <> '') and (AssortDetailRec."19" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetailRec."19";
            //                                     Evaluate(Qty, AssortDetailRec."19");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."19");
            //                                 end;

            //                                 break;
            //                             end;
            //                         20:
            //                             if (AssortDetailRec."20" <> '') and (AssortDetailRec."20" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."20";
            //                                     Evaluate(Qty, AssortDetailRec."20");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."20");
            //                                 end;

            //                                 break;
            //                             end;
            //                         21:
            //                             if (AssortDetailRec."21" <> '') and (AssortDetailRec."21" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."21";
            //                                     Evaluate(Qty, AssortDetailRec."21");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."21");
            //                                 end;

            //                                 break;
            //                             end;
            //                         22:
            //                             if (AssortDetailRec."22" <> '') and (AssortDetailRec."22" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."22";
            //                                     Evaluate(Qty, AssortDetailRec."22");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."22");
            //                                 end;

            //                                 break;
            //                             end;
            //                         23:
            //                             if (AssortDetailRec."23" <> '') and (AssortDetailRec."23" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."23";
            //                                     Evaluate(Qty, AssortDetailRec."23");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."23");
            //                                 end;

            //                                 break;
            //                             end;
            //                         24:
            //                             if (AssortDetailRec."24" <> '') and (AssortDetailRec."24" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."24";
            //                                     Evaluate(Qty, AssortDetailRec."24");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."24");
            //                                 end;

            //                                 break;
            //                             end;
            //                         25:
            //                             if (AssortDetailRec."25" <> '') and (AssortDetailRec."25" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."25";
            //                                     Evaluate(Qty, AssortDetailRec."25");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."25");
            //                                 end;

            //                                 break;
            //                             end;
            //                         26:
            //                             if (AssortDetailRec."26" <> '') and (AssortDetailRec."26" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."26";
            //                                     Evaluate(Qty, AssortDetailRec."26");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."26");
            //                                 end;

            //                                 break;
            //                             end;
            //                         27:
            //                             if (AssortDetailRec."27" <> '') and (AssortDetailRec."27" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."27";
            //                                     Evaluate(Qty, AssortDetailRec."27");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."27");
            //                                 end;

            //                                 break;
            //                             end;
            //                         28:
            //                             if (AssortDetailRec."28" <> '') and (AssortDetailRec."28" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."28";
            //                                     Evaluate(Qty, AssortDetailRec."28");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."28");
            //                                 end;

            //                                 break;
            //                             end;
            //                         29:
            //                             if (AssortDetailRec."29" <> '') and (AssortDetailRec."29" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."29";
            //                                     Evaluate(Qty, AssortDetailRec."29");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."29");
            //                                 end;

            //                                 break;
            //                             end;
            //                         30:
            //                             if (AssortDetailRec."30" <> '') and (AssortDetailRec."30" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."30";
            //                                     Evaluate(Qty, AssortDetailRec."30");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."30");
            //                                 end;

            //                                 break;
            //                             end;
            //                         31:
            //                             if (AssortDetailRec."31" <> '') and (AssortDetailRec."31" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."31";
            //                                     Evaluate(Qty, AssortDetailRec."31");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."31");
            //                                 end;

            //                                 break;
            //                             end;
            //                         32:
            //                             if (AssortDetailRec."32" <> '') and (AssortDetailRec."32" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."32";
            //                                     Evaluate(Qty, AssortDetailRec."32");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."32");
            //                                 end;

            //                                 break;
            //                             end;
            //                         33:
            //                             if (AssortDetailRec."33" <> '') and (AssortDetailRec."33" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."33";
            //                                     Evaluate(Qty, AssortDetailRec."33");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."33");
            //                                 end;

            //                                 break;
            //                             end;
            //                         34:
            //                             if (AssortDetailRec."34" <> '') and (AssortDetailRec."34" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."34";
            //                                     Evaluate(Qty, AssortDetailRec."34");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."34");
            //                                 end;

            //                                 break;
            //                             end;
            //                         35:
            //                             if (AssortDetailRec."35" <> '') and (AssortDetailRec."35" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."35";
            //                                     Evaluate(Qty, AssortDetailRec."35");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."35");
            //                                 end;

            //                                 break;
            //                             end;
            //                         36:
            //                             if (AssortDetailRec."36" <> '') and (AssortDetailRec."36" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."36";
            //                                     Evaluate(Qty, AssortDetailRec."36");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."36");
            //                                 end;

            //                                 break;
            //                             end;
            //                         37:
            //                             if (AssortDetailRec."37" <> '') and (AssortDetailRec."37" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."37";
            //                                     Evaluate(Qty, AssortDetailRec."37");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."37");
            //                                 end;

            //                                 break;
            //                             end;
            //                         38:
            //                             if (AssortDetailRec."38" <> '') and (AssortDetailRec."38" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."38";
            //                                     Evaluate(Qty, AssortDetailRec."38");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."38");
            //                                 end;

            //                                 break;
            //                             end;
            //                         39:
            //                             if (AssortDetailRec."39" <> '') and (AssortDetailRec."39" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."39";
            //                                     Evaluate(Qty, AssortDetailRec."39");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."39");
            //                                 end;

            //                                 break;
            //                             end;
            //                         40:
            //                             if (AssortDetailRec."40" <> '') and (AssortDetailRec."40" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."40";
            //                                     Evaluate(Qty, AssortDetailRec."40");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."40");
            //                                 end;

            //                                 break;
            //                             end;
            //                         41:
            //                             if (AssortDetailRec."41" <> '') and (AssortDetailRec."41" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."41";
            //                                     Evaluate(Qty, AssortDetailRec."41");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."41");
            //                                 end;

            //                                 break;
            //                             end;
            //                         42:
            //                             if (AssortDetailRec."42" <> '') and (AssortDetailRec."42" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."42";
            //                                     Evaluate(Qty, AssortDetailRec."42");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."42");
            //                                 end;

            //                                 break;
            //                             end;
            //                         43:
            //                             if (AssortDetailRec."43" <> '') and (AssortDetailRec."43" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."43";
            //                                     Evaluate(Qty, AssortDetailRec."43");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."43");
            //                                 end;

            //                                 break;
            //                             end;
            //                         44:
            //                             if (AssortDetailRec."44" <> '') and (AssortDetailRec."44" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."44";
            //                                     Evaluate(Qty, AssortDetailRec."44");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."44");
            //                                 end;

            //                                 break;
            //                             end;
            //                         45:
            //                             if (AssortDetailRec."45" <> '') and (AssortDetailRec."45" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."45";
            //                                     Evaluate(Qty, AssortDetailRec."45");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."45");
            //                                 end;

            //                                 break;
            //                             end;
            //                         46:
            //                             if (AssortDetailRec."46" <> '') and (AssortDetailRec."46" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."46";
            //                                     Evaluate(Qty, AssortDetailRec."46");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."46");
            //                                 end;

            //                                 break;
            //                             end;
            //                         47:
            //                             if (AssortDetailRec."47" <> '') and (AssortDetailRec."47" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."47";
            //                                     Evaluate(Qty, AssortDetailRec."47");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."47");
            //                                 end;

            //                                 break;
            //                             end;
            //                         48:
            //                             if (AssortDetailRec."48" <> '') and (AssortDetailRec."48" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."48";
            //                                     Evaluate(Qty, AssortDetailRec."48");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."48");
            //                                 end;

            //                                 break;
            //                             end;
            //                         49:
            //                             if (AssortDetailRec."49" <> '') and (AssortDetailRec."49" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."49";
            //                                     Evaluate(Qty, AssortDetailRec."49");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."49");
            //                                 end;

            //                                 break;
            //                             end;
            //                         50:
            //                             if (AssortDetailRec."50" <> '') and (AssortDetailRec."50" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."50";
            //                                     Evaluate(Qty, AssortDetailRec."50");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."50");
            //                                 end;

            //                                 break;
            //                             end;
            //                         51:
            //                             if (AssortDetailRec."51" <> '') and (AssortDetailRec."51" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."51";
            //                                     Evaluate(Qty, AssortDetailRec."51");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."51");
            //                                 end;

            //                                 break;
            //                             end;
            //                         52:
            //                             if (AssortDetailRec."52" <> '') and (AssortDetailRec."52" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."52";
            //                                     Evaluate(Qty, AssortDetailRec."52");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."52");
            //                                 end;

            //                                 break;
            //                             end;
            //                         53:
            //                             if (AssortDetailRec."53" <> '') and (AssortDetailRec."53" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."53";
            //                                     Evaluate(Qty, AssortDetailRec."53");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."53");
            //                                 end;

            //                                 break;
            //                             end;
            //                         54:
            //                             if (AssortDetailRec."54" <> '') and (AssortDetailRec."54" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."54";
            //                                     Evaluate(Qty, AssortDetailRec."54");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."54");
            //                                 end;

            //                                 break;
            //                             end;
            //                         55:
            //                             if (AssortDetailRec."55" <> '') and (AssortDetailRec."55" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."55";
            //                                     Evaluate(Qty, AssortDetailRec."55");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."55");
            //                                 end;

            //                                 break;
            //                             end;
            //                         56:
            //                             if (AssortDetailRec."56" <> '') and (AssortDetailRec."56" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."56";
            //                                     Evaluate(Qty, AssortDetailRec."56");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."56");
            //                                 end;

            //                                 break;
            //                             end;
            //                         57:
            //                             if (AssortDetailRec."57" <> '') and (AssortDetailRec."57" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."57";
            //                                     Evaluate(Qty, AssortDetailRec."57");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."57");
            //                                 end;

            //                                 break;
            //                             end;
            //                         58:
            //                             if (AssortDetailRec."58" <> '') and (AssortDetailRec."58" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."58";
            //                                     Evaluate(Qty, AssortDetailRec."58");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."58");
            //                                 end;

            //                                 break;
            //                             end;
            //                         59:
            //                             if (AssortDetailRec."59" <> '') and (AssortDetailRec."59" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."59";
            //                                     Evaluate(Qty, AssortDetailRec."59");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."59");
            //                                 end;

            //                                 break;
            //                             end;
            //                         60:
            //                             if (AssortDetailRec."60" <> '') and (AssortDetailRec."60" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."60";
            //                                     Evaluate(Qty, AssortDetailRec."60");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."60");
            //                                 end;

            //                                 break;
            //                             end;
            //                         61:
            //                             if (AssortDetailRec."61" <> '') and (AssortDetailRec."61" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."61";
            //                                     Evaluate(Qty, AssortDetailRec."61");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."61");
            //                                 end;

            //                                 break;
            //                             end;
            //                         62:
            //                             if (AssortDetailRec."62" <> '') and (AssortDetailRec."62" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."62";
            //                                     Evaluate(Qty, AssortDetailRec."62");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."62");
            //                                 end;

            //                                 break;
            //                             end;
            //                         63:
            //                             if (AssortDetailRec."63" <> '') and (AssortDetailRec."63" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."63";
            //                                     Evaluate(Qty, AssortDetailRec."63");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."63");
            //                                 end;

            //                                 break;
            //                             end;
            //                         64:
            //                             if (AssortDetailRec."64" <> '') and (AssortDetailRec."64" <> '0') then begin

            //                                 AssortDetail1Rec.Reset();
            //                                 AssortDetail1Rec.SetRange("Style No.", rec."No.");
            //                                 AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
            //                                 AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

            //                                 if AssortDetail1Rec.FindSet() then begin
            //                                     Description := rec."Style No." + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."64";
            //                                     Evaluate(Qty, AssortDetailRec."64");
            //                                     CreateFGItems(BOMRec.No, Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."64");
            //                                 end;

            //                                 break;
            //                             end;
            //                     end;

            //                     StatusGB := 1;
            //                 end;
            //             until AssortDetailRec.Next() = 0;

            //             AutoGenRec.Reset();
            //             AutoGenRec.SetRange("No.", BOMRec.No);
            //             AutoGenRec.SetFilter("Include in PO", '=%1', true);
            //             if AutoGenRec.FindSet() then
            //                 AutoGenRec.ModifyAll("Included in PO", true);


            //             AutoGenRec.Reset();
            //             AutoGenRec.SetRange("No.", BOMRec.No);
            //             AutoGenRec.SetFilter("Include in PO", '=%1', true);
            //             if AutoGenRec.FindSet() then
            //                 AutoGenRec.ModifyAll("Include in PO", false);

            //             //Delete Prod orders                      
            //             SalesHeaderRec.Reset();
            //             SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
            //             SalesHeaderRec.SetRange("Style No", rec."Style No.");
            //             SalesHeaderRec.SetRange(Lot, rec."Lot No.");
            //             SalesHeaderRec.SetFilter(EntryType, '=%1', SalesHeaderRec.EntryType::FG);

            //             if SalesHeaderRec.FindSet() then begin
            //                 ProOrderHedRec.Reset();
            //                 ProOrderHedRec.SetRange("Source Type", ProOrderHedRec."Source Type"::"Sales Header");
            //                 ProOrderHedRec.SetRange("Source No.", SalesHeaderRec."No.");

            //                 if ProOrderHedRec.FindSet() then begin
            //                     //Delete Prod order lines
            //                     ProOrderLineRec.Reset();
            //                     ProOrderLineRec.SetRange("Prod. Order No.", ProOrderHedRec."No.");
            //                     if ProOrderLineRec.FindSet() then
            //                         ProOrderLineRec.DeleteAll();

            //                     //Delete Prod order header
            //                     ProOrderHedRec.Delete();
            //                 end;
            //             end;

            //             //Create Prod orders                       
            //             SalesHeaderRec.Reset();
            //             SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
            //             SalesHeaderRec.SetRange("Style No", rec."Style No.");
            //             SalesHeaderRec.SetRange(Lot, rec."Lot No.");
            //             SalesHeaderRec.SetRange(EntryType, SalesHeaderRec.EntryType::FG);
            //             if SalesHeaderRec.FindSet() then
            //                 ProOrderNo := CodeUnitNavApp.CreateProdOrder(SalesHeaderRec."No.", 'Bulk');

            //             Message('Completed');
            //         end
            //         else
            //             Error('Color Size Matrix not defined.');
            //     end;
            // }

            // action("Remove error data")
            // {
            //     Caption = 'Remove error data';
            //     Image = RemoveLine;
            //     ApplicationArea = All;

            //     trigger OnAction();
            //     var
            //         Ass: Record AssorColorSizeRatio;
            //     begin
            //         Ass.Reset();
            //         Ass.SetRange("lot No.", 'A_17093054');
            //         Ass.FindSet();
            //         Ass.DeleteAll();
            //     end;
            // }
        }
    }

    procedure ColorSensitivity(BOMNo: Code[20])
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineColorRec: Record "BOM Line";
        BOMLineColorNewRec: Record "BOM Line";
        BOMAssortRec: Record AssortmentDetails;
        BOMLInePORec: Record BOMPOSelection;
        LineNo: Integer;
    begin

        //Delete old records        
        BOMLineColorRec.Reset();
        BOMLineColorRec.SetRange("No.", BOMNo);
        BOMLineColorRec.SetRange(Type, 1);
        BOMLineColorRec.DeleteAll();

        //Get Max Lineno
        BOMLineColorRec.Reset();
        BOMLineColorRec.SetRange("No.", BOMNo);
        BOMLineColorRec.SetRange(Type, 1);

        if BOMLineColorRec.FindLast() then
            LineNo := BOMLineColorRec."Line No";

        //Get Selected colors from BOM
        BOMLIneEstimateRec.Reset();
        BOMLIneEstimateRec.SetRange("No.", BOMNo);
        BOMLIneEstimateRec.SetRange("Color Sensitive", true);

        if BOMLIneEstimateRec.FindSet() then begin
            repeat

                BOMLInePORec.Reset();
                BOMLInePORec.SetRange("BOM No.", BOMNo);
                BOMLInePORec.SetRange("Lot No.", rec."Lot No.");
                BOMLInePORec.SetRange(Selection, true);

                if BOMLInePORec.FindSet() then begin

                    repeat
                        //Get Style Colors
                        BOMAssortRec.Reset();
                        BOMAssortRec.SetRange("Style No.", rec."No.");
                        BOMAssortRec.SetRange(Type, '1');
                        BOMAssortRec.SetRange("lot No.", BOMLInePORec."lot No.");
                        BOMAssortRec.SetCurrentKey("Style No.", "lot No.", "Colour No");
                        BOMAssortRec.FindSet();

                        //Check whether Item already existed in the color sensivity table
                        BOMLineColorRec.Reset();
                        BOMLineColorRec.SetRange("No.", BOMNo);
                        BOMLineColorRec.SetRange(Type, 1);
                        BOMLineColorRec.SetRange("Item No.", BOMLIneEstimateRec."Item No.");
                        BOMLineColorRec.SetRange("GMT Color No.", BOMAssortRec."Colour No");
                        BOMLineColorRec.SetRange(Placement, BOMLIneEstimateRec."Placement of GMT");

                        if not BOMLineColorRec.FindSet() then begin
                            GrpColor := '';
                            repeat

                                if GrpColor <> BOMAssortRec."Colour No" then begin
                                    GrpColor := BOMAssortRec."Colour No";

                                    LineNo += 10000;
                                    BOMLineColorNewRec.Init();
                                    BOMLineColorNewRec."No." := BOMNo;
                                    BOMLineColorNewRec.Type := 1;
                                    BOMLineColorNewRec."Line No" := LineNo;
                                    BOMLineColorNewRec."Item No." := BOMLIneEstimateRec."Item No.";
                                    BOMLineColorNewRec."Item Name" := BOMLIneEstimateRec."Item Name";
                                    BOMLineColorNewRec."Main Category No." := BOMLIneEstimateRec."Main Category No.";
                                    BOMLineColorNewRec."Main Category Name" := BOMLIneEstimateRec."Main Category Name";
                                    BOMLineColorNewRec."GMT Color No." := BOMAssortRec."Colour No";
                                    BOMLineColorNewRec."GMT Color Name." := BOMAssortRec."Colour Name";
                                    BOMLineColorNewRec."Construction No." := BOMLIneEstimateRec."Article No.";
                                    BOMLineColorNewRec."Construction Name." := BOMLIneEstimateRec."Article Name.";
                                    BOMLineColorNewRec."Dimension No." := BOMLIneEstimateRec."Dimension No.";
                                    BOMLineColorNewRec."Dimension Name" := BOMLIneEstimateRec."Dimension Name.";
                                    BOMLineColorNewRec."Item Color No." := BOMAssortRec."Colour No";
                                    BOMLineColorNewRec."Item Color Name." := BOMAssortRec."Colour Name";
                                    BOMLineColorNewRec.Placement := BOMLIneEstimateRec."Placement of GMT";
                                    BOMLineColorNewRec."Created User" := UserId;
                                    BOMLineColorNewRec."Created Date" := WorkDate();
                                    BOMLineColorNewRec."PO No." := BOMAssortRec."PO No.";
                                    BOMLineColorNewRec."Lot No." := BOMAssortRec."Lot No.";
                                    BOMLineColorNewRec.Select := true;
                                    BOMLineColorNewRec.Insert();
                                end;
                            until BOMAssortRec.Next() = 0;
                        end;
                    until BOMLInePORec.Next() = 0;
                end;
            until BOMLIneEstimateRec.Next() = 0;
        end;
    end;


    procedure SizeSensitivity(BOMNo: Code[20])
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineSizeRec: Record "BOM Line";
        BOMLineSizeNewRec: Record "BOM Line";
        BOMAssortRec: Record AssortmentDetailsInseam;
        BOMLInePORec: Record BOMPOSelection;
        LineNo: Integer;
    begin

        //Delete old records        
        BOMLineSizeRec.Reset();
        BOMLineSizeRec.SetRange("No.", BOMNo);
        BOMLineSizeRec.SetRange(Type, 2);
        BOMLineSizeRec.DeleteAll();

        //Get Max Lineno
        BOMLineSizeRec.Reset();
        BOMLineSizeRec.SetRange("No.", BOMNo);
        BOMLineSizeRec.SetRange(Type, 2);

        if BOMLineSizeRec.FindLast() then
            LineNo := BOMLineSizeRec."Line No";

        //Get Selected sizes from BOM
        BOMLIneEstimateRec.Reset();
        BOMLIneEstimateRec.SetRange("No.", BOMNo);
        BOMLIneEstimateRec.SetRange("size Sensitive", true);

        if BOMLIneEstimateRec.FindSet() then begin
            repeat

                BOMLInePORec.Reset();
                BOMLInePORec.SetRange("BOM No.", BOMNo);
                BOMLInePORec.SetRange("Lot No.", rec."Lot No.");
                BOMLInePORec.SetRange(Selection, true);

                if BOMLInePORec.FindSet() then begin

                    repeat
                        //Get Style Sizes
                        BOMAssortRec.Reset();
                        BOMAssortRec.SetRange("Style No.", rec."No.");
                        BOMAssortRec.SetRange("lot No.", BOMLInePORec."lot No.");
                        BOMAssortRec.SetCurrentKey("Style No.", "lot No.", "GMT Size");
                        BOMAssortRec.FindSet();

                        //Check whether Item already existed in the size sensivity table
                        BOMLineSizeRec.Reset();
                        BOMLineSizeRec.SetRange("No.", BOMNo);
                        BOMLineSizeRec.SetRange("Lot No.", BOMAssortRec."Lot No.");
                        BOMLineSizeRec.SetRange(Type, 2);
                        BOMLineSizeRec.SetRange("Item No.", BOMLIneEstimateRec."Item No.");
                        BOMLineSizeRec.SetRange("GMR Size Name", BOMAssortRec."GMT Size");
                        BOMLineSizeRec.SetRange(Placement, BOMLIneEstimateRec."Placement of GMT");

                        if BOMAssortRec."GMT Size" <> '' then begin
                            if not BOMLineSizeRec.FindSet() then begin
                                GrpSize := '';
                                repeat

                                    if GrpSize <> BOMAssortRec."GMT Size" then begin
                                        GrpSize := BOMAssortRec."GMT Size";

                                        LineNo += 10000;
                                        BOMLineSizeNewRec.Init();
                                        BOMLineSizeNewRec."No." := BOMNo;
                                        BOMLineSizeNewRec.Type := 2;
                                        BOMLineSizeNewRec."Line No" := LineNo;
                                        BOMLineSizeNewRec."Item No." := BOMLIneEstimateRec."Item No.";
                                        BOMLineSizeNewRec."Item Name" := BOMLIneEstimateRec."Item Name";
                                        BOMLineSizeNewRec."Main Category No." := BOMLIneEstimateRec."Main Category No.";
                                        BOMLineSizeNewRec."Main Category Name" := BOMLIneEstimateRec."Main Category Name";
                                        BOMLineSizeNewRec."GMR Size Name" := BOMAssortRec."GMT Size";
                                        BOMLineSizeNewRec."Main Cat size Name" := BOMAssortRec."GMT Size";
                                        BOMLineSizeNewRec.Placement := BOMLIneEstimateRec."Placement of GMT";
                                        BOMLineSizeNewRec.Price := BOMLIneEstimateRec.Rate;
                                        BOMLineSizeNewRec.WST := BOMLIneEstimateRec.WST;
                                        BOMLineSizeNewRec."Created User" := UserId;
                                        BOMLineSizeNewRec."Created Date" := WorkDate();
                                        BOMLineSizeNewRec."PO No." := BOMAssortRec."PO No.";
                                        BOMLineSizeNewRec."Lot No." := BOMAssortRec."Lot No.";
                                        BOMLineSizeNewRec.Select := true;
                                        BOMLineSizeNewRec.Insert();
                                    end;

                                until BOMAssortRec.Next() = 0;
                            end;
                        end
                        else
                            Error('Incomplete GMT SIZE record in Assortment Size/Inseam List.');

                    until BOMLInePORec.Next() = 0;
                end;
            until BOMLIneEstimateRec.Next() = 0;
        end;

    end;

    procedure CountrySensitivity(BOMNo: Code[20])
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineCountryRec: Record "BOM Line";
        BOMLineCountryNewRec: Record "BOM Line";
        BOMAssortRec: Record AssortmentDetails;
        BOMLInePORec: Record BOMPOSelection;
        LineNo: Integer;
    begin

        //Delete old records        
        BOMLineCountryRec.Reset();
        BOMLineCountryRec.SetRange("No.", BOMNo);
        BOMLineCountryRec.SetRange(Type, 3);
        BOMLineCountryRec.DeleteAll();

        //Get Max Lineno
        BOMLineCountryRec.Reset();
        BOMLineCountryRec.SetRange("No.", BOMNo);
        BOMLineCountryRec.SetRange(Type, 3);

        if BOMLineCountryRec.FindLast() then
            LineNo := BOMLineCountryRec."Line No";

        //Get Selected country from BOM
        BOMLIneEstimateRec.Reset();
        BOMLIneEstimateRec.SetRange("No.", BOMNo);
        BOMLIneEstimateRec.SetRange("Country Sensitive", true);

        if BOMLIneEstimateRec.FindSet() then begin
            repeat

                BOMLInePORec.Reset();//
                BOMLInePORec.SetRange("BOM No.", BOMNo);//
                BOMLInePORec.SetRange("Lot No.", rec."Lot No.");//
                BOMLInePORec.SetRange(Selection, true);//

                if BOMLInePORec.FindSet() then begin  //

                    repeat //    
                           //Get Style country
                        BOMAssortRec.Reset();
                        BOMAssortRec.SetRange("Style No.", rec."No.");
                        BOMAssortRec.SetRange(Type, '2');
                        BOMAssortRec.SetRange("lot No.", BOMLInePORec."lot No."); //
                        BOMAssortRec.SetCurrentKey("Style No.", "lot No.", "Country Code");  //     
                        BOMAssortRec.FindSet();

                        //Check whether Item already existed in the country sensitivity table
                        BOMLineCountryRec.Reset();
                        BOMLineCountryRec.SetRange("No.", BOMNo);
                        BOMLineCountryRec.SetRange("lot No.", BOMAssortRec."lot No.");
                        BOMLineCountryRec.SetRange(Type, 3);
                        BOMLineCountryRec.SetRange("Item No.", BOMLIneEstimateRec."Item No.");
                        BOMLineCountryRec.SetRange("Country Code", BOMAssortRec."Country Code");
                        BOMLineCountryRec.SetRange(Placement, BOMLIneEstimateRec."Placement of GMT");

                        if not BOMLineCountryRec.FindSet() then begin
                            GrpCountry := '';
                            repeat

                                if GrpCountry <> BOMAssortRec."Country Code" then begin
                                    GrpCountry := BOMAssortRec."Country Code";
                                    LineNo += 10000;
                                    BOMLineCountryNewRec.Init();
                                    BOMLineCountryNewRec."No." := BOMNo;
                                    BOMLineCountryNewRec.Type := 3;
                                    BOMLineCountryNewRec."Line No" := LineNo;
                                    BOMLineCountryNewRec."Item No." := BOMLIneEstimateRec."Item No.";
                                    BOMLineCountryNewRec."Item Name" := BOMLIneEstimateRec."Item Name";
                                    BOMLineCountryNewRec."Main Category No." := BOMLIneEstimateRec."Main Category No.";
                                    BOMLineCountryNewRec."Main Category Name" := BOMLIneEstimateRec."Main Category Name";
                                    BOMLineCountryNewRec."Country Code" := BOMAssortRec."Country Code";
                                    BOMLineCountryNewRec."Country Name" := BOMAssortRec."Country Name";
                                    BOMLineCountryNewRec.Placement := BOMLIneEstimateRec."Placement of GMT";
                                    BOMLineCountryNewRec."Created User" := UserId;
                                    BOMLineCountryNewRec."Created Date" := WorkDate();
                                    BOMLineCountryNewRec."PO No." := BOMAssortRec."PO No.";
                                    BOMLineCountryNewRec."Lot No." := BOMAssortRec."Lot No.";
                                    BOMLineCountryNewRec.Select := true;
                                    BOMLineCountryNewRec.Insert();
                                end;
                            until BOMAssortRec.Next() = 0;
                        end;
                    until BOMLInePORec.Next() = 0;
                end;
            until BOMLIneEstimateRec.Next() = 0;
        end;
    end;

    procedure ItemPOSensitivity(BOMNo: Code[20])
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineItemPORec: Record "BOM Line";
        BOMLineItemPONewRec: Record "BOM Line";
        StyleMasterPORec: Record "Style Master PO";
        BOMLInePORec: Record BOMPOSelection;
        LineNo: Integer;
    begin

        //Delete old records        
        BOMLineItemPORec.Reset();
        BOMLineItemPORec.SetRange("No.", BOMNo);
        BOMLineItemPORec.SetRange("Lot No.", rec."Lot No.");
        BOMLineItemPORec.SetRange(Type, 4);
        BOMLineItemPORec.DeleteAll();

        //Get Max Lineno
        BOMLineItemPORec.Reset();
        BOMLineItemPORec.SetRange("No.", BOMNo);
        BOMLineItemPORec.SetRange(Type, 4);

        if BOMLineItemPORec.FindLast() then
            LineNo := BOMLineItemPORec."Line No";

        //Get Selected PO from BOM
        BOMLIneEstimateRec.Reset();
        BOMLIneEstimateRec.SetRange("No.", BOMNo);
        BOMLIneEstimateRec.SetRange("PO Sensitive", true);

        if BOMLIneEstimateRec.FindSet() then begin
            repeat
                BOMLInePORec.Reset();//
                BOMLInePORec.SetRange("BOM No.", BOMNo);//
                BOMLInePORec.SetRange("Lot No.", rec."Lot No.");//
                BOMLInePORec.SetRange(Selection, true);//

                if BOMLInePORec.FindSet() then begin  //

                    repeat //    
                           //Get Style country
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", rec."No.");
                        StyleMasterPORec.SetRange("lot No.", BOMLInePORec."lot No."); //
                        StyleMasterPORec.SetCurrentKey("Style No.", "lot No.");  //     
                        StyleMasterPORec.FindSet();

                        //Check whether Item already existed in the country sensitivity table
                        BOMLineItemPORec.Reset();
                        BOMLineItemPORec.SetRange("No.", BOMNo);
                        BOMLineItemPORec.SetRange(Type, 4);
                        BOMLineItemPORec.SetRange("Item No.", BOMLIneEstimateRec."Item No.");
                        BOMLineItemPORec.SetRange("lot No.", StyleMasterPORec."lot No.");
                        BOMLineItemPORec.SetRange(Placement, BOMLIneEstimateRec."Placement of GMT");

                        if not BOMLineItemPORec.FindSet() then begin
                            repeat
                                LineNo += 10000;
                                BOMLineItemPONewRec.Init();
                                BOMLineItemPONewRec."No." := BOMNo;
                                BOMLineItemPONewRec.Type := 4;
                                BOMLineItemPONewRec."Line No" := LineNo;
                                BOMLineItemPONewRec."Item No." := BOMLIneEstimateRec."Item No.";
                                BOMLineItemPONewRec."Item Name" := BOMLIneEstimateRec."Item Name";
                                BOMLineItemPONewRec."Main Category No." := BOMLIneEstimateRec."Main Category No.";
                                BOMLineItemPONewRec."Main Category Name" := BOMLIneEstimateRec."Main Category Name";
                                BOMLineItemPONewRec."Lot No." := StyleMasterPORec."Lot No.";
                                BOMLineItemPONewRec."PO No." := StyleMasterPORec."PO No.";
                                BOMLineItemPONewRec.Placement := BOMLIneEstimateRec."Placement of GMT";
                                BOMLineItemPONewRec."Created User" := UserId;
                                BOMLineItemPONewRec."Created Date" := WorkDate();
                                BOMLineItemPONewRec.Select := true;
                                BOMLineItemPONewRec.Insert();
                            until StyleMasterPORec.Next() = 0;
                        end;
                    until BOMLInePORec.Next() = 0;
                end;
            until BOMLIneEstimateRec.Next() = 0;
        end;
    end;


    procedure CreateFGItems(BOMNo: Code[20]; ItemDesc: Text[500]; Lot: Code[20]; Qty: Integer; Color: Code[20]; Size: Code[20])
    var
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        NavAppSetupRec: Record "NavApp Setup";
        ItemMasterRec: Record Item;
        ItemUinitRec: Record "Item Unit of Measure";
        ColorRec: Record Colour;
        StyleMasPORec: Record "Style Master PO";
        FOBPcsPrice: Decimal;
        ItemRec: Record Item;
        NextItemNo: Code[20];
        ItemNo: Code[20];
        SalesDocNo: Code[20];
        ProdBOM: Code[20];
    begin

        //Get FOB Pcs price
        FOBPcsPrice := 0;

        //Get unit price
        StyleMasPORec.Reset();
        StyleMasPORec.SetRange("Style No.", rec."No.");
        StyleMasPORec.SetRange("Lot No.", Lot);
        if StyleMasPORec.FindSet() then
            FOBPcsPrice := StyleMasPORec."Unit Price";

        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Check for item existance
        ItemMasterRec.Reset();
        ItemMasterRec.SetRange(Description, ItemDesc);

        if not ItemMasterRec.FindSet() then begin   //If new item

            //Get next Item no
            NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."FG Item Nos.", Today(), true);

            //Create new item
            ItemRec.Init();
            ItemRec."No." := NextItemNo;
            ItemRec.Description := ItemDesc;
            ItemRec.Type := ItemRec.Type::Inventory;
            ItemRec."Gen. Prod. Posting Group" := NavAppSetupRec."Gen Posting Group-FG";
            ItemRec."Inventory Posting Group" := NavAppSetupRec."Inventory Posting Group-FG";
            ItemRec."VAT Prod. Posting Group" := 'ZERO';
            //ItemRec."VAT Bus. Posting " := 'ZERO';
            ItemRec."Color No." := Color;

            ColorRec.Reset();
            ColorRec.SetRange("No.", Color);
            ColorRec.FindSet();
            ItemRec."Color Name" := ColorRec."Colour Name";

            ItemRec."Size Range No." := Size;
            ItemRec."Rounding Precision" := 0.00001;

            //Insert into Item unit of measure
            ItemUinitRec.Init();
            ItemUinitRec."Item No." := NextItemNo;
            ItemUinitRec.Code := 'PCS';
            ItemUinitRec."Qty. per Unit of Measure" := 1;
            ItemUinitRec.Insert();

            ItemRec.Validate("Base Unit of Measure", 'PCS');
            ItemRec.Validate("Replenishment System", 1);
            ItemRec.Validate("Manufacturing Policy", 1);
            ItemRec."Production BOM No." := '';
            ItemRec."Unit Price" := FOBPcsPrice;
            ItemRec."Routing No." := NavAppSetupRec.Routing;
            ItemRec.Insert(true);

            //Create new sales order
            CreateSalesOrder(NextItemNo, Lot, Qty, FOBPcsPrice);
            //Create new Prod BOM
            CreateProdBOM(BOMNo, Color, size, Lot, NextItemNo, ItemDesc);

        end
        else begin   //If old item - Delete existing data and insert again

            ItemNo := ItemMasterRec."No.";
            ProdBOM := ItemMasterRec."Production BOM No.";

            if ProdBOM = '' then begin
                CreateSalesOrder(ItemNo, Lot, Qty, FOBPcsPrice);
                CreateProdBOM(BOMNo, Color, size, Lot, ItemNo, ItemDesc);
            end
            else
                UpdateProdBOM(BOMNo, Color, size, Lot, ItemNo, ProdBOM);
        end;
    end;


    procedure CreateSalesOrder(Item: code[20]; Lot: Code[20]; Qty: Integer; Price: Decimal)
    var
        SalesHeaderRec: Record "Sales Header";
        AssoRec: Record AssorColorSizeRatio;
        SalesLineRec: Record "Sales Line";
        SalesLineRec1: Record "Sales Line";
        NavAppSetupRec: Record "NavApp Setup";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        StyMasterPORec: Record "Style Master PO";
        StyMasterRec: Record "Style Master";
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
        ContractLCStyleRec: Record "Contract/LCStyle";
        ContractLcMasterRec: Record "Contract/LCMaster";
    begin

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Get location for the style
        StyMasterRec.Reset();
        StyMasterRec.SetRange("No.", rec."No.");
        StyMasterRec.FindSet();

        if StyMasterRec."Factory Code" = '' then
            Error('Factory is not assigned for the style : #1', StyMasterRec."Style No.");

        // Get Contract No
        //Done By sachith on 15/03/23
        ContractLCStyleRec.Reset();
        ContractLCStyleRec.SetRange("Style No.", Rec."No.");

        if ContractLCStyleRec.FindSet() then begin
            ContractLcMasterRec.Reset();
            ContractLcMasterRec.SetRange("No.", ContractLCStyleRec."No.");
            if not ContractLcMasterRec.FindSet() then
                Error('Cannot find the Contract No : %1', ContractLCStyleRec."No.");
        end;

        //Get ship date
        StyMasterPORec.Reset();
        StyMasterPORec.SetRange("Style No.", rec."No.");
        StyMasterPORec.SetRange("Lot No.", Lot);
        StyMasterPORec.FindSet();

        AssoRec.Reset();
        AssoRec.SetRange("Style No.", rec."No.");
        AssoRec.SetRange("Lot No.", Lot);
        AssoRec.SetFilter("Colour Name", '<>%1', '*');

        if AssoRec.FindSet() then begin
            if AssoRec.SalesOrderNo <> '' then begin // Sales order already created

                NextOrderNo := AssoRec.SalesOrderNo;

                //Get Max Lineno
                LineNo := 0;
                SalesLineRec1.Reset();
                SalesLineRec1.SetCurrentKey("Document Type", "Document No.");
                SalesLineRec1.SetRange("Document No.", NextOrderNo);
                SalesLineRec1.SetFilter("Document Type", '=%!', SalesLineRec1."Document Type"::Order);

                if SalesLineRec1.FindLast() then
                    LineNo := SalesLineRec1."Line No.";

                //Insert Line
                LineNo += 10;
                SalesLineRec.Init();
                SalesLineRec."Document Type" := SalesLineRec."Document Type"::Order;
                SalesLineRec."Document No." := NextOrderNo;
                SalesLineRec."Line No." := LineNo;
                SalesLineRec.Type := SalesLineRec.Type::Item;
                SalesLineRec."VAT Bus. Posting Group" := 'ZERO';
                SalesLineRec."VAT Prod. Posting Group" := 'ZERO';
                SalesLineRec.validate("No.", Item);
                SalesLineRec.validate(Quantity, Qty);
                SalesLineRec."Gen. Prod. Posting Group" := 'RETAIL';
                SalesLineRec."Gen. Bus. Posting Group" := 'EU';
                SalesLineRec.validate("Unit Price", Price);
                SalesLineRec."Planned Delivery Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Planned Shipment Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Shipment Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Tax Group Code" := NavAppSetupRec.TaxGroupCode;
                SalesLineRec.Validate("Location Code", StyMasterRec."Factory Code");
                SalesLineRec.INSERT();
            end
            else begin  //create new sales order

                //Check whether user logged in or not
                LoginSessionsRec.Reset();
                LoginSessionsRec.SetRange(SessionID, SessionId());

                if not LoginSessionsRec.FindSet() then begin  //not logged in
                    Clear(LoginRec);
                    LoginRec.LookupMode(true);
                    LoginRec.RunModal();

                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());
                    LoginSessionsRec.FindSet();
                end;

                //Insert Header
                NextOrderNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."FG SO Nos.", Today(), true);
                LineNo := 10;
                SalesHeaderRec.Init();
                SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
                SalesHeaderRec."No." := NextOrderNo;
                SalesHeaderRec."Posting Date" := WorkDate();
                SalesHeaderRec."Requested Delivery Date" := StyMasterPORec."Ship Date";
                SalesHeaderRec."Order Date" := WorkDate();
                SalesHeaderRec.Validate("Sell-to Customer No.", rec."Buyer No.");
                //SalesHeaderRec.Validate("Bill-to Customer No.", "Buyer No.");                
                SalesHeaderRec."Document Date" := WORKDATE;
                SalesHeaderRec."Due Date" := StyMasterPORec."Ship Date";
                SalesHeaderRec."Shipping No. Series" := 'S-SHPT';
                SalesHeaderRec."Posting No. Series" := 'S-INV+';
                SalesHeaderRec."Style No" := rec."No.";
                SalesHeaderRec."Style Name" := rec."Style No.";
                SalesHeaderRec."PO No" := StyMasterPORec."PO No.";
                SalesHeaderRec.Validate("Location Code", StyMasterRec."Factory Code");
                SalesHeaderRec.EntryType := SalesHeaderRec.EntryType::FG;
                SalesHeaderRec.Lot := Lot;
                SalesHeaderRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                //Done By sachith on 15/03/23
                SalesHeaderRec."Contract No" := ContractLcMasterRec."Contract No";
                SalesHeaderRec.INSERT();

                //Insert Line
                SalesLineRec.Init();
                SalesLineRec."Document Type" := SalesLineRec."Document Type"::Order;
                SalesLineRec."Document No." := NextOrderNo;
                SalesLineRec."Line No." := LineNo;
                SalesLineRec.Type := SalesLineRec.Type::Item;
                SalesLineRec."VAT Bus. Posting Group" := 'ZERO';
                SalesLineRec."VAT Prod. Posting Group" := 'ZERO';
                SalesLineRec.validate("No.", Item);
                SalesLineRec.validate(Quantity, Qty);
                SalesLineRec."Gen. Prod. Posting Group" := 'RETAIL';
                SalesLineRec."Gen. Bus. Posting Group" := 'EU';
                SalesLineRec.validate("Unit Price", Price);
                SalesLineRec."Planned Delivery Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Planned Shipment Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Shipment Date" := StyMasterPORec."Ship Date";
                SalesLineRec."Tax Group Code" := NavAppSetupRec.TaxGroupCode;
                SalesLineRec.Validate("Location Code", StyMasterRec."Factory Code");
                SalesLineRec.INSERT();

                //update with new sales order
                AssoRec.ModifyAll(SalesOrderNo, NextOrderNo);

            end;
        end;
    end;


    procedure CreateProdBOM(BOMNo: code[20]; Color: code[20]; Size: Code[20]; Lot: Code[20]; FGItem: Code[20]; ItemDesc: Text[500])
    var
        NextBOMNo: Code[20];
        ItemCategoryRec: Record "Item Category";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        ProdBOMHeaderRec: Record "Production BOM Header";
        ProdBOMLineRec: Record "Production BOM Line";
        ProdBOMLine1Rec: Record "Production BOM Line";
        AutoGenRec: Record "BOM Line AutoGen";
        AutoGenPrBOMRec: Record "BOM Line AutoGen ProdBOM";
        BOMLineEstimateRec: Record "BOM Line Estimate";
        MainCateRec: Record "Main Category";
        NavAppSetupRec: Record "NavApp Setup";
        ItemUinitRec: Record "Item Unit of Measure";
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
        LineNo: Integer;
        ItemMasterRec: Record item;
        Description: Text[500];
        NextItemNo: Code[20];
        HeaderGenerated: Boolean;
        UOMRec: Record "Unit of Measure";
        StyMasterPORec: Record "Style Master PO";
        ConvFactor: Decimal;
        ConsumptionTot: Decimal;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            LoginSessionsRec.Reset();
            LoginSessionsRec.SetRange(SessionID, SessionId());
            LoginSessionsRec.FindSet();
        end;

        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        //Generate Prod BOM Header
        if HeaderGenerated = false then begin

            //Generate Production BOM Header                                            
            NextBomNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."FG ProdBOM Nos.", Today(), true);
            ProdBOMHeaderRec.Init();
            ProdBOMHeaderRec."No." := NextBomNo;
            ProdBOMHeaderRec.Description := ItemDesc;
            ProdBOMHeaderRec.Validate("Unit of Measure Code", 'PCS');
            ProdBOMHeaderRec.Validate("Low-Level Code", 0);
            ProdBOMHeaderRec.Validate(Status, 0);
            ProdBOMHeaderRec."Creation Date" := WorkDate();
            ProdBOMHeaderRec."Last Date Modified" := WorkDate();
            ProdBOMHeaderRec."No. Series" := 'PRODBOM';
            ProdBOMHeaderRec."Style No." := rec."No.";
            ProdBOMHeaderRec."Style Name" := rec."Style No.";
            ProdBOMHeaderRec.Lot := Lot;
            ProdBOMHeaderRec.EntryType := ProdBOMHeaderRec.EntryType::FG;
            ProdBOMHeaderRec."BOM Type" := ProdBOMHeaderRec."BOM Type"::"Bulk";
            ProdBOMHeaderRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
            ProdBOMHeaderRec.Insert(true);
            HeaderGenerated := true;

            //Update Prod BOm No in item master
            ItemMasterRec.Reset();
            ItemMasterRec.SetRange("No.", FGItem);

            if ItemMasterRec.FindSet() then
                ItemMasterRec.ModifyAll("Production BOM No.", NextBomNo);
        end;

        AutoGenRec.Reset();
        AutoGenRec.SetCurrentKey("Main Category No.", "Item No.", "GMT Color No.", "GMT Size Name", "Lot No.");
        AutoGenRec.Ascending(true);
        AutoGenRec.SetRange("No.", BOMNo);
        AutoGenRec.SetRange("Lot No.", lot);
        AutoGenRec.SetRange("GMT Color No.", Color);
        //AutoGenRec.SetRange("GMT Size Name", Size);

        if AutoGenRec.FindSet() then begin

            repeat

                if AutoGenRec."Article Name." = '-' then
                    Error('Invalid Article : %1', AutoGenRec."Article Name.");

                if AutoGenRec."Dimension Name." = '-' then
                    Error('Invalid Dimension : %1', AutoGenRec."Dimension Name.");

                if (AutoGenRec."Include in PO" = true) or (AutoGenRec."Included in PO" = true) then begin

                    BOMLineEstimateRec.Reset();
                    BOMLineEstimateRec.SetRange("No.", BOMNo);
                    BOMLineEstimateRec.SetRange("Item No.", AutoGenRec."Item No.");
                    BOMLineEstimateRec.SetRange("Placement of GMT", AutoGenRec."Placement of GMT");

                    if BOMLineEstimateRec.FindSet() then begin

                        if BOMLineEstimateRec.Reconfirm = false then begin

                            if (AutoGenRec."GMT Size Name" = Size) or (AutoGenRec."GMT Size Name" = '') then begin
                                //if (AutoGenRec."GMT Size Name" = Size) or ((AutoGenRec."GMT Size Name" = '') and (StatusGB = 0)) then begin

                                //Get Dimenion only status
                                MainCateRec.Reset();
                                MainCateRec.SetRange("No.", AutoGenRec."Main Category No.");
                                if MainCateRec.FindSet() then begin
                                    if MainCateRec."Inv. Posting Group Code" = '' then
                                        Error('Inventory Posting Group is not setup for the Main Category : %1. Cannot proceed.', AutoGenRec."Main Category Name");

                                    if MainCateRec."Prod. Posting Group Code" = '' then
                                        Error('Product Posting Group is not setup for the Main Category : %1. Cannot proceed.', AutoGenRec."Main Category Name");
                                end
                                else
                                    Error('Cannot find Main Category details.');

                                //Generate description
                                Description := AutoGenRec."Item Name";

                                if AutoGenRec."Item Color Name" <> '' then
                                    Description := Description + ' / ' + AutoGenRec."Item Color Name";

                                if AutoGenRec."Article Name." <> '' then
                                    Description := Description + ' / ' + AutoGenRec."Article Name.";

                                if MainCateRec.DimensionOnly then begin
                                    if AutoGenRec."Dimension Name." <> '' then
                                        Description := Description + ' / ' + AutoGenRec."Dimension Name.";
                                end
                                else begin
                                    if AutoGenRec."GMT Size Name" <> '' then
                                        Description := Description + ' / ' + AutoGenRec."GMT Size Name";
                                end;

                                //Check whether item exists
                                ItemMasterRec.Reset();
                                ItemMasterRec.SetRange(Description, Description);

                                if ItemMasterRec.FindSet() then begin
                                    NextItemNo := ItemMasterRec."No.";

                                    ItemUinitRec.Reset();
                                    ItemUinitRec.SetRange("Item No.", NextItemNo);
                                    ItemUinitRec.SetRange(Code, AutoGenRec."Unit N0.");

                                    if not ItemUinitRec.FindSet() then begin
                                        //Insert into Item unit of measure
                                        ItemUinitRec.Init();
                                        ItemUinitRec."Item No." := NextItemNo;
                                        ItemUinitRec.Code := AutoGenRec."Unit N0.";
                                        ItemUinitRec."Qty. per Unit of Measure" := 1;
                                        ItemUinitRec.Insert();
                                    end;

                                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                                    ItemMasterRec.Modify();
                                end
                                else begin
                                    NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."RM Nos.", Today(), true);

                                    ItemMasterRec.Init();
                                    ItemMasterRec."No." := NextItemNo;
                                    ItemMasterRec.Description := Description;
                                    ItemMasterRec."Main Category No." := AutoGenRec."Main Category No.";
                                    ItemMasterRec."Main Category Name" := AutoGenRec."Main Category Name";
                                    ItemMasterRec."Sub Category No." := AutoGenRec."Sub Category No.";
                                    ItemMasterRec."Sub Category Name" := AutoGenRec."Sub Category Name";
                                    ItemMasterRec."Rounding Precision" := 0.00001;

                                    //Check for Item category
                                    ItemCategoryRec.Reset();
                                    ItemCategoryRec.SetRange(Code, AutoGenRec."Main Category No.");
                                    if not ItemCategoryRec.FindSet() then begin
                                        ItemCategoryRec.Init();
                                        ItemCategoryRec.Code := AutoGenRec."Main Category No.";
                                        ItemCategoryRec.Description := AutoGenRec."Main Category Name";
                                        ItemCategoryRec.Insert();
                                    end;

                                    ItemMasterRec."Item Category Code" := AutoGenRec."Main Category No.";
                                    ItemMasterRec."Color No." := AutoGenRec."Item Color No.";
                                    ItemMasterRec."Color Name" := AutoGenRec."Item Color Name";

                                    if MainCateRec.DimensionOnly then
                                        ItemMasterRec."Size Range No." := AutoGenRec."Dimension Name."
                                    else
                                        ItemMasterRec."Size Range No." := AutoGenRec."GMT Size Name";

                                    ItemMasterRec."Article No." := AutoGenRec."Article No.";
                                    ItemMasterRec."Article" := AutoGenRec."Article Name.";
                                    ItemMasterRec."Dimension Width No." := AutoGenRec."Dimension No.";
                                    ItemMasterRec."Dimension Width" := AutoGenRec."Dimension Name.";
                                    ItemMasterRec.Type := ItemMasterRec.Type::Inventory;
                                    ItemMasterRec."Unit Cost" := AutoGenRec.Rate;
                                    ItemMasterRec."Unit Price" := AutoGenRec.Rate;
                                    ItemMasterRec."Last Direct Cost" := AutoGenRec.Rate;
                                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                                    ItemMasterRec."VAT Prod. Posting Group" := 'ZERO';

                                    if MainCateRec.LOTTracking then begin
                                        ItemMasterRec.Validate("Item Tracking Code", NavAppSetupRec."LOT Tracking Code");
                                        ItemMasterRec."Lot Nos." := NavAppSetupRec."LOTTracking Nos.";
                                    end;

                                    //Insert into Item unit of measure
                                    ItemUinitRec.Init();
                                    ItemUinitRec."Item No." := NextItemNo;
                                    ItemUinitRec.Code := AutoGenRec."Unit N0.";
                                    ItemUinitRec."Qty. per Unit of Measure" := 1;

                                    ItemUinitRec.Insert();

                                    ItemMasterRec.Validate("Base Unit of Measure", AutoGenRec."Unit N0.");
                                    ItemMasterRec.Validate("Replenishment System", 0);
                                    ItemMasterRec.Validate("Manufacturing Policy", 1);
                                    ItemMasterRec.Insert(true);
                                end;

                                UOMRec.Reset();
                                UOMRec.SetRange(Code, AutoGenRec."Unit N0.");
                                UOMRec.FindSet();
                                ConvFactor := UOMRec."Converion Parameter";

                                if ConvFactor = 0 then
                                    ConvFactor := 1;

                                if (AutoGenRec.Type = AutoGenRec.Type::Doz) and (AutoGenRec."Unit N0." = 'DOZ') then
                                    ConvFactor := 1;

                                //Generate Production BOM Lines
                                ProdBOMLineRec.Reset();
                                ProdBOMLineRec.SetCurrentKey("Production BOM No.", Description);
                                ProdBOMLineRec.SetRange("Production BOM No.", NextBomNo);
                                ProdBOMLineRec.SetRange(Description, Description);

                                if not ProdBOMLineRec.FindSet() then begin    //Not existing bom item

                                    LineNo += 10000;
                                    ProdBOMLine1Rec.Init();
                                    ProdBOMLine1Rec."Production BOM No." := NextBomNo;
                                    //ProdBOMLine1Rec.Validate("Main Category Name", AutoGenRec."Main Category Name");
                                    ProdBOMLine1Rec.Validate("Main Category Code", AutoGenRec."Main Category No.");
                                    ProdBOMLine1Rec."Line No." := LineNo;
                                    ProdBOMLine1Rec.Type := ProdBOMLine1Rec.Type::Item;
                                    ProdBOMLine1Rec.Validate("No.", NextItemNo);
                                    ProdBOMLine1Rec.Description := Description;
                                    ProdBOMLine1Rec.Validate("Unit of Measure Code", AutoGenRec."Unit N0.");

                                    if AutoGenRec.Type = AutoGenRec.Type::Pcs then
                                        ConsumptionTot := AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100
                                    else
                                        if AutoGenRec.Type = AutoGenRec.Type::Doz then
                                            ConsumptionTot := (AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100) / 12;

                                    if ConvFactor <> 0 then
                                        ConsumptionTot := ConsumptionTot / ConvFactor;

                                    if ConsumptionTot = 0 then
                                        ConsumptionTot := 1;

                                    ProdBOMLine1Rec.Quantity := ConsumptionTot;
                                    ProdBOMLine1Rec."Quantity per" := ConsumptionTot;
                                    ProdBOMLine1Rec.Insert(true);

                                end
                                else begin  // Update existing item qty

                                    if AutoGenRec.Type = AutoGenRec.Type::Pcs then
                                        ConsumptionTot := AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100
                                    else
                                        if AutoGenRec.Type = AutoGenRec.Type::Doz then
                                            ConsumptionTot := (AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100) / 12;

                                    if ConvFactor <> 0 then
                                        ConsumptionTot := ConsumptionTot / ConvFactor;

                                    if ConsumptionTot = 0 then
                                        ConsumptionTot := 1;

                                    //ProdBOMLineRec.Validate(Quantity, ProdBOMLineRec."Quantity" + AutoGenRec.Consumption);
                                    ProdBOMLineRec."Quantity" := ProdBOMLineRec."Quantity" + ConsumptionTot;
                                    ProdBOMLineRec."Quantity per" := ProdBOMLineRec."Quantity per" + ConsumptionTot;
                                    ProdBOMLineRec.Modify();
                                end;

                                //Create Worksheet Entry
                                //CreateWorksheetEntry(NextItemNo, AutoGenRec."Supplier No.", AutoGenRec.Requirment, AutoGenRec.Rate, Lot, AutoGenRec.PO, AutoGenRec."Main Category Name", AutoGenRec."GMT Size Name");

                                //Update Auto generate                               
                                AutoGenRec."New Item No." := NextItemNo;
                                AutoGenRec.Modify();

                                //Update Prod BOm No in item master
                                ItemMasterRec.Reset();
                                ItemMasterRec.SetRange("No.", FGItem);

                                if ItemMasterRec.FindSet() then
                                    ItemMasterRec.ModifyAll("Production BOM No.", NextBomNo);

                                AutoGenPrBOMRec.Reset();
                                AutoGenPrBOMRec.SetRange("No.", BOMNo);
                                AutoGenPrBOMRec.SetRange("Item No.", AutoGenRec."Item No.");
                                AutoGenPrBOMRec.SetRange("Line No.", AutoGenRec."Line No.");
                                AutoGenPrBOMRec.SetRange("Production BOM No.", NextBomNo);

                                if not AutoGenPrBOMRec.FindSet() then begin
                                    //insert Autogen prod bom table
                                    AutoGenPrBOMRec.Init();
                                    AutoGenPrBOMRec."No." := BOMNo;
                                    AutoGenPrBOMRec."Item No." := AutoGenRec."Item No.";
                                    AutoGenPrBOMRec."Line No." := AutoGenRec."Line No.";
                                    AutoGenPrBOMRec."Created User" := UserId;
                                    AutoGenPrBOMRec."Created Date" := WorkDate();
                                    AutoGenPrBOMRec."Production BOM No." := NextBomNo;
                                    AutoGenPrBOMRec.Insert();
                                end;
                            end;
                        end;
                    end;
                end;
            until AutoGenRec.Next() = 0;

            //StatusGB := 1;

            //Update Status of the BOM to released
            ProdBOMHeaderRec.Reset();
            ProdBOMHeaderRec.SetRange("No.", NextBOMNo);
            if ProdBOMHeaderRec.FindSet() then begin
                ProdBOMHeaderRec.Validate(Status, 1);
                ProdBOMHeaderRec.Modify();
            end;

        end;

    end;

    procedure UpdateProdBOM(BOMNo: code[20]; Color: code[20]; Size: Code[20]; Lot: Code[20]; FGItem: Code[20]; ProdBOM: Code[20])
    var
        ItemCategoryRec: Record "Item Category";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        ProdBOMHeaderRec: Record "Production BOM Header";
        ProdBOMLineRec: Record "Production BOM Line";
        ProdBOMLine1Rec: Record "Production BOM Line";
        AutoGenRec: Record "BOM Line AutoGen";
        AutoGenPrBOMRec: Record "BOM Line AutoGen ProdBOM";
        BOMLineEstimateRec: Record "BOM Line Estimate";
        MainCateRec: Record "Main Category";
        NavAppSetupRec: Record "NavApp Setup";
        ItemUinitRec: Record "Item Unit of Measure";
        LineNo: Integer;
        ItemMasterRec: Record item;
        Description: Text[500];
        NextItemNo: Code[20];
        UOMRec: Record "Unit of Measure";
        ConvFactor: Decimal;
        ConsumptionTot: Decimal;
    begin
        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        AutoGenRec.Reset();
        AutoGenRec.SetCurrentKey("Main Category No.", "Item No.", "GMT Color No.", "GMT Size Name", "Lot No.");
        AutoGenRec.Ascending(true);
        AutoGenRec.SetRange("No.", BOMNo);
        AutoGenRec.SetRange("Lot No.", lot);
        AutoGenRec.SetRange("GMT Color No.", Color);
        //AutoGenRec.SetRange("GMT Size Name", Size);

        if AutoGenRec.FindSet() then begin

            repeat

                if (AutoGenRec."Include in PO" = true) and (AutoGenRec."Included in PO" = false) then begin

                    BOMLineEstimateRec.Reset();
                    BOMLineEstimateRec.SetRange("No.", BOMNo);
                    BOMLineEstimateRec.SetRange("Item No.", AutoGenRec."Item No.");
                    BOMLineEstimateRec.SetRange("Placement of GMT", AutoGenRec."Placement of GMT");

                    if BOMLineEstimateRec.FindSet() then begin

                        if BOMLineEstimateRec.Reconfirm = false then begin

                            if (AutoGenRec."GMT Size Name" = Size) or (AutoGenRec."GMT Size Name" = '') then begin

                                //Get Dimenion only status
                                MainCateRec.Reset();
                                MainCateRec.SetRange("No.", AutoGenRec."Main Category No.");
                                if MainCateRec.FindSet() then begin
                                    if MainCateRec."Inv. Posting Group Code" = '' then
                                        Error('Inventory Posting Group is not setup for the Main Category : %1. Cannot proceed.', AutoGenRec."Main Category Name");

                                    if MainCateRec."Prod. Posting Group Code" = '' then
                                        Error('Product Posting Group is not setup for the Main Category : %1. Cannot proceed.', AutoGenRec."Main Category Name");
                                end
                                else
                                    Error('Cannot find Main Category details.');

                                //Generate description
                                Description := AutoGenRec."Item Name";

                                if AutoGenRec."Item Color Name" <> '' then
                                    Description := Description + ' / ' + AutoGenRec."Item Color Name";

                                if AutoGenRec."Article Name." <> '' then
                                    Description := Description + ' / ' + AutoGenRec."Article Name.";

                                if MainCateRec.DimensionOnly then begin
                                    if AutoGenRec."Dimension Name." <> '' then
                                        Description := Description + ' / ' + AutoGenRec."Dimension Name.";
                                end
                                else begin
                                    if AutoGenRec."GMT Size Name" <> '' then
                                        Description := Description + ' / ' + AutoGenRec."GMT Size Name";
                                end;

                                //Check whether item exists
                                ItemMasterRec.Reset();
                                ItemMasterRec.SetRange(Description, Description);

                                if ItemMasterRec.FindSet() then begin
                                    NextItemNo := ItemMasterRec."No.";

                                    ItemUinitRec.Reset();
                                    ItemUinitRec.SetRange("Item No.", NextItemNo);
                                    ItemUinitRec.SetRange(Code, AutoGenRec."Unit N0.");

                                    if not ItemUinitRec.FindSet() then begin
                                        //Insert into Item unit of measure
                                        ItemUinitRec.Init();
                                        ItemUinitRec."Item No." := NextItemNo;
                                        ItemUinitRec.Code := AutoGenRec."Unit N0.";
                                        ItemUinitRec."Qty. per Unit of Measure" := 1;
                                        ItemUinitRec.Insert();
                                    end;

                                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                                    ItemMasterRec.Modify();
                                end
                                else begin

                                    NextItemNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."RM Nos.", Today(), true);

                                    ItemMasterRec.Init();
                                    ItemMasterRec."No." := NextItemNo;
                                    ItemMasterRec.Description := Description;
                                    ItemMasterRec."Main Category No." := AutoGenRec."Main Category No.";
                                    ItemMasterRec."Main Category Name" := AutoGenRec."Main Category Name";
                                    ItemMasterRec."Rounding Precision" := 0.00001;

                                    //Check for Item category
                                    ItemCategoryRec.Reset();
                                    ItemCategoryRec.SetRange(Code, AutoGenRec."Main Category No.");
                                    if not ItemCategoryRec.FindSet() then begin
                                        ItemCategoryRec.Init();
                                        ItemCategoryRec.Code := AutoGenRec."Main Category No.";
                                        ItemCategoryRec.Description := AutoGenRec."Main Category Name";
                                        ItemCategoryRec.Insert();
                                    end;

                                    ItemMasterRec."Item Category Code" := AutoGenRec."Main Category No.";

                                    ItemMasterRec."Sub Category No." := AutoGenRec."Sub Category No.";
                                    ItemMasterRec."Sub Category Name" := AutoGenRec."Sub Category Name";
                                    ItemMasterRec."Color No." := AutoGenRec."Item Color No.";
                                    ItemMasterRec."Color Name" := AutoGenRec."Item Color Name";

                                    if MainCateRec.DimensionOnly then
                                        ItemMasterRec."Size Range No." := AutoGenRec."Dimension Name."
                                    else
                                        ItemMasterRec."Size Range No." := AutoGenRec."GMT Size Name";

                                    ItemMasterRec."Article No." := AutoGenRec."Article No.";
                                    ItemMasterRec."Dimension Width No." := AutoGenRec."Dimension No.";
                                    ItemMasterRec.Type := ItemMasterRec.Type::Inventory;
                                    ItemMasterRec."Unit Cost" := AutoGenRec.Rate;
                                    ItemMasterRec."Unit Price" := AutoGenRec.Rate;
                                    ItemMasterRec."Last Direct Cost" := AutoGenRec.Rate;
                                    ItemMasterRec.validate("Gen. Prod. Posting Group", MainCateRec."Prod. Posting Group Code");
                                    ItemMasterRec.validate("Inventory Posting Group", MainCateRec."Inv. Posting Group Code");
                                    //ItemMasterRec."Inventory Posting Group" := NavAppSetupRec."Inventory Posting Group-RM";
                                    ItemMasterRec."VAT Prod. Posting Group" := 'ZERO';
                                    //ItemMasterRec."VAT Bus. Posting Gr. (Price)" := 'ZERO';

                                    if MainCateRec.LOTTracking then begin
                                        ItemMasterRec.Validate("Item Tracking Code", NavAppSetupRec."LOT Tracking Code");
                                        ItemMasterRec."Lot Nos." := NavAppSetupRec."LOTTracking Nos.";
                                    end;

                                    //Insert into Item unit of measure
                                    ItemUinitRec.Init();
                                    ItemUinitRec."Item No." := NextItemNo;
                                    ItemUinitRec.Code := AutoGenRec."Unit N0.";
                                    ItemUinitRec."Qty. per Unit of Measure" := 1;

                                    ItemUinitRec.Insert();

                                    ItemMasterRec.Validate("Base Unit of Measure", AutoGenRec."Unit N0.");
                                    ItemMasterRec.Validate("Replenishment System", 0);
                                    ItemMasterRec.Validate("Manufacturing Policy", 1);
                                    ItemMasterRec.Insert(true);

                                end;


                                //Update Status of the BOM to New
                                ProdBOMHeaderRec.Reset();
                                ProdBOMHeaderRec.SetRange("No.", ProdBOM);
                                if ProdBOMHeaderRec.FindSet() then begin
                                    ProdBOMHeaderRec.Validate(Status, 0);
                                    ProdBOMHeaderRec.Modify();
                                end;

                                //get max line no
                                ProdBOMLineRec.Reset();
                                ProdBOMLineRec.SetRange("Production BOM No.", ProdBOM);

                                if ProdBOMLineRec.FindLast() then
                                    LineNo := ProdBOMLineRec."Line No.";

                                UOMRec.Reset();
                                UOMRec.SetRange(Code, AutoGenRec."Unit N0.");
                                UOMRec.FindSet();
                                ConvFactor := UOMRec."Converion Parameter";

                                if ConvFactor = 0 then
                                    ConvFactor := 1;

                                if (AutoGenRec.Type = AutoGenRec.Type::Doz) and (AutoGenRec."Unit N0." = 'DOZ') then
                                    ConvFactor := 1;

                                //Generate Production BOM Lines
                                ProdBOMLineRec.Reset();
                                ProdBOMLineRec.SetCurrentKey("Production BOM No.", Description);
                                ProdBOMLineRec.SetRange("Production BOM No.", ProdBOM);
                                ProdBOMLineRec.SetRange(Description, Description);

                                if not ProdBOMLineRec.FindSet() then begin    //Not existing bom item

                                    LineNo += 10000;
                                    ProdBOMLine1Rec.Init();
                                    ProdBOMLine1Rec."Production BOM No." := ProdBOM;
                                    ProdBOMLine1Rec."Line No." := LineNo;
                                    ProdBOMLine1Rec.Type := ProdBOMLine1Rec.Type::Item;
                                    ProdBOMLine1Rec.Validate("Main Category Code", AutoGenRec."Main Category No.");
                                    ProdBOMLine1Rec.Validate("No.", NextItemNo);
                                    ProdBOMLine1Rec.Description := Description;
                                    ProdBOMLine1Rec.Validate("Unit of Measure Code", AutoGenRec."Unit N0.");

                                    if AutoGenRec.Type = AutoGenRec.Type::Pcs then
                                        ConsumptionTot := AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100
                                    else
                                        if AutoGenRec.Type = AutoGenRec.Type::Doz then
                                            ConsumptionTot := (AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100) / 12;

                                    if ConvFactor <> 0 then
                                        ConsumptionTot := ConsumptionTot / ConvFactor;

                                    if ConsumptionTot = 0 then
                                        ConsumptionTot := 1;

                                    ProdBOMLine1Rec.Quantity := ConsumptionTot;
                                    ProdBOMLine1Rec."Quantity per" := ConsumptionTot;
                                    ProdBOMLine1Rec.Insert(true);

                                end
                                else begin  // Update existing item qty

                                    if AutoGenRec.Type = AutoGenRec.Type::Pcs then
                                        ConsumptionTot := AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100
                                    else
                                        if AutoGenRec.Type = AutoGenRec.Type::Doz then
                                            ConsumptionTot := (AutoGenRec.Consumption + (AutoGenRec.Consumption * AutoGenRec.WST) / 100) / 12;

                                    if ConvFactor <> 0 then
                                        ConsumptionTot := ConsumptionTot / ConvFactor;

                                    if ConsumptionTot = 0 then
                                        ConsumptionTot := 1;

                                    ProdBOMLineRec."Quantity" := ProdBOMLineRec."Quantity" + ConsumptionTot;
                                    ProdBOMLineRec."Quantity per" := ProdBOMLineRec."Quantity per" + ConsumptionTot;
                                    ProdBOMLineRec.Modify();

                                end;

                                //Set status to release
                                ProdBOMHeaderRec.Reset();
                                ProdBOMHeaderRec.SetRange("No.", ProdBOM);
                                if ProdBOMHeaderRec.FindSet() then begin
                                    ProdBOMHeaderRec.Validate(Status, 1);
                                    ProdBOMHeaderRec.Modify();
                                end;

                                //Create Worksheet Entry
                                //CreateWorksheetEntry(NextItemNo, AutoGenRec."Supplier No.", AutoGenRec.Requirment, AutoGenRec.Rate, Lot, AutoGenRec.PO, AutoGenRec."Main Category Name", AutoGenRec."GMT Size Name");

                                //Update Auto generate                              
                                AutoGenRec."New Item No." := NextItemNo;
                                AutoGenRec.Modify();


                                //insert Autogen prod bom table
                                AutoGenPrBOMRec.Reset();
                                AutoGenPrBOMRec.SetRange("No.", BOMNo);
                                AutoGenPrBOMRec.SetRange("Item No.", AutoGenRec."Item No.");
                                AutoGenPrBOMRec.SetRange("Line No.", AutoGenRec."Line No.");
                                AutoGenPrBOMRec.SetRange("Production BOM No.", ProdBOM);

                                if not AutoGenPrBOMRec.FindSet() then begin
                                    AutoGenPrBOMRec.Init();
                                    AutoGenPrBOMRec."No." := BOMNo;
                                    AutoGenPrBOMRec."Item No." := AutoGenRec."Item No.";
                                    AutoGenPrBOMRec."Line No." := AutoGenRec."Line No.";
                                    AutoGenPrBOMRec."Created User" := UserId;
                                    AutoGenPrBOMRec."Created Date" := WorkDate();
                                    AutoGenPrBOMRec."Production BOM No." := ProdBOM;
                                    AutoGenPrBOMRec.Insert();
                                end;
                                //StatusGB := 1;

                            end;
                        end;
                    end;
                end;
            until AutoGenRec.Next() = 0;
        end;
    end;

    procedure InsertAutoGenProdBOM(ItemNo: Code[20]; LineNo: Integer)
    var
        BLAutoGenPRBOMRec: Record "BOM Line AutoGen ProdBOM";
    begin
        // BLAutoGenPRBOMRec.Init();
        // BLAutoGenPRBOMRec."No." := "No";
        // BLAutoGenPRBOMRec."Item No." := ItemNo;
        // BLAutoGenPRBOMRec."Line No." := LineNo;
        // BLAutoGenPRBOMRec."Created User" := UserId;
        // BLAutoGenPRBOMRec."Created Date" := WorkDate();
        // BLAutoGenPRBOMRec."Production BOM No." := '';
        // BLAutoGenPRBOMRec.Insert();
    end;


    trigger OnDeleteRecord(): Boolean
    var
    begin
        Error('Style already confirmed. Cannot delete.');
    end;


    procedure xxx()
    var
        StyleMasterRec: Record "Style Master";
    begin
        CurrPage.Update();
        CurrPage.AssorColorSizeRatioListPart.Page.Update();
    end;


    procedure Refresh()
    var
    begin
        CurrPage.Update();
    end;


    var
        POTotal: BigInteger;
        GrpSize: Text[50];
        GrpColor: code[20];
        GrpCountry: code[20];
        NextOrderNo: Code[20];
        LineNo: Integer;
        StatusGB: Integer;
}