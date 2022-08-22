page 50353 DailyCuttingOutListPart
{
    PageType = ListPart;
    SourceTable = ProductionOutLine;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'Style';
                }

                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'Lot No';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'PO No';
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'Colour';
                }

                field("1"; "1")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }
                field("2"; "2")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("3"; "3")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("4"; "4")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("5"; "5")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("6"; "6")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("7"; "7")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("8"; "8")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("9"; "9")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("10"; "10")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("11"; "11")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("12"; "12")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("13"; "13")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("14"; "14")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("15"; "15")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("16"; "16")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("17"; "17")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("18"; "18")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("19"; "19")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("20"; "20")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("21"; "21")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("22"; "22")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("23"; "23")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("24"; "24")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("25"; "25")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("26"; "26")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("27"; "27")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("28"; "28")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("29"; "29")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("30"; "30")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("31"; "31")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("32"; "32")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("33"; "33")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("34"; "34")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("35"; "35")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("36"; "36")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("37"; "37")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("38"; "38")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("39"; "39")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("40"; "40")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("41"; "41")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("42"; "42")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("43"; "43")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("44"; "44")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("45"; "45")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("46"; "46")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("47"; "47")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }



                field("48"; "48")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("49"; "49")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("50"; "50")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("51"; "51")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("52"; "52")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("53"; "53")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("54"; "54")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("55"; "55")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("56"; "56")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("57"; "57")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("58"; "58")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("59"; "59")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("60"; "60")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("61"; "61")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("62"; "62")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("63"; "63")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("64"; "64")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field(Total; Total)
                {
                    ApplicationArea = All;
                    StyleExpr = 'strongaccent';
                    Editable = false;
                }
            }
        }
    }



    procedure CalTotal()
    var
        Count: Integer;
        Number: Integer;
        Tot: Integer;
    begin
        if "Colour Name" <> '*' then begin
            for Count := 1 To 64 do begin
                case Count of
                    1:
                        if "1" <> '' then
                            Evaluate(Number, "1")
                        else
                            Number := 0;
                    2:
                        if "2" <> '' then
                            Evaluate(Number, "2")
                        else
                            Number := 0;
                    3:
                        if "3" <> '' then
                            Evaluate(Number, "3")
                        else
                            Number := 0;
                    4:
                        if "4" <> '' then
                            Evaluate(Number, "4")
                        else
                            Number := 0;
                    5:
                        if "5" <> '' then
                            Evaluate(Number, "5")
                        else
                            Number := 0;
                    6:
                        if "6" <> '' then
                            Evaluate(Number, "6")
                        else
                            Number := 0;
                    7:
                        if "7" <> '' then
                            Evaluate(Number, "7")
                        else
                            Number := 0;
                    8:
                        if "8" <> '' then
                            Evaluate(Number, "8")
                        else
                            Number := 0;
                    9:
                        if "9" <> '' then
                            Evaluate(Number, "9")
                        else
                            Number := 0;
                    10:
                        if "10" <> '' then
                            Evaluate(Number, "10")
                        else
                            Number := 0;
                    11:
                        if "11" <> '' then
                            Evaluate(Number, "11")
                        else
                            Number := 0;
                    12:
                        if "12" <> '' then
                            Evaluate(Number, "12")
                        else
                            Number := 0;
                    13:
                        if "13" <> '' then
                            Evaluate(Number, "13")
                        else
                            Number := 0;
                    14:
                        if "14" <> '' then
                            Evaluate(Number, "14")
                        else
                            Number := 0;
                    15:
                        if "15" <> '' then
                            Evaluate(Number, "15")
                        else
                            Number := 0;
                    16:
                        if "16" <> '' then
                            Evaluate(Number, "16")
                        else
                            Number := 0;
                    17:
                        if "17" <> '' then
                            Evaluate(Number, "17")
                        else
                            Number := 0;
                    18:
                        if "18" <> '' then
                            Evaluate(Number, "18")
                        else
                            Number := 0;
                    19:
                        if "19" <> '' then
                            Evaluate(Number, "19")
                        else
                            Number := 0;
                    20:
                        if "20" <> '' then
                            Evaluate(Number, "20")
                        else
                            Number := 0;
                    21:
                        if "21" <> '' then
                            Evaluate(Number, "21")
                        else
                            Number := 0;
                    22:
                        if "22" <> '' then
                            Evaluate(Number, "22")
                        else
                            Number := 0;
                    23:
                        if "23" <> '' then
                            Evaluate(Number, "23")
                        else
                            Number := 0;
                    24:
                        if "24" <> '' then
                            Evaluate(Number, "24")
                        else
                            Number := 0;
                    25:
                        if "25" <> '' then
                            Evaluate(Number, "25")
                        else
                            Number := 0;
                    26:
                        if "26" <> '' then
                            Evaluate(Number, "26")
                        else
                            Number := 0;
                    27:
                        if "27" <> '' then
                            Evaluate(Number, "27")
                        else
                            Number := 0;
                    28:
                        if "28" <> '' then
                            Evaluate(Number, "28")
                        else
                            Number := 0;
                    29:
                        if "29" <> '' then
                            Evaluate(Number, "29")
                        else
                            Number := 0;
                    30:
                        if "30" <> '' then
                            Evaluate(Number, "30")
                        else
                            Number := 0;
                    31:
                        if "31" <> '' then
                            Evaluate(Number, "31")
                        else
                            Number := 0;
                    32:
                        if "32" <> '' then
                            Evaluate(Number, "32")
                        else
                            Number := 0;
                    33:
                        if "33" <> '' then
                            Evaluate(Number, "33")
                        else
                            Number := 0;
                    34:
                        if "34" <> '' then
                            Evaluate(Number, "34")
                        else
                            Number := 0;
                    35:
                        if "35" <> '' then
                            Evaluate(Number, "35")
                        else
                            Number := 0;
                    36:
                        if "36" <> '' then
                            Evaluate(Number, "36")
                        else
                            Number := 0;
                    37:
                        if "37" <> '' then
                            Evaluate(Number, "37")
                        else
                            Number := 0;
                    38:
                        if "38" <> '' then
                            Evaluate(Number, "38")
                        else
                            Number := 0;
                    39:
                        if "39" <> '' then
                            Evaluate(Number, "39")
                        else
                            Number := 0;
                    40:
                        if "40" <> '' then
                            Evaluate(Number, "40")
                        else
                            Number := 0;
                    41:
                        if "41" <> '' then
                            Evaluate(Number, "41")
                        else
                            Number := 0;
                    42:
                        if "42" <> '' then
                            Evaluate(Number, "42")
                        else
                            Number := 0;
                    43:
                        if "43" <> '' then
                            Evaluate(Number, "43")
                        else
                            Number := 0;
                    44:
                        if "44" <> '' then
                            Evaluate(Number, "44")
                        else
                            Number := 0;
                    45:
                        if "45" <> '' then
                            Evaluate(Number, "45")
                        else
                            Number := 0;
                    46:
                        if "46" <> '' then
                            Evaluate(Number, "46")
                        else
                            Number := 0;
                    47:
                        if "47" <> '' then
                            Evaluate(Number, "47")
                        else
                            Number := 0;
                    48:
                        if "48" <> '' then
                            Evaluate(Number, "48")
                        else
                            Number := 0;
                    49:
                        if "49" <> '' then
                            Evaluate(Number, "49")
                        else
                            Number := 0;
                    50:
                        if "50" <> '' then
                            Evaluate(Number, "50")
                        else
                            Number := 0;
                    51:
                        if "51" <> '' then
                            Evaluate(Number, "51")
                        else
                            Number := 0;
                    52:
                        if "52" <> '' then
                            Evaluate(Number, "52")
                        else
                            Number := 0;
                    53:
                        if "53" <> '' then
                            Evaluate(Number, "53")
                        else
                            Number := 0;
                    54:
                        if "54" <> '' then
                            Evaluate(Number, "54")
                        else
                            Number := 0;
                    55:
                        if "55" <> '' then
                            Evaluate(Number, "55")
                        else
                            Number := 0;
                    56:
                        if "56" <> '' then
                            Evaluate(Number, "56")
                        else
                            Number := 0;
                    57:
                        if "57" <> '' then
                            Evaluate(Number, "57")
                        else
                            Number := 0;
                    58:
                        if "58" <> '' then
                            Evaluate(Number, "58")
                        else
                            Number := 0;
                    59:
                        if "59" <> '' then
                            Evaluate(Number, "59")
                        else
                            Number := 0;
                    60:
                        if "60" <> '' then
                            Evaluate(Number, "60")
                        else
                            Number := 0;
                    61:
                        if "61" <> '' then
                            Evaluate(Number, "61")
                        else
                            Number := 0;
                    62:
                        if "62" <> '' then
                            Evaluate(Number, "62")
                        else
                            Number := 0;
                    63:
                        if "63" <> '' then
                            Evaluate(Number, "63")
                        else
                            Number := 0;
                    64:
                        if "64" <> '' then
                            Evaluate(Number, "64")
                        else
                            Number := 0;
                end;

                Tot := Tot + Number;
            end;
        end;

        Total := Tot;

        CurrPage.Update();
        Update_Sty_Master_PO();

    end;


    procedure Update_Sty_Master_PO()
    var
        StyleMasterPORec: Record "Style Master PO";
        ProductionOutLine: Record ProductionOutLine;
        ProdOutHeaderRec: Record ProductionOutHeader;
        LineTotal: BigInteger;
        OutputQtyVar: BigInteger;
        InputQtyVar: BigInteger;
    begin

        ProdOutHeaderRec.Reset();
        ProdOutHeaderRec.SetRange("No.", "No.");

        if ProdOutHeaderRec.FindSet() then begin
            OutputQtyVar := ProdOutHeaderRec."Output Qty";
            InputQtyVar := ProdOutHeaderRec."Input Qty";
        end;

        LineTotal := 0;

        //Get In/out Total
        ProductionOutLine.Reset();
        ProductionOutLine.SetRange("Style No.", "Style No.");
        ProductionOutLine.SetRange("Lot No.", "Lot No.");
        ProductionOutLine.SetRange(Type, Type);
        ProductionOutLine.SetRange(In_Out, In_Out);

        if ProductionOutLine.FindSet() then begin
            repeat
                if ProductionOutLine."Colour No" <> '*' then
                    LineTotal += ProductionOutLine.Total;
            until ProductionOutLine.Next() = 0;
        end;

        if In_Out = 'IN' then
            if InputQtyVar < LineTotal then
                Error('Input quantity should match color/size total quantity.');

        if In_Out = 'OUT' then
            if OutputQtyVar < LineTotal then
                Error('Output quantity should match color/size total quantity.');


        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange("Style No.", "Style No.");
        StyleMasterPORec.SetRange("Lot No.", "Lot No.");
        StyleMasterPORec.FindSet();

        CASE Type OF
            type::Saw:
                BEGIN
                    if In_Out = 'IN' then
                        StyleMasterPORec.ModifyAll("Sawing In Qty", LineTotal)
                    else
                        if In_Out = 'OUT' then
                            StyleMasterPORec.ModifyAll("Sawing Out Qty", LineTotal);
                END;
            type::Wash:
                begin
                    if In_Out = 'IN' then
                        StyleMasterPORec.ModifyAll("Wash In Qty", LineTotal)
                    else
                        if In_Out = 'OUT' then
                            StyleMasterPORec.ModifyAll("Wash Out Qty", LineTotal);
                end;
            type::Cut:
                begin
                    StyleMasterPORec.ModifyAll("Cut Out Qty", LineTotal);
                end;
            type::Emb:
                begin
                    if In_Out = 'IN' then
                        StyleMasterPORec.ModifyAll("Emb In Qty", LineTotal)
                    else
                        if In_Out = 'OUT' then
                            StyleMasterPORec.ModifyAll("Emb Out Qty", LineTotal);
                end;
            type::Print:
                begin
                    if In_Out = 'IN' then
                        StyleMasterPORec.ModifyAll("Print In Qty", LineTotal)
                    else
                        if In_Out = 'OUT' then
                            StyleMasterPORec.ModifyAll("print Out Qty", LineTotal);
                end;
            type::Fin:
                begin
                    StyleMasterPORec.ModifyAll("Finish Qty", LineTotal);
                end;
            type::Ship:
                begin
                    StyleMasterPORec.ModifyAll("Shipped Qty", LineTotal);
                end;
        END;

        CurrPage.Update();

    end;


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorSewing(Rec);

        if "Colour Name" = '*' then begin
            Clear(SetEdit);
            SetEdit := false;
        end
        ELSE begin
            Clear(SetEdit);
            SetEdit := true;
        end;
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit: Boolean;

}