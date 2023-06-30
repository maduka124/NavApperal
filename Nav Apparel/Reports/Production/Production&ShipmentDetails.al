report 50627 ProductionAndShipmentDetails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Production & Shipment Details';
    RDLCLayout = 'Report_Layouts/Production/ProductionAndShipmentDetails.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            column(Buyer_Name; "Buyer Name")
            { }

            dataitem("NavApp Planning Lines"; "NavApp Planning Lines")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Line No.");

                trigger OnPreDataItem()
                begin
                    if FactoryFilter <> '' then
                        SetRange(Factory, FactoryFilter);
                end;
            }

            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = where("Cut Out Qty" = filter(> 0));

                column(cutting; CutOutQty)
                { }
                column(Sewing; SawOutQty)
                { }
                column(Finishing; FinOutQty)
                { }
                column(WashOutQty; WashOutQty)
                { }
                column(ShipOutQty; ShipOutQty)
                { }
                column(ShipDate; "Ship Date")
                { }
                column(PoNo; "PO No.")
                { }
                column(stDate; stDate)
                { }
                column(endDate; endDate)
                { }
                column(Buyer; Buyer)
                { }
                column(StyleNo; StyleName)
                { }
                column(SMV; SMV)
                { }
                column(OrderQty; OrderQty)
                { }
                column(AssignedContractNo; AssignContrantNo)
                { }
                column(CompLogo; comRec.Picture)
                { }
                column(CutOutTotal; CutOutTotal)
                { }
                column(SawOutTotal; SawOutTotal)
                { }
                column(WashOutTotal; WashOutTotal)
                { }
                column(FinOutTotal; FinOutTotal)
                { }
                column(ShipOutTotal; ShipOutTotal)
                { }

                trigger OnPreDataItem()
                begin
                    SetRange("Ship Date", stDate, endDate);

                end;

                trigger OnAfterGetRecord()

                begin
                    comRec.Get;
                    comRec.CalcFields(Picture);

                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", "Style No.");
                    if StyleMasterRec.FindFirst() then begin
                        Buyer := StyleMasterRec."Buyer Name";
                        StyleName := StyleMasterRec."Style No.";
                        SMV := StyleMasterRec.SMV;
                        OrderQty := StyleMasterRec."Order Qty";
                        AssignContrantNo := StyleMasterRec.AssignedContractNo;
                    end;

                    //Cuting QTY
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Cut);
                    if ProductionRec.FindSet() then begin
                        CutOutQty += ProductionRec."Output Qty";

                    end;

                    //Cuting Total
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter("Prod Date", '<=%1', endDate);
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Cut);
                    if ProductionRec.FindSet() then begin
                        repeat
                            CutOutTotal += ProductionRec."Output Qty";
                        until ProductionRec.Next() = 0;
                    end;

                    //Sew QTY
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Saw);
                    if ProductionRec.FindSet() then begin
                        SawOutQty += ProductionRec."Output Qty";
                    end;

                    //Sew Total
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter("Prod Date", '<=%1', endDate);
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Saw);
                    if ProductionRec.FindSet() then begin
                        repeat
                            SawOutTotal += ProductionRec."Output Qty";
                        until ProductionRec.Next() = 0;
                    end;

                    //Finish QTY
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Fin);
                    if ProductionRec.FindSet() then begin
                        WashOutQty += ProductionRec."Output Qty";
                    end;

                    //Finish Total
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter("Prod Date", '<=%1', endDate);
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Fin);
                    if ProductionRec.FindSet() then begin
                        repeat
                            FinOutTotal += ProductionRec."Output Qty";
                        until ProductionRec.Next() = 0;
                    end;

                    //Wash QTY
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Wash);
                    if ProductionRec.FindSet() then begin
                        FinOutQty += ProductionRec."Output Qty";
                    end;

                    //Wash Total
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter("Prod Date", '<=%1', endDate);
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Wash);
                    if ProductionRec.FindSet() then begin
                        repeat
                            WashOutTotal += ProductionRec."Output Qty";
                        until ProductionRec.Next() = 0;
                    end;

                    //Ship QTY
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Ship);
                    if ProductionRec.FindSet() then begin
                        ShipOutQty += ProductionRec."Output Qty";
                    end;


                    //Ship Total
                    ProductionRec.Reset();
                    ProductionRec.SetRange("Style No.", "Style No.");
                    ProductionRec.SetRange("PO No", "PO No.");
                    ProductionRec.SetFilter("Prod Date", '<=%1', endDate);
                    ProductionRec.SetFilter(Type, '=%1', ProductionRec.Type::Ship);
                    if ProductionRec.FindSet() then begin
                        repeat
                            ShipOutTotal += ProductionRec."Output Qty";
                        until ProductionRec.Next() = 0;
                    end;

                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange("Buyer No.", BuyerNo);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Filter By';

                    field(FactoryFilter; FactoryFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';

                        trigger OnLookup(var texts: text): Boolean
                        var
                            LocationRec: Record Location;
                            LocationRec2: Record Location;
                            UserRec: Record "User Setup";
                        begin
                            UserRec.Reset();
                            UserRec.Get(UserId);

                            LocationRec2.Reset();
                            LocationRec2.SetFilter("Sewing Unit", '=%1', true);
                            LocationRec2.FindSet();

                            LocationRec.Reset();
                            LocationRec.SetRange(Code, UserRec."Factory Code");
                            LocationRec.SetFilter("Sewing Unit", '=%1', true);
                            if LocationRec.FindSet() then begin
                                if Page.RunModal(15, LocationRec) = Action::LookupOK then
                                    FactoryFilter := LocationRec.Code
                            end
                            else
                                if Page.RunModal(15, LocationRec2) = Action::LookupOK then begin
                                    FactoryFilter := LocationRec2.Code;
                                end;
                        end;
                    }

                    field(BuyerNo; BuyerNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer';
                        TableRelation = Customer."No.";
                    }

                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Start Date';

                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping End Date';

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        ShipOutTotal: BigInteger;
        WashOutTotal: BigInteger;
        FinOutTotal: BigInteger;
        SawOutTotal: BigInteger;
        CutOutTotal: BigInteger;
        ShipOutQty: BigInteger;
        WashOutQty: BigInteger;
        FinOutQty: BigInteger;
        SawOutQty: BigInteger;
        CutOutQty: BigInteger;
        ProductionRec: Record ProductionOutHeader;
        AssignContrantNo: Code[20];
        OrderQty: BigInteger;
        SMV: Decimal;
        StyleName: Text[50];
        Buyer: Text[50];
        StyleMasterRec: Record "Style Master";
        stDate: Date;
        endDate: Date;
        comRec: Record "Company Information";
        FactoryFilter: Code[20];
        BuyerNo: Code[20];
}