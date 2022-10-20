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
                    Editable = SetEdit1;

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
                    Editable = SetEdit1;

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
                    Caption = 'Fabric/Item Description';
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, "Fabric/Time Desc");
                        if ItemRec.FindSet() then
                            "Fabric/Time Desc No" := ItemRec."No.";
                    end;
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    Editable = SetEdit1;

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
                    Editable = SetEdit1;

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
                    Editable = SetEdit1;
                }

                field("Skincage (L)"; "Skincage (L)")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("Width( W)"; "Width( W)")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("TARGET YY"; "TARGET YY")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("Acutal YY"; "Acutal YY")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("1"; "1")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }
                field("2"; "2")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("3"; "3")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("4"; "4")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("5"; "5")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("6"; "6")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("7"; "7")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("8"; "8")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("9"; "9")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("10"; "10")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("11"; "11")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("12"; "12")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("13"; "13")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("14"; "14")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("15"; "15")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("16"; "16")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("17"; "17")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("18"; "18")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("19"; "19")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("20"; "20")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("21"; "21")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("22"; "22")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("23"; "23")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("24"; "24")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("25"; "25")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("26"; "26")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("27"; "27")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("28"; "28")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("29"; "29")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("30"; "30")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("31"; "31")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("32"; "32")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("33"; "33")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("34"; "34")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("35"; "35")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("36"; "36")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("37"; "37")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("38"; "38")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("39"; "39")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("40"; "40")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("41"; "41")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("42"; "42")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("43"; "43")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("44"; "44")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("45"; "45")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("46"; "46")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("47"; "47")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("48"; "48")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("49"; "49")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("50"; "50")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("51"; "51")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("52"; "52")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("53"; "53")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("54"; "54")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("55"; "55")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("56"; "56")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("57"; "57")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("58"; "58")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("59"; "59")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("60"; "60")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("61"; "61")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("62"; "62")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("63"; "63")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("64"; "64")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then
            UserRole := UserRec.UserRole;

        if UserRole = 'CAD' then
            SetEdit1 := false
        else
            SetEdit1 := true;
    end;

    var
        SetEdit1: Boolean;
        UserRole: Text[50];
}