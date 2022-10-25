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
                field("Item Name"; "Item Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Roll No"; "Roll No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(MFShade; MFShade)
                {
                    ApplicationArea = All;
                    Caption = 'Manufacturer Shade';
                    Editable = false;
                }

                field(Shade; Shade)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ShadeRec: Record Shade;
                    begin
                        ShadeRec.Reset();
                        ShadeRec.SetRange(Shade, "Shade");
                        if ShadeRec.FindSet() then
                            "Shade No" := ShadeRec."No.";

                        CurrPage.Update();

                    end;
                }


                field(YDS; YDS)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Tag Length';
                }

                field(Width; Width)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Tag Width';
                }

                field("Act. Width"; "Act. Width")
                {
                    ApplicationArea = All;
                }

                field("Act. Legth"; "Act. Legth")
                {
                    ApplicationArea = All;
                }

                field("BW. Length"; "BW. Length")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "Length%" := ("AW. Length" - "BW. Length") * 100 / 50;
                        CurrPage.Update();
                        Find_PTN_Group();
                        CurrPage.Update();
                    end;
                }

                field("AW. Length"; "AW. Length")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "Length%" := ("AW. Length" - "BW. Length") * 100 / 50;
                        CurrPage.Update();
                        Find_PTN_Group();
                        CurrPage.Update();
                    end;
                }

                field("BW. Width"; "BW. Width")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "WiDth%" := ("AW. Width" - "BW. Width") * 100 / 50;
                        CurrPage.Update();
                        Find_PTN_Group();
                        CurrPage.Update();
                    end;
                }

                field("AW. Width"; "AW. Width")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "WiDth%" := ("AW. Width" - "BW. Width") * 100 / 50;
                        CurrPage.Update();
                        Find_PTN_Group();
                        CurrPage.Update();
                    end;
                }

                field("Length%"; "Length%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("WiDth%"; "WiDth%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PTTN GRP"; "PTTN GRP")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Status)
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
        FabricProceHeaderRec.SetRange("FabricProceNo.", "FabricProceNo.");
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
                        if "Length%" < 0 then begin
                            if (FabShriTestLineRec."From Length%" <= "Length%") and (FabShriTestLineRec."To Length%" >= "Length%") and (FabShriTestLineRec."From WiDth%" <= "WiDth%") and (FabShriTestLineRec."To WiDth%" >= "WiDth%") then begin
                                "PTTN GRP" := FabShriTestLineRec."Pattern Code";
                                break; //><
                            end;
                        end
                        else
                            if (FabShriTestLineRec."From Length%" <= "Length%") and (FabShriTestLineRec."To Length%" >= "Length%") and (FabShriTestLineRec."From WiDth%" <= "WiDth%") and (FabShriTestLineRec."To WiDth%" >= "WiDth%") then begin
                                "PTTN GRP" := FabShriTestLineRec."Pattern Code";
                                break; //< >
                            end
                            else
                                "PTTN GRP" := '-';

                    until FabShriTestLineRec.Next() = 0;
                end
                else
                    "PTTN GRP" := '-';

            end;

        end;

    end;
}