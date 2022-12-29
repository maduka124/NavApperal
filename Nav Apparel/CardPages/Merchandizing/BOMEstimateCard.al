page 50985 "BOM Estimate Card"
{
    PageType = Card;
    SourceTable = "BOM Estimate";
    Caption = 'Estimate BOM';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = EditableGB;

                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Estimate BOM No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        CustomerRec: Record Customer;
                        BOMRec: Record "BOM Estimate";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;


                        //Check for duplicates
                        BOMRec.Reset();
                        BOMRec.SetRange("Style Name", rec."Style Name");
                        if BOMRec.FindSet() then
                            Error('Style : %1 already used to create an Estimate BOM ', BOMRec."Style Name");

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasterRec.FindSet() then
                            rec."Style No." := StyleMasterRec."No.";

                        CurrPage.Update();

                        StyleMasterRec.get(rec."Style No.");
                        rec."Style Name" := StyleMasterRec."Style No.";
                        rec."Store No." := StyleMasterRec."Store No.";
                        rec."Brand No." := StyleMasterRec."Brand No.";
                        rec."Buyer No." := StyleMasterRec."Buyer No.";
                        rec."Season No." := StyleMasterRec."Season No.";
                        rec."Department No." := StyleMasterRec."Department No.";
                        rec."Garment Type No." := StyleMasterRec."Garment Type No.";

                        rec."Store Name" := StyleMasterRec."Store Name";
                        rec."Brand Name" := StyleMasterRec."Brand Name";
                        rec."Buyer Name" := StyleMasterRec."Buyer Name";
                        rec."Season Name" := StyleMasterRec."Season Name";
                        rec."Department Name" := StyleMasterRec."Department Name";
                        rec."Garment Type Name" := StyleMasterRec."Garment Type Name";
                        rec.Quantity := StyleMasterRec."Order Qty";

                        CustomerRec.get(rec."Buyer No.");
                        rec."Currency No." := CustomerRec."Currency Code";

                        //Assigh Estimate bom no to the style. (For "Copy BOM feature" purpose only)
                        StyleMasterRec.EstimateBOM := rec."No.";
                        StyleMasterRec.Modify();

                        CurrPage.Update();

                    end;
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';

                    trigger OnValidate()
                    var
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", rec."Store Name");
                        if GarmentStoreRec.FindSet() then
                            rec."Store No." := GarmentStoreRec."No.";
                    end;
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';

                    trigger OnValidate()
                    var
                        BrandRec: Record "Brand";
                    begin
                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", rec."Brand Name");
                        if BrandRec.FindSet() then
                            rec."Brand No." := BrandRec."No.";
                    end;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, rec."Buyer Name");
                        if BuyerRec.FindSet() then begin
                            rec."Buyer No." := BuyerRec."No.";
                            rec."Currency No." := BuyerRec."Currency Code";
                        end;
                    end;
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';

                    trigger OnValidate()
                    var
                        SeasonsRec: Record "Seasons";
                    begin
                        SeasonsRec.Reset();
                        SeasonsRec.SetRange("Season Name", rec."Season Name");
                        if SeasonsRec.FindSet() then
                            rec."Season No." := SeasonsRec."No.";
                    end;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department Style";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", rec."Department Name");
                        if DepartmentRec.FindSet() then
                            rec."Department No." := DepartmentRec."No.";
                    end;
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';

                    trigger OnValidate()
                    var
                        GarmentTypeRec: Record "Garment Type";
                    begin
                        GarmentTypeRec.Reset();
                        GarmentTypeRec.SetRange("Garment Type Description", rec."Garment Type Name");
                        if GarmentTypeRec.FindSet() then
                            rec."Garment Type No." := GarmentTypeRec."No.";
                    end;
                }

                // field(Revision; Revision)
                // {
                //     ApplicationArea = All;
                // }

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BOMEstLineRec: Record "BOM Estimate Line";
                        ConvFactor: Decimal;
                        UOMRec: Record "Unit of Measure";
                        x: Integer;
                        Total: Decimal;
                    begin

                        Total := 0;
                        BOMEstLineRec.Reset();
                        BOMEstLineRec.SetRange("No.", rec."No.");
                        if BOMEstLineRec.FindSet() then begin

                            repeat
                                BOMEstLineRec.qty := rec.Quantity;

                                UOMRec.Reset();
                                UOMRec.SetRange(Code, BOMEstLineRec."Unit N0.");
                                if UOMRec.FindSet() then
                                    ConvFactor := UOMRec."Converion Parameter";

                                if BOMEstLineRec.Type = BOMEstLineRec.type::Pcs then
                                    BOMEstLineRec.Requirment := (BOMEstLineRec.Consumption * rec.Quantity) + (BOMEstLineRec.Consumption * rec.Quantity) * BOMEstLineRec.WST / 100
                                else
                                    if BOMEstLineRec.Type = BOMEstLineRec.type::Doz then
                                        BOMEstLineRec.Requirment := ((BOMEstLineRec.Consumption * rec.Quantity) + (BOMEstLineRec.Consumption * rec.Quantity) * BOMEstLineRec.WST / 100) / 12;

                                if (x = 0) and (ConvFactor <> 0) then
                                    BOMEstLineRec.Requirment := BOMEstLineRec.Requirment / ConvFactor;

                                BOMEstLineRec.Requirment := Round(BOMEstLineRec.Requirment, 1);
                                BOMEstLineRec.Value := BOMEstLineRec.Requirment * BOMEstLineRec.Rate;
                                Total += BOMEstLineRec.Value;

                                BOMEstLineRec.Modify();

                            until BOMEstLineRec.Next() = 0;

                            if rec.Quantity <> 0 then
                                rec."Material Cost Pcs." := (Total / rec.Quantity);

                            rec."Material Cost Doz." := rec."Material Cost Pcs." * 12;
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Currency No."; rec."Currency No.")
                {
                    ApplicationArea = All;
                    Caption = 'Currency';
                }

                field("Material Cost Doz."; rec."Material Cost Doz.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Material Cost Pcs."; rec."Material Cost Pcs.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(" ")
            {
                Editable = EditableGB;

                part("BOM Estimate Line List part"; "BOM Estimate Line List part")
                {
                    ApplicationArea = All;
                    Caption = 'Line Items';
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }

        area(FactBoxes)
        {
            part(MyFactBox; "BOM Picture FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Style No.");
                Caption = ' ';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                ApplicationArea = All;
                Image = Calculate;

                trigger OnAction()
                var
                    BOMEstLineRec: Record "BOM Estimate Line";
                    ConvFactor: Decimal;
                    UOMRec: Record "Unit of Measure";
                    Total: Decimal;
                begin

                    if rec.Quantity = 0 then
                        Error('Quantity is zero. Cannot proceed.');

                    Total := 0;
                    BOMEstLineRec.Reset();
                    BOMEstLineRec.SetCurrentKey("No.");
                    BOMEstLineRec.SetRange("No.", rec."No.");

                    IF (BOMEstLineRec.FINDSET) THEN
                        repeat

                            ConvFactor := 0;
                            UOMRec.Reset();
                            UOMRec.SetRange(Code, BOMEstLineRec."Unit N0.");
                            if UOMRec.FindSet() then
                                ConvFactor := UOMRec."Converion Parameter";

                            // if BOMEstLineRec.Type = BOMEstLineRec.Type::Pcs then
                            //     if BOMEstLineRec.AjstReq = 0 then
                            //         BOMEstLineRec.WST := (100 * BOMEstLineRec.Requirment) / (BOMEstLineRec.Qty * BOMEstLineRec.Consumption) - 100
                            //     else
                            //         BOMEstLineRec.WST := (100 * BOMEstLineRec.AjstReq) / (BOMEstLineRec.Qty * BOMEstLineRec.Consumption) - 100
                            // else
                            //     if BOMEstLineRec.Type = BOMEstLineRec.Type::Doz then
                            //         if BOMEstLineRec.AjstReq = 0 then
                            //             BOMEstLineRec.WST := (100 * BOMEstLineRec.Requirment * 12) / (BOMEstLineRec.Qty * BOMEstLineRec.Consumption) - 100
                            //         else
                            //             BOMEstLineRec.WST := (100 * BOMEstLineRec.AjstReq * 12) / (BOMEstLineRec.Qty * BOMEstLineRec.Consumption) - 100;


                            if BOMEstLineRec.Type = BOMEstLineRec.Type::Pcs then
                                BOMEstLineRec.Requirment := (BOMEstLineRec.Consumption * BOMEstLineRec.Qty) + (BOMEstLineRec.Qty * BOMEstLineRec.Consumption) * BOMEstLineRec.WST / 100
                            else
                                if BOMEstLineRec.Type = BOMEstLineRec.Type::Doz then
                                    BOMEstLineRec.Requirment := ((BOMEstLineRec.Consumption * BOMEstLineRec.Qty) + (BOMEstLineRec.Qty * BOMEstLineRec.Consumption) * BOMEstLineRec.WST / 100) / 12;

                            //BOMEstLineRec.Requirment := Round(BOMEstLineRec.Requirment, 1);

                            if ConvFactor <> 0 then
                                BOMEstLineRec.Requirment := BOMEstLineRec.Requirment / ConvFactor;

                            if BOMEstLineRec.Requirment = 0 then
                                BOMEstLineRec.Requirment := 1;

                            BOMEstLineRec.Value := BOMEstLineRec.Requirment * BOMEstLineRec.Rate;
                            Total += BOMEstLineRec.Value;
                            BOMEstLineRec.Modify();

                        until BOMEstLineRec.Next() = 0;

                    rec."Material Cost Pcs." := (Total / rec.Quantity);
                    rec."Material Cost Doz." := rec."Material Cost Pcs." * 12;
                    CurrPage.Update();

                    Message('Calculation completed');

                end;
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BOM Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BOMEstimateRec: Record "BOM Estimate";
        BOMLineEstRec: Record "BOM Estimate Line";
        StyleMas: Record "Style Master";
    begin
        BOMEstimateRec.SetRange("No.", rec."No.");
        BOMEstimateRec.DeleteAll();

        BOMLineEstRec.SetRange("No.", rec."No.");
        BOMLineEstRec.DeleteAll();

        StyleMas.Reset();
        StyleMas.SetRange("No.", rec."Style No.");
        StyleMas.FindSet();
        StyleMas.ModifyAll(EstimateBOM, '');

    end;

    trigger OnClosePage()
    var
        BOMEstLineRec: Record "BOM Estimate Line";
    begin
        BOMEstLineRec.Reset();
        BOMEstLineRec.SetRange("No.", rec."No.");
        if BOMEstLineRec.FindSet() then begin
            repeat
                if BOMEstLineRec."Supplier No." = '' then
                    Error('Suppler is mandatory.');

            until BOMEstLineRec.Next() = 0;

        end;

        if rec."Material Cost Doz." = 0 then
            Error('Material Cost Doz is not calculated.');

        if rec."Material Cost Pcs." = 0 then
            Error('Material Cost Pcs is not calculated.');

    end;


    trigger OnOpenPage()
    var
        EstCostRec: Record "BOM Estimate Cost";
    begin
        EditableGB := true;
        EstCostRec.Reset();
        EstCostRec.SetRange("BOM No.", rec."No.");
        if EstCostRec.FindSet() then begin
            if EstCostRec.Status = EstCostRec.Status::Approved then
                EditableGB := false;
        end;
    end;


    trigger OnAfterGetCurrRecord()
    var
        EstCostRec: Record "BOM Estimate Cost";
    begin
        EditableGB := true;
        EstCostRec.Reset();
        EstCostRec.SetRange("BOM No.", rec."No.");
        if EstCostRec.FindSet() then begin
            if EstCostRec.Status = EstCostRec.Status::Approved then
                EditableGB := false;
        end;
    end;


    var
        EditableGB: Boolean;
}