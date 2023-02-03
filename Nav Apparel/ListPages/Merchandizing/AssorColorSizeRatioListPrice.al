page 51020 AssorColorSizeRatiPricListPart
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
                    Editable = false;
                }

                field("1"; rec."1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible1_2;
                }
                field("2"; rec."2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible2_2;
                }

                field("3"; rec."3")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible3_2;
                }

                field("4"; rec."4")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible4_2;
                }

                field("5"; rec."5")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible5_2;
                }

                field("6"; rec."6")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible6_2;
                }

                field("7"; rec."7")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible7_2;
                }

                field("8"; rec."8")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible8_2;
                }

                field("9"; rec."9")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible9_2;
                }

                field("10"; rec."10")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible10_2;
                }

                field("11"; rec."11")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible11_2;
                }

                field("12"; rec."12")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible12_2;
                }

                field("13"; rec."13")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible13_2;
                }

                field("14"; rec."14")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible14_2;
                }

                field("15"; rec."15")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible15_2;
                }

                field("16"; rec."16")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible16_2;
                }

                field("17"; rec."17")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible17_2;
                }

                field("18"; rec."18")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible18_2;
                }

                field("19"; rec."19")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible19_2;
                }

                field("20"; rec."20")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible20_2;
                }

                field("21"; rec."21")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible21_2;
                }

                field("22"; rec."22")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible22_2;
                }

                field("23"; rec."23")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible23_2;
                }

                field("24"; rec."24")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible24_2;
                }

                field("25"; rec."25")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible25_2;
                }

                field("26"; rec."26")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible26_2;
                }

                field("27"; rec."27")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible27_2;
                }

                field("28"; rec."28")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible28_2;
                }

                field("29"; rec."29")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible29_2;
                }

                field("30"; rec."30")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible30_2;
                }

                field("31"; rec."31")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible31_2;
                }

                field("32"; rec."32")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible32_2;
                }

                field("33"; rec."33")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible33_2;
                }

                field("34"; rec."34")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible34_2;
                }

                field("35"; rec."35")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible35_2;
                }

                field("36"; rec."36")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    // Visible = SetVisible36_2;
                }

                field("37"; rec."37")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible37_2;
                }

                field("38"; rec."38")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible38_2;
                }

                field("39"; rec."39")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible39_2;
                }

                field("40"; rec."40")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible40_2;
                }

                field("41"; rec."41")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible41_2;
                }

                field("42"; rec."42")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible42_2;
                }

                field("43"; rec."43")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible43_2;
                }

                field("44"; rec."44")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible44_2;
                }

                field("45"; rec."45")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible45_2;
                }

                field("46"; rec."46")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible46_2;
                }

                field("47"; rec."47")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible47_2;
                }

                field("48"; rec."48")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible48_2;
                }

                field("49"; rec."49")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible49_2;
                }

                field("50"; rec."50")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible50_2;
                }

                field("51"; rec."51")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible51_2;
                }

                field("52"; rec."52")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible52_2;
                }

                field("53"; rec."53")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible53_2;
                }

                field("54"; rec."54")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible54_2;
                }

                field("55"; rec."55")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible55_2;
                }

                field("56"; rec."56")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible56_2;
                }

                field("57"; rec."57")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible57_2;
                }

                field("58"; rec."58")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible58_2;
                }

                field("59"; rec."59")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible59_2;
                }

                field("60"; rec."60")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    // Visible = SetVisible60_2;
                }

                field("61"; rec."61")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    // Visible = SetVisible61_2;
                }

                field("62"; rec."62")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible62_2;
                }

                field("63"; rec."63")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible63_2;
                }

                field("64"; rec."64")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible = SetVisible64_2;
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

        // AssoDetail.Reset();
        // AssoDetail.SetRange("Style No.", rec."Style No.");
        // AssoDetail.SetRange("Lot No.", rec."lot No.");
        // AssoDetail.FindSet();
        // Rowcount := AssoDetail.Count;

        // for Count := 1 To 64 do begin
        //     case Count of
        //         1:
        //             if Rowcount >= Count then
        //                 SetVisible1_2 := true
        //             else
        //                 SetVisible1_2 := false;
        //         2:
        //             if Rowcount >= Count then
        //                 SetVisible2_2 := true
        //             else
        //                 SetVisible2_2 := false;
        //         3:
        //             if Rowcount >= Count then
        //                 SetVisible3_2 := true
        //             else
        //                 SetVisible3_2 := false;
        //         4:
        //             if Rowcount >= Count then
        //                 SetVisible4_2 := true
        //             else
        //                 SetVisible4_2 := false;
        //         5:
        //             if Rowcount >= Count then
        //                 SetVisible5_2 := true
        //             else
        //                 SetVisible5_2 := false;
        //         6:
        //             if Rowcount >= Count then
        //                 SetVisible6_2 := true
        //             else
        //                 SetVisible6_2 := false;
        //         7:
        //             if Rowcount >= Count then
        //                 SetVisible7_2 := true
        //             else
        //                 SetVisible7_2 := false;
        //         8:
        //             if Rowcount >= Count then
        //                 SetVisible8_2 := true
        //             else
        //                 SetVisible8_2 := false;
        //         9:
        //             if Rowcount >= Count then
        //                 SetVisible9_2 := true
        //             else
        //                 SetVisible9_2 := false;
        //         10:
        //             if Rowcount >= Count then
        //                 SetVisible10_2 := true
        //             else
        //                 SetVisible10_2 := false;
        //         11:
        //             if Rowcount >= Count then
        //                 SetVisible11_2 := true
        //             else
        //                 SetVisible11_2 := false;
        //         12:
        //             if Rowcount >= Count then
        //                 SetVisible12_2 := true
        //             else
        //                 SetVisible12_2 := false;
        //         13:
        //             if Rowcount >= Count then
        //                 SetVisible13_2 := true
        //             else
        //                 SetVisible13_2 := false;
        //         14:
        //             if Rowcount >= Count then
        //                 SetVisible14_2 := true
        //             else
        //                 SetVisible14_2 := false;
        //         15:
        //             if Rowcount >= Count then
        //                 SetVisible15_2 := true
        //             else
        //                 SetVisible15_2 := false;
        //         16:
        //             if Rowcount >= Count then
        //                 SetVisible16_2 := true
        //             else
        //                 SetVisible16_2 := false;
        //         17:
        //             if Rowcount >= Count then
        //                 SetVisible17_2 := true
        //             else
        //                 SetVisible17_2 := false;
        //         18:
        //             if Rowcount >= Count then
        //                 SetVisible18_2 := true
        //             else
        //                 SetVisible18_2 := false;
        //         19:
        //             if Rowcount >= Count then
        //                 SetVisible19_2 := true
        //             else
        //                 SetVisible19_2 := false;
        //         20:
        //             if Rowcount >= Count then
        //                 SetVisible20_2 := true
        //             else
        //                 SetVisible20_2 := false;
        //         21:
        //             if Rowcount >= Count then
        //                 SetVisible21_2 := true
        //             else
        //                 SetVisible21_2 := false;
        //         22:
        //             if Rowcount >= Count then
        //                 SetVisible22_2 := true
        //             else
        //                 SetVisible22_2 := false;
        //         23:
        //             if Rowcount >= Count then
        //                 SetVisible23_2 := true
        //             else
        //                 SetVisible23_2 := false;
        //         24:
        //             if Rowcount >= Count then
        //                 SetVisible24_2 := true
        //             else
        //                 SetVisible24_2 := false;
        //         25:
        //             if Rowcount >= Count then
        //                 SetVisible25_2 := true
        //             else
        //                 SetVisible25_2 := false;
        //         26:
        //             if Rowcount >= Count then
        //                 SetVisible26_2 := true
        //             else
        //                 SetVisible26_2 := false;
        //         27:
        //             if Rowcount >= Count then
        //                 SetVisible27_2 := true
        //             else
        //                 SetVisible27_2 := false;
        //         28:
        //             if Rowcount >= Count then
        //                 SetVisible28_2 := true
        //             else
        //                 SetVisible28_2 := false;
        //         29:
        //             if Rowcount >= Count then
        //                 SetVisible29_2 := true
        //             else
        //                 SetVisible29_2 := false;
        //         30:
        //             if Rowcount >= Count then
        //                 SetVisible30_2 := true
        //             else
        //                 SetVisible30_2 := false;
        //         31:
        //             if Rowcount >= Count then
        //                 SetVisible31_2 := true
        //             else
        //                 SetVisible31_2 := false;
        //         32:
        //             if Rowcount >= Count then
        //                 SetVisible32_2 := true
        //             else
        //                 SetVisible32_2 := false;
        //         33:
        //             if Rowcount >= Count then
        //                 SetVisible33_2 := true
        //             else
        //                 SetVisible33_2 := false;
        //         34:
        //             if Rowcount >= Count then
        //                 SetVisible34_2 := true
        //             else
        //                 SetVisible34_2 := false;
        //         35:
        //             if Rowcount >= Count then
        //                 SetVisible35_2 := true
        //             else
        //                 SetVisible35_2 := false;
        //         36:
        //             if Rowcount >= Count then
        //                 SetVisible36_2 := true
        //             else
        //                 SetVisible36_2 := false;
        //         37:
        //             if Rowcount >= Count then
        //                 SetVisible37_2 := true
        //             else
        //                 SetVisible37_2 := false;
        //         38:
        //             if Rowcount >= Count then
        //                 SetVisible38_2 := true
        //             else
        //                 SetVisible38_2 := false;
        //         39:
        //             if Rowcount >= Count then
        //                 SetVisible39_2 := true
        //             else
        //                 SetVisible39_2 := false;
        //         40:
        //             if Rowcount >= Count then
        //                 SetVisible40_2 := true
        //             else
        //                 SetVisible40_2 := false;
        //         41:
        //             if Rowcount >= Count then
        //                 SetVisible41_2 := true
        //             else
        //                 SetVisible41_2 := false;
        //         42:
        //             if Rowcount >= Count then
        //                 SetVisible42_2 := true
        //             else
        //                 SetVisible42_2 := false;
        //         43:
        //             if Rowcount >= Count then
        //                 SetVisible43_2 := true
        //             else
        //                 SetVisible43_2 := false;
        //         44:
        //             if Rowcount >= Count then
        //                 SetVisible44_2 := true
        //             else
        //                 SetVisible44_2 := false;
        //         45:
        //             if Rowcount >= Count then
        //                 SetVisible45_2 := true
        //             else
        //                 SetVisible45_2 := false;
        //         46:
        //             if Rowcount >= Count then
        //                 SetVisible46_2 := true
        //             else
        //                 SetVisible46_2 := false;
        //         47:
        //             if Rowcount >= Count then
        //                 SetVisible47_2 := true
        //             else
        //                 SetVisible47_2 := false;
        //         48:
        //             if Rowcount >= Count then
        //                 SetVisible48_2 := true
        //             else
        //                 SetVisible48_2 := false;
        //         49:
        //             if Rowcount >= Count then
        //                 SetVisible49_2 := true
        //             else
        //                 SetVisible49_2 := false;
        //         50:
        //             if Rowcount >= Count then
        //                 SetVisible50_2 := true
        //             else
        //                 SetVisible50_2 := false;
        //         51:
        //             if Rowcount >= Count then
        //                 SetVisible51_2 := true
        //             else
        //                 SetVisible51_2 := false;
        //         52:
        //             if Rowcount >= Count then
        //                 SetVisible52_2 := true
        //             else
        //                 SetVisible52_2 := false;
        //         53:
        //             if Rowcount >= Count then
        //                 SetVisible53_2 := true
        //             else
        //                 SetVisible53_2 := false;
        //         54:
        //             if Rowcount >= Count then
        //                 SetVisible54_2 := true
        //             else
        //                 SetVisible54_2 := false;
        //         55:
        //             if Rowcount >= Count then
        //                 SetVisible55_2 := true
        //             else
        //                 SetVisible55_2 := false;
        //         56:
        //             if Rowcount >= Count then
        //                 SetVisible56_2 := true
        //             else
        //                 SetVisible56_2 := false;
        //         57:
        //             if Rowcount >= Count then
        //                 SetVisible57_2 := true
        //             else
        //                 SetVisible57_2 := false;
        //         58:
        //             if Rowcount >= Count then
        //                 SetVisible58_2 := true
        //             else
        //                 SetVisible58_2 := false;
        //         59:
        //             if Rowcount >= Count then
        //                 SetVisible59_2 := true
        //             else
        //                 SetVisible59_2 := false;
        //         60:
        //             if Rowcount >= Count then
        //                 SetVisible60_2 := true
        //             else
        //                 SetVisible60_2 := false;
        //         61:
        //             if Rowcount >= Count then
        //                 SetVisible61_2 := true
        //             else
        //                 SetVisible61_2 := false;
        //         62:
        //             if Rowcount >= Count then
        //                 SetVisible62_2 := true
        //             else
        //                 SetVisible62_2 := false;
        //         63:
        //             if Rowcount >= Count then
        //                 SetVisible63_2 := true
        //             else
        //                 SetVisible63_2 := false;
        //         64:
        //             if Rowcount >= Count then
        //                 SetVisible64_2 := true
        //             else
        //                 SetVisible64_2 := false;
        //     end;
        // end;

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
    // SetVisible1_2: Boolean;
    // SetVisible2_2: Boolean;
    // SetVisible3_2: Boolean;
    // SetVisible4_2: Boolean;
    // SetVisible5_2: Boolean;
    // SetVisible6_2: Boolean;
    // SetVisible7_2: Boolean;
    // SetVisible8_2: Boolean;
    // SetVisible9_2: Boolean;
    // SetVisible10_2: Boolean;
    // SetVisible11_2: Boolean;
    // SetVisible12_2: Boolean;
    // SetVisible13_2: Boolean;
    // SetVisible14_2: Boolean;
    // SetVisible15_2: Boolean;
    // SetVisible16_2: Boolean;
    // SetVisible17_2: Boolean;
    // SetVisible18_2: Boolean;
    // SetVisible19_2: Boolean;
    // SetVisible20_2: Boolean;
    // SetVisible21_2: Boolean;
    // SetVisible22_2: Boolean;
    // SetVisible23_2: Boolean;
    // SetVisible24_2: Boolean;
    // SetVisible25_2: Boolean;
    // SetVisible26_2: Boolean;
    // SetVisible27_2: Boolean;
    // SetVisible28_2: Boolean;
    // SetVisible29_2: Boolean;
    // SetVisible30_2: Boolean;
    // SetVisible31_2: Boolean;
    // SetVisible32_2: Boolean;
    // SetVisible33_2: Boolean;
    // SetVisible34_2: Boolean;
    // SetVisible35_2: Boolean;
    // SetVisible36_2: Boolean;
    // SetVisible37_2: Boolean;
    // SetVisible38_2: Boolean;
    // SetVisible39_2: Boolean;
    // SetVisible40_2: Boolean;
    // SetVisible41_2: Boolean;
    // SetVisible42_2: Boolean;
    // SetVisible43_2: Boolean;
    // SetVisible44_2: Boolean;
    // SetVisible45_2: Boolean;
    // SetVisible46_2: Boolean;
    // SetVisible47_2: Boolean;
    // SetVisible48_2: Boolean;
    // SetVisible49_2: Boolean;
    // SetVisible50_2: Boolean;
    // SetVisible51_2: Boolean;
    // SetVisible52_2: Boolean;
    // SetVisible53_2: Boolean;
    // SetVisible54_2: Boolean;
    // SetVisible55_2: Boolean;
    // SetVisible56_2: Boolean;
    // SetVisible57_2: Boolean;
    // SetVisible58_2: Boolean;
    // SetVisible59_2: Boolean;
    // SetVisible60_2: Boolean;
    // SetVisible61_2: Boolean;
    // SetVisible62_2: Boolean;
    // SetVisible63_2: Boolean;
    // SetVisible64_2: Boolean;
}