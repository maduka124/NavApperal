page 50722 JobcreationPageListPart
{
    PageType = Listpart;
    ApplicationArea = All;
    AutoSplitKey = true;
    UsageCategory = Lists;
    SourceTable = JobCreationLine;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Split No"; rec."Split No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Select; rec.Select)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashingSampleReqRec: Record JobCreationLine;
                        CountRec: Integer;
                    begin
                        CurrPage.Update();
                        CountRec := 0;
                        WashingSampleReqRec.Reset();
                        WashingSampleReqRec.SetRange(No, rec.No);
                        WashingSampleReqRec.SetRange("Line No", rec."Line No");
                        WashingSampleReqRec.SetFilter(Select, '=%1', true);

                        if WashingSampleReqRec.FindSet() then
                            CountRec := WashingSampleReqRec.Count;

                        if CountRec > 1 then
                            Error('You can select only one entry');
                    end;
                }

                field("wash Type"; rec."wash Type")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';

                    trigger OnValidate()
                    var
                        WashtypeRec: record "Wash Type";
                        WashsampleResLine: Record "Washing Sample Requsition Line";
                    begin

                        WashsampleResLine.Reset();
                        WashsampleResLine.SetRange("No.", rec.No);
                        WashsampleResLine.FindSet();
                        if WashsampleResLine."Split Status" = WashsampleResLine."Split Status"::Yes then
                            Error('This sample request already posted. Cannot change Wash Type.');

                        WashtypeRec.Reset();
                        WashtypeRec.SetRange("Wash Type Name", rec."Wash Type");
                        if WashtypeRec.FindSet() then
                            rec."Wash Type No." := WashtypeRec."No.";
                    end;
                }

                field(QTY; rec.QTY)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashsampleResLine: Record "Washing Sample Requsition Line";
                        JobCreLineRec: Record JobCreationLine;
                        InterRec: Record IntermediateTable;
                        Inter1Rec: Record IntermediateTable;
                        TotalQty: Integer;
                    begin
                        WashsampleResLine.Reset();
                        WashsampleResLine.SetRange("No.", rec.No);
                        WashsampleResLine.FindSet();
                        if WashsampleResLine."Split Status" = WashsampleResLine."Split Status"::Yes then
                            Error('This sample request already posted. Cannot change Qty.');

                        CurrPage.Update();

                        WashsampleResLine.Reset();
                        WashsampleResLine.SetRange("No.", rec.No);
                        WashsampleResLine.FindSet();

                        rec.Type := WashsampleResLine.Type;
                        rec.BuyerCode := WashsampleResLine."Buyer No";
                        rec.BuyerName := WashsampleResLine.Buyer;
                        rec."Style No" := WashsampleResLine."Style No.";
                        rec."Style Name" := WashsampleResLine."Style Name";
                        rec."Color Name" := WashsampleResLine."Color Name";
                        rec."Color Code" := WashsampleResLine."Color Code";
                        rec.Size := WashsampleResLine.Size;
                        rec."Req Date" := WashsampleResLine."Req Date";
                        rec."Order Qty" := WashsampleResLine."Req Qty BW QC Pass";
                        rec."Garment Type" := WashsampleResLine."Gament Type";
                        rec."Sample Type" := WashsampleResLine.SampleType;
                        rec.Remark := WashsampleResLine.RemarkLine;
                        rec."Unite Price" := WashsampleResLine."Unite Price";

                        Inter1Rec.Reset();
                        Inter1Rec.SetRange("No", rec.No);
                        Inter1Rec.SetRange("Line No", rec."Line No");
                        Inter1Rec.SetRange("Split No", rec."Split No");

                        if not Inter1Rec.FindSet() then begin
                            InterRec.Init();
                            InterRec.No := rec.No;
                            InterRec."Line No" := rec."Line No";
                            InterRec."Split No" := rec."Split No";
                            InterRec."Split Qty" := rec.QTY;
                            InterRec."Wash Type" := rec."wash Type";
                            InterRec."Unite Price" := rec."Unite Price";
                            InterRec.Insert();
                        end
                        else begin
                            Inter1Rec."Split Qty" := rec.QTY;
                            Inter1Rec.Modify();
                        end;

                        CurrPage.Update();

                        JobCreLineRec.Reset();
                        JobCreLineRec.SetRange("No", rec.No);
                        JobCreLineRec.SetRange("Line No", rec."Line No");

                        if JobCreLineRec.FindSet() then begin
                            repeat
                                TotalQty += JobCreLineRec.QTY;
                            until JobCreLineRec.Next() = 0;
                            WashsampleResLine."Total Split Qty" := TotalQty;
                            WashsampleResLine.Modify();
                            CurrPage.Update();
                        end;

                        if WashsampleResLine."Req Qty BW QC Pass" < TotalQty then
                            Error('Total split qty is greater then requested qty');
                    end;
                }

                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashsampleResLine: Record "Washing Sample Requsition Line";
                    begin

                        WashsampleResLine.Reset();
                        WashsampleResLine.SetRange("No.", rec.No);
                        WashsampleResLine.FindSet();
                        if WashsampleResLine."Split Status" = WashsampleResLine."Split Status"::Yes then
                            Error('This sample request already posted. Cannot change Comment.');
                    end;
                }

                field(Option; rec.Option)
                {
                    ApplicationArea = All;
                    Caption = 'Split Options';

                    trigger OnValidate()
                    var
                        WashsampleResLine: Record "Washing Sample Requsition Line";
                    begin

                        WashsampleResLine.Reset();
                        WashsampleResLine.SetRange("No.", rec.No);
                        WashsampleResLine.FindSet();
                        if WashsampleResLine."Split Status" = WashsampleResLine."Split Status"::Yes then
                            Error('This sample request already posted. Cannot change Option (Split).');
                    end;
                }

                field("Reciepe (Prod BOM)"; rec."Reciepe (Prod BOM)")
                {
                    ApplicationArea = All;
                    Caption = 'Recipe (Prod. BOM)';

                    trigger OnValidate()
                    var
                        JobCreLineRec: Record JobCreationLine;
                        ItemRec: Record Item;
                        IntermediateTable: Record IntermediateTable;
                    begin
                        if rec."Reciepe (Prod BOM)" <> '' then begin
                            JobCreLineRec.Reset();
                            JobCreLineRec.SetRange(No, rec.No);
                            JobCreLineRec.SetRange("Reciepe (Prod BOM)", rec."Reciepe (Prod BOM)");
                            JobCreLineRec.SetFilter("Split No", '<>%1', rec."Split No");
                            if JobCreLineRec.FindSet() then
                                Error('Reciepe already assigned.')
                        end;

                        //Get FG No of the line
                        IntermediateTable.Reset();
                        IntermediateTable.SetRange(No, rec.No);
                        IntermediateTable.SetRange("Line No", rec."Line No");
                        IntermediateTable.SetRange("Split No", rec."Split No");

                        if IntermediateTable.FindSet() then begin
                            //Update BOM of the FG
                            ItemRec.Reset();
                            ItemRec.SetRange("No.", IntermediateTable."FG No");

                            if ItemRec.FindSet() then begin
                                ItemRec."Production BOM No." := rec."Reciepe (Prod BOM)";
                                ItemRec.Modify();
                            end
                            else
                                Error('Cannot find the FG item');
                        end
                        else
                            Error('Cannot find the Intermediate line');

                    end;
                }

                field("Job Card (Prod Order)"; rec."Job Card (Prod Order)")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    var
                        JobCreLineRec: Record JobCreationLine;
                    begin
                        if rec."Job Card (Prod Order)" <> '' then begin
                            JobCreLineRec.Reset();
                            JobCreLineRec.SetRange(No, rec.No);
                            JobCreLineRec.SetRange("Job Card (Prod Order)", rec."Job Card (Prod Order)");
                            JobCreLineRec.SetFilter("Split No", '<>%1', rec."Split No");
                            if JobCreLineRec.FindSet() then
                                Error('Job Card already assigned.');
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Recipe")
            {
                ApplicationArea = All;
                Image = ViewOrder;

                trigger OnAction()
                var
                    JobCreationSplit: Record JobCreationLine;
                    ProductionBomRevise: Page "Production BOM";
                begin
                    JobCreationSplit.Reset();
                    JobCreationSplit.SetRange(No, rec.No);
                    JobCreationSplit.SetRange("Line No", rec."Line No");
                    JobCreationSplit.SetFilter(Select, '=%1', true);

                    if JobCreationSplit.FindSet() then begin

                        if JobCreationSplit."Reciepe (Prod BOM)" <> '' then begin
                            Clear(ProductionBomRevise);
                            ProductionBomRevise.PassParametersBom(JobCreationSplit."Reciepe (Prod BOM)", false);
                            ProductionBomRevise.Editable := false;
                            ProductionBomRevise.RunModal();
                        end
                        else
                            Error('No Recipe entered for the selected entry.');
                    end
                    else
                        Error('Select a record.');
                end;
            }

            action("View Job Card")
            {
                ApplicationArea = All;
                Image = ViewJob;

                trigger OnAction()
                var
                    JobCreationSplit: Record JobCreationLine;
                    ProdOrderRevise: Page "Firm Planned Prod. Order";
                begin
                    JobCreationSplit.Reset();
                    JobCreationSplit.SetRange(No, rec.No);
                    JobCreationSplit.SetRange("Line No", rec."Line No");
                    JobCreationSplit.SetFilter(Select, '=%1', true);

                    if JobCreationSplit.FindSet() then begin

                        if JobCreationSplit."Job Card (Prod Order)" <> '' then begin
                            Clear(ProdOrderRevise);
                            ProdOrderRevise.PassParameters(JobCreationSplit."Job Card (Prod Order)", false);
                            ProdOrderRevise.Editable := false;
                            ProdOrderRevise.RunModal();
                        end
                        else
                            Error('No Job Card entered for the selected entry.');
                    end
                    else
                        Error('Select a record.');
                end;
            }

            action("Print Job Card")
            {
                ApplicationArea = Basic, Suite;
                Image = Print;

                trigger OnAction()
                var
                    JobCreationSplit: Record JobCreationLine;
                    BarcodeString: Text;
                    BarcodeSymbology: Enum "Barcode Symbology";
                    BarcodeFontProvider: Interface "Barcode Font Provider";
                    Temp: Text;
                    EncodedText: Text;
                    ProdOrderRec: Record "Production Order";
                    Barcode: Text[50];
                begin

                    if rec."Job Card (Prod Order)" = '' then
                        Error('No Job Card no entered.');

                    JobCreationSplit.Reset();
                    JobCreationSplit.SetRange(No, rec.No);
                    JobCreationSplit.SetRange("Line No", rec."Line No");
                    JobCreationSplit.SetFilter(Select, '=%1', true);

                    if JobCreationSplit.FindSet() then begin

                        ProdOrderRec.Reset();
                        ProdOrderRec.SetRange("No.", rec."Job Card (Prod Order)");
                        Report.RunModal(50670, true, true, ProdOrderRec);

                        BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
                        BarcodeString := JobCreationSplit."Job Card (Prod Order)";
                        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                        EncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                        Temp := EncodedText.Replace('(', '');
                        Barcode := Temp.Replace(')', '');

                        ProdOrderRec.Reset();
                        ProdOrderRec.SetRange("No.", JobCreationSplit."Job Card (Prod Order)");
                        if ProdOrderRec.FindSet() then begin
                            ProdOrderRec.BarCode := Barcode;
                            ProdOrderRec.Modify();
                        end;

                    end
                    else
                        Error('Select a record.');
                end;
            }

            action("Up Date Job Card")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                trigger OnAction()
                var
                    JobcreationLineRec: Record JobCreationLine;
                    ProdutionBomlineRec: Record "Production BOM Line";
                    ProductioOrderLineRec: Record "Prod. Order Line";
                    ProductioOrderLine2Rec: Record "Prod. Order Line";
                    MaxLineNo: Integer;

                begin
                    JobcreationLineRec.Reset();
                    JobcreationLineRec.SetRange(No, rec.No);
                    JobcreationLineRec.SetRange("Line No", rec."Line No");
                    JobcreationLineRec.SetRange("Split No", rec."Split No");
                    JobcreationLineRec.SetFilter(Select, '=%1', true);

                    if JobcreationLineRec.FindSet() then begin

                        if JobcreationLineRec."Reciepe (Prod BOM)" = '' then
                            Error('No recipe entered for the selected entry.');

                        if JobcreationLineRec."Job Card (Prod Order)" = '' then
                            Error('No job card for the selected entry.');

                        //Get Max Line No
                        ProductioOrderLine2Rec.Reset();
                        ProductioOrderLine2Rec.SetRange("Prod. Order No.", rec."Job Card (Prod Order)");

                        if ProductioOrderLine2Rec.FindLast() then
                            MaxLineNo := ProductioOrderLine2Rec."Line No.";

                        ProductioOrderLineRec.Reset();
                        ProductioOrderLineRec.SetRange("Prod. Order No.", rec."Job Card (Prod Order)");

                        if ProductioOrderLineRec.FindSet() then begin

                            ProdutionBomlineRec.Reset();
                            ProdutionBomlineRec.SetRange("Production BOM No.", rec."Reciepe (Prod BOM)");

                            if ProdutionBomlineRec.FindSet() then begin
                                if ProdutionBomlineRec."No." <> ProductioOrderLineRec."Item No." then
                                    repeat
                                        MaxLineNo += 1;
                                        ProductioOrderLine2Rec.Init();
                                        ProductioOrderLine2Rec."Prod. Order No." := ProductioOrderLineRec."Prod. Order No.";
                                        ProductioOrderLine2Rec.Status := ProductioOrderLineRec.Status::"Firm Planned";
                                        ProductioOrderLine2Rec."Line No." := MaxLineNo;
                                        ProductioOrderLine2Rec."Item No." := ProdutionBomlineRec."No.";
                                        ProductioOrderLine2Rec.Description := ProdutionBomlineRec.Description;
                                        ProductioOrderLine2Rec.Step := ProdutionBomlineRec.Step;
                                        ProductioOrderLine2Rec.Water := ProdutionBomlineRec."Water(L)";
                                        ProductioOrderLine2Rec.Temp := ProdutionBomlineRec.Temperature;
                                        ProductioOrderLine2Rec."Time(Min)" := ProdutionBomlineRec.Time;
                                        ProductioOrderLine2Rec.Insert();

                                    until ProdutionBomlineRec.Next() = 0;
                                Message('Job card updated');
                            end;
                        end;
                    end
                    else
                        Error('Select a record');
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        intermidiateRec: Record IntermediateTable;
        WashsampleResLine: Record "Washing Sample Requsition Line";
        WashsampleResLine2Rec: Record "Washing Sample Requsition Line";
    begin

        WashsampleResLine.Reset();
        WashsampleResLine.SetRange("No.", rec.No);
        WashsampleResLine.FindSet();
        if WashsampleResLine."Split Status" = WashsampleResLine."Split Status"::Yes then
            Error('This sample request already posted. Cannot delete the entry.');

        intermidiateRec.Reset();
        intermidiateRec.SetRange(No, rec.No);
        intermidiateRec.SetRange("Line No", rec."Line No");
        intermidiateRec.SetRange("Split No", rec."Split No");

        if intermidiateRec.FindSet() then
            intermidiateRec.DeleteAll();


        // WashsampleResLine2Rec.Reset();
        // WashsampleResLine2Rec.SetRange("No.", No);
        // WashsampleResLine2Rec.SetRange("Line no.", "Line No");


        // if WashsampleResLine2Rec.FindSet() then begin
        //     WashsampleResLine2Rec.Delete();
        //     WashsampleResLine2Rec."Total Split Qty" := WashsampleResLine2Rec."Total Split Qty" - QTY;
        //     CurrPage.Update();
        // end;
    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        WashsampleResLine: Record "Washing Sample Requsition Line";
    begin
        WashsampleResLine.Reset();
        WashsampleResLine.SetRange("No.", rec.No);
        WashsampleResLine.FindSet();
        if WashsampleResLine."Split Status" = WashsampleResLine."Split Status"::Yes then
            Error('This sample request already posted. Cannot insert new entry.');
    end;
}