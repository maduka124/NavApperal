pageextension 50801 ReleaseProductionOrder extends "Released Production Order"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Prod Order Type"; rec."Prod Order Type")
            {
                ApplicationArea = all;
                Caption = 'Prod. Order Type';
            }


        }
        addafter("No.")
        {
            field(Buyer1; rec.Buyer)
            {
                ApplicationArea = All;
                Caption = 'Buyer';

                trigger OnValidate()
                var
                    CustomerRec: Record Customer;
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
                        LoginSessionsRec.FindSet();
                        rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    end
                    else begin   //logged in
                        rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    end;


                    CustomerRec.Reset();
                    CustomerRec.SetRange(Name, rec.Buyer);
                    if CustomerRec.FindSet() then
                        rec.BuyerCode := CustomerRec."No.";
                end;
            }
            field("Style Name1"; rec."Style Name")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    StyleRec: Record "Style Master";

                begin

                    StyleRec.Reset();
                    StyleRec.SetRange("Style No.", rec."Style Name");
                    if StyleRec.FindSet() then
                        rec."Style No." := StyleRec."No.";
                end;
            }
            // field("Shortcut Dimension 1 Code1"; "Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Factory';
            // }
            field(PO1; rec.PO)
            {
                ApplicationArea = all;
                Caption = 'PO';
            }

            field("Lot No."; rec."Lot No.")
            {
                ApplicationArea = all;
                Caption = 'Lot No';
            }

        }


        addafter(General)
        {
            group("Washing")
            {
                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, rec.Buyer);
                        if CustomerRec.FindSet() then
                            rec.BuyerCode := CustomerRec."No.";
                    end;
                }

                field("Style Name"; rec."Style Name")
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
                        StyleRec.SetRange("Style No.", rec."Style Name");
                        if StyleRec.FindSet() then
                            rec."Style No." := StyleRec."No.";


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

                field(PO; rec.PO)
                {
                    ApplicationArea = All;
                }

                field(Color; rec.Color)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StyleColorRec: Record StyleColor;
                    begin
                        StyleColorRec.Reset();
                        StyleColorRec.SetRange(Color, rec.Color);
                        if StyleColorRec.FindSet() then
                            rec.ColorCode := StyleColorRec."Color No.";

                    end;
                }

                field("Wash Type"; rec."Wash Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashTypeRec: Record "Wash Type";
                    begin
                        WashTypeRec.Reset();
                        WashTypeRec.SetRange("Wash Type Name", rec."Wash Type");
                        if WashTypeRec.FindSet() then
                            rec."Wash Type Code" := WashTypeRec."No.";
                    end;
                }

                field(Fabric; rec.Fabric)
                {
                    ApplicationArea = All;
                }

                field("Gament Type"; rec."Gament Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        GarmentypeRec: Record "Garment Type";
                    begin
                        GarmentypeRec.Reset();
                        GarmentypeRec.SetRange("Garment Type Description", rec."Gament Type");
                        if GarmentypeRec.FindSet() then
                            rec."Gament Type Code" := GarmentypeRec."No.";
                    end;
                }

                field("Sample/Bulk"; rec."Sample/Bulk")
                {
                    ApplicationArea = All;
                }

                field("Hydro Extractor (Minutes)"; rec."Hydro Extractor (Minutes)")
                {
                    ApplicationArea = All;
                }

                field("Hot Dryer (Temp 'C)"; rec."Hot Dryer (Temp 'C)")
                {
                    ApplicationArea = All;
                }

                field("Cool Dry"; rec."Cool Dry")
                {
                    ApplicationArea = All;
                }

                field("Machine Type"; rec."Machine Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashingMachineTypeRec: Record WashingMachineType;
                    begin
                        WashingMachineTypeRec.Reset();
                        WashingMachineTypeRec.SetRange(Description, rec."Machine Type");
                        if WashingMachineTypeRec.FindSet() then
                            rec."Machine Type Code" := WashingMachineTypeRec.code;
                    end;
                }

                field("Load Weight (Kg)"; rec."Load Weight (Kg)")
                {
                    ApplicationArea = All;
                }

                field("Piece Weight (g)"; rec."Piece Weight (g)")
                {
                    ApplicationArea = All;
                }

                field("Remarks Job Card"; rec."Remarks Job Card")
                {
                    ApplicationArea = All;
                    Caption = 'Remark';
                }

                field("Total Water Ltrs:"; rec."Total Water Ltrs:")
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

                field("Process Time:"; rec."Process Time:")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


            }
        }


    }


    actions
    {
        addafter("Change &Status")
        {
            action("Washing orders")
            {
                Image = ViewDetails;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SalesHedd: Record "Sales Header";
                    WashSalesHedd: Record "Sales Header";
                begin
                    if not SalesHedd.get(SalesHedd."Document Type"::Order, rec."Source No.") then
                        Error('Sales Order not found for %1', rec."No.");

                    if SalesHedd."PO No" = '' then
                        Error('PO no must have a value');

                    WashSalesHedd.Reset();
                    WashSalesHedd.SetRange("PO No", SalesHedd."PO No");
                    WashSalesHedd.SetFilter("No.", '%1', 'WSH*');
                    Page.Run(9305, WashSalesHedd);
                end;
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
            rec."No." := NoGb;
            Editable := EditableGb;
            rec.Status := rec.Status::"Firm Planned";
        end;

        ProdLne.Reset();
        ProdLne.SetRange("Prod. Order No.", rec."No.");
        ProdLne.SetRange(Status, rec.Status);
        if ProdLne.FindSet() then
            repeat
                TotalWaterLtrs += ProdLne.Water;
                TotalTime += ProdLne."Time(Min)";
            until ProdLne.Next() = 0;

        rec."Total Water Ltrs:" := TotalWaterLtrs;
        rec."Process Time:" := TotalTime;
        CurrPage.Update();

    end;
}