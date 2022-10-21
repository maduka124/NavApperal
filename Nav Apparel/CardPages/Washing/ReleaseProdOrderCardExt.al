pageextension 50801 ReleaseProductionOrder extends "Released Production Order"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Prod Order Type"; "Prod Order Type")
            {
                ApplicationArea = all;
                Caption = 'Prod. Order Type';
            }


        }
        addafter("No.")
        {
            field(Buyer1; Buyer)
            {
                ApplicationArea = All;
                Caption = 'Buyer';

                trigger OnValidate()
                var
                    CustomerRec: Record Customer;
                begin
                    CustomerRec.Reset();
                    CustomerRec.SetRange(Name, Buyer);
                    if CustomerRec.FindSet() then
                        BuyerCode := CustomerRec."No.";
                end;
            }
            field("Style Name1"; "Style Name")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    StyleRec: Record "Style Master";

                begin

                    StyleRec.Reset();
                    StyleRec.SetRange("Style No.", "Style Name");
                    if StyleRec.FindSet() then
                        "Style No." := StyleRec."No.";
                end;
            }
            // field("Shortcut Dimension 1 Code1"; "Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Factory';
            // }
            field(PO1; PO)
            {
                ApplicationArea = all;
                Caption = 'PO';
            }

        }


        addafter(General)
        {
            group("Washing")
            {
                field(Buyer; Buyer)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, Buyer);
                        if CustomerRec.FindSet() then
                            BuyerCode := CustomerRec."No.";
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StyleRec: Record "Style Master";
                        AssoRec: Record AssorColorSizeRatio;
                        StyleColorRec: Record StyleColor;
                        Color: Code[20];
                    begin

                        StyleRec.Reset();
                        StyleRec.SetRange("Style No.", "Style Name");
                        if StyleRec.FindSet() then
                            "Style No." := StyleRec."No.";


                        CurrPage.Update();

                        //Deleet old recorsd
                        StyleColorRec.Reset();
                        StyleColorRec.SetRange("User ID", UserId);
                        if StyleColorRec.FindSet() then
                            StyleColorRec.DeleteAll();

                        //Get Colors for the style
                        AssoRec.Reset();
                        AssoRec.SetCurrentKey("Style No.", "Colour Name");
                        AssoRec.SetRange("Style No.", StyleRec."No.");
                        AssoRec.SetFilter("Colour Name", '<>%1', '*');

                        if AssoRec.FindSet() then begin
                            repeat
                                if Color <> AssoRec."Colour No" then begin
                                    StyleColorRec.Init();
                                    StyleColorRec."User ID" := UserId;
                                    StyleColorRec."Color No." := AssoRec."Colour No";
                                    StyleColorRec.Color := AssoRec."Colour Name";
                                    StyleColorRec.Insert();
                                    Color := AssoRec."Colour No";
                                end;
                            until AssoRec.Next() = 0;
                        end;
                    end;
                }

                field(PO; PO)
                {
                    ApplicationArea = All;
                }

                field(Color; Color)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StyleColorRec: Record StyleColor;
                    begin
                        StyleColorRec.Reset();
                        StyleColorRec.SetRange(Color, Color);
                        if StyleColorRec.FindSet() then
                            ColorCode := StyleColorRec."Color No.";

                    end;
                }

                field("Wash Type"; "Wash Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashTypeRec: Record "Wash Type";
                    begin
                        WashTypeRec.Reset();
                        WashTypeRec.SetRange("Wash Type Name", "Wash Type");
                        if WashTypeRec.FindSet() then
                            "Wash Type Code" := WashTypeRec."No.";
                    end;
                }

                field(Fabric; Fabric)
                {
                    ApplicationArea = All;
                }

                field("Gament Type"; "Gament Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        GarmentypeRec: Record "Garment Type";
                    begin
                        GarmentypeRec.Reset();
                        GarmentypeRec.SetRange("Garment Type Description", "Gament Type");
                        if GarmentypeRec.FindSet() then
                            "Gament Type Code" := GarmentypeRec."No.";
                    end;
                }

                field("Sample/Bulk"; "Sample/Bulk")
                {
                    ApplicationArea = All;
                }

                field("Hydro Extractor (Minutes)"; "Hydro Extractor (Minutes)")
                {
                    ApplicationArea = All;
                }

                field("Hot Dryer (Temp 'C)"; "Hot Dryer (Temp 'C)")
                {
                    ApplicationArea = All;
                }

                field("Cool Dry"; "Cool Dry")
                {
                    ApplicationArea = All;
                }

                field("Machine Type"; "Machine Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashingMachineTypeRec: Record WashingMachineType;
                    begin
                        WashingMachineTypeRec.Reset();
                        WashingMachineTypeRec.SetRange(Description, "Machine Type");
                        if WashingMachineTypeRec.FindSet() then
                            "Machine Type Code" := WashingMachineTypeRec.code;
                    end;
                }

                field("Load Weight (Kg)"; "Load Weight (Kg)")
                {
                    ApplicationArea = All;
                }

                field("Piece Weight (g)"; "Piece Weight (g)")
                {
                    ApplicationArea = All;
                }

                field("Remarks Job Card"; "Remarks Job Card")
                {
                    ApplicationArea = All;
                    Caption = 'Remark';
                }

                field("Total Water Ltrs:"; "Total Water Ltrs:")
                {
                    ApplicationArea = All;
                    Editable = false;

                    // trigger OnValidate()
                    // var
                    //     //prodHead: Record "Production Order";
                    //     WaterAmt: Decimal;
                    //     prodLine: Record "Prod. Order Line";
                    // begin
                    //     prodLine.Reset();
                    //     prodLine.SetRange("Prod. Order No.", "No.");
                    //     if prodLine.FindSet() then
                    //         repeat
                    //             CurrPage.Update();
                    //             WaterAmt += prodLine.Water;
                    //         until prodLine.Next() = 0;

                    //     "Total Water Ltrs:" := WaterAmt;
                    // end;
                }

                field("Process Time:"; "Process Time:")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    var
        NoGb: code[20];
        EditableGb: Boolean;

    procedure PassParameters(NoPara: Code[20]; EditablePara: Boolean);
    var
    begin
        NoGb := NoPara;
        EditableGb := EditablePara;
    end;


    trigger OnOpenPage()
    var
        ProdLne: Record "Prod. Order Line";
        TotalWaterLtrs: Decimal;
        TotalTime: Decimal;
    begin
        if NoGb <> '' then begin
            "No." := NoGb;
            Editable := EditableGb;
            Status := Status::"Firm Planned";
        end;

        ProdLne.Reset();
        ProdLne.SetRange("Prod. Order No.", "No.");
        ProdLne.SetRange(Status, Status);
        if ProdLne.FindSet() then
            repeat
                TotalWaterLtrs += ProdLne.Water;
                TotalTime += ProdLne."Time(Min)";
            until ProdLne.Next() = 0;

        "Total Water Ltrs:" := TotalWaterLtrs;
        "Process Time:" := TotalTime;
        CurrPage.Update();

    end;
}