report 50631 TransferOrderCardPageReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Transfer Order Report';
    RDLCLayout = 'Report_Layouts/Warehouse/TransferOrder.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = sorting("No.");
            column(No_; "No.")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(SystemCreatedBy; "Created User")
            { }
            column(Style_No_; "Style No.")
            { }
            column(StyleName; StyleName)
            { }
            column(BuyerName; BuyerName)
            { }
            column(garmentTypeName; garmentTypeName)
            { }
            column(TransferFrom; "Transfer-from Name")
            { }
            column(TransfeTo; "Transfer-to Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(PoQty; PoQty)
            { }
            column(PONo; PONo)
            { }
            column(PO; PO)
            { }
            //     column(po)
            // { }
            //     column()
            // { }
            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLinkReference = "Transfer Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(Item_No_; "Item No.")
                { }
                column(Description; Description)
                { }
                column(Unit_of_Measure; "Unit of Measure")
                { }
                column(Quantity; Quantity)
                { }
                column(ItemColor; ItemColor)
                { }
                //     column()
                // { }
                //     column()
                // { }
                //     column()
                // { }

                trigger OnAfterGetRecord()

                begin
                    ItemRec.SetRange("No.", "Item No.");
                    if ItemRec.FindFirst() then begin
                        ItemColor := ItemRec."Color Name";
                    end;
                end;

            }
            dataitem("Production Order"; "Production Order")
            {
                DataItemLinkReference = "Transfer Header";
                DataItemLink = PO = field(PO);
                DataItemTableView = sorting("Source No.");

                column(Planned_Order_No_; "No.")
                { }
                // column(PO; PO)
                // { }
                // column()
                // { }
                dataitem("Prod. Order Line"; "Prod. Order Line")
                {
                    DataItemLinkReference = "Production Order";
                    DataItemLink = "Prod. Order No." = field("No.");
                    DataItemTableView = sorting("Prod. Order No.", "Line No.", Status);

                    column(Quantityprodline; Quantity)
                    { }
                }
            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    StyleName := StyleRec."Style No.";
                    BuyerName := StyleRec."Buyer Name";
                    garmentTypeName := StyleRec."Garment Type Name";
                end;

                // po.SetRange("Style No.", "Style No.");
                // if StylePoRec.FindFirst() then begin
                //     PoQty := StylePoRec.Qty;
                //     PONo := StylePoRec."PO No.";
                // end;
                // locationRec.Reset();
                // locationRec.SetRange(Code, "Transfer-from Code");
                // if locationRec.FindFirst() then begin
                //     TransferFrom := locationRec.Address;
                // end;
                // locationRec2.Reset();
                // locationRec2.SetRange(Code, "Transfer-to Code");
                // if locationRec2.FindFirst() then begin
                //     TransfeTo := locationRec2.Address;
                // end;


                // UserRec.Reset();
                // //UserRec.SetRange("User Security ID", SystemCreatedBy);
                // UserRec.SetFilter("User Security ID", '=%1', SystemCreatedBy);
                // if UserRec.Findset() then begin
                //     UserName := UserRec."User Name";
                // end;

            end;

            // end;

            trigger OnPreDataItem()

            begin
                SetRange("No.", TransferOrderFilter);
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
                    field(TransferOrderFilter; TransferOrderFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Transfer Order No';
                        Editable = false;
                        // TableRelation = "Transfer Header"."No.";

                    }
                }
            }
        }
    }

    procedure Set_Value(TransferOrderFil: Code[20])
    var
    begin
        TransferOrderFilter := TransferOrderFil;
    end;




    var
        // TransferFromFilter: Code[20];
        // TransferTo: Code[20];
        UserName: Code[50];
        UserRec: Record User;
        TransferOrderFilter: Code[20];
        comRec: Record "Company Information";
        StyleRec: Record "Style Master";
        StyleName: Text[50];
        BuyerName: Text[50];
        garmentTypeName: Text[50];

        ItemRec: Record Item;
        locationRec: Record Location;
        locationRec2: Record Location;
        TransferFrom: Text[100];
        TransfeTo: Text[100];
        ItemColor: Text[50];
        ProductionRec: Record "Production Order";
        PONo: Code[20];
        PoQty: BigInteger;


}