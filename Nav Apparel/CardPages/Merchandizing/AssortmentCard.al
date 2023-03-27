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
            action("Adjust Sales Orders")
            {
                Caption = 'Adjust Sales Orders';
                Image = CreateJobSalesInvoice;
                ApplicationArea = All;

                trigger OnAction();
                var
                    AssortDetailRec: Record AssorColorSizeRatio;
                    AssortDetail1Rec: Record AssorColorSizeRatio;
                    BOMLineAutoGenRec: Record "BOM Line AutoGen";
                    BOMPOSelectionRec: Record BOMPOSelection;
                    StyleMasterPORec: Record "Style Master PO";
                    BOMRec: Record BOM;
                    LineNo: BigInteger;
                    Description: Text[500];
                    Qty: Decimal;
                    StatusGB: Integer;
                    Count: Integer;
                    Mode: Text[20];
                begin
                    LineNo := 0;
                    Description := '';
                    Mode := '';

                    //Check for the BOM
                    BOMRec.Reset();
                    BOMRec.SetRange("Style No.", rec."Style No.");
                    if not BOMRec.FindSet() then
                        Error('You have not created a BOM for this Style.');


                    //Check for the Auto gen line
                    BOMLineAutoGenRec.Reset();
                    BOMLineAutoGenRec.SetRange("No.", BOMRec.No);
                    if not BOMLineAutoGenRec.FindSet() then
                        Error('You have not run "Auto Generate" in BOM : %1. Cannot proceed.', BOMRec.No);


                    //Add BOM POSeletion record                   
                    StyleMasterPORec.Reset();
                    StyleMasterPORec.SetRange("Style No.", rec."Style No.");
                    StyleMasterPORec.SetRange("lot No.", rec."Lot No.");
                    StyleMasterPORec.FindSet();

                    AssortDetailRec.Reset();
                    AssortDetailRec.SetRange("Style No.", rec."Style No.");
                    AssortDetailRec.SetRange("lot No.", rec."Lot No.");
                    AssortDetailRec.SetFilter("Colour Name", '<>%1', '*');

                    if AssortDetailRec.FindSet() then begin
                        if AssortDetailRec.SalesOrderNo = '' then begin // Sales order not created (NEW PO)
                            Mode := 'NEW';
                            //insert PO details
                            BOMPOSelectionRec.Reset();
                            BOMPOSelectionRec.SetRange("BOM No.", BOMRec."No");
                            BOMPOSelectionRec.SetRange("Lot No.", rec."Lot No.");
                            if not BOMPOSelectionRec.FindSet() then begin
                                BOMPOSelectionRec.Init();
                                BOMPOSelectionRec."BOM No." := BOMRec."No";
                                BOMPOSelectionRec."Style No." := rec."Style No.";
                                BOMPOSelectionRec."Lot No." := StyleMasterPORec."Lot No.";
                                BOMPOSelectionRec."PO No." := StyleMasterPORec."PO No.";
                                BOMPOSelectionRec.Qty := StyleMasterPORec.Qty;
                                BOMPOSelectionRec.Mode := StyleMasterPORec.Mode;
                                BOMPOSelectionRec."Ship Date" := StyleMasterPORec."Ship Date";
                                BOMPOSelectionRec.Selection := false;
                                BOMPOSelectionRec."Created User" := UserId;
                                BOMPOSelectionRec."Created Date" := WorkDate();
                                BOMPOSelectionRec.Insert();
                            end;
                        end
                        else begin                                      // Sales order already created (old PO)
                            //Check existing PO qty and update
                            BOMPOSelectionRec.Reset();
                            BOMPOSelectionRec.SetRange("BOM No.", BOMRec."No");
                            BOMPOSelectionRec.SetRange("Lot No.", rec."Lot No.");
                            if BOMPOSelectionRec.FindSet() then begin
                                if BOMPOSelectionRec.Qty <> StyleMasterPORec.Qty then begin        // old PO , Qty changed
                                    BOMPOSelectionRec.Qty := StyleMasterPORec.Qty;
                                    BOMPOSelectionRec.Modify();
                                    Mode := 'EDIT';
                                end
                                else                                                              // old PO , Qty same
                                    Mode := '';
                            end;
                        end;
                    end;

                    //Add Sencitivity
                    ColorSensitivity(BOMRec.No);
                    SizeSensitivity(BOMRec.No);
                    CountrySensitivity();
                    ItemPOSensitivity();


                    AssortDetailRec.Reset();
                    AssortDetailRec.SetRange("Style No.", rec."Style No.");
                    AssortDetailRec.SetRange("lot No.", rec."Lot No.");
                    AssortDetailRec.SetFilter("Colour Name", '<>%1', '*');

                    if AssortDetailRec.FindSet() then begin
                        repeat

                            if AssortDetailRec.SalesOrderNo = '' then begin // Sales order not created (NEW PO)

                                //Check for the Auto gen line
                                BOMLineAutoGenRec.Reset();
                                BOMLineAutoGenRec.SetRange("No.", BOMRec.No);
                                BOMLineAutoGenRec.SetRange("Lot No.", AssortDetailRec."lot No.");
                                BOMLineAutoGenRec.SetFilter("Included in PO", '=%1', true);
                                if BOMLineAutoGenRec.FindSet() then
                                    Error('You have already run "Write To MRP" for the BOM : %1. Cannot proceed.', BOMRec.No);


                                StatusGB := 0;
                                FOR Count := 1 TO 64 DO begin
                                    Qty := 0;

                                    // case Count of
                                    //     1:
                                    //         if (AssortDetailRec."1" <> '') and (AssortDetailRec."1" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."1";
                                    //                 Evaluate(Qty, AssortDetailRec."1");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."1");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     2:
                                    //         if (AssortDetailRec."2" <> '') and (AssortDetailRec."2" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."2";
                                    //                 Evaluate(Qty, AssortDetailRec."2");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."2");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     3:
                                    //         if (AssortDetailRec."3" <> '') and (AssortDetailRec."3" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."3";
                                    //                 Evaluate(Qty, AssortDetailRec."3");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."3");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     4:
                                    //         if (AssortDetailRec."4" <> '') and (AssortDetailRec."4" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."4";
                                    //                 Evaluate(Qty, AssortDetailRec."4");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."4");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     5:
                                    //         if (AssortDetailRec."5" <> '') and (AssortDetailRec."5" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."5";
                                    //                 Evaluate(Qty, AssortDetailRec."5");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."5");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     6:
                                    //         if (AssortDetailRec."6" <> '') and (AssortDetailRec."6" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."6";
                                    //                 Evaluate(Qty, AssortDetailRec."6");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."6");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     7:
                                    //         if (AssortDetailRec."7" <> '') and (AssortDetailRec."7" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."7";
                                    //                 Evaluate(Qty, AssortDetailRec."7");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."7");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     8:
                                    //         if (AssortDetailRec."8" <> '') and (AssortDetailRec."8" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."8";
                                    //                 Evaluate(Qty, AssortDetailRec."8");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."8");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     9:
                                    //         if (AssortDetailRec."9" <> '') and (AssortDetailRec."9" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."9";
                                    //                 Evaluate(Qty, AssortDetailRec."9");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."9");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     10:
                                    //         if (AssortDetailRec."10" <> '') and (AssortDetailRec."10" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."10";
                                    //                 Evaluate(Qty, AssortDetailRec."10");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."10");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     11:
                                    //         if (AssortDetailRec."11" <> '') and (AssortDetailRec."11" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."11";
                                    //                 Evaluate(Qty, AssortDetailRec."11");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."11");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     12:
                                    //         if (AssortDetailRec."12" <> '') and (AssortDetailRec."12" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."12";
                                    //                 Evaluate(Qty, AssortDetailRec."12");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."12");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     13:
                                    //         if (AssortDetailRec."13" <> '') and (AssortDetailRec."13" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."13";
                                    //                 Evaluate(Qty, AssortDetailRec."13");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."13");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     14:
                                    //         if (AssortDetailRec."14" <> '') and (AssortDetailRec."14" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."14";
                                    //                 Evaluate(Qty, AssortDetailRec."14");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."14");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     15:
                                    //         if (AssortDetailRec."15" <> '') and (AssortDetailRec."15" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."15";
                                    //                 Evaluate(Qty, AssortDetailRec."15");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."15");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     16:
                                    //         if (AssortDetailRec."16" <> '') and (AssortDetailRec."16" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."16";
                                    //                 Evaluate(Qty, AssortDetailRec."16");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."16");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     17:
                                    //         if (AssortDetailRec."17" <> '') and (AssortDetailRec."17" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."17";
                                    //                 Evaluate(Qty, AssortDetailRec."17");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."17");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     18:
                                    //         if (AssortDetailRec."18" <> '') and (AssortDetailRec."18" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."18";
                                    //                 Evaluate(Qty, AssortDetailRec."18");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."18");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     19:
                                    //         if (AssortDetailRec."19" <> '') and (AssortDetailRec."19" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetailRec."19";
                                    //                 Evaluate(Qty, AssortDetailRec."19");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."19");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     20:
                                    //         if (AssortDetailRec."20" <> '') and (AssortDetailRec."20" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."20";
                                    //                 Evaluate(Qty, AssortDetailRec."20");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."20");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     21:
                                    //         if (AssortDetailRec."21" <> '') and (AssortDetailRec."21" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."21";
                                    //                 Evaluate(Qty, AssortDetailRec."21");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."21");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     22:
                                    //         if (AssortDetailRec."22" <> '') and (AssortDetailRec."22" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."22";
                                    //                 Evaluate(Qty, AssortDetailRec."22");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."22");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     23:
                                    //         if (AssortDetailRec."23" <> '') and (AssortDetailRec."23" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."23";
                                    //                 Evaluate(Qty, AssortDetailRec."23");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."23");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     24:
                                    //         if (AssortDetailRec."24" <> '') and (AssortDetailRec."24" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."24";
                                    //                 Evaluate(Qty, AssortDetailRec."24");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."24");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     25:
                                    //         if (AssortDetailRec."25" <> '') and (AssortDetailRec."25" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."25";
                                    //                 Evaluate(Qty, AssortDetailRec."25");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."25");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     26:
                                    //         if (AssortDetailRec."26" <> '') and (AssortDetailRec."26" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."26";
                                    //                 Evaluate(Qty, AssortDetailRec."26");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."26");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     27:
                                    //         if (AssortDetailRec."27" <> '') and (AssortDetailRec."27" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."27";
                                    //                 Evaluate(Qty, AssortDetailRec."27");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."27");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     28:
                                    //         if (AssortDetailRec."28" <> '') and (AssortDetailRec."28" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."28";
                                    //                 Evaluate(Qty, AssortDetailRec."28");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."28");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     29:
                                    //         if (AssortDetailRec."29" <> '') and (AssortDetailRec."29" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."29";
                                    //                 Evaluate(Qty, AssortDetailRec."29");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."29");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     30:
                                    //         if (AssortDetailRec."30" <> '') and (AssortDetailRec."30" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."30";
                                    //                 Evaluate(Qty, AssortDetailRec."30");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."30");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     31:
                                    //         if (AssortDetailRec."31" <> '') and (AssortDetailRec."31" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."31";
                                    //                 Evaluate(Qty, AssortDetailRec."31");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."31");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     32:
                                    //         if (AssortDetailRec."32" <> '') and (AssortDetailRec."32" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."32";
                                    //                 Evaluate(Qty, AssortDetailRec."32");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."32");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     33:
                                    //         if (AssortDetailRec."33" <> '') and (AssortDetailRec."33" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."33";
                                    //                 Evaluate(Qty, AssortDetailRec."33");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."33");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     34:
                                    //         if (AssortDetailRec."34" <> '') and (AssortDetailRec."34" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."34";
                                    //                 Evaluate(Qty, AssortDetailRec."34");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."34");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     35:
                                    //         if (AssortDetailRec."35" <> '') and (AssortDetailRec."35" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."35";
                                    //                 Evaluate(Qty, AssortDetailRec."35");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."35");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     36:
                                    //         if (AssortDetailRec."36" <> '') and (AssortDetailRec."36" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."36";
                                    //                 Evaluate(Qty, AssortDetailRec."36");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."36");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     37:
                                    //         if (AssortDetailRec."37" <> '') and (AssortDetailRec."37" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."37";
                                    //                 Evaluate(Qty, AssortDetailRec."37");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."37");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     38:
                                    //         if (AssortDetailRec."38" <> '') and (AssortDetailRec."38" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."38";
                                    //                 Evaluate(Qty, AssortDetailRec."38");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."38");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     39:
                                    //         if (AssortDetailRec."39" <> '') and (AssortDetailRec."39" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."39";
                                    //                 Evaluate(Qty, AssortDetailRec."39");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."39");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     40:
                                    //         if (AssortDetailRec."40" <> '') and (AssortDetailRec."40" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."40";
                                    //                 Evaluate(Qty, AssortDetailRec."40");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."40");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     41:
                                    //         if (AssortDetailRec."41" <> '') and (AssortDetailRec."41" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."41";
                                    //                 Evaluate(Qty, AssortDetailRec."41");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."41");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     42:
                                    //         if (AssortDetailRec."42" <> '') and (AssortDetailRec."42" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."42";
                                    //                 Evaluate(Qty, AssortDetailRec."42");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."42");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     43:
                                    //         if (AssortDetailRec."43" <> '') and (AssortDetailRec."43" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."43";
                                    //                 Evaluate(Qty, AssortDetailRec."43");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."43");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     44:
                                    //         if (AssortDetailRec."44" <> '') and (AssortDetailRec."44" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."44";
                                    //                 Evaluate(Qty, AssortDetailRec."44");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."44");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     45:
                                    //         if (AssortDetailRec."45" <> '') and (AssortDetailRec."45" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."45";
                                    //                 Evaluate(Qty, AssortDetailRec."45");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."45");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     46:
                                    //         if (AssortDetailRec."46" <> '') and (AssortDetailRec."46" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."46";
                                    //                 Evaluate(Qty, AssortDetailRec."46");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."46");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     47:
                                    //         if (AssortDetailRec."47" <> '') and (AssortDetailRec."47" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."47";
                                    //                 Evaluate(Qty, AssortDetailRec."47");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."47");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     48:
                                    //         if (AssortDetailRec."48" <> '') and (AssortDetailRec."48" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."48";
                                    //                 Evaluate(Qty, AssortDetailRec."48");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."48");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     49:
                                    //         if (AssortDetailRec."49" <> '') and (AssortDetailRec."49" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."49";
                                    //                 Evaluate(Qty, AssortDetailRec."49");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."49");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     50:
                                    //         if (AssortDetailRec."50" <> '') and (AssortDetailRec."50" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."50";
                                    //                 Evaluate(Qty, AssortDetailRec."50");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."50");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     51:
                                    //         if (AssortDetailRec."51" <> '') and (AssortDetailRec."51" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."51";
                                    //                 Evaluate(Qty, AssortDetailRec."51");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."51");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     52:
                                    //         if (AssortDetailRec."52" <> '') and (AssortDetailRec."52" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."52";
                                    //                 Evaluate(Qty, AssortDetailRec."52");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."52");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     53:
                                    //         if (AssortDetailRec."53" <> '') and (AssortDetailRec."53" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."53";
                                    //                 Evaluate(Qty, AssortDetailRec."53");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."53");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     54:
                                    //         if (AssortDetailRec."54" <> '') and (AssortDetailRec."54" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."54";
                                    //                 Evaluate(Qty, AssortDetailRec."54");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."54");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     55:
                                    //         if (AssortDetailRec."55" <> '') and (AssortDetailRec."55" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."55";
                                    //                 Evaluate(Qty, AssortDetailRec."55");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."55");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     56:
                                    //         if (AssortDetailRec."56" <> '') and (AssortDetailRec."56" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."56";
                                    //                 Evaluate(Qty, AssortDetailRec."56");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."56");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     57:
                                    //         if (AssortDetailRec."57" <> '') and (AssortDetailRec."57" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."57";
                                    //                 Evaluate(Qty, AssortDetailRec."57");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."57");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     58:
                                    //         if (AssortDetailRec."58" <> '') and (AssortDetailRec."58" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."58";
                                    //                 Evaluate(Qty, AssortDetailRec."58");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."58");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     59:
                                    //         if (AssortDetailRec."59" <> '') and (AssortDetailRec."59" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."59";
                                    //                 Evaluate(Qty, AssortDetailRec."59");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."59");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     60:
                                    //         if (AssortDetailRec."60" <> '') and (AssortDetailRec."60" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."60";
                                    //                 Evaluate(Qty, AssortDetailRec."60");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."60");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     61:
                                    //         if (AssortDetailRec."61" <> '') and (AssortDetailRec."61" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."61";
                                    //                 Evaluate(Qty, AssortDetailRec."61");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."61");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     62:
                                    //         if (AssortDetailRec."62" <> '') and (AssortDetailRec."62" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."62";
                                    //                 Evaluate(Qty, AssortDetailRec."62");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."62");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     63:
                                    //         if (AssortDetailRec."63" <> '') and (AssortDetailRec."63" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."63";
                                    //                 Evaluate(Qty, AssortDetailRec."63");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."63");
                                    //             end;

                                    //             break;
                                    //         end;
                                    //     64:
                                    //         if (AssortDetailRec."64" <> '') and (AssortDetailRec."64" <> '0') then begin

                                    //             AssortDetail1Rec.Reset();
                                    //             AssortDetail1Rec.SetRange("Style No.", rec."Style No.");
                                    //             AssortDetail1Rec.SetRange("Lot No.", AssortDetailRec."Lot No.");
                                    //             AssortDetail1Rec.SetFilter("Colour Name", '=%1', '*');

                                    //             if AssortDetail1Rec.FindSet() then begin
                                    //                 Description := rec."Style Name" + '/' + rec."Garment Type Name" + '/' + AssortDetailRec."Lot No." + '/' + AssortDetailRec."Colour Name" + '/' + AssortDetail1Rec."64";
                                    //                 Evaluate(Qty, AssortDetailRec."64");
                                    //                 CreateFGItems(Description, AssortDetailRec."Lot No.", Qty, AssortDetailRec."Colour No", AssortDetail1Rec."64");
                                    //             end;

                                    //             break;
                                    //         end;
                                    // end;

                                    StatusGB := 1;
                                end;
                            end
                            else
                                Error('Sales Order already created.');

                        until AssortDetailRec.Next() = 0;

                        // AutoGenRec.Reset();
                        // AutoGenRec.SetRange("No.", rec."No");
                        // AutoGenRec.SetFilter("Include in PO", '=%1', true);
                        // if AutoGenRec.FindSet() then
                        //     AutoGenRec.ModifyAll("Included in PO", true);


                        // AutoGenRec.Reset();
                        // AutoGenRec.SetRange("No.", rec."No");
                        // AutoGenRec.SetFilter("Include in PO", '=%1', true);
                        // if AutoGenRec.FindSet() then
                        //     AutoGenRec.ModifyAll("Include in PO", false);


                        // //Create Prod orders                       
                        // SalesHeaderRec.Reset();
                        // SalesHeaderRec."Document Type" := SalesHeaderRec."Document Type"::Order;
                        // SalesHeaderRec.SetRange("Style No", rec."Style No.");
                        // SalesHeaderRec.SetRange(EntryType, SalesHeaderRec.EntryType::FG);
                        // if SalesHeaderRec.FindSet() then begin

                        //     //Window.Open(TextCon1);
                        //     repeat
                        //         ProOrderNo := CodeUnitNavApp.CreateProdOrder(SalesHeaderRec."No.", 'Bulk');
                        //     //Window.Update(1, ProOrderNo);
                        //     //Sleep(100);
                        //     until SalesHeaderRec.Next() = 0;
                        //     //Window.Close();

                        //end;

                        Message('Completed');
                    end
                    else
                        Error('Color Size Matrix not defined.');
                end;
            }

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
        BOMLineColorRec.SetRange("Lot No.", rec."Lot No.");
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
                        BOMAssortRec.SetRange("Style No.", rec."Style No.");
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
        BOMLineSizeRec.SetRange("Lot No.", rec."Lot No.");
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
                        BOMAssortRec.SetRange("Style No.", rec."Style No.");
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

    procedure CountrySensitivity()
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineCountryRec: Record "BOM Line";
        BOMLineCountryNewRec: Record "BOM Line";
        BOMAssortRec: Record AssortmentDetails;
        BOMLInePORec: Record BOMPOSelection;
        LineNo: Integer;
        BOMNo: Code[20];
    begin

        //Delete old records        
        BOMLineCountryRec.Reset();
        BOMLineCountryRec.SetRange("No.", BOMNo);
        BOMLineCountryRec.SetRange("Lot No.", rec."Lot No.");
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
                        BOMAssortRec.SetRange("Style No.", rec."Style No.");
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
                                    //Message(Format(BOMAssortRec."Colour No"));
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

    procedure ItemPOSensitivity()
    var
        BOMLIneEstimateRec: Record "BOM Line Estimate";
        BOMLineItemPORec: Record "BOM Line";
        BOMLineItemPONewRec: Record "BOM Line";
        StyleMasterPORec: Record "Style Master PO";
        BOMLInePORec: Record BOMPOSelection;
        LineNo: Integer;
        BOMNo: Code[20];
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
                        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
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

}