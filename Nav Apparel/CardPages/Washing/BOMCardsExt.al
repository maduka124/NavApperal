pageextension 50755 WashinBOMCards extends "Production BOM"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("BOM Type"; rec."BOM Type")
            {
                ApplicationArea = All;
            }

            field("Style Name"; rec."Style Name")
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
                    StyleMasRec.SetRange("Style No.", rec."Style Name");
                    if StyleMasRec.FindSet() then
                        rec."Style No." := StyleMasRec."No.";

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

            field(Lot; rec.Lot)
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
        }

        addafter(General)
        {
            group(Washing)
            {
                field("Lot Size (Kg)"; rec."Lot Size (Kg)")
                {
                    ApplicationArea = All;
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
                            rec."Wash Type No" := WashTypeRec."No.";
                    end;
                }

                field("Bulk/Sample"; rec."Bulk/Sample")
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
            }
        }

        modify(Description)
        {
            trigger OnAfterValidate()
            var
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
            end;
        }
    }


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
            rec."No." := NoGb;
            Editable := EditableGb;
        end;
    end;
}