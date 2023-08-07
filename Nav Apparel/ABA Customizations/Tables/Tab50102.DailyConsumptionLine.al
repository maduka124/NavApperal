table 50102 "Daily Consumption Line"
{
    Caption = 'Daily Consumption Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Order Quantity"; Decimal)
        {
            Caption = 'Order Quantity';
            DataClassification = ToBeClassified;
        }
        field(7; "Daily Consumption"; Decimal)
        {
            Caption = 'Daily Consumption';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Daily Consumption" > "Balance Quantity" then
                    Error('Required Qty. must not be greater than balance qty.');
            end;
        }
        field(8; "prod. Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
            DataClassification = ToBeClassified;
        }
        field(9; "Issued Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Balance Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Main Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(12; "Main Category Name"; Text[50])
        {
            Caption = 'Main Category';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                MainCatRec: Record "Main Category";
            begin
                MainCatRec.Reset();
                MainCatRec.SetRange("Main Category Name", "Main Category Name");
                if MainCatRec.FindSet() then
                    "Main Category" := MainCatRec."No."
                else
                    Error('Invalid Main Category Name');
            end;


            trigger OnLookup()
            var
                ProdOrdComp: Record "Prod. Order Component";
                MainCatFilter: Record "Main Category Filter";
                ProdOrder: Record "Production Order";
                MainCat: Record "Main Category";
                DailyConsumpLineRec: record "Daily Consumption Header";
            begin
                MainCatFilter.Reset();
                MainCatFilter.DeleteAll();

                DailyConsumpLineRec.Reset();
                DailyConsumpLineRec.SetRange("No.", rec."Document No.");
                DailyConsumpLineRec.FindSet();

                ProdOrder.Reset();
                ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                ProdOrder.SetRange(BuyerCode, DailyConsumpLineRec."Buyer Code");
                ProdOrder.SetRange("Style Name", DailyConsumpLineRec."Style Name");
                ProdOrder.SetRange(PO, DailyConsumpLineRec.PO);
                if ProdOrder.FindFirst() then begin
                    ProdOrdComp.Reset();
                    ProdOrdComp.SetRange("Prod. Order No.", ProdOrder."No.");
                    ProdOrdComp.SetRange(Status, ProdOrder.Status);
                    if ProdOrdComp.FindFirst() then begin
                        repeat
                            if not MainCatFilter.Get(ProdOrdComp."Item Cat. Code") then begin
                                MainCatFilter.Init();
                                MainCatFilter.Code := ProdOrdComp."Item Cat. Code";
                                if MainCat.Get(MainCatFilter.Code) then
                                    MainCatFilter.Name := MainCat."Main Category Name";
                                MainCatFilter.Insert();
                            end;
                        until ProdOrdComp.Next() = 0;
                    end;
                end;

                Commit();
                if Page.RunModal(50118, MainCatFilter) = Action::LookupOK then begin
                    "Main Category" := MainCatFilter.Code;
                    "Main Category Name" := MainCatFilter.Name;
                end
            end;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
