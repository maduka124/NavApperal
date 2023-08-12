report 51385 EnventoryDayBook
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Inventory Day Book';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/Store/EnventoryDayBook.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.") where("Entry Type" = filter(Consumption));

            column(Main_Category_Name; "Main Category Name")
            { }
            column(MainCategoryName; MainCategoryName)
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }

            // column(Description; Description)
            // { }

            column(Quantity; Quantity * -1)
            { }
            column(UOM; UOM)
            { }
            column(DescriptionRec; DescriptionRec)
            { }
            column(GRNQTY; GRNQTY)
            { }
            column(UnitPrice; UnitPrice)
            { }
            column(StartDate; StartDate)
            { }
            column(EndDate; EndDate)
            { }
            column(Factory; Factory)
            { }
            column(ReorderLevel; ReorderLevel)
            { }
            column(ReorderQty; ReorderQty)
            { }
            column(CompLogo; comRec.Picture)
            { }

            trigger OnPreDataItem()
            begin

                if StartDate = 0D then
                    Error('Invalid Start Date');

                if Factory = '' then
                    Error('Invalid Factory');

                if EndDate = 0D then begin
                    SetRange("Posting Date", StartDate);
                    SetRange("Location Code", Factory);
                end
                else begin
                    SetRange("Posting Date", StartDate, EndDate);
                    SetRange("Location Code", Factory);
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                UOM := '';
                DescriptionRec := '';
                GRNQTY := 0;

                comRec.Get;
                comRec.CalcFields(Picture);

                if EndDate = 0D then begin
                    GRNLineRec.Reset();
                    GRNLineRec.SetRange("Posting Date", StartDate);
                    GRNLineRec.SetRange("Location Code", Factory);
                    GRNLineRec.SetFilter(Type, '=%1', GRNLineRec.Type::Item);
                    GRNLineRec.SetRange("No.", "Item Ledger Entry"."Item No.");

                    if GRNLineRec.FindFirst() then
                        repeat
                            ItemRec.Get(GRNLineRec."No.");

                            GRNQTY := GRNQTY + GRNLineRec.Quantity;
                            UOM := ItemRec."Base Unit of Measure";
                            DescriptionRec := ItemRec.Description;
                            ReorderLevel := ItemRec."Reorder Point";
                            ReorderQty := ItemRec."Reorder Quantity";
                            UnitPrice := ItemRec."Unit Price";

                        until GRNLineRec.Next() = 0
                    else begin

                        ItemRec1.Get("Item Ledger Entry"."Item No.");

                        UOM := ItemRec1."Base Unit of Measure";
                        DescriptionRec := ItemRec1.Description;
                        ReorderLevel := ItemRec1."Reorder Point";
                        ReorderQty := ItemRec1."Reorder Quantity";
                        UnitPrice := ItemRec1."Unit Price";
                    end;
                end
                else begin
                    GRNLineRec.Reset();
                    GRNLineRec.SetRange("Posting Date", StartDate, EndDate);
                    GRNLineRec.SetRange("Location Code", Factory);
                    GRNLineRec.SetRange("No.", "Item Ledger Entry"."Item No.");
                    GRNLineRec.SetFilter(Type, '=%1', GRNLineRec.Type::Item);

                    if GRNLineRec.FindSet() then
                        repeat
                            ItemRec.Get(GRNLineRec."No.");

                            GRNQTY := GRNQTY + GRNLineRec.Quantity;
                            UOM := ItemRec."Base Unit of Measure";
                            DescriptionRec := ItemRec.Description;
                            ReorderLevel := ItemRec."Reorder Point";
                            ReorderQty := ItemRec."Reorder Quantity";
                            UnitPrice := ItemRec."Unit Price";

                        until GRNLineRec.Next() = 0

                    else begin
                        ItemRec1.Get("Item Ledger Entry"."Item No.");

                        UOM := ItemRec1."Base Unit of Measure";
                        DescriptionRec := ItemRec1.Description;
                        ReorderLevel := ItemRec1."Reorder Point";
                        ReorderQty := ItemRec1."Reorder Quantity";
                        UnitPrice := ItemRec1."Unit Price";
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

                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                        trigger OnValidate()
                        begin
                            if EndDate <> 0D then begin
                                if StartDate > EndDate then
                                    Error('Start Date should Be grater than end date');
                            end;
                        end;
                    }

                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';

                        trigger OnValidate()
                        begin
                            if StartDate > EndDate then
                                Error('Start Date should Be grater than end date');
                        end;
                    }

                    field(Factory; Factory)
                    {
                        ApplicationArea = All;
                        TableRelation = Location.Code;
                        Caption = 'Factory';
                        ShowMandatory = true;
                    }
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        Factory: Code[20];
        GRNLineRec: Record "Purch. Rcpt. Line";
        ItemRec: Record Item;
        GRNQTY: Integer;
        DescriptionRec: Text[200];
        UOM: Code[20];
        UnitPrice: Decimal;
        ReorderLevel: Integer;
        ReorderQty: Integer;
        ItemRec1: Record Item;
        comRec: Record "Company Information";
}