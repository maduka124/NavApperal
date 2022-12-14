page 50596 "Ratio Creation ListPart"
{
    PageType = ListPart;
    SourceTable = RatioCreationLine;
    SourceTableView = sorting(RatioCreNo, "Group ID", LineNo) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Marker Name"; "Marker Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Caption = 'Marker';

                    trigger OnValidate()
                    var
                        RatioCreationLineRec: Record RatioCreationLine;
                        RatioCreationLineRec1: Record RatioCreationLine;
                        LineNo1: Integer;
                        ComponentGroupCode: Code[20];
                        UOMVar: Code[20];
                        UOMCodeVar: Code[20];
                    begin

                        if LineNo = 0 then begin

                            //Get Component group no
                            RatioCreationLineRec.Reset();
                            RatioCreationLineRec.SetRange(RatioCreNo, "RatioCreNo");
                            RatioCreationLineRec.SetFilter("Record Type", '%1', 'H');

                            if RatioCreationLineRec.FindSet() then begin
                                ComponentGroupCode := RatioCreationLineRec."Component Group Code";
                                UOMVar := RatioCreationLineRec.UOM;
                                UOMCodeVar := RatioCreationLineRec."UOM Code";
                            end;

                            //Get Max line no
                            RatioCreationLineRec.Reset();
                            RatioCreationLineRec.SetRange(RatioCreNo, "RatioCreNo");
                            RatioCreationLineRec.SetRange("Group ID", "Group ID");

                            if RatioCreationLineRec.FindLast() then
                                LineNo1 := RatioCreationLineRec.LineNo;

                            LineNo := LineNo1 + 1;

                            // Get detalis of existing line                 
                            RatioCreationLineRec1.Reset();
                            RatioCreationLineRec1.SetRange("RatioCreNo", "RatioCreNo");
                            RatioCreationLineRec1.SetRange("Group ID", "Group ID");
                            RatioCreationLineRec1.SetRange(LineNo, LineNo1 - 1);
                            RatioCreationLineRec1.SetFilter("Record Type", '%1', 'R');

                            if RatioCreationLineRec1.FindSet() then begin

                                //Insert R1 Line                        
                                "Created Date" := Today;
                                "Created User" := UserId;
                                "Group ID" := "Group ID";
                                "Lot No." := RatioCreationLineRec1."Lot No.";
                                "PO No." := RatioCreationLineRec1."PO No.";
                                qty := 0;
                                "Record Type" := 'R';
                                "Sewing Job No." := RatioCreationLineRec1."Sewing Job No.";
                                ShipDate := RatioCreationLineRec1.ShipDate;
                                "Style Name" := RatioCreationLineRec1."Style Name";
                                "Style No." := RatioCreationLineRec1."Style No.";
                                "SubLotNo." := RatioCreationLineRec1."SubLotNo.";
                                "Colour No" := RatioCreationLineRec1."Colour No";
                                "Colour Name" := RatioCreationLineRec1."Colour Name";
                                "Component Group Code" := ComponentGroupCode;
                                UOM := UOMVar;
                                "UOM Code" := UOMCodeVar;
                                Plies := 0;
                                "1" := '0';
                                "2" := '0';
                                "3" := '0';
                                "4" := '0';
                                "5" := '0';
                                "6" := '0';
                                "7" := '0';
                                "8" := '0';
                                "9" := '0';
                                "10" := '0';
                                "11" := '0';
                                "12" := '0';
                                "13" := '0';
                                "14" := '0';
                                "15" := '0';
                                "16" := '0';
                                "17" := '0';
                                "18" := '0';
                                "19" := '0';
                                "20" := '0';
                                "21" := '0';
                                "22" := '0';
                                "23" := '0';
                                "24" := '0';
                                "25" := '0';
                                "26" := '0';
                                "27" := '0';
                                "28" := '0';
                                "29" := '0';
                                "30" := '0';
                                "31" := '0';
                                "32" := '0';
                                "33" := '0';
                                "34" := '0';
                                "35" := '0';
                                "36" := '0';
                                "37" := '0';
                                "38" := '0';
                                "39" := '0';
                                "40" := '0';
                                "41" := '0';
                                "42" := '0';
                                "43" := '0';
                                "44" := '0';
                                "45" := '0';
                                "46" := '0';
                                "47" := '0';
                                "48" := '0';
                                "49" := '0';
                                "50" := '0';
                                "51" := '0';
                                "52" := '0';
                                "53" := '0';
                                "54" := '0';
                                "55" := '0';
                                "56" := '0';
                                "57" := '0';
                                "58" := '0';
                                "59" := '0';
                                "60" := '0';
                                "61" := '0';
                                "62" := '0';
                                "63" := '0';
                                "64" := '0';

                                CurrPage.Update();
                            end;
                        end;

                    end;
                }

                field("Pattern Version"; "Pattern Version")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }
                field(Length; Length)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }

                field("Length Tollarance  "; "Length Tollarance  ")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Caption = 'Length Tollarance (cm/inch)';
                }

                field(Width; Width)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }

                field("Width Tollarance"; "Width Tollarance")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Caption = 'Width Tollarance (cm/inch)';
                }

                field(Efficiency; Efficiency)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }

                field(Plies; Plies)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                        CurrPage.Update();
                    end;
                }

                field("Color Total"; "Color Total")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }

                field("1"; "1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }
                field("2"; "2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("3"; "3")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("4"; "4")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("5"; "5")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("6"; "6")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("7"; "7")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("8"; "8")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("9"; "9")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("10"; "10")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("11"; "11")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("12"; "12")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("13"; "13")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("14"; "14")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("15"; "15")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("16"; "16")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("17"; "17")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("18"; "18")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("19"; "19")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("20"; "20")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("21"; "21")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("22"; "22")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("23"; "23")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("24"; "24")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("25"; "25")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("26"; "26")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("27"; "27")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("28"; "28")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("29"; "29")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("30"; "30")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("31"; "31")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("32"; "32")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("33"; "33")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("34"; "34")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("35"; "35")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("36"; "36")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("37"; "37")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("38"; "38")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("39"; "39")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("40"; "40")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("41"; "41")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("42"; "42")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("43"; "43")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("44"; "44")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("45"; "45")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }


                field("46"; "46")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("47"; "47")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("48"; "48")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("49"; "49")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("50"; "50")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("51"; "51")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("52"; "52")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("53"; "53")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("54"; "54")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("55"; "55")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("56"; "56")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("57"; "57")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("58"; "58")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("59"; "59")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("60"; "60")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("61"; "61")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("62"; "62")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("63"; "63")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("64"; "64")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorRatioCreation(Rec);

        if ("Record Type" = 'R') or ("Record Type" = '') then begin
            Clear(SetEdit1);
            SetEdit1 := true;
        end
        ELSE begin
            Clear(SetEdit1);
            SetEdit1 := false;
        end;
    end;


    trigger OnAfterGetCurrRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorRatioCreation(Rec);

        if ("Record Type" = 'R') or ("Record Type" = '') then begin
            Clear(SetEdit1);
            SetEdit1 := true;
        end
        ELSE begin
            Clear(SetEdit1);
            SetEdit1 := false;
        end;
    end;


    procedure Cal_Balance()
    var
        RatioCreationLineRec: Record RatioCreationLine;
        RatioCreationLineRec1: Record RatioCreationLine;
        RatioCreationLineRec2: Record RatioCreationLine;
        LineNo1: Integer;
        MaxLineNo: Integer;
        Number: Decimal;
        Number1: Decimal;
    begin

        if Plies <> 0 then begin

            LineNo1 := LineNo;

            //Get max line no
            RatioCreationLineRec.Reset();
            RatioCreationLineRec.SetRange(RatioCreNo);

            if RatioCreationLineRec.FindLast() then
                MaxLineNo := RatioCreationLineRec.LineNo;

            repeat

                RatioCreationLineRec.Reset();
                RatioCreationLineRec.SetRange(RatioCreNo, RatioCreNo);
                RatioCreationLineRec.SetRange("Group ID", "Group ID");
                RatioCreationLineRec.SetRange(Ref, LineNo1);
                RatioCreationLineRec.SetRange("Marker Name", 'Balance');

                //Insert balance record
                if not RatioCreationLineRec.FindSet() then begin
                    //Insert balance line with zero values
                    RatioCreationLineRec.Init();
                    RatioCreationLineRec."Created Date" := Today;
                    RatioCreationLineRec."Created User" := UserId;
                    RatioCreationLineRec."Group ID" := "Group ID";
                    RatioCreationLineRec.LineNo := LineNo1 + 1;
                    RatioCreationLineRec."Lot No." := "Lot No.";
                    RatioCreationLineRec."PO No." := "PO No.";
                    RatioCreationLineRec.qty := 0;
                    RatioCreationLineRec."Record Type" := 'B';
                    RatioCreationLineRec."Sewing Job No." := "Sewing Job No.";
                    RatioCreationLineRec."Component Group Code" := "Component Group Code";
                    RatioCreationLineRec.ShipDate := ShipDate;
                    RatioCreationLineRec."RatioCreNo" := "RatioCreNo";
                    RatioCreationLineRec."Style Name" := "Style Name";
                    RatioCreationLineRec."Style No." := "Style No.";
                    RatioCreationLineRec."SubLotNo." := "SubLotNo.";
                    RatioCreationLineRec."Marker Name" := 'Balance';
                    RatioCreationLineRec.Ref := LineNo1;
                    RatioCreationLineRec."Colour No" := "Colour No";
                    RatioCreationLineRec."Colour Name" := "Colour Name";
                    RatioCreationLineRec."1" := '0';
                    RatioCreationLineRec."2" := '0';
                    RatioCreationLineRec."3" := '0';
                    RatioCreationLineRec."4" := '0';
                    RatioCreationLineRec."5" := '0';
                    RatioCreationLineRec."6" := '0';
                    RatioCreationLineRec."7" := '0';
                    RatioCreationLineRec."8" := '0';
                    RatioCreationLineRec."9" := '0';
                    RatioCreationLineRec."10" := '0';
                    RatioCreationLineRec."11" := '0';
                    RatioCreationLineRec."12" := '0';
                    RatioCreationLineRec."13" := '0';
                    RatioCreationLineRec."14" := '0';
                    RatioCreationLineRec."15" := '0';
                    RatioCreationLineRec."16" := '0';
                    RatioCreationLineRec."17" := '0';
                    RatioCreationLineRec."18" := '0';
                    RatioCreationLineRec."19" := '0';
                    RatioCreationLineRec."20" := '0';
                    RatioCreationLineRec."21" := '0';
                    RatioCreationLineRec."22" := '0';
                    RatioCreationLineRec."23" := '0';
                    RatioCreationLineRec."24" := '0';
                    RatioCreationLineRec."25" := '0';
                    RatioCreationLineRec."26" := '0';
                    RatioCreationLineRec."27" := '0';
                    RatioCreationLineRec."28" := '0';
                    RatioCreationLineRec."29" := '0';
                    RatioCreationLineRec."30" := '0';
                    RatioCreationLineRec."31" := '0';
                    RatioCreationLineRec."32" := '0';
                    RatioCreationLineRec."33" := '0';
                    RatioCreationLineRec."34" := '0';
                    RatioCreationLineRec."35" := '0';
                    RatioCreationLineRec."36" := '0';
                    RatioCreationLineRec."37" := '0';
                    RatioCreationLineRec."38" := '0';
                    RatioCreationLineRec."39" := '0';
                    RatioCreationLineRec."40" := '0';
                    RatioCreationLineRec."41" := '0';
                    RatioCreationLineRec."42" := '0';
                    RatioCreationLineRec."43" := '0';
                    RatioCreationLineRec."44" := '0';
                    RatioCreationLineRec."45" := '0';
                    RatioCreationLineRec."46" := '0';
                    RatioCreationLineRec."47" := '0';
                    RatioCreationLineRec."48" := '0';
                    RatioCreationLineRec."49" := '0';
                    RatioCreationLineRec."50" := '0';
                    RatioCreationLineRec."51" := '0';
                    RatioCreationLineRec."52" := '0';
                    RatioCreationLineRec."53" := '0';
                    RatioCreationLineRec."54" := '0';
                    RatioCreationLineRec."55" := '0';
                    RatioCreationLineRec."56" := '0';
                    RatioCreationLineRec."57" := '0';
                    RatioCreationLineRec."58" := '0';
                    RatioCreationLineRec."59" := '0';
                    RatioCreationLineRec."60" := '0';
                    RatioCreationLineRec."61" := '0';
                    RatioCreationLineRec."62" := '0';
                    RatioCreationLineRec."63" := '0';
                    RatioCreationLineRec."64" := '0';
                    RatioCreationLineRec.Insert();
                end;

                //Get balance line record
                RatioCreationLineRec1.Reset();
                RatioCreationLineRec1.SetRange(RatioCreNo, RatioCreNo);
                RatioCreationLineRec1.SetRange("Group ID", "Group ID");
                RatioCreationLineRec1.SetRange(LineNo, LineNo1 + 1);
                RatioCreationLineRec1.FindSet();


                //Get Current line
                RatioCreationLineRec2.Reset();
                RatioCreationLineRec2.SetRange(RatioCreNo, RatioCreNo);
                RatioCreationLineRec2.SetRange("Group ID", "Group ID");
                RatioCreationLineRec2.SetRange(LineNo, LineNo1);
                RatioCreationLineRec2.FindSet();


                //Get totals of before line
                RatioCreationLineRec.Reset();
                RatioCreationLineRec.SetRange(RatioCreNo, RatioCreNo);
                RatioCreationLineRec.SetRange("Group ID", "Group ID");
                RatioCreationLineRec.SetRange(LineNo, LineNo1 - 1);

                if RatioCreationLineRec.FindSet() then begin

                    if (RatioCreationLineRec."1" <> '') and (RatioCreationLineRec2."1" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."1");
                        Evaluate(Number1, RatioCreationLineRec2."1");
                        RatioCreationLineRec1."1" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."1" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."2" <> '') and (RatioCreationLineRec2."2" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."2");
                        Evaluate(Number1, RatioCreationLineRec2."2");
                        RatioCreationLineRec1."2" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."2" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."3" <> '') and (RatioCreationLineRec2."3" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."3");
                        Evaluate(Number1, RatioCreationLineRec2."3");
                        RatioCreationLineRec1."3" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."3" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."4" <> '') and (RatioCreationLineRec2."4" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."4");
                        Evaluate(Number1, RatioCreationLineRec2."4");
                        RatioCreationLineRec1."4" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."4" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."5" <> '') and (RatioCreationLineRec2."5" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."5");
                        Evaluate(Number1, RatioCreationLineRec2."5");
                        RatioCreationLineRec1."5" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."5" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."6" <> '') and (RatioCreationLineRec2."6" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."6");
                        Evaluate(Number1, RatioCreationLineRec2."6");
                        RatioCreationLineRec1."6" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."6" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."7" <> '') and (RatioCreationLineRec2."7" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."7");
                        Evaluate(Number1, RatioCreationLineRec2."7");
                        RatioCreationLineRec1."7" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."7" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."8" <> '') and (RatioCreationLineRec2."8" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."8");
                        Evaluate(Number1, RatioCreationLineRec2."8");
                        RatioCreationLineRec1."8" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."8" := '0';
                    ///////////////
                    /// 

                    if (RatioCreationLineRec."9" <> '') and (RatioCreationLineRec2."9" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."9");
                        Evaluate(Number1, RatioCreationLineRec2."9");
                        RatioCreationLineRec1."9" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."9" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."10" <> '') and (RatioCreationLineRec2."10" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."10");
                        Evaluate(Number1, RatioCreationLineRec2."10");
                        RatioCreationLineRec1."10" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."10" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."11" <> '') and (RatioCreationLineRec2."11" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."11");
                        Evaluate(Number1, RatioCreationLineRec2."11");
                        RatioCreationLineRec1."11" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."11" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."12" <> '') and (RatioCreationLineRec2."12" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."12");
                        Evaluate(Number1, RatioCreationLineRec2."12");
                        RatioCreationLineRec1."12" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."12" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."13" <> '') and (RatioCreationLineRec2."13" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."13");
                        Evaluate(Number1, RatioCreationLineRec2."13");
                        RatioCreationLineRec1."13" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."13" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."14" <> '') and (RatioCreationLineRec2."14" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."14");
                        Evaluate(Number1, RatioCreationLineRec2."14");
                        RatioCreationLineRec1."14" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."14" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."15" <> '') and (RatioCreationLineRec2."15" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."15");
                        Evaluate(Number1, RatioCreationLineRec2."15");
                        RatioCreationLineRec1."15" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."15" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."16" <> '') and (RatioCreationLineRec2."16" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."16");
                        Evaluate(Number1, RatioCreationLineRec2."16");
                        RatioCreationLineRec1."16" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."16" := '0';

                    if (RatioCreationLineRec."17" <> '') and (RatioCreationLineRec2."17" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."17");
                        Evaluate(Number1, RatioCreationLineRec2."17");
                        RatioCreationLineRec1."17" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."17" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."18" <> '') and (RatioCreationLineRec2."18" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."18");
                        Evaluate(Number1, RatioCreationLineRec2."18");
                        RatioCreationLineRec1."18" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."18" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."19" <> '') and (RatioCreationLineRec2."19" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."19");
                        Evaluate(Number1, RatioCreationLineRec2."19");
                        RatioCreationLineRec1."19" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."19" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."20" <> '') and (RatioCreationLineRec2."20" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."20");
                        Evaluate(Number1, RatioCreationLineRec2."20");
                        RatioCreationLineRec1."20" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."20" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."21" <> '') and (RatioCreationLineRec2."21" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."21");
                        Evaluate(Number1, RatioCreationLineRec2."21");
                        RatioCreationLineRec1."21" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."21" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."22" <> '') and (RatioCreationLineRec2."22" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."22");
                        Evaluate(Number1, RatioCreationLineRec2."22");
                        RatioCreationLineRec1."22" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."22" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."23" <> '') and (RatioCreationLineRec2."23" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."23");
                        Evaluate(Number1, RatioCreationLineRec2."23");
                        RatioCreationLineRec1."23" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."23" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."24" <> '') and (RatioCreationLineRec2."24" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."24");
                        Evaluate(Number1, RatioCreationLineRec2."24");
                        RatioCreationLineRec1."24" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."24" := '0';

                    if (RatioCreationLineRec."25" <> '') and (RatioCreationLineRec2."25" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."25");
                        Evaluate(Number1, RatioCreationLineRec2."25");
                        RatioCreationLineRec1."25" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."25" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."26" <> '') and (RatioCreationLineRec2."26" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."26");
                        Evaluate(Number1, RatioCreationLineRec2."26");
                        RatioCreationLineRec1."26" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."26" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."27" <> '') and (RatioCreationLineRec2."27" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."27");
                        Evaluate(Number1, RatioCreationLineRec2."27");
                        RatioCreationLineRec1."27" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."27" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."28" <> '') and (RatioCreationLineRec2."28" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."28");
                        Evaluate(Number1, RatioCreationLineRec2."28");
                        RatioCreationLineRec1."28" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."28" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."29" <> '') and (RatioCreationLineRec2."29" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."29");
                        Evaluate(Number1, RatioCreationLineRec2."29");
                        RatioCreationLineRec1."29" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."29" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."30" <> '') and (RatioCreationLineRec2."30" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."30");
                        Evaluate(Number1, RatioCreationLineRec2."30");
                        RatioCreationLineRec1."30" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."30" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."31" <> '') and (RatioCreationLineRec2."31" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."31");
                        Evaluate(Number1, RatioCreationLineRec2."31");
                        RatioCreationLineRec1."31" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."31" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."32" <> '') and (RatioCreationLineRec2."32" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."32");
                        Evaluate(Number1, RatioCreationLineRec2."32");
                        RatioCreationLineRec1."32" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."32" := '0';

                    if (RatioCreationLineRec."33" <> '') and (RatioCreationLineRec2."33" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."33");
                        Evaluate(Number1, RatioCreationLineRec2."33");
                        RatioCreationLineRec1."33" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."33" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."34" <> '') and (RatioCreationLineRec2."34" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."34");
                        Evaluate(Number1, RatioCreationLineRec2."34");
                        RatioCreationLineRec1."34" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."34" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."35" <> '') and (RatioCreationLineRec2."35" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."35");
                        Evaluate(Number1, RatioCreationLineRec2."35");
                        RatioCreationLineRec1."35" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."35" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."36" <> '') and (RatioCreationLineRec2."36" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."36");
                        Evaluate(Number1, RatioCreationLineRec2."36");
                        RatioCreationLineRec1."36" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."36" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."37" <> '') and (RatioCreationLineRec2."37" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."37");
                        Evaluate(Number1, RatioCreationLineRec2."37");
                        RatioCreationLineRec1."37" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."37" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."38" <> '') and (RatioCreationLineRec2."38" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."38");
                        Evaluate(Number1, RatioCreationLineRec2."38");
                        RatioCreationLineRec1."38" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."38" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."39" <> '') and (RatioCreationLineRec2."39" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."39");
                        Evaluate(Number1, RatioCreationLineRec2."39");
                        RatioCreationLineRec1."39" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."39" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."40" <> '') and (RatioCreationLineRec2."40" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."40");
                        Evaluate(Number1, RatioCreationLineRec2."40");
                        RatioCreationLineRec1."40" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."40" := '0';

                    if (RatioCreationLineRec."41" <> '') and (RatioCreationLineRec2."41" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."41");
                        Evaluate(Number1, RatioCreationLineRec2."41");
                        RatioCreationLineRec1."41" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."41" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."42" <> '') and (RatioCreationLineRec2."42" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."42");
                        Evaluate(Number1, RatioCreationLineRec2."42");
                        RatioCreationLineRec1."42" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."42" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."43" <> '') and (RatioCreationLineRec2."43" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."43");
                        Evaluate(Number1, RatioCreationLineRec2."43");
                        RatioCreationLineRec1."43" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."43" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."44" <> '') and (RatioCreationLineRec2."44" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."44");
                        Evaluate(Number1, RatioCreationLineRec2."44");
                        RatioCreationLineRec1."44" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."44" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."45" <> '') and (RatioCreationLineRec2."45" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."45");
                        Evaluate(Number1, RatioCreationLineRec2."45");
                        RatioCreationLineRec1."45" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."45" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."46" <> '') and (RatioCreationLineRec2."46" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."46");
                        Evaluate(Number1, RatioCreationLineRec2."46");
                        RatioCreationLineRec1."46" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."46" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."47" <> '') and (RatioCreationLineRec2."47" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."47");
                        Evaluate(Number1, RatioCreationLineRec2."47");
                        RatioCreationLineRec1."47" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."47" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."48" <> '') and (RatioCreationLineRec2."48" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."48");
                        Evaluate(Number1, RatioCreationLineRec2."48");
                        RatioCreationLineRec1."48" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."48" := '0';

                    if (RatioCreationLineRec."49" <> '') and (RatioCreationLineRec2."49" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."49");
                        Evaluate(Number1, RatioCreationLineRec2."49");
                        RatioCreationLineRec1."49" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."49" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."50" <> '') and (RatioCreationLineRec2."50" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."50");
                        Evaluate(Number1, RatioCreationLineRec2."50");
                        RatioCreationLineRec1."50" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."50" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."51" <> '') and (RatioCreationLineRec2."51" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."51");
                        Evaluate(Number1, RatioCreationLineRec2."51");
                        RatioCreationLineRec1."51" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."51" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."52" <> '') and (RatioCreationLineRec2."52" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."52");
                        Evaluate(Number1, RatioCreationLineRec2."52");
                        RatioCreationLineRec1."52" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."52" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."53" <> '') and (RatioCreationLineRec2."53" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."53");
                        Evaluate(Number1, RatioCreationLineRec2."53");
                        RatioCreationLineRec1."53" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."53" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."54" <> '') and (RatioCreationLineRec2."54" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."54");
                        Evaluate(Number1, RatioCreationLineRec2."54");
                        RatioCreationLineRec1."54" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."54" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."55" <> '') and (RatioCreationLineRec2."55" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."55");
                        Evaluate(Number1, RatioCreationLineRec2."55");
                        RatioCreationLineRec1."55" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."55" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."56" <> '') and (RatioCreationLineRec2."56" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."56");
                        Evaluate(Number1, RatioCreationLineRec2."56");
                        RatioCreationLineRec1."56" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."56" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."57" <> '') and (RatioCreationLineRec2."57" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."57");
                        Evaluate(Number1, RatioCreationLineRec2."57");
                        RatioCreationLineRec1."57" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."57" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."58" <> '') and (RatioCreationLineRec2."58" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."58");
                        Evaluate(Number1, RatioCreationLineRec2."58");
                        RatioCreationLineRec1."58" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."58" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."59" <> '') and (RatioCreationLineRec2."59" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."59");
                        Evaluate(Number1, RatioCreationLineRec2."59");
                        RatioCreationLineRec1."59" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."59" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."60" <> '') and (RatioCreationLineRec2."60" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."60");
                        Evaluate(Number1, RatioCreationLineRec2."60");
                        RatioCreationLineRec1."60" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."60" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."61" <> '') and (RatioCreationLineRec2."61" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."61");
                        Evaluate(Number1, RatioCreationLineRec2."61");
                        RatioCreationLineRec1."61" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."61" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."62" <> '') and (RatioCreationLineRec2."62" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."62");
                        Evaluate(Number1, RatioCreationLineRec2."62");
                        RatioCreationLineRec1."62" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."62" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."63" <> '') and (RatioCreationLineRec2."63" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."63");
                        Evaluate(Number1, RatioCreationLineRec2."63");
                        RatioCreationLineRec1."63" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."63" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."64" <> '') and (RatioCreationLineRec2."64" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."64");
                        Evaluate(Number1, RatioCreationLineRec2."64");
                        RatioCreationLineRec1."64" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."64" := '0';


                    RatioCreationLineRec1.Modify();

                end;

                LineNo1 += 2;

            until MaxLineNo < LineNo1;

        end;

    end;


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit1: Boolean;


    trigger OnDeleteRecord(): Boolean
    var
        CurCreLineRec: Record CutCreationLine;
        RatioLineRec: Record RatioCreationLine;
        FabRec: Record FabricRequsition;
    begin

        if ("Record Type" = 'R') then begin

            //Check for cut creation
            CurCreLineRec.Reset();
            CurCreLineRec.SetRange("Marker Name", "Marker Name");
            CurCreLineRec.SetRange("Style No.", "Style No.");
            CurCreLineRec.SetRange("Colour No", "Colour No");
            CurCreLineRec.SetRange("Group ID", "Group ID");
            CurCreLineRec.SetRange("Component Group Code", "Component Group Code");

            if CurCreLineRec.FindSet() then begin
                Message('Cannot delete. Cut creation already created for this Marker : %1', "Marker Name");
                exit(false);
            end;

            //Check for Fabric Requsition
            FabRec.Reset();
            FabRec.SetRange("Marker Name", "Marker Name");
            FabRec.SetRange("Style No.", "Style No.");
            FabRec.SetRange("Group ID", "Group ID");
            FabRec.SetRange("Component Group Code", "Component Group Code");

            if FabRec.FindSet() then begin
                Message('Cannot delete. Fabric requsition has created for this Ratio');
                exit(false);
            end;

        end;

        if ("Record Type" = 'B') then begin

            //Get marker name            
            RatioLineRec.Reset();
            RatioLineRec.SetRange(RatioCreNo, RatioCreNo);
            RatioLineRec.SetRange("Group ID", "Group ID");
            RatioLineRec.SetRange("Style No.", "Style No.");
            RatioLineRec.SetRange("Colour No", "Colour No");
            RatioLineRec.SetRange("Component Group Code", "Component Group Code");
            RatioLineRec.SetRange(LineNo, ref);
            RatioLineRec.FindSet();

            CurCreLineRec.Reset();
            CurCreLineRec.SetRange("Marker Name", RatioLineRec."Marker Name");
            CurCreLineRec.SetRange("Style No.", "Style No.");
            CurCreLineRec.SetRange("Colour No", "Colour No");
            CurCreLineRec.SetRange("Group ID", "Group ID");
            CurCreLineRec.SetRange("Component Group Code", "Component Group Code");

            if CurCreLineRec.FindSet() then begin
                Message('Cannot delete. Cut creation already created for this Marker : %1', "Marker Name");
                exit(false);
            end;

        end;


        if ("Record Type" = 'H') or ("Record Type" = 'H1') then begin

            //Get Ration lines
            RatioLineRec.Reset();
            RatioLineRec.SetRange(RatioCreNo, RatioCreNo);
            RatioLineRec.SetRange("Group ID", "Group ID");
            RatioLineRec.SetRange("Style No.", "Style No.");
            RatioLineRec.SetRange("Colour No", "Colour No");
            RatioLineRec.SetRange("Component Group Code", "Component Group Code");
            RatioLineRec.SetFilter("Record Type", '=%1', 'R');

            if RatioLineRec.FindSet() then begin
                repeat

                    //Check for cut creation
                    CurCreLineRec.Reset();
                    CurCreLineRec.SetRange("Marker Name", RatioLineRec."Marker Name");
                    CurCreLineRec.SetRange("Style No.", RatioLineRec."Style No.");
                    CurCreLineRec.SetRange("Colour No", RatioLineRec."Colour No");
                    CurCreLineRec.SetRange("Group ID", RatioLineRec."Group ID");
                    CurCreLineRec.SetRange("Component Group Code", RatioLineRec."Component Group Code");

                    if CurCreLineRec.FindSet() then begin
                        Message('Cannot delete. Cut creation already created for this Marker %1', RatioLineRec."Marker Name");
                        exit(false);
                    end;

                    //Check for Fabric Requsition
                    FabRec.Reset();
                    FabRec.SetRange("Marker Name", RatioLineRec."Marker Name");
                    FabRec.SetRange("Style No.", RatioLineRec."Style No.");
                    FabRec.SetRange("Group ID", RatioLineRec."Group ID");
                    FabRec.SetRange("Component Group Code", RatioLineRec."Component Group Code");

                    if FabRec.FindSet() then begin
                        Message('Cannot delete. Fabric requsition has created for this Ratio');
                        exit(false);
                    end;

                until RatioLineRec.Next() = 0;
            end;

            //Delete all Ratio lines
            RatioLineRec.Reset();
            RatioLineRec.SetRange(RatioCreNo, RatioCreNo);
            if RatioLineRec.FindSet() then
                RatioLineRec.DeleteAll();

        end;

    end;

}