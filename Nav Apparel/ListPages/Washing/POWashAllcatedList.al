page 51427 "Allocated Style/PO For Wash"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashingMaster;
    SourceTableView = sorting("Plan Start Date");
    // order(descending) where("Wash Allocated" = filter(true)) where("Wash Close/Open" = filter(true))
    CardPageId = POWashAllocatedCard;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

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

                field("Washing Plant"; Rec."Washing Plant")
                {
                    ApplicationArea = All;
                }

                field("Wash Type"; Rec."Wash Type")
                {
                    ApplicationArea = All;
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

                field("Received Qty"; Rec."Received Qty")
                {
                    ApplicationArea = all;
                }

                field(Recipe; Rec.Recipe)
                {
                    ApplicationArea = All;
                }

                field("First Received Date"; Rec."First Received Date")
                {
                    ApplicationArea = All;
                }

                field("Last Received Date"; Rec."Last Received Date")
                {
                    ApplicationArea = All;
                }

                field("Plan Date"; Rec."Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Actual Date"; Rec."Actual Date")
                {
                    ApplicationArea = All;
                }

                field("Close Plan Date"; Rec."Close Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Close Actual Plan Date"; Rec."Close Actual Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Delivery Qty"; Rec."Delivery Qty")
                {
                    ApplicationArea = All;
                }

                field("Delivery Start Date"; Rec."Delivery Start Date")
                {
                    ApplicationArea = All;
                }

                field("Delivery End Date"; Rec."Delivery End Date")
                {
                    ApplicationArea = All;
                }

                field("SMV WHISKERS"; Rec."SMV WHISKERS")
                {
                    ApplicationArea = All;
                }

                field("SMV BRUSH"; Rec."SMV BRUSH")
                {
                    ApplicationArea = All;
                }

                field("SMV BASE WASH"; Rec."SMV BASE WASH")
                {
                    ApplicationArea = All;
                }

                field("SMV FINAL WASH"; Rec."SMV FINAL WASH")
                {
                    ApplicationArea = All;
                }

                field("SMV ACID/ RANDOM WASH"; Rec."SMV ACID/ RANDOM WASH")
                {
                    ApplicationArea = All;
                }

                field("SMV PP SPRAY"; Rec."SMV PP SPRAY")
                {
                    ApplicationArea = All;
                }

                field("SMV DESTROY"; Rec."SMV DESTROY")
                {
                    ApplicationArea = All;
                }

                field("SMV LASER WHISKERS"; Rec."SMV LASER WHISKERS")
                {
                    ApplicationArea = All;
                }

                field("SMV LASER BRUSH"; Rec."SMV LASER BRUSH")
                {
                    ApplicationArea = All;
                }

                field("SMV LASER DESTROY"; Rec."SMV LASER DESTROY")
                {
                    ApplicationArea = All;
                }


                field("Production WHISKERS"; Rec."Production WHISKERS")
                {
                    ApplicationArea = All;
                }

                field("Production BRUSH"; Rec."Production BRUSH")
                {
                    ApplicationArea = All;
                }

                field("Production BASE WASH"; Rec."Production BASE WASH")
                {
                    ApplicationArea = All;
                }

                field("Production FINAL WASH"; Rec."Production FINAL WASH")
                {
                    ApplicationArea = All;
                }

                field("Production ACID/ RANDOM WASH"; Rec."Production ACID/ RANDOM WASH")
                {
                    ApplicationArea = All;
                }

                field("Production PP SPRAY"; Rec."Production PP SPRAY")
                {
                    ApplicationArea = All;
                }

                field("Production DESTROY"; Rec."Production DESTROY")
                {
                    ApplicationArea = All;
                }

                field("Production LASER WHISKERS"; Rec."Production LASER WHISKERS")
                {
                    ApplicationArea = All;
                }

                field("Production LASER BRUSH"; Rec."Production LASER BRUSH")
                {
                    ApplicationArea = All;
                }

                field("Production LASER DESTROY"; Rec."Production LASER DESTROY")
                {
                    ApplicationArea = All;
                }

                field("Balance LASER DESTROY"; Rec."Balance LASER DESTROY")
                {
                    ApplicationArea = All;
                }

                field("Balance WHISKERS"; Rec."Balance WHISKERS")
                {
                    ApplicationArea = All;
                }

                field("Balance BRUSH"; Rec."Balance BRUSH")
                {
                    ApplicationArea = All;
                }

                field("Balance BASE WASH"; Rec."Balance BASE WASH")
                {
                    ApplicationArea = All;
                }

                field("Balance FINAL WASH"; Rec."Balance FINAL WASH")
                {
                    ApplicationArea = All;
                }

                field("Balance ACID/ RANDOM WASH"; Rec."Balance ACID/ RANDOM WASH")
                {
                    ApplicationArea = All;
                }

                field("Balance PP SPRAY"; Rec."Balance PP SPRAY")
                {
                    ApplicationArea = All;
                }

                field("Balance DESTROY"; Rec."Balance DESTROY")
                {
                    ApplicationArea = All;
                }

                field("Balance LASER WHISKERS"; Rec."Balance LASER WHISKERS")
                {
                    ApplicationArea = All;
                }

                field("Balance LASER BRUSH"; Rec."Balance LASER BRUSH")
                {
                    ApplicationArea = All;
                }

                field("Close Reject"; Rec."Close Reject")
                {
                    ApplicationArea = All;
                }

                field("Close Sample"; Rec."Close Sample")
                {
                    ApplicationArea = All;
                }

                field("Close Left Over"; Rec."Close Left Over")
                {
                    ApplicationArea = All;
                }

                field("Close Production Loss"; Rec."Close Production Loss")
                {
                    ApplicationArea = All;
                }

                field("Closing Status"; Rec."Closing Status")
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
        ProductionOutHeaderRec: Record ProductionOutHeader;
        NavAppProdDetailRec: Record "NavApp Prod Plans Details";
        MaxTartget: BigInteger;
        Total: BigInteger;

    begin

        //Cut Qty;
        Total := 0;

        ProductionOutHeaderRec.Reset();
        ProductionOutHeaderRec.SetRange(Type, ProductionOutHeaderRec.Type::Cut);
        ProductionOutHeaderRec.SetRange("Style No.", Rec."Style No");
        ProductionOutHeaderRec.SetRange("PO No", Rec."PO No");
        ProductionOutHeaderRec.SetRange("Lot No.", Rec.Lot);

        if ProductionOutHeaderRec.FindSet() then begin
            repeat
                ProductioOutLineRec.Reset();
                // ProductioOutLineRec.SetRange(Type, ProductioOutLineRec.Type::Cut);
                // ProductioOutLineRec.SetRange("Style No.", Rec."Style No");
                // ProductioOutLineRec.SetRange("PO No.", Rec."PO No");
                // ProductioOutLineRec.SetRange("Lot No.", Rec.Lot);
                ProductioOutLineRec.SetRange("No.", ProductionOutHeaderRec."No.");
                // ProductioOutLineRec.SetRange(In_Out, 'OUT');

                if ProductioOutLineRec.FindSet() then begin
                    repeat
                        if ProductioOutLineRec."Colour Name" = Rec."Color Name" then
                            Total += ProductioOutLineRec.Total;
                    until ProductioOutLineRec.Next() = 0;

                end;
            until ProductionOutHeaderRec.Next() = 0;
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

    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
        LocationRec: Record Location;
    begin

        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec."Factory Code" <> '' then begin
            LocationRec.Reset();

            LocationRec.SetRange(Code, UserRec."Factory Code");

            if LocationRec.FindSet() then begin
                rec.SetFilter("Washing Plant", '=%1', LocationRec.Name);
                Rec.SetFilter("Closing Status", '=%1', Rec."Closing Status"::Open);
            end;

        end;

    end;
}