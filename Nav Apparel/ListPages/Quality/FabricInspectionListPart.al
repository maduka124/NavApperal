page 50563 "Fabric Inspection ListPart"
{
    PageType = ListPart;
    SourceTable = FabricInspectionLine;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Defects; Defects)
                {
                    ApplicationArea = All;
                    Caption = 'Defect';

                    trigger OnValidate()
                    var
                        DefectsRec: Record Defects;
                    begin
                        DefectsRec.Reset();
                        DefectsRec.SetRange(Defects, Defects);
                        if DefectsRec.FindSet() then
                            "DefectsNo." := DefectsRec."No.";

                        "Point 1" := '0';
                        "Point 2" := '0';
                        "Point 3" := '0';
                        "Point 4" := '0';
                        "Point Total" := 0;
                    end;
                }

                field("Point 1"; "Point 1")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field("Point 2"; "Point 2")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field("Point 3"; "Point 3")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field("Point 4"; "Point 4")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field("Point Total"; "Point Total")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    procedure Cal()
    var
        p1: Decimal;
        p2: Decimal;
        p3: Decimal;
        p4: Decimal;
        FabricInspecRec: Record FabricInspection;
        FabricInspecLineRec: Record FabricInspectionLine;
        CustRec: Record Customer;
        Total1: Decimal;
        temp1: Decimal;
        Total2: Decimal;
        temp2: Decimal;
        Total3: Decimal;
        temp3: Decimal;
        Total4: Decimal;
        temp4: Decimal;
    begin

        FabricInspecRec.Reset();
        FabricInspecRec.SetRange("InsNo.", "InsNo.");

        if FabricInspecRec.FindSet() then begin

            CustRec.Reset();
            CustRec.SetRange("No.", FabricInspecRec."Buyer No.");

            if CustRec.FindSet() then begin

                CurrPage.Update();
                Evaluate(p1, "Point 1");
                Evaluate(p2, "Point 2");
                Evaluate(p3, "Point 3");
                Evaluate(p4, "Point 4");
                "Point Total" := p1 + p2 + p3 + p4;
                CurrPage.Update();

                FabricInspecLineRec.Reset();
                FabricInspecLineRec.SetRange("InsNo.", "InsNo.");

                if FabricInspecLineRec.FindSet() then begin
                    repeat
                        Evaluate(temp1, FabricInspecLineRec."Point 1");
                        Total1 += temp1;
                        Evaluate(temp2, FabricInspecLineRec."Point 2");
                        Total2 += temp2;
                        Evaluate(temp3, FabricInspecLineRec."Point 3");
                        Total3 += temp3;
                        Evaluate(temp4, FabricInspecLineRec."Point 4");
                        Total4 += temp4;
                    until FabricInspecLineRec.Next() = 0;

                    FabricInspecRec.Reset();
                    FabricInspecRec.SetRange("InsNo.", "InsNo.");
                    FabricInspecRec.FindSet();
                    FabricInspecRec."1 Point (Up to 3 inches)" := Total1;
                    FabricInspecRec."1 Point" := Total1;
                    FabricInspecRec."2 Point (Up to 3-6 inches)" := Total2;
                    FabricInspecRec."2 Point" := Total2 * 2;
                    FabricInspecRec."3 Point (Up to 6-9 inches)" := Total3;
                    FabricInspecRec."3 Point " := Total3 * 3;
                    FabricInspecRec."4 Point (Above 9 inches) " := Total4;
                    FabricInspecRec."4 Point" := Total4 * 4;

                    FabricInspecRec."Points per 100 SQ Yds 1" := FabricInspecRec."1 Point" + FabricInspecRec."2 Point" + FabricInspecRec."3 Point " + FabricInspecRec."4 Point";
                    FabricInspecRec."Points per 100 SQ Yds 2" := (((FabricInspecRec."Points per 100 SQ Yds 1" / FabricInspecRec."Actual Length") * 36) / FabricInspecRec."Actual Width") * 100;

                    if CustRec."Fab Inspection Level" >= FabricInspecRec."Points per 100 SQ Yds 1" then
                        FabricInspecRec.Status := 'Pass'
                    else
                        FabricInspecRec.Status := 'Fail';

                    FabricInspecRec.Modify();

                end;
            end;
        end;
    end;

}