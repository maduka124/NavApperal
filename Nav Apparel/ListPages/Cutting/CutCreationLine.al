page 50598 "Cut Creation Line"
{
    PageType = ListPart;
    SourceTable = CutCreationLine;
    SourceTableView = sorting("CutCreNo.", "Marker Name", "Line No") order(ascending);
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Group ID"; Rec."Group ID")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = false;
                }

                field("Marker Name"; Rec."Marker Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Caption = 'Marker';
                }

                field("Cut No"; Rec."Cut No")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }

                field(Plies; Rec.Plies)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }

                field("1"; Rec."1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible1;
                }
                field("2"; Rec."2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible2;
                }

                field("3"; Rec."3")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible3;
                }

                field("4"; Rec."4")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible4;
                }

                field("5"; Rec."5")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible5;
                }

                field("6"; Rec."6")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible6;
                }

                field("7"; Rec."7")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible7;
                }

                field("8"; Rec."8")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible8;
                }

                field("9"; Rec."9")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible9;
                }

                field("10"; Rec."10")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible10;
                }

                field("11"; Rec."11")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible11;
                }

                field("12"; Rec."12")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible12;
                }

                field("13"; Rec."13")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible13;
                }

                field("14"; Rec."14")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible14;
                }

                field("15"; Rec."15")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible15;
                }

                field("16"; Rec."16")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible16;
                }

                field("17"; Rec."17")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible17;
                }

                field("18"; Rec."18")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible18;
                }

                field("19"; Rec."19")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible19;
                }

                field("20"; Rec."20")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible20;
                }

                field("21"; Rec."21")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible21;
                }

                field("22"; Rec."22")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible22;
                }

                field("23"; Rec."23")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible23;
                }

                field("24"; Rec."24")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible24;
                }

                field("25"; Rec."25")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible25;
                }

                field("26"; Rec."26")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible26;
                }

                field("27"; Rec."27")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible27;
                }

                field("28"; Rec."28")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible28;
                }

                field("29"; Rec."29")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible29;
                }

                field("30"; Rec."30")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible30;
                }

                field("31"; Rec."31")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible31;
                }

                field("32"; Rec."32")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible32;
                }

                field("33"; Rec."33")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible33;
                }

                field("34"; Rec."34")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible34;
                }

                field("35"; Rec."35")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible35;
                }

                field("36"; Rec."36")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible36;
                }

                field("37"; Rec."37")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible37;
                }

                field("38"; Rec."38")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible38;
                }

                field("39"; Rec."39")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible39;
                }

                field("40"; Rec."40")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible40;
                }

                field("41"; Rec."41")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible41;
                }

                field("42"; Rec."42")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible42;
                }

                field("43"; Rec."43")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible43;
                }

                field("44"; Rec."44")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible44;
                }

                field("45"; Rec."45")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible45;
                }


                field("46"; Rec."46")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible46;
                }

                field("47"; Rec."47")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible47;
                }

                field("48"; Rec."48")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible48;
                }

                field("49"; Rec."49")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible49;
                }

                field("50"; Rec."50")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible50;
                }

                field("51"; Rec."51")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible51;
                }

                field("52"; Rec."52")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible52;
                }

                field("53"; Rec."53")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible53;
                }

                field("54"; Rec."54")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible54;
                }

                field("55"; Rec."55")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible55;
                }

                field("56"; Rec."56")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible56;
                }

                field("57"; Rec."57")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible57;
                }

                field("58"; Rec."58")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible58;
                }

                field("59"; Rec."59")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible59;
                }

                field("60"; Rec."60")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible60;
                }

                field("61"; Rec."61")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible61;
                }

                field("62"; Rec."62")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible62;
                }

                field("63"; Rec."63")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible63;
                }

                field("64"; Rec."64")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible64;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    var
        Rowcount: Integer;
        Count: Integer;
        CutCreLineRec: Record CutCreationLine;
    begin
        StyleExprTxt := ChangeColor.ChangeColorCutCreation(Rec);

        CutCreLineRec.Reset();
        CutCreLineRec.SetRange("CutCreNo.", Rec."CutCreNo.");
        CutCreLineRec.SetFilter("Record Type", '=%1', 'H');
        //CutCreLineRec.SetFilter("Cut No", '=%1', 0);
        CutCreLineRec.FindSet();

        for Count := 1 To 64 do begin
            case Count of
                1:
                    if CutCreLineRec."1" <> '' then
                        SetVisible1 := true
                    else
                        SetVisible1 := false;
                2:
                    if CutCreLineRec."2" <> '' then
                        SetVisible2 := true
                    else
                        SetVisible2 := false;
                3:
                    if CutCreLineRec."3" <> '' then
                        SetVisible3 := true
                    else
                        SetVisible3 := false;
                4:
                    if CutCreLineRec."4" <> '' then
                        SetVisible4 := true
                    else
                        SetVisible4 := false;
                5:
                    if CutCreLineRec."5" <> '' then
                        SetVisible5 := true
                    else
                        SetVisible5 := false;
                6:
                    if CutCreLineRec."6" <> '' then
                        SetVisible6 := true
                    else
                        SetVisible6 := false;
                7:
                    if CutCreLineRec."7" <> '' then
                        SetVisible7 := true
                    else
                        SetVisible7 := false;
                8:
                    if CutCreLineRec."8" <> '' then
                        SetVisible8 := true
                    else
                        SetVisible8 := false;
                9:
                    if CutCreLineRec."9" <> '' then
                        SetVisible9 := true
                    else
                        SetVisible9 := false;
                10:
                    if CutCreLineRec."10" <> '' then
                        SetVisible10 := true
                    else
                        SetVisible10 := false;
                11:
                    if CutCreLineRec."11" <> '' then
                        SetVisible11 := true
                    else
                        SetVisible11 := false;
                12:
                    if CutCreLineRec."12" <> '' then
                        SetVisible12 := true
                    else
                        SetVisible12 := false;
                13:
                    if CutCreLineRec."13" <> '' then
                        SetVisible13 := true
                    else
                        SetVisible13 := false;
                14:
                    if CutCreLineRec."14" <> '' then
                        SetVisible14 := true
                    else
                        SetVisible14 := false;
                15:
                    if CutCreLineRec."15" <> '' then
                        SetVisible15 := true
                    else
                        SetVisible15 := false;
                16:
                    if CutCreLineRec."16" <> '' then
                        SetVisible16 := true
                    else
                        SetVisible16 := false;
                17:
                    if CutCreLineRec."17" <> '' then
                        SetVisible17 := true
                    else
                        SetVisible17 := false;
                18:
                    if CutCreLineRec."18" <> '' then
                        SetVisible18 := true
                    else
                        SetVisible18 := false;
                19:
                    if CutCreLineRec."19" <> '' then
                        SetVisible19 := true
                    else
                        SetVisible19 := false;
                20:
                    if CutCreLineRec."20" <> '' then
                        SetVisible20 := true
                    else
                        SetVisible20 := false;
                21:
                    if CutCreLineRec."21" <> '' then
                        SetVisible21 := true
                    else
                        SetVisible21 := false;
                22:
                    if CutCreLineRec."22" <> '' then
                        SetVisible22 := true
                    else
                        SetVisible22 := false;
                23:
                    if CutCreLineRec."23" <> '' then
                        SetVisible23 := true
                    else
                        SetVisible23 := false;
                24:
                    if CutCreLineRec."24" <> '' then
                        SetVisible24 := true
                    else
                        SetVisible24 := false;
                25:
                    if CutCreLineRec."25" <> '' then
                        SetVisible25 := true
                    else
                        SetVisible25 := false;
                26:
                    if CutCreLineRec."26" <> '' then
                        SetVisible26 := true
                    else
                        SetVisible26 := false;
                27:
                    if CutCreLineRec."27" <> '' then
                        SetVisible27 := true
                    else
                        SetVisible27 := false;
                28:
                    if CutCreLineRec."28" <> '' then
                        SetVisible28 := true
                    else
                        SetVisible28 := false;
                29:
                    if CutCreLineRec."29" <> '' then
                        SetVisible29 := true
                    else
                        SetVisible29 := false;
                30:
                    if CutCreLineRec."30" <> '' then
                        SetVisible30 := true
                    else
                        SetVisible30 := false;
                31:
                    if CutCreLineRec."31" <> '' then
                        SetVisible31 := true
                    else
                        SetVisible31 := false;
                32:
                    if CutCreLineRec."32" <> '' then
                        SetVisible32 := true
                    else
                        SetVisible32 := false;
                33:
                    if CutCreLineRec."33" <> '' then
                        SetVisible33 := true
                    else
                        SetVisible33 := false;
                34:
                    if CutCreLineRec."34" <> '' then
                        SetVisible34 := true
                    else
                        SetVisible34 := false;
                35:
                    if CutCreLineRec."35" <> '' then
                        SetVisible35 := true
                    else
                        SetVisible35 := false;
                36:
                    if CutCreLineRec."36" <> '' then
                        SetVisible36 := true
                    else
                        SetVisible36 := false;
                37:
                    if CutCreLineRec."37" <> '' then
                        SetVisible37 := true
                    else
                        SetVisible37 := false;
                38:
                    if CutCreLineRec."38" <> '' then
                        SetVisible38 := true
                    else
                        SetVisible38 := false;
                39:
                    if CutCreLineRec."39" <> '' then
                        SetVisible39 := true
                    else
                        SetVisible39 := false;
                40:
                    if CutCreLineRec."40" <> '' then
                        SetVisible40 := true
                    else
                        SetVisible40 := false;
                41:
                    if CutCreLineRec."41" <> '' then
                        SetVisible41 := true
                    else
                        SetVisible41 := false;
                42:
                    if CutCreLineRec."42" <> '' then
                        SetVisible42 := true
                    else
                        SetVisible42 := false;
                43:
                    if CutCreLineRec."43" <> '' then
                        SetVisible43 := true
                    else
                        SetVisible43 := false;
                44:
                    if CutCreLineRec."44" <> '' then
                        SetVisible44 := true
                    else
                        SetVisible44 := false;
                45:
                    if CutCreLineRec."45" <> '' then
                        SetVisible45 := true
                    else
                        SetVisible45 := false;
                46:
                    if CutCreLineRec."46" <> '' then
                        SetVisible46 := true
                    else
                        SetVisible46 := false;
                47:
                    if CutCreLineRec."47" <> '' then
                        SetVisible47 := true
                    else
                        SetVisible47 := false;
                48:
                    if CutCreLineRec."48" <> '' then
                        SetVisible48 := true
                    else
                        SetVisible48 := false;
                49:
                    if CutCreLineRec."49" <> '' then
                        SetVisible49 := true
                    else
                        SetVisible49 := false;
                50:
                    if CutCreLineRec."50" <> '' then
                        SetVisible50 := true
                    else
                        SetVisible50 := false;
                51:
                    if CutCreLineRec."51" <> '' then
                        SetVisible51 := true
                    else
                        SetVisible51 := false;
                52:
                    if CutCreLineRec."52" <> '' then
                        SetVisible52 := true
                    else
                        SetVisible52 := false;
                53:
                    if CutCreLineRec."53" <> '' then
                        SetVisible53 := true
                    else
                        SetVisible53 := false;
                54:
                    if CutCreLineRec."54" <> '' then
                        SetVisible54 := true
                    else
                        SetVisible54 := false;
                55:
                    if CutCreLineRec."55" <> '' then
                        SetVisible55 := true
                    else
                        SetVisible55 := false;
                56:
                    if CutCreLineRec."56" <> '' then
                        SetVisible56 := true
                    else
                        SetVisible56 := false;
                57:
                    if CutCreLineRec."57" <> '' then
                        SetVisible57 := true
                    else
                        SetVisible57 := false;
                58:
                    if CutCreLineRec."58" <> '' then
                        SetVisible58 := true
                    else
                        SetVisible58 := false;
                59:
                    if CutCreLineRec."59" <> '' then
                        SetVisible59 := true
                    else
                        SetVisible59 := false;
                60:
                    if CutCreLineRec."60" <> '' then
                        SetVisible60 := true
                    else
                        SetVisible60 := false;
                61:
                    if CutCreLineRec."61" <> '' then
                        SetVisible61 := true
                    else
                        SetVisible61 := false;
                62:
                    if CutCreLineRec."62" <> '' then
                        SetVisible62 := true
                    else
                        SetVisible62 := false;
                63:
                    if CutCreLineRec."63" <> '' then
                        SetVisible63 := true
                    else
                        SetVisible63 := false;
                64:
                    if CutCreLineRec."64" <> '' then
                        SetVisible64 := true
                    else
                        SetVisible64 := false;
            end;
        end;

        // if ("Record Type" = 'R') then begin
        //     Clear(SetEdit1);
        //     SetEdit1 := true;
        // end
        // ELSE begin
        //     Clear(SetEdit1);
        //     SetEdit1 := false;
        // end;
    end;


    trigger OnAfterGetCurrRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorCutCreation(Rec);

        // if ("Record Type" = 'R') then begin
        //     Clear(SetEdit1);
        //     SetEdit1 := true;
        // end
        // ELSE begin
        //     Clear(SetEdit1);
        //     SetEdit1 := false;
        // end;
    end;


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit1: Boolean;
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