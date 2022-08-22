page 71012823 "YY Requsition ListPart"
{
    PageType = ListPart;
    SourceTable = "YY Requsition Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                    Editable = false;
                }

                field("YY Type"; "YY Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        YYTypeRec: Record "YY Type";
                    begin
                        YYTypeRec.Reset();
                        YYTypeRec.SetRange("YY Type Desc", "YY Type");
                        if YYTypeRec.FindSet() then
                            "YY Type No." := YYTypeRec."No.";
                    end;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                        if MainCategoryRec.FindSet() then
                            "Main Category No." := MainCategoryRec."No.";
                    end;
                }

                field("Fabric/Time Desc"; "Fabric/Time Desc")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric/Time Description';
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", "Color Name");
                        if ColourRec.FindSet() then
                            "Color No" := ColourRec."No.";
                    end;
                }

                field("Wash Type Name"; "Wash Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';

                    trigger OnValidate()
                    var
                        WashTypeRec: Record "Wash Type";
                    begin
                        WashTypeRec.Reset();
                        WashTypeRec.SetRange("Wash Type Name", "Wash Type Name");
                        if WashTypeRec.FindSet() then
                            "Wash Type No" := WashTypeRec."No.";
                    end;
                }

                field(Width; Width)
                {
                    ApplicationArea = All;
                }

                field("Skincage (L)"; "Skincage (L)")
                {
                    ApplicationArea = All;
                }

                field("Width( W)"; "Width( W)")
                {
                    ApplicationArea = All;
                }

                field("TARGET YY"; "TARGET YY")
                {
                    ApplicationArea = All;
                }

                field("Acutal YY"; "Acutal YY")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }

                field("1"; "1")
                {
                    ApplicationArea = All;
                }
                field("2"; "2")
                {
                    ApplicationArea = All;
                }

                field("3"; "3")
                {
                    ApplicationArea = All;
                }

                field("4"; "4")
                {
                    ApplicationArea = All;
                }

                field("5"; "5")
                {
                    ApplicationArea = All;
                }

                field("6"; "6")
                {
                    ApplicationArea = All;
                }

                field("7"; "7")
                {
                    ApplicationArea = All;
                }

                field("8"; "8")
                {
                    ApplicationArea = All;
                }

                field("9"; "9")
                {
                    ApplicationArea = All;
                }

                field("10"; "10")
                {
                    ApplicationArea = All;
                }

                field("11"; "11")
                {
                    ApplicationArea = All;
                }

                field("12"; "12")
                {
                    ApplicationArea = All;
                }

                field("13"; "13")
                {
                    ApplicationArea = All;
                }

                field("14"; "14")
                {
                    ApplicationArea = All;
                }

                field("15"; "15")
                {
                    ApplicationArea = All;
                }

                field("16"; "16")
                {
                    ApplicationArea = All;
                }

                field("17"; "17")
                {
                    ApplicationArea = All;
                }

                field("18"; "18")
                {
                    ApplicationArea = All;
                }

                field("19"; "19")
                {
                    ApplicationArea = All;
                }

                field("20"; "20")
                {
                    ApplicationArea = All;
                }

                field("21"; "21")
                {
                    ApplicationArea = All;
                }

                field("22"; "22")
                {
                    ApplicationArea = All;
                }

                field("23"; "23")
                {
                    ApplicationArea = All;
                }

                field("24"; "24")
                {
                    ApplicationArea = All;
                }

                field("25"; "25")
                {
                    ApplicationArea = All;
                }

                field("26"; "26")
                {
                    ApplicationArea = All;
                }

                field("27"; "27")
                {
                    ApplicationArea = All;
                }

                field("28"; "28")
                {
                    ApplicationArea = All;
                }

                field("29"; "29")
                {
                    ApplicationArea = All;
                }

                field("30"; "30")
                {
                    ApplicationArea = All;
                }

                field("31"; "31")
                {
                    ApplicationArea = All;
                }

                field("32"; "32")
                {
                    ApplicationArea = All;
                }

                field("33"; "33")
                {
                    ApplicationArea = All;
                }

                field("34"; "34")
                {
                    ApplicationArea = All;
                }

                field("35"; "35")
                {
                    ApplicationArea = All;
                }

                field("36"; "36")
                {
                    ApplicationArea = All;
                }

                field("37"; "37")
                {
                    ApplicationArea = All;
                }

                field("38"; "38")
                {
                    ApplicationArea = All;
                }

                field("39"; "39")
                {
                    ApplicationArea = All;
                }

                field("40"; "40")
                {
                    ApplicationArea = All;
                }

                field("41"; "41")
                {
                    ApplicationArea = All;
                }

                field("42"; "42")
                {
                    ApplicationArea = All;
                }

                field("43"; "43")
                {
                    ApplicationArea = All;
                }

                field("44"; "44")
                {
                    ApplicationArea = All;
                }

                field("45"; "45")
                {
                    ApplicationArea = All;
                }

                field("46"; "46")
                {
                    ApplicationArea = All;
                }

                field("47"; "47")
                {
                    ApplicationArea = All;
                }

                field("48"; "48")
                {
                    ApplicationArea = All;
                }

                field("49"; "49")
                {
                    ApplicationArea = All;
                }

                field("50"; "50")
                {
                    ApplicationArea = All;
                }

                field("51"; "51")
                {
                    ApplicationArea = All;
                }

                field("52"; "52")
                {
                    ApplicationArea = All;
                }

                field("53"; "53")
                {
                    ApplicationArea = All;
                }

                field("54"; "54")
                {
                    ApplicationArea = All;
                }

                field("55"; "55")
                {
                    ApplicationArea = All;
                }

                field("56"; "56")
                {
                    ApplicationArea = All;
                }

                field("57"; "57")
                {
                    ApplicationArea = All;
                }

                field("58"; "58")
                {
                    ApplicationArea = All;
                }

                field("59"; "59")
                {
                    ApplicationArea = All;
                }

                field("60"; "60")
                {
                    ApplicationArea = All;
                }

                field("61"; "61")
                {
                    ApplicationArea = All;
                }

                field("62"; "62")
                {
                    ApplicationArea = All;
                }

                field("63"; "63")
                {
                    ApplicationArea = All;
                }

                field("64"; "64")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}