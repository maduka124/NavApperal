page 50588 "Sewing Job Creation ListPart1"
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = AssorColorSizeRatio;
    SourceTableView = sorting("Style No.", "Lot No.", "Country Name") order(ascending);
    // where("Colour Name" = filter('*'));
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Lot No';
                }

                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'PO No';
                }

                field("Country Name"; Rec."Country Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Country';
                }

                field(ShipDate; Rec.ShipDate)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Ship Date';
                }

                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Caption = 'Order Qty';
                }

                field("Colour Name"; Rec."Colour Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Caption = 'Colour';
                }

                field("1"; Rec."1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible1;
                }
                field("2"; Rec."2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible2;
                }

                field("3"; Rec."3")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible3;
                }

                field("4"; Rec."4")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible4;
                }

                field("5"; Rec."5")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible5;
                }

                field("6"; Rec."6")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible6;
                }

                field("7"; Rec."7")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible7;
                }

                field("8"; Rec."8")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible8;
                }

                field("9"; Rec."9")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible9;
                }

                field("10"; Rec."10")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible10;
                }

                field("11"; Rec."11")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible11;
                }

                field("12"; Rec."12")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible12;
                }

                field("13"; Rec."13")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible13;
                }

                field("14"; Rec."14")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible14;
                }

                field("15"; Rec."15")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible15;
                }

                field("16"; Rec."16")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible16;
                }

                field("17"; Rec."17")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible17;
                }

                field("18"; Rec."18")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible18;
                }

                field("19"; Rec."19")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible19;
                }

                field("20"; Rec."20")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible20;
                }

                field("21"; Rec."21")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible21;
                }

                field("22"; Rec."22")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible22;
                }

                field("23"; Rec."23")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible23;
                }

                field("24"; Rec."24")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible24;
                }

                field("25"; Rec."25")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible25;
                }

                field("26"; Rec."26")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible26;
                }

                field("27"; Rec."27")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible27;
                }

                field("28"; Rec."28")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible28;
                }

                field("29"; Rec."29")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible29;
                }

                field("30"; Rec."30")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible30;
                }

                field("31"; Rec."31")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible31;
                }

                field("32"; Rec."32")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible32;
                }

                field("33"; Rec."33")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible33;
                }

                field("34"; Rec."34")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible34;
                }

                field("35"; Rec."35")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible35;
                }

                field("36"; Rec."36")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible36;
                }

                field("37"; Rec."37")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible37;
                }

                field("38"; Rec."38")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible38;
                }

                field("39"; Rec."39")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible39;
                }

                field("40"; Rec."40")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible40;
                }

                field("41"; Rec."41")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible41;
                }


                field("42"; Rec."42")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible42;
                }


                field("43"; Rec."43")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible43;
                }


                field("44"; Rec."44")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible44;
                }


                field("45"; Rec."45")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible45;
                }


                field("46"; Rec."46")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible46;
                }


                field("47"; Rec."47")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible47;
                }

                field("48"; Rec."48")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible48;
                }

                field("49"; Rec."49")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible49;
                }

                field("50"; Rec."50")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible50;
                }

                field("51"; Rec."51")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible51;
                }

                field("52"; Rec."52")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible52;
                }

                field("53"; Rec."53")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible53;
                }

                field("54"; Rec."54")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible54;
                }

                field("55"; Rec."55")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible55;
                }

                field("56"; Rec."56")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible56;
                }

                field("57"; Rec."57")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible57;
                }

                field("58"; Rec."58")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible58;
                }

                field("59"; Rec."59")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible59;
                }

                field("60"; Rec."60")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible60;
                }

                field("61"; Rec."61")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible61;
                }

                field("62"; Rec."62")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible62;
                }

                field("63"; Rec."63")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible63;
                }

                field("64"; Rec."64")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Visible = SetVisible64;
                }

                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Caption = 'Colour Qty';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Rowcount: Integer;
        Count: Integer;
        AssoDetail: Record AssortmentDetailsInseam;
        StyleMasPoRec: Record "Style Master PO";
    begin
        StyleExprTxt := ChangeColor.ChangeColorAsso(Rec);

        StyleMasPoRec.Reset();
        StyleMasPoRec.SetRange("Style No.", Rec."Style No.");
        StyleMasPoRec.FindSet();

        repeat

            AssoDetail.Reset();
            AssoDetail.SetRange("Style No.", Rec."Style No.");
            AssoDetail.SetRange("Lot No.", StyleMasPoRec."lot No.");

            if AssoDetail.FindSet() then begin
                if RowCountGL <= AssoDetail.Count then begin
                    Rowcount := AssoDetail.Count;
                    RowCountGL := AssoDetail.Count;
                end
                else
                    Rowcount := RowCountGL;
            end;

        until StyleMasPoRec.Next() = 0;

        for Count := 1 To 64 do begin
            case Count of
                1:
                    if Rowcount >= Count then
                        SetVisible1 := true
                    else
                        SetVisible1 := false;
                2:
                    if Rowcount >= Count then
                        SetVisible2 := true
                    else
                        SetVisible2 := false;
                3:
                    if Rowcount >= Count then
                        SetVisible3 := true
                    else
                        SetVisible3 := false;
                4:
                    if Rowcount >= Count then
                        SetVisible4 := true
                    else
                        SetVisible4 := false;
                5:
                    if Rowcount >= Count then
                        SetVisible5 := true
                    else
                        SetVisible5 := false;
                6:
                    if Rowcount >= Count then
                        SetVisible6 := true
                    else
                        SetVisible6 := false;
                7:
                    if Rowcount >= Count then
                        SetVisible7 := true
                    else
                        SetVisible7 := false;
                8:
                    if Rowcount >= Count then
                        SetVisible8 := true
                    else
                        SetVisible8 := false;
                9:
                    if Rowcount >= Count then
                        SetVisible9 := true
                    else
                        SetVisible9 := false;
                10:
                    if Rowcount >= Count then
                        SetVisible10 := true
                    else
                        SetVisible10 := false;
                11:
                    if Rowcount >= Count then
                        SetVisible11 := true
                    else
                        SetVisible11 := false;
                12:
                    if Rowcount >= Count then
                        SetVisible12 := true
                    else
                        SetVisible12 := false;
                13:
                    if Rowcount >= Count then
                        SetVisible13 := true
                    else
                        SetVisible13 := false;
                14:
                    if Rowcount >= Count then
                        SetVisible14 := true
                    else
                        SetVisible14 := false;
                15:
                    if Rowcount >= Count then
                        SetVisible15 := true
                    else
                        SetVisible15 := false;
                16:
                    if Rowcount >= Count then
                        SetVisible16 := true
                    else
                        SetVisible16 := false;
                17:
                    if Rowcount >= Count then
                        SetVisible17 := true
                    else
                        SetVisible17 := false;
                18:
                    if Rowcount >= Count then
                        SetVisible18 := true
                    else
                        SetVisible18 := false;
                19:
                    if Rowcount >= Count then
                        SetVisible19 := true
                    else
                        SetVisible19 := false;
                20:
                    if Rowcount >= Count then
                        SetVisible20 := true
                    else
                        SetVisible20 := false;
                21:
                    if Rowcount >= Count then
                        SetVisible21 := true
                    else
                        SetVisible21 := false;
                22:
                    if Rowcount >= Count then
                        SetVisible22 := true
                    else
                        SetVisible22 := false;
                23:
                    if Rowcount >= Count then
                        SetVisible23 := true
                    else
                        SetVisible23 := false;
                24:
                    if Rowcount >= Count then
                        SetVisible24 := true
                    else
                        SetVisible24 := false;
                25:
                    if Rowcount >= Count then
                        SetVisible25 := true
                    else
                        SetVisible25 := false;
                26:
                    if Rowcount >= Count then
                        SetVisible26 := true
                    else
                        SetVisible26 := false;
                27:
                    if Rowcount >= Count then
                        SetVisible27 := true
                    else
                        SetVisible27 := false;
                28:
                    if Rowcount >= Count then
                        SetVisible28 := true
                    else
                        SetVisible28 := false;
                29:
                    if Rowcount >= Count then
                        SetVisible29 := true
                    else
                        SetVisible29 := false;
                30:
                    if Rowcount >= Count then
                        SetVisible30 := true
                    else
                        SetVisible30 := false;
                31:
                    if Rowcount >= Count then
                        SetVisible31 := true
                    else
                        SetVisible31 := false;
                32:
                    if Rowcount >= Count then
                        SetVisible32 := true
                    else
                        SetVisible32 := false;
                33:
                    if Rowcount >= Count then
                        SetVisible33 := true
                    else
                        SetVisible33 := false;
                34:
                    if Rowcount >= Count then
                        SetVisible34 := true
                    else
                        SetVisible34 := false;
                35:
                    if Rowcount >= Count then
                        SetVisible35 := true
                    else
                        SetVisible35 := false;
                36:
                    if Rowcount >= Count then
                        SetVisible36 := true
                    else
                        SetVisible36 := false;
                37:
                    if Rowcount >= Count then
                        SetVisible37 := true
                    else
                        SetVisible37 := false;
                38:
                    if Rowcount >= Count then
                        SetVisible38 := true
                    else
                        SetVisible38 := false;
                39:
                    if Rowcount >= Count then
                        SetVisible39 := true
                    else
                        SetVisible39 := false;
                40:
                    if Rowcount >= Count then
                        SetVisible40 := true
                    else
                        SetVisible40 := false;
                41:
                    if Rowcount >= Count then
                        SetVisible41 := true
                    else
                        SetVisible41 := false;
                42:
                    if Rowcount >= Count then
                        SetVisible42 := true
                    else
                        SetVisible42 := false;
                43:
                    if Rowcount >= Count then
                        SetVisible43 := true
                    else
                        SetVisible43 := false;
                44:
                    if Rowcount >= Count then
                        SetVisible44 := true
                    else
                        SetVisible44 := false;
                45:
                    if Rowcount >= Count then
                        SetVisible45 := true
                    else
                        SetVisible45 := false;
                46:
                    if Rowcount >= Count then
                        SetVisible46 := true
                    else
                        SetVisible46 := false;
                47:
                    if Rowcount >= Count then
                        SetVisible47 := true
                    else
                        SetVisible47 := false;
                48:
                    if Rowcount >= Count then
                        SetVisible48 := true
                    else
                        SetVisible48 := false;
                49:
                    if Rowcount >= Count then
                        SetVisible49 := true
                    else
                        SetVisible49 := false;
                50:
                    if Rowcount >= Count then
                        SetVisible50 := true
                    else
                        SetVisible50 := false;
                51:
                    if Rowcount >= Count then
                        SetVisible51 := true
                    else
                        SetVisible51 := false;
                52:
                    if Rowcount >= Count then
                        SetVisible52 := true
                    else
                        SetVisible52 := false;
                53:
                    if Rowcount >= Count then
                        SetVisible53 := true
                    else
                        SetVisible53 := false;
                54:
                    if Rowcount >= Count then
                        SetVisible54 := true
                    else
                        SetVisible54 := false;
                55:
                    if Rowcount >= Count then
                        SetVisible55 := true
                    else
                        SetVisible55 := false;
                56:
                    if Rowcount >= Count then
                        SetVisible56 := true
                    else
                        SetVisible56 := false;
                57:
                    if Rowcount >= Count then
                        SetVisible57 := true
                    else
                        SetVisible57 := false;
                58:
                    if Rowcount >= Count then
                        SetVisible58 := true
                    else
                        SetVisible58 := false;
                59:
                    if Rowcount >= Count then
                        SetVisible59 := true
                    else
                        SetVisible59 := false;
                60:
                    if Rowcount >= Count then
                        SetVisible60 := true
                    else
                        SetVisible60 := false;
                61:
                    if Rowcount >= Count then
                        SetVisible61 := true
                    else
                        SetVisible61 := false;
                62:
                    if Rowcount >= Count then
                        SetVisible62 := true
                    else
                        SetVisible62 := false;
                63:
                    if Rowcount >= Count then
                        SetVisible63 := true
                    else
                        SetVisible63 := false;
                64:
                    if Rowcount >= Count then
                        SetVisible64 := true
                    else
                        SetVisible64 := false;
            end;
        end;

        if Rec."Colour Name" = '*' then begin
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
        RowCountGL: Integer;
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit: Boolean;
        SetVisible1: Boolean;
        SetVisible2: Boolean;
        SetVisible3: Boolean;
        SetVisible4: Boolean;
        SetVisible5: Boolean;
        SetVisible6: Boolean;
        SetVisible7: Boolean;
        SetVisible8: Boolean;
        SetVisible9: Boolean;
        SetVisible10: Boolean;
        SetVisible11: Boolean;
        SetVisible12: Boolean;
        SetVisible13: Boolean;
        SetVisible14: Boolean;
        SetVisible15: Boolean;
        SetVisible16: Boolean;
        SetVisible17: Boolean;
        SetVisible18: Boolean;
        SetVisible19: Boolean;
        SetVisible20: Boolean;
        SetVisible21: Boolean;
        SetVisible22: Boolean;
        SetVisible23: Boolean;
        SetVisible24: Boolean;
        SetVisible25: Boolean;
        SetVisible26: Boolean;
        SetVisible27: Boolean;
        SetVisible28: Boolean;
        SetVisible29: Boolean;
        SetVisible30: Boolean;
        SetVisible31: Boolean;
        SetVisible32: Boolean;
        SetVisible33: Boolean;
        SetVisible34: Boolean;
        SetVisible35: Boolean;
        SetVisible36: Boolean;
        SetVisible37: Boolean;
        SetVisible38: Boolean;
        SetVisible39: Boolean;
        SetVisible40: Boolean;
        SetVisible41: Boolean;
        SetVisible42: Boolean;
        SetVisible43: Boolean;
        SetVisible44: Boolean;
        SetVisible45: Boolean;
        SetVisible46: Boolean;
        SetVisible47: Boolean;
        SetVisible48: Boolean;
        SetVisible49: Boolean;
        SetVisible50: Boolean;
        SetVisible51: Boolean;
        SetVisible52: Boolean;
        SetVisible53: Boolean;
        SetVisible54: Boolean;
        SetVisible55: Boolean;
        SetVisible56: Boolean;
        SetVisible57: Boolean;
        SetVisible58: Boolean;
        SetVisible59: Boolean;
        SetVisible60: Boolean;
        SetVisible61: Boolean;
        SetVisible62: Boolean;
        SetVisible63: Boolean;
        SetVisible64: Boolean;
}