page 51427 "Allocated Style/PO For Wash"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashingMaster;
    SourceTableView = sorting("Plan Start Date");
    // order(descending) where("Wash Allocated" = filter(true))
    CardPageId = POWashAllocatedCard;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
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

                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Color Qty"; Rec."Color Qty")
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

                field("Cut Qty"; Rec."Cut Qty")
                {
                    ApplicationArea = All;
                }

                field("Sew Qty"; Rec."Sew Qty")
                {
                    ApplicationArea = All;
                }

                field("Washing Plant"; Rec."Washing Plant")
                {
                    ApplicationArea = All;
                }

                field("Wash Type"; Rec."Wash Type")
                {
                    ApplicationArea = All;
                }

                field(Recipe; Rec.Recipe)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        LocationRec: Record Location;
        StylemasterPORec: Record "Style Master PO";
        ProductioOutLineRec: Record ProductionOutLine;
        AssortmentDetailsRec: Record AssorColorSizeRatio;
        NavAppProdDetailRec: Record "NavApp Prod Plans Details";
        MaxTartget: BigInteger;
        Total: BigInteger;

    begin

        //Cut Qty;
        Total := 0;

        ProductioOutLineRec.Reset();
        ProductioOutLineRec.SetRange(Type, ProductioOutLineRec.Type::Cut);
        ProductioOutLineRec.SetRange("Style No.", Rec."Style No");
        ProductioOutLineRec.SetRange("PO No.", Rec."PO No");
        ProductioOutLineRec.SetRange("Lot No.", Rec.Lot);
        ProductioOutLineRec.SetRange("Colour Name", Rec."Color Name");
        ProductioOutLineRec.SetRange(In_Out, 'OUT');

        if ProductioOutLineRec.FindSet() then begin
            repeat
                Total += ProductioOutLineRec.Total;
            until ProductioOutLineRec.Next() = 0;
            Rec."Cut Qty" := Total;
            Rec.Modify(true);
        end;

        //Sew Qty
        Total := 0;

        ProductioOutLineRec.Reset();
        ProductioOutLineRec.SetRange(Type, ProductioOutLineRec.Type::Saw);
        ProductioOutLineRec.SetRange("Style No.", Rec."Style No");
        ProductioOutLineRec.SetRange("PO No.", Rec."PO No");
        ProductioOutLineRec.SetRange("Lot No.", Rec.Lot);
        ProductioOutLineRec.SetRange("Colour Name", Rec."Color Name");
        ProductioOutLineRec.SetRange(In_Out, 'OUT');

        if ProductioOutLineRec.FindSet() then begin
            repeat
                Total += ProductioOutLineRec.Total;
            until ProductioOutLineRec.Next() = 0;
            Rec."Sew Qty" := Total;
            Rec.Modify(true);
        end;

        //Get Max target and Sewfactory
        MaxTartget := 0;

        NavAppProdDetailRec.Reset();
        NavAppProdDetailRec.SetRange("Style No.", Rec."Style No");
        NavAppProdDetailRec.SetRange("PO No.", Rec."PO No");
        NavAppProdDetailRec.SetRange("Lot No.", Rec.Lot);

        if NavAppProdDetailRec.FindFirst() then begin
            Rec."Sewing Factory Code" := NavAppProdDetailRec."Factory No.";
            Rec.Modify(true);

            repeat
                if NavAppProdDetailRec.Target > MaxTartget then
                    MaxTartget := NavAppProdDetailRec.Target;
            until NavAppProdDetailRec.Next() = 0;
        end;

        Rec."Plan Max Target" := MaxTartget;
        Rec.Modify(true);

        LocationRec.Reset();
        LocationRec.SetRange(Code, NavAppProdDetailRec."Factory No.");
        if LocationRec.FindSet() then begin
            Rec."Sewing Factory Name" := LocationRec.Name;
            Rec.Modify(true);
        end;

        //Get plan Start Date
        NavAppProdDetailRec.Reset();
        NavAppProdDetailRec.SetRange("Style No.", Rec."Style No");
        NavAppProdDetailRec.SetRange("PO No.", Rec."PO No");
        NavAppProdDetailRec.SetRange("Lot No.", Rec.Lot);
        NavAppProdDetailRec.SetCurrentKey(PlanDate);
        NavAppProdDetailRec.Ascending(true);

        if NavAppProdDetailRec.FindFirst() then begin
            Rec."Plan Start Date" := NavAppProdDetailRec.PlanDate;
            Rec.Modify(true);
        end;

        //Get Last Plan Date
        NavAppProdDetailRec.Reset();
        NavAppProdDetailRec.SetRange("Style No.", Rec."Style No");
        NavAppProdDetailRec.SetRange("PO No.", Rec."PO No");
        NavAppProdDetailRec.SetRange("Lot No.", Rec.Lot);
        NavAppProdDetailRec.SetCurrentKey(PlanDate);
        NavAppProdDetailRec.Ascending(true);

        if NavAppProdDetailRec.FindLast() then begin
            Rec."Plan End Date" := NavAppProdDetailRec.PlanDate;
            Rec.Modify(true);
        end;

        //Get Ship Date
        StylemasterPORec.Reset();
        StylemasterPORec.SetRange("Style No.", Rec."Style No");
        StylemasterPORec.SetRange("PO No.", Rec."PO No");
        StylemasterPORec.SetRange("Lot No.", Rec.Lot);

        if StylemasterPORec.FindSet() then begin
            Rec."Shipment Date" := StylemasterPORec."Ship Date";
            Rec.Modify(true);
        end;

        //Color Qty
        AssortmentDetailsRec.Reset();
        AssortmentDetailsRec.SetRange("Style No.", Rec."Style No");
        AssortmentDetailsRec.SetRange("Lot No.", Rec.Lot);
        AssortmentDetailsRec.SetRange("PO No.", Rec."PO No");
        AssortmentDetailsRec.SetRange("Colour Name", Rec."Color Name");

        if AssortmentDetailsRec.FindSet() then begin
            Rec."Color Qty" := AssortmentDetailsRec.Total;
            Rec.Modify(true);
        end;




    end;
}