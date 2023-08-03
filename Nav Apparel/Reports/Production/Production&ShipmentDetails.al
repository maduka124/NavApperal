report 50627 ProductionAndShipmentDetails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Production & Shipment Details';
    RDLCLayout = 'Report_Layouts/Production/ProductionAndShipmentDetails.rdl';
    DefaultLayout = RDLC;

    dataset
    {


        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {

            DataItemTableView = sorting("No.");

            column(Buyer_Name; "Sell-to Customer No.")
            { }
            column(AssignedContractNo; "Contract No")
            { }
            column(Location_Code; "Location Code")
            { }
          

            dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Style No." = field("Style No"), "PO No." = field("PO No");
                DataItemTableView = sorting("No.");
                column(PoNo; "PO No.")
                { }
                column(OrderQty; OrderQty)
                { }
                column(SMV; SMV)
                { }
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
                column(ShipDate; Shdate)
                { }
                column(stDate; stDate)
                { }
                column(endDate; endDate)
                { }
                column(Buyer; Buyer)
                { }
                column(StyleNo; StyleName)
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
                        AssignContrantNo := StyleMasterRec."LC No/Contract";
                    end;


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
                end;

            }
            trigger OnPreDataItem()
            begin
                if stDate <> 0D then
                    SetRange("Shipment Date", stDate, endDate);

                if BuyerNo <> '' then
                    SetRange("Sell-to Customer No.", BuyerNo);

                if FactoryFilter <> '' then
                    SetRange("Location Code", FactoryFilter);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ShipOutTotal := 0;
                SalesInvoiceHrec.Reset();
                SalesInvoiceHrec.SetRange("No.", "No.");
                SalesInvoiceHrec.SetFilter("Shipment Date", '<=%1', endDate);
                if SalesInvoiceHrec.FindSet() then begin
                    SalesInvoiceLineRec.Reset();
                    SalesInvoiceLineRec.SetRange("Document No.", SalesInvoiceHrec."No.");
                    if SalesInvoiceLineRec.FindSet() then begin
                        repeat
                            ShipOutTotal += SalesInvoiceLineRec.Quantity;
                        until SalesInvoiceLineRec.Next() = 0;
                    end;
                end;

                SalesInvoiceHrec.Reset();
                SalesInvoiceHrec.SetRange("No.", "No.");
                if SalesInvoiceHrec.FindSet() then begin
                    Shdate := SalesInvoiceHrec."Shipment Date";
                end;


                ShipOutQty := 0;
                SalesInvoiceHrec.Reset();
                SalesInvoiceHrec.SetRange("No.", "No.");
                if SalesInvoiceHrec.FindSet() then begin
                    SalesInvoiceLineRec.Reset();
                    SalesInvoiceLineRec.SetRange("Document No.", SalesInvoiceHrec."No.");
                    if SalesInvoiceLineRec.FindSet() then begin
                        repeat
                            ShipOutQty += SalesInvoiceLineRec.Quantity;
                        until SalesInvoiceLineRec.Next() = 0;
                    end;
                end;
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
        Shdate: Date;
        SalesInvoiceHrec: Record "Sales Invoice Header";
        SalesInvoiceLineRec: Record "Sales Invoice Line";
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