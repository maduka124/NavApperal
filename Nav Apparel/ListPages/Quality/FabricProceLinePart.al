page 50678 "FabricProceListPart"
{
    PageType = ListPart;
    SourceTable = FabricProceLine;
    InsertAllowed = false;
    //DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Roll No"; rec."Roll No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(MFShade; rec.MFShade)
                {
                    ApplicationArea = All;
                    Caption = 'Manufacturer Shade';
                    Editable = false;
                }

                field(Shade; rec.Shade)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ShadeRec: Record Shade;
                    begin
                        ShadeRec.Reset();
                        ShadeRec.SetRange(Shade, rec."Shade");
                        if ShadeRec.FindSet() then
                            rec."Shade No" := ShadeRec."No.";

                        CurrPage.Update();

                    end;
                }


                field(YDS; rec.YDS)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Tag Length';
                }

                field(Width; rec.Width)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Tag Width';
                }

                field("Act. Width"; rec."Act. Width")
                {
                    ApplicationArea = All;
                }

                field("Act. Legth"; rec."Act. Legth")
                {
                    ApplicationArea = All;
                }

                field("BW. Length"; rec."BW. Length")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."Length%" := (rec."AW. Length" - rec."BW. Length") * 100 / 50;
                        CurrPage.Update();
                        Find_PTN_Group();
                        CurrPage.Update();
                    end;
                }

                field("AW. Length"; rec."AW. Length")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."Length%" := (rec."AW. Length" - rec."BW. Length") * 100 / 50;
                        CurrPage.Update();
                        Find_PTN_Group();
                        CurrPage.Update();
                    end;
                }

                field("BW. Width"; rec."BW. Width")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."WiDth%" := (rec."AW. Width" - rec."BW. Width") * 100 / 50;
                        CurrPage.Update();
                        Find_PTN_Group();
                        CurrPage.Update();
                    end;
                }

                field("AW. Width"; rec."AW. Width")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."WiDth%" := (rec."AW. Width" - rec."BW. Width") * 100 / 50;
                        CurrPage.Update();
                        Find_PTN_Group();
                        CurrPage.Update();
                    end;
                }

                field("Length%"; rec."Length%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("WiDth%"; rec."WiDth%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PTTN GRP"; rec."PTTN GRP")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    procedure Find_PTN_Group()
    var
        FabShriTestLineRec: Record FabShrinkageTestLine;
        FabShriTestHeaderRec: Record FabShrinkageTestHeader;
        FabricProceHeaderRec: Record FabricProceHeader;
        TempNo: Code[20];
    begin

        FabricProceHeaderRec.Reset();
        FabricProceHeaderRec.SetRange("FabricProceNo.", rec."FabricProceNo.");
        if FabricProceHeaderRec.FindSet() then begin


            FabShriTestHeaderRec.RESET;
            FabShriTestHeaderRec.SetRange("Style No.", FabricProceHeaderRec."Style No.");
            FabShriTestHeaderRec.SetRange("Buyer No.", FabricProceHeaderRec."Buyer No.");
            FabShriTestHeaderRec.SetRange("PO No.", FabricProceHeaderRec."PO No.");
            FabShriTestHeaderRec.SetRange(GRN, FabricProceHeaderRec.GRN);
            FabShriTestHeaderRec.SetRange("Color No", FabricProceHeaderRec."Color No");
            FabShriTestHeaderRec.SetRange("Item No", FabricProceHeaderRec."Item No");

            IF FabShriTestHeaderRec.FindSet() THEN begin
                TempNo := FabShriTestHeaderRec."FabShrTestNo.";

                FabShriTestLineRec.Reset();
                FabShriTestLineRec.SetRange("FabShrTestNo.", TempNo);

                if FabShriTestLineRec.FindSet() then begin
                    repeat
                        if rec."Length%" < 0 then begin
                            if (FabShriTestLineRec."From Length%" <= rec."Length%") and (FabShriTestLineRec."To Length%" >= rec."Length%") and (FabShriTestLineRec."From WiDth%" <= rec."WiDth%") and (FabShriTestLineRec."To WiDth%" >= rec."WiDth%") then begin
                                rec."PTTN GRP" := FabShriTestLineRec."Pattern Code";
                                break; //><
                            end;
                        end
                        else
                            if (FabShriTestLineRec."From Length%" <= rec."Length%") and (FabShriTestLineRec."To Length%" >= rec."Length%") and (FabShriTestLineRec."From WiDth%" <= rec."WiDth%") and (FabShriTestLineRec."To WiDth%" >= rec."WiDth%") then begin
                                rec."PTTN GRP" := FabShriTestLineRec."Pattern Code";
                                break; //< >
                            end
                            else
                                rec."PTTN GRP" := '-';

                    until FabShriTestLineRec.Next() = 0;
                end
                else
                    rec."PTTN GRP" := '-';

            end;

        end;

    end;
}