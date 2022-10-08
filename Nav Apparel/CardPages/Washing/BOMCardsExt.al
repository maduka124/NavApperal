pageextension 50755 WashinBOMCards extends "Production BOM"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("BOM Type"; "BOM Type")
            {
                ApplicationArea = All;
            }

            field("Style Name"; "Style Name")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    StyleMasRec: Record "Style Master";
                    AssoRec: Record AssorColorSizeRatio;
                    StyleColorRec: Record StyleColor;
                    Color: Code[20];
                begin

                    StyleMasRec.Reset();
                    StyleMasRec.SetRange("Style No.", "Style Name");
                    if StyleMasRec.FindSet() then
                        "Style No." := StyleMasRec."No.";

                    CurrPage.Update();

                    //Deleet old recorsd
                    StyleColorRec.Reset();
                    StyleColorRec.SetRange("User ID", UserId);
                    if StyleColorRec.FindSet() then
                        StyleColorRec.DeleteAll();

                    //Get Colors for the style
                    AssoRec.Reset();
                    AssoRec.SetCurrentKey("Style No.", "Colour Name");
                    AssoRec.SetRange("Style No.", StyleMasRec."No.");
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

            field(Lot; Lot)
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
        }

        addafter(General)
        {
            group(Washing)
            {
                field("Lot Size (Kg)"; "Lot Size (Kg)")
                {
                    ApplicationArea = All;
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
                            "Wash Type No" := WashTypeRec."No.";
                    end;
                }

                field("Bulk/Sample"; "Bulk/Sample")
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
            }
        }
    }

    // actions
    // {
    //     addafter("Copy &BOM")
    //     {
    //         action("Up Date JobCard")
    //         {

    //         }
    //     }

    // }

    var
        NoGb: code[20];
        EditableGb: Boolean;

    procedure PassParametersBom(NoPara: Code[20]; EditablePara: Boolean);
    var
    begin
        NoGb := NoPara;
        EditableGb := EditablePara;
    end;


    trigger OnOpenPage()
    var
    begin
        if NoGb <> '' then begin
            "No." := NoGb;
            Editable := EditableGb;
        end;
    end;
}