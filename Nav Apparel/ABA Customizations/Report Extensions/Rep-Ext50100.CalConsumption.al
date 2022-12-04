reportextension 50879 CalConsumption extends "Calc. Consumption"
{
    dataset
    {
        modify("Production Order")
        {
            // RequestFilterFields = Buyer, "Style Name", PO;
            trigger OnBeforePreDataItem()
            begin
                if BuyerFilter <> '' then
                    SetRange(Buyer, BuyerFilter);

                if StyleFilter <> '' then
                    SetRange("Style Name", StyleFilter);

                if PoFilter <> '' then
                    SetRange(PO, PoFilter);

                if ProdOrderFilter <> '' then
                    SetRange("No.", ProdOrderFilter);
            end;
        }
        modify("Prod. Order Component")
        {
            trigger OnBeforePreDataItem()
            begin
                if FilterCat <> '' then
                    SetRange("Invent. Posting Group", FilterCat);

            end;
        }
    }
    requestpage
    {
        layout
        {
            addlast(content)
            {
                field(BuyerFilter; BuyerFilter)
                {
                    Caption = 'Buyer Name';
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustRec: Record Customer;
                    begin
                        CustRec.Reset();
                        if Page.RunModal(22, CustRec) = Action::LookupOK then
                            BuyerFilter := CustRec.Name;
                    end;
                }
                field(StyleFilter; StyleFilter)
                {
                    Caption = 'Style';
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        if BuyerFilter = '' then
                            Error('Buyer name must have a value');

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Buyer Name", BuyerFilter);
                        if Page.RunModal(71012729, StyleMasterRec) = Action::LookupOK then
                            StyleFilter := StyleMasterRec."Style No.";
                    end;
                }
                field(PoFilter; PoFilter)
                {
                    Caption = 'PO';
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ProdOrd: Record "Production Order";
                    begin
                        if BuyerFilter = '' then
                            Error('Buyer name must have a value');

                        if StyleFilter = '' then
                            Error('Style name must have a value');

                        ProdOrd.Reset();
                        ProdOrd.SetRange(Status, ProdOrd.Status::Released);
                        ProdOrd.SetRange(Buyer, BuyerFilter);
                        ProdOrd.SetRange("Style Name", StyleFilter);
                        if Page.RunModal(99000815, ProdOrd) = Action::LookupOK then begin
                            PoFilter := ProdOrd.PO;
                            ProdOrderFilter := ProdOrd."No.";
                        end;
                    end;
                }
                field(ProdOrderFilter; ProdOrderFilter)
                {
                    Caption = 'Prod. Order No.';
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ProdOrd: Record "Production Order";
                    begin
                        if BuyerFilter = '' then
                            Error('Buyer name must have a value');

                        if StyleFilter = '' then
                            Error('Style must have a value');

                        if PoFilter = '' then
                            Error('PO must have a value');

                        ProdOrd.Reset();
                        ProdOrd.SetRange(Status, ProdOrd.Status::Released);
                        ProdOrd.SetRange(Buyer, BuyerFilter);
                        ProdOrd.SetRange("Style Name", StyleFilter);
                        ProdOrd.SetRange(PO, PoFilter);
                        if Page.RunModal(99000815, ProdOrd) = Action::LookupOK then
                            ProdOrderFilter := ProdOrd."No.";
                    end;
                }
            }
        }
    }
    procedure SetItemCat(GetItemCat: Code[20])
    begin
        FilterCat := GetItemCat;
    end;

    var
        FilterCat: Code[20];
        BuyerFilter: Text[100];
        StyleFilter: Code[20];
        PoFilter: Code[20];
        ProdOrderFilter: Code[20];

}
