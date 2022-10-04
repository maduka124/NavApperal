report 50644 ProductionOrderReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Production Order Report';
    RDLCLayout = 'Report_Layouts/Production/ProductionOrder.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            column(No_; "No.")
            { }
            column(Buyer; Buyer)
            { }
            column(Source_No_; "Source No.")
            { }
            column(Description; Description)
            { }
            column(Quantity; Quantity)
            { }
            column(Style_Name; styleName)
            { }
            column(PoNo; PoNo)
            { }
            column(Planned_Order_No_; "Planned Order No.")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            { }


            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLinkReference = "Production Order";
                DataItemLink = "Prod. Order No." = field("No.");
                DataItemTableView = sorting("Prod. Order No.");
                column(Item_No_; "Item No.")
                { }
                column(DescriptionLine; Description)
                { }
                column(QuantityLine; Quantity)
                { }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                { }
                column(Remaining_Quantity; "Remaining Quantity")
                { }
                column(Location_Code; "Location Code")
                { }
                //     column()
                // { }
                trigger OnPreDataItem()

                begin
                    SetRange("Item No.", ItemNo);
                end;
            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                SalesRec.SetRange("No.", "Source No.");
                if SalesRec.FindFirst() then begin
                    styleName := SalesRec."Style Name";
                    PoNo := SalesRec."PO No";
                end;
            end;

            trigger OnPreDataItem()

            begin
                SetRange("No.", ProdNo);
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
                    field(ProdNo; ProdNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Released Production Order No';
                        TableRelation = "Production Order"."No.";
                    }
                    field(ItemNo; ItemNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Item No';
                        TableRelation = Item."No.";
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

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
        comRec: Record "Company Information";
        SalesRec: Record "Sales Header";
        styleName: text[50];
        PoNo: Code[20];
        ProdNo: Code[20];
        ItemNo: Code[20];

}