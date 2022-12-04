page 50563 "Fabric Inspection ListPart1"
{
    PageType = ListPart;
    SourceTable = FabricInspectionLine1;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Defects; rec.Defects)
                {
                    ApplicationArea = All;
                    Caption = 'Defect';

                    trigger OnValidate()
                    var
                        DefectsRec: Record Defects;
                    begin
                        DefectsRec.Reset();
                        DefectsRec.SetRange(Defects, rec.Defects);
                        if DefectsRec.FindSet() then
                            rec."DefectsNo." := DefectsRec."No.";

                        rec."Point 1" := '0';
                        rec."Point 2" := '0';
                        rec."Point 3" := '0';
                        rec."Point 4" := '0';
                        rec."Point Total" := 0;
                    end;
                }

                field("Point 1"; rec."Point 1")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field("Point 2"; rec."Point 2")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field("Point 3"; rec."Point 3")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field("Point 4"; rec."Point 4")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field("Point Total"; rec."Point Total")
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
        FabricInspecLineRec: Record FabricInspectionLine1;
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
        FabricInspecRec.SetRange("InsNo.", rec."InsNo.");

        if FabricInspecRec.FindSet() then begin

            CustRec.Reset();
            CustRec.SetRange("No.", FabricInspecRec."Buyer No.");

            if CustRec.FindSet() then begin

                CurrPage.Update();
                Evaluate(p1, rec."Point 1");
                Evaluate(p2, rec."Point 2");
                Evaluate(p3, rec."Point 3");
                Evaluate(p4, rec."Point 4");
                rec."Point Total" := p1 + p2 + p3 + p4;
                CurrPage.Update();

                FabricInspecLineRec.Reset();
                FabricInspecLineRec.SetRange("InsNo.", rec."InsNo.");

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
                    FabricInspecRec.SetRange("InsNo.", rec."InsNo.");
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