page 51468 "Cancel Style/PO For Wash"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PendingAllocationWash;
    CardPageId = PendingAllocationCard;
    SourceTableView = sorting() where("Wash Allocated" = filter(false), Cancel = filter(true));
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Seq No"; Rec."Seq No")
                {
                    ApplicationArea = All;
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO';
                }

                field(Lot; Rec.Lot)
                {
                    ApplicationArea = All;
                }

                field("PO Qty"; Rec."PO Qty")
                {
                    ApplicationArea = All;
                }

                field("Plan Max Target"; Rec."Plan Max Target")
                {
                    ApplicationArea = All;
                    Caption = 'Plan Target';
                }

                field("Sewing Factory Name"; Rec."Sewing Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sew Factory';
                }

                field("Plan Start Date"; Rec."Plan Start Date")
                {
                    ApplicationArea = All;
                }

                field("Plan End Date"; Rec."Plan End Date")
                {
                    ApplicationArea = All;
                }

                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }


            }
        }
    }

    trigger OnOpenPage()
    var
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        StyleMaster2PORec: Record "Style Master PO";
        PendingAllocationRec: Record PendingAllocationWash;
        PendingAllocation2Rec: Record PendingAllocationWash;
        SalesInvoiceLineRec: Record "Sales Invoice Line";
        SalesInvoiceHeaderRec: Record "Sales Invoice Header";
        NavAppProdDetailRec: Record "NavApp Prod Plans Details";
        No: Integer;
        ShipQty: Integer;
        LocationRec: Record Location;
        MaxTartget: BigInteger;
    begin

        PendingAllocationRec.Reset();
        if PendingAllocationRec.FindLast() then
            No := PendingAllocationRec."Seq No";

        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange(Status, StyleMasterPORec.Status::Confirm);

        if StyleMasterPORec.FindFirst() then begin
            repeat

                if StyleMasterPORec."Style Name" <> '' then begin

                    PendingAllocation2Rec.Reset();
                    PendingAllocation2Rec.SetRange("Style No", StyleMasterPORec."Style No.");
                    PendingAllocation2Rec.SetRange("PO No", StyleMasterPORec."PO No.");
                    PendingAllocation2Rec.SetRange(Lot, StyleMasterPORec."Lot No.");

                    if not PendingAllocation2Rec.FindSet() then begin

                        ShipQty := 0;
                        SalesInvoiceHeaderRec.Reset();
                        SalesInvoiceHeaderRec.SetRange("Style No", StyleMasterPORec."Style No.");
                        SalesInvoiceHeaderRec.SetRange(Lot, StyleMasterPORec."Lot No.");
                        SalesInvoiceHeaderRec.SetRange("PO No", StyleMasterPORec."PO No.");

                        if SalesInvoiceHeaderRec.FindSet() then begin
                            repeat
                                SalesInvoiceLineRec.Reset();
                                SalesInvoiceLineRec.SetRange("Document No.", SalesInvoiceHeaderRec."No.");
                                SalesInvoiceLineRec.SetRange(Type, SalesInvoiceLineRec.Type::Item);

                                if SalesInvoiceLineRec.FindSet() then begin
                                    repeat
                                        ShipQty += SalesInvoiceLineRec.Quantity;
                                    until SalesInvoiceLineRec.Next() = 0;
                                end;

                            until SalesInvoiceHeaderRec.Next() = 0;
                        end;
                        if ShipQty <= StyleMasterPORec.Qty then begin


                            PendingAllocationRec.Init();
                            No += 1;
                            PendingAllocationRec."Seq No" := No;
                            PendingAllocationRec."Style No" := StyleMasterPORec."Style No.";
                            PendingAllocationRec."Style Name" := StyleMasterPORec."Style Name";
                            PendingAllocationRec."PO No" := StyleMasterPORec."PO No.";
                            PendingAllocationRec.Lot := StyleMasterPORec."Lot No.";
                            PendingAllocationRec."Shipment Date" := StyleMasterPORec."Ship Date";

                            NavAppProdDetailRec.Reset();
                            NavAppProdDetailRec.SetRange("Style No.", StyleMasterPORec."Style No.");
                            NavAppProdDetailRec.SetRange("PO No.", StyleMasterPORec."PO No.");
                            NavAppProdDetailRec.SetRange("Lot No.", StyleMasterPORec."Lot No.");

                            MaxTartget := 0;

                            if NavAppProdDetailRec.FindFirst() then begin
                                PendingAllocationRec."Sewing Factory Code" := NavAppProdDetailRec."Factory No.";

                                repeat
                                    if NavAppProdDetailRec.Target > MaxTartget then
                                        MaxTartget := NavAppProdDetailRec.Target;
                                until NavAppProdDetailRec.Next() = 0;
                            end;

                            PendingAllocationRec."Plan Max Target" := MaxTartget;


                            LocationRec.Reset();
                            LocationRec.SetRange(Code, NavAppProdDetailRec."Factory No.");
                            if LocationRec.FindSet() then
                                PendingAllocationRec."Sewing Factory Name" := LocationRec.Name;

                            //Get plan Start Date
                            NavAppProdDetailRec.Reset();
                            NavAppProdDetailRec.SetRange("Style No.", StyleMasterPORec."Style No.");
                            NavAppProdDetailRec.SetRange("PO No.", StyleMasterPORec."PO No.");
                            NavAppProdDetailRec.SetRange("Lot No.", StyleMasterPORec."Lot No.");
                            NavAppProdDetailRec.SetCurrentKey(PlanDate);
                            NavAppProdDetailRec.Ascending(true);

                            if NavAppProdDetailRec.FindFirst() then
                                PendingAllocationRec."Plan Start Date" := NavAppProdDetailRec.PlanDate;

                            //Get Last Plan Date
                            NavAppProdDetailRec.Reset();
                            NavAppProdDetailRec.SetRange("Style No.", StyleMasterPORec."Style No.");
                            NavAppProdDetailRec.SetRange("PO No.", StyleMasterPORec."PO No.");
                            NavAppProdDetailRec.SetRange("Lot No.", StyleMasterPORec."Lot No.");
                            NavAppProdDetailRec.SetCurrentKey(PlanDate);
                            NavAppProdDetailRec.Ascending(true);

                            if NavAppProdDetailRec.FindLast() then
                                PendingAllocationRec."Plan End Date" := NavAppProdDetailRec.PlanDate;

                            PendingAllocationRec."PO Qty" := StyleMasterPORec.Qty;

                            //Get Buyer From Stylemaster
                            StyleMasterRec.Reset();
                            StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");

                            if StyleMasterRec.FindSet() then begin
                                PendingAllocationRec."Buyer Code" := StyleMasterRec."Buyer No.";
                                PendingAllocationRec."Buyer Name" := StyleMasterRec."Buyer Name";
                            end;

                            PendingAllocationRec.Insert();
                        end;
                    end
                    // else begin

                    //     StyleMaster2PORec.Reset();
                    //     StyleMaster2PORec.SetRange("Style No.", PendingAllocation2Rec."Style No");
                    //     StyleMaster2PORec.SetRange("Lot No.", PendingAllocation2Rec.Lot);

                    //     if StyleMaster2PORec.FindSet() then begin
                    //         if PendingAllocation2Rec."PO No" <> StyleMaster2PORec."PO No." then begin
                    //             PendingAllocation2Rec."PO No" := StyleMaster2PORec."PO No.";
                    //             PendingAllocation2Rec.Modify(true);
                    //         end;

                    //         if PendingAllocation2Rec."PO Qty" <> StyleMaster2PORec.Qty then begin
                    //             PendingAllocation2Rec."PO Qty" := StyleMaster2PORec.Qty;
                    //             PendingAllocation2Rec.Modify(true);
                    //         end;
                    //     end;

                    //     NavAppProdDetailRec.Reset();
                    //     NavAppProdDetailRec.SetRange("PO No.", Rec."PO No");
                    //     NavAppProdDetailRec.SetRange("Style No.", Rec."Style No");
                    //     NavAppProdDetailRec.SetRange("Lot No.", Rec.Lot);
                    //     NavAppProdDetailRec.SetCurrentKey(PlanDate);
                    //     NavAppProdDetailRec.Ascending(true);

                    //     if NavAppProdDetailRec.FindFirst() then begin

                    //         if NavAppProdDetailRec.PlanDate <> rec."Plan Start Date" then begin
                    //             PendingAllocation2Rec."Plan Start Date" := NavAppProdDetailRec.PlanDate;
                    //             PendingAllocation2Rec.Modify(true);
                    //         end;

                    //     end;

                    //     NavAppProdDetailRec.Reset();
                    //     NavAppProdDetailRec.SetRange("PO No.", Rec."PO No");
                    //     NavAppProdDetailRec.SetRange("Style No.", Rec."Style No");
                    //     NavAppProdDetailRec.SetRange("Lot No.", Rec.Lot);
                    //     NavAppProdDetailRec.SetCurrentKey(PlanDate);
                    //     NavAppProdDetailRec.Ascending(true);

                    //     if NavAppProdDetailRec.FindLast() then begin

                    //         if NavAppProdDetailRec."Factory No." <> Rec."Sewing Factory Code" then begin
                    //             PendingAllocation2Rec."Sewing Factory Code" := NavAppProdDetailRec."Factory No.";
                    //             PendingAllocation2Rec.Modify(true);

                    //             LocationRec.Reset();
                    //             LocationRec.SetRange(Code, NavAppProdDetailRec."Factory No.");
                    //             if LocationRec.FindSet() then begin
                    //                 PendingAllocationRec."Sewing Factory Name" := LocationRec.Name;
                    //                 PendingAllocation2Rec.Modify(true);
                    //             end;


                    //         end;

                    //         if NavAppProdDetailRec.PlanDate <> rec."Plan End Date" then begin
                    //             PendingAllocation2Rec."Plan End Date" := NavAppProdDetailRec.PlanDate;
                    //             PendingAllocation2Rec.Modify(true);
                    //         end;
                    //     end;

                    //     NavAppProdDetailRec.Reset();
                    //     NavAppProdDetailRec.SetRange("Style No.", StyleMasterPORec."Style No.");
                    //     NavAppProdDetailRec.SetRange("PO No.", StyleMasterPORec."PO No.");
                    //     NavAppProdDetailRec.SetRange("Lot No.", StyleMasterPORec."Lot No.");

                    //     MaxTartget := 0;

                    //     if NavAppProdDetailRec.FindFirst() then begin
                    //         PendingAllocationRec."Sewing Factory Code" := NavAppProdDetailRec."Factory No.";

                    //         repeat
                    //             if NavAppProdDetailRec.Target > MaxTartget then
                    //                 MaxTartget := NavAppProdDetailRec.Target;
                    //         until NavAppProdDetailRec.Next() = 0;

                    //         if MaxTartget <> Rec."Plan Max Target" then begin
                    //             PendingAllocation2Rec."Plan Max Target" := MaxTartget;
                    //             PendingAllocation2Rec.Modify(true);
                    //         end;
                    //     end;


                    // end;
                end;
            until StyleMasterPORec.Next() = 0;
        end;
    end;
}