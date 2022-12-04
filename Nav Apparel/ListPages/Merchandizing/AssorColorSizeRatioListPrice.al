page 71012676 AssorColorSizeRatiPricListPart
{
    PageType = ListPart;
    //AutoSplitKey = true;
    SourceTable = AssorColorSizeRatioPrice;
    SourceTableView = sorting("Country Name", "Pack No", "Colour Name") order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Country Name"; rec."Country Name")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Pack No"; rec."Pack No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Pack';
                    StyleExpr = StyleExprTxt;
                }

                field("Colour No"; rec."Colour No")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';
                    Visible = false;
                }

                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                }

                field("1"; rec."1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible1;
                }
                field("2"; rec."2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible2;
                }

                field("3"; rec."3")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible3;
                }

                field("4"; rec."4")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible4;
                }

                field("5"; rec."5")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible5;
                }

                field("6"; rec."6")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible6;
                }

                field("7"; rec."7")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible7;
                }

                field("8"; rec."8")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible8;
                }

                field("9"; rec."9")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible9;
                }

                field("10"; rec."10")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible10;
                }

                field("11"; rec."11")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible11;
                }

                field("12"; rec."12")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible12;
                }

                field("13"; rec."13")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible13;
                }

                field("14"; rec."14")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible14;
                }

                field("15"; rec."15")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible15;
                }

                field("16"; rec."16")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible16;
                }

                field("17"; rec."17")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible17;
                }

                field("18"; rec."18")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible18;
                }

                field("19"; rec."19")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible19;
                }

                field("20"; rec."20")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible20;
                }

                field("21"; rec."21")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible21;
                }

                field("22"; rec."22")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible22;
                }

                field("23"; rec."23")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible23;
                }

                field("24"; rec."24")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible24;
                }

                field("25"; rec."25")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible25;
                }

                field("26"; rec."26")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible26;
                }

                field("27"; rec."27")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible27;
                }

                field("28"; rec."28")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible28;
                }

                field("29"; rec."29")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible29;
                }

                field("30"; rec."30")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible30;
                }

                field("31"; rec."31")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible31;
                }

                field("32"; rec."32")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible32;
                }

                field("33"; rec."33")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible33;
                }

                field("34"; rec."34")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible34;
                }

                field("35"; rec."35")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible35;
                }

                field("36"; rec."36")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible36;
                }

                field("37"; rec."37")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible37;
                }

                field("38"; rec."38")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible38;
                }

                field("39"; rec."39")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible39;
                }

                field("40"; rec."40")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible40;
                }

                field("41"; rec."41")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible41;
                }

                field("42"; rec."42")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible42;
                }

                field("43"; rec."43")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible43;
                }

                field("44"; rec."44")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible44;
                }

                field("45"; rec."45")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible45;
                }

                field("46"; rec."46")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible46;
                }

                field("47"; rec."47")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible47;
                }

                field("48"; rec."48")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible48;
                }

                field("49"; rec."49")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible49;
                }

                field("50"; rec."50")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible50;
                }

                field("51"; rec."51")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible51;
                }

                field("52"; rec."52")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible52;
                }

                field("53"; rec."53")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible53;
                }

                field("54"; rec."54")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible54;
                }

                field("55"; rec."55")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible55;
                }

                field("56"; rec."56")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible56;
                }

                field("57"; rec."57")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible57;
                }

                field("58"; rec."58")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible58;
                }

                field("59"; rec."59")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible59;
                }

                field("60"; rec."60")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible60;
                }

                field("61"; rec."61")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible61;
                }

                field("62"; rec."62")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible62;
                }

                field("63"; rec."63")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible63;
                }

                field("64"; rec."64")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Visible = SetVisible64;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Copy Size/Colour/Price To All PO")
            {
                ApplicationArea = All;
                Image = CopyCosttoGLBudget;

                trigger OnAction()
                var
                    AssorColorSizeRatioPriceRec: Record AssorColorSizeRatioPrice;
                    AssorColorSizeRatioPriceNewRec: Record AssorColorSizeRatioPrice;
                    PORec: Record "Style Master PO";
                    LineNo: Integer;
                begin
                    AssorColorSizeRatioPriceRec.Reset();
                    AssorColorSizeRatioPriceRec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioPriceRec.SetRange("lot No.", rec."lot No.");

                    PORec.Reset();
                    PORec.SetRange("Style No.", rec."Style No.");
                    PORec.FindSet();

                    if not AssorColorSizeRatioPriceRec.FINDSET() then
                        Message('Cannot find color details for PO NO %1', rec."PO No.")
                    else begin
                        repeat
                            LineNo := 0;
                            if rec."PO No." <> PORec."PO No." then begin
                                //Delete Existing records                                    
                                AssorColorSizeRatioPriceNewRec.Reset();
                                AssorColorSizeRatioPriceNewRec.SetRange("Style No.", rec."Style No.");
                                AssorColorSizeRatioPriceNewRec.SetRange("lot No.", PORec."lot No.");
                                AssorColorSizeRatioPriceNewRec.DeleteAll();

                                repeat
                                    //Add new record
                                    LineNo += 10000;
                                    AssorColorSizeRatioPriceNewRec.Init();
                                    AssorColorSizeRatioPriceNewRec."Style No." := rec."Style No.";
                                    AssorColorSizeRatioPriceNewRec."lot No." := PORec."lot No.";
                                    AssorColorSizeRatioPriceNewRec."PO No." := PORec."PO No.";
                                    AssorColorSizeRatioPriceNewRec."Line No." := LineNo;
                                    AssorColorSizeRatioPriceNewRec."Colour No" := AssorColorSizeRatioPriceRec."Colour No";
                                    AssorColorSizeRatioPriceNewRec."Colour Name" := AssorColorSizeRatioPriceRec."Colour Name";
                                    AssorColorSizeRatioPriceNewRec."SHID/LOT" := AssorColorSizeRatioPriceRec."SHID/LOT";
                                    AssorColorSizeRatioPriceNewRec."SHID/LOT Name" := AssorColorSizeRatioPriceRec."SHID/LOT Name";
                                    AssorColorSizeRatioPriceNewRec."1" := AssorColorSizeRatioPriceRec."1";
                                    AssorColorSizeRatioPriceNewRec."2" := AssorColorSizeRatioPriceRec."2";
                                    AssorColorSizeRatioPriceNewRec."3" := AssorColorSizeRatioPriceRec."3";
                                    AssorColorSizeRatioPriceNewRec."4" := AssorColorSizeRatioPriceRec."4";
                                    AssorColorSizeRatioPriceNewRec."5" := AssorColorSizeRatioPriceRec."5";
                                    AssorColorSizeRatioPriceNewRec."6" := AssorColorSizeRatioPriceRec."6";
                                    AssorColorSizeRatioPriceNewRec."7" := AssorColorSizeRatioPriceRec."7";
                                    AssorColorSizeRatioPriceNewRec."8" := AssorColorSizeRatioPriceRec."8";
                                    AssorColorSizeRatioPriceNewRec."9" := AssorColorSizeRatioPriceRec."9";
                                    AssorColorSizeRatioPriceNewRec."10" := AssorColorSizeRatioPriceRec."10";
                                    AssorColorSizeRatioPriceNewRec."11" := AssorColorSizeRatioPriceRec."11";
                                    AssorColorSizeRatioPriceNewRec."12" := AssorColorSizeRatioPriceRec."12";
                                    AssorColorSizeRatioPriceNewRec."13" := AssorColorSizeRatioPriceRec."13";
                                    AssorColorSizeRatioPriceNewRec."14" := AssorColorSizeRatioPriceRec."14";
                                    AssorColorSizeRatioPriceNewRec."15" := AssorColorSizeRatioPriceRec."15";
                                    AssorColorSizeRatioPriceNewRec."16" := AssorColorSizeRatioPriceRec."16";
                                    AssorColorSizeRatioPriceNewRec."17" := AssorColorSizeRatioPriceRec."17";
                                    AssorColorSizeRatioPriceNewRec."18" := AssorColorSizeRatioPriceRec."18";
                                    AssorColorSizeRatioPriceNewRec."19" := AssorColorSizeRatioPriceRec."19";
                                    AssorColorSizeRatioPriceNewRec."20" := AssorColorSizeRatioPriceRec."20";
                                    AssorColorSizeRatioPriceNewRec."21" := AssorColorSizeRatioPriceRec."21";
                                    AssorColorSizeRatioPriceNewRec."22" := AssorColorSizeRatioPriceRec."22";
                                    AssorColorSizeRatioPriceNewRec."23" := AssorColorSizeRatioPriceRec."23";
                                    AssorColorSizeRatioPriceNewRec."24" := AssorColorSizeRatioPriceRec."24";
                                    AssorColorSizeRatioPriceNewRec."25" := AssorColorSizeRatioPriceRec."25";
                                    AssorColorSizeRatioPriceNewRec."26" := AssorColorSizeRatioPriceRec."26";
                                    AssorColorSizeRatioPriceNewRec."27" := AssorColorSizeRatioPriceRec."27";
                                    AssorColorSizeRatioPriceNewRec."28" := AssorColorSizeRatioPriceRec."28";
                                    AssorColorSizeRatioPriceNewRec."29" := AssorColorSizeRatioPriceRec."29";
                                    AssorColorSizeRatioPriceNewRec."30" := AssorColorSizeRatioPriceRec."30";
                                    AssorColorSizeRatioPriceNewRec."31" := AssorColorSizeRatioPriceRec."31";
                                    AssorColorSizeRatioPriceNewRec."32" := AssorColorSizeRatioPriceRec."32";
                                    AssorColorSizeRatioPriceNewRec."33" := AssorColorSizeRatioPriceRec."33";
                                    AssorColorSizeRatioPriceNewRec."34" := AssorColorSizeRatioPriceRec."34";
                                    AssorColorSizeRatioPriceNewRec."35" := AssorColorSizeRatioPriceRec."35";
                                    AssorColorSizeRatioPriceNewRec."36" := AssorColorSizeRatioPriceRec."36";
                                    AssorColorSizeRatioPriceNewRec."37" := AssorColorSizeRatioPriceRec."37";
                                    AssorColorSizeRatioPriceNewRec."38" := AssorColorSizeRatioPriceRec."38";
                                    AssorColorSizeRatioPriceNewRec."39" := AssorColorSizeRatioPriceRec."39";
                                    AssorColorSizeRatioPriceNewRec."40" := AssorColorSizeRatioPriceRec."40";
                                    AssorColorSizeRatioPriceNewRec."41" := AssorColorSizeRatioPriceRec."41";
                                    AssorColorSizeRatioPriceNewRec."42" := AssorColorSizeRatioPriceRec."42";
                                    AssorColorSizeRatioPriceNewRec."43" := AssorColorSizeRatioPriceRec."43";
                                    AssorColorSizeRatioPriceNewRec."44" := AssorColorSizeRatioPriceRec."44";
                                    AssorColorSizeRatioPriceNewRec."45" := AssorColorSizeRatioPriceRec."45";
                                    AssorColorSizeRatioPriceNewRec."46" := AssorColorSizeRatioPriceRec."46";
                                    AssorColorSizeRatioPriceNewRec."47" := AssorColorSizeRatioPriceRec."47";
                                    AssorColorSizeRatioPriceNewRec."48" := AssorColorSizeRatioPriceRec."48";
                                    AssorColorSizeRatioPriceNewRec."49" := AssorColorSizeRatioPriceRec."49";
                                    AssorColorSizeRatioPriceNewRec."50" := AssorColorSizeRatioPriceRec."50";
                                    AssorColorSizeRatioPriceNewRec."51" := AssorColorSizeRatioPriceRec."51";
                                    AssorColorSizeRatioPriceNewRec."52" := AssorColorSizeRatioPriceRec."52";
                                    AssorColorSizeRatioPriceNewRec."53" := AssorColorSizeRatioPriceRec."53";
                                    AssorColorSizeRatioPriceNewRec."54" := AssorColorSizeRatioPriceRec."54";
                                    AssorColorSizeRatioPriceNewRec."55" := AssorColorSizeRatioPriceRec."55";
                                    AssorColorSizeRatioPriceNewRec."56" := AssorColorSizeRatioPriceRec."56";
                                    AssorColorSizeRatioPriceNewRec."57" := AssorColorSizeRatioPriceRec."57";
                                    AssorColorSizeRatioPriceNewRec."58" := AssorColorSizeRatioPriceRec."58";
                                    AssorColorSizeRatioPriceNewRec."59" := AssorColorSizeRatioPriceRec."59";
                                    AssorColorSizeRatioPriceNewRec."60" := AssorColorSizeRatioPriceRec."60";
                                    AssorColorSizeRatioPriceNewRec."61" := AssorColorSizeRatioPriceRec."61";
                                    AssorColorSizeRatioPriceNewRec."62" := AssorColorSizeRatioPriceRec."62";
                                    AssorColorSizeRatioPriceNewRec."63" := AssorColorSizeRatioPriceRec."63";
                                    AssorColorSizeRatioPriceNewRec."64" := AssorColorSizeRatioPriceRec."64";
                                    AssorColorSizeRatioPriceNewRec."Country Code" := AssorColorSizeRatioPriceRec."Country Code";
                                    AssorColorSizeRatioPriceNewRec."Country Name" := AssorColorSizeRatioPriceRec."Country Name";
                                    AssorColorSizeRatioPriceNewRec."Pack No" := AssorColorSizeRatioPriceRec."Pack No";
                                    AssorColorSizeRatioPriceNewRec."Created User" := UserId;
                                    AssorColorSizeRatioPriceNewRec."Created Date" := WorkDate();
                                    AssorColorSizeRatioPriceNewRec.Insert();
                                until AssorColorSizeRatioPriceRec.Next() = 0;
                            end;
                        until PORec.Next() = 0;
                    end;

                    //Delete blank record
                    AssorColorSizeRatioPriceNewRec.Reset();
                    AssorColorSizeRatioPriceNewRec.SetFilter("Colour Name", '=%1', '');
                    if AssorColorSizeRatioPriceNewRec.FindSet() then
                        AssorColorSizeRatioPriceNewRec.Delete();

                    CurrPage.Update();
                    Message('Size/Color/Price copied to all PO');

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Rowcount: Integer;
        Count: Integer;
        AssoDetail: Record AssortmentDetailsInseam;
    begin
        StyleExprTxt := ChangeColor.ChangeColorAssoPrice(Rec);

        AssoDetail.Reset();
        AssoDetail.SetRange("Style No.", rec."Style No.");
        AssoDetail.SetRange("Lot No.", rec."lot No.");
        AssoDetail.FindSet();
        Rowcount := AssoDetail.Count;

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

        if rec."Colour Name" = '*' then begin
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