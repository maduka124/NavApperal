page 51018 AssorColorSizeRatioListPart
{
    PageType = ListPart;
    //AutoSplitKey = true;
    SourceTable = AssorColorSizeRatio;
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
                    Caption = 'Pack No';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("SHID/LOT"; rec."SHID/LOT")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;

                    trigger OnValidate()
                    var
                        ShadeRec: Record Shade;
                    begin

                        ShadeRec.Reset();
                        ShadeRec.SetRange("No.", Rec."SHID/LOT");
                        if not ShadeRec.FindSet() then
                            Error('Invalid SHID/LOT');

                        if rec."Lot No." = '' then
                            Error('Invalid Lot No');

                        ShadeRec.get(rec."SHID/LOT");
                        rec."SHID/LOT Name" := ShadeRec.Shade;
                    end;
                }

                field("1"; rec."1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    ////Visible =SetVisible1;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Lot No." = '' then
                            Error('Invalid Lot No');

                        CalTotal();
                    end;
                }
                field("2"; rec."2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible2;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Lot No." = '' then
                            Error('Invalid Lot No');

                        CalTotal();
                    end;
                }

                field("3"; rec."3")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible3;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Lot No." = '' then
                            Error('Invalid Lot No');

                        CalTotal();
                    end;
                }

                field("4"; rec."4")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible4;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Lot No." = '' then
                            Error('Invalid Lot No');

                        CalTotal();
                    end;
                }

                field("5"; rec."5")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible5;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Lot No." = '' then
                            Error('Invalid Lot No');

                        CalTotal();
                    end;
                }

                field("6"; rec."6")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible6;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Lot No." = '' then
                            Error('Invalid Lot No');

                        CalTotal();
                    end;
                }

                field("7"; rec."7")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible7;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("8"; rec."8")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible8;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("9"; rec."9")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible9;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("10"; rec."10")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible10;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("11"; rec."11")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible11;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("12"; rec."12")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible12;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("13"; rec."13")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible13;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("14"; rec."14")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible14;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("15"; rec."15")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible15;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("16"; rec."16")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible16;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("17"; rec."17")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible17;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("18"; rec."18")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible18;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("19"; rec."19")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible19;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("20"; rec."20")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible20;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("21"; rec."21")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible21;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("22"; rec."22")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible22;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("23"; rec."23")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible23;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("24"; rec."24")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible24;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("25"; rec."25")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible25;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("26"; rec."26")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible26;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("27"; rec."27")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible27;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("28"; rec."28")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible28;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("29"; rec."29")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible29;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("30"; rec."30")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible30;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("31"; rec."31")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible31;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("32"; rec."32")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible32;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("33"; rec."33")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible33;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("34"; rec."34")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible34;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("35"; rec."35")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible35;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("36"; rec."36")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible36;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("37"; rec."37")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible37;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("38"; rec."38")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible38;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("39"; rec."39")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible39;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("40"; rec."40")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible40;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("41"; rec."41")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible41;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("42"; rec."42")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible42;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("43"; rec."43")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible43;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("44"; rec."44")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible44;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("45"; rec."45")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible45;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("46"; rec."46")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible46;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("47"; rec."47")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible47;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }



                field("48"; rec."48")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible48;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("49"; rec."49")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible49;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("50"; rec."50")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible50;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("51"; rec."51")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible51;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("52"; rec."52")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible52;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("53"; rec."53")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible53;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("54"; rec."54")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible54;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("55"; rec."55")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible55;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("56"; rec."56")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible56;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("57"; rec."57")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible57;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("58"; rec."58")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible58;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("59"; rec."59")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible59;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("60"; rec."60")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible60;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("61"; rec."61")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible61;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("62"; rec."62")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible62;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("63"; rec."63")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible63;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("64"; rec."64")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    //Visible =SetVisible64;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field(Total; rec.Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Size/Colour Qty Ratio")
            {
                ApplicationArea = All;
                Image = CopyBudget;

                trigger OnAction();
                var
                    AssorDetailsRec: Record AssortmentDetails;
                    AssorDetailsPackCountryRec: Record AssortmentDetails;
                    AssorColorSizeRatioNewRec: Record AssorColorSizeRatio;
                    AssorDetailsInseamRec: Record AssortmentDetailsInseam;
                    StyleRec: Record "Style Master PO";
                    StyleRec1: Record "Style Master";
                    LineNo: Integer;
                    Seq: Integer;
                begin

                    StyleRec1.Reset();
                    StyleRec1.SetRange("No.", rec."Style No.");
                    StyleRec1.FindSet();

                    StyleRec.Reset();
                    StyleRec.SetRange("Style No.", rec."Style No.");
                    StyleRec.SetRange("Lot No.", rec."Lot No.");
                    StyleRec.FindLast();

                    rec."PO No." := StyleRec."PO No.";

                    //Color
                    AssorDetailsRec.Reset();
                    AssorDetailsRec.SetRange("Style No.", rec."Style No.");
                    AssorDetailsRec.SetRange("lot No.", rec."lot No.");
                    AssorDetailsRec.SetRange(Type, '1');

                    //Pack Country
                    AssorDetailsPackCountryRec.Reset();
                    AssorDetailsPackCountryRec.SetRange("Style No.", rec."Style No.");
                    AssorDetailsPackCountryRec.SetRange("lot No.", rec."lot No.");
                    AssorDetailsPackCountryRec.SetRange(Type, '2');

                    // //Size
                    // AssorDetailsInseamRec.Reset();
                    // AssorDetailsInseamRec.SetRange("Style No.", "Style No.");
                    // AssorDetailsInseamRec.SetRange("PO No.", "PO No.");
                    // AssorDetailsInseamRec.FindSet();

                    //Delete blank record
                    AssorColorSizeRatioNewRec.Reset();
                    AssorColorSizeRatioNewRec.SetFilter("Colour Name", '=%1', '');
                    if AssorColorSizeRatioNewRec.FindSet() then
                        AssorColorSizeRatioNewRec.Delete();

                    CurrPage.Update();

                    //Ratio
                    AssorColorSizeRatioNewRec.Reset();
                    AssorColorSizeRatioNewRec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioNewRec.SetRange("lot No.", rec."lot No.");
                    AssorColorSizeRatioNewRec.deleteAll();

                    //Copying Colors
                    if not AssorDetailsRec.FINDSET() then
                        Message('Cannot find color details for PO NO %1', rec."PO No.")
                    else begin
                        if not AssorDetailsPackCountryRec.FINDSET() then
                            Message('Cannot find pack/country details for PO NO %1', rec."PO No.")
                        else begin
                            LineNo := 0;
                            repeat
                                LineNo += 10000;
                                //insert default line

                                if AssorDetailsPackCountryRec."Country Code" = '' then
                                    Error('Invalid country');

                                if AssorDetailsPackCountryRec."Pack No" = '' then
                                    Error('Invalid Pack');

                                AssorColorSizeRatioNewRec.Init();
                                AssorColorSizeRatioNewRec."Style No." := rec."Style No.";
                                AssorColorSizeRatioNewRec."Style Name" := StyleRec1."Style No.";
                                AssorColorSizeRatioNewRec."PO No." := rec."PO No.";
                                AssorColorSizeRatioNewRec."lot No." := rec."lot No.";
                                AssorColorSizeRatioNewRec."Line No." := LineNo;
                                AssorColorSizeRatioNewRec."Colour No" := '*';
                                AssorColorSizeRatioNewRec."Colour Name" := '*';
                                AssorColorSizeRatioNewRec."Pack No" := AssorDetailsPackCountryRec."Pack No";
                                AssorColorSizeRatioNewRec."Country Code" := AssorDetailsPackCountryRec."Country Code";
                                AssorColorSizeRatioNewRec."Country Name" := AssorDetailsPackCountryRec."Country Name";
                                AssorColorSizeRatioNewRec.Qty := 0;
                                AssorColorSizeRatioNewRec."Created User" := UserId;
                                AssorColorSizeRatioNewRec."Created Date" := WorkDate();
                                AssorColorSizeRatioNewRec.Insert();


                                //ADD COM SIZE
                                AssorColorSizeRatioNewRec.Reset();
                                AssorColorSizeRatioNewRec.SetRange("Style No.", rec."Style No.");
                                AssorColorSizeRatioNewRec.SetRange("lot No.", rec."lot No.");
                                AssorColorSizeRatioNewRec.SetRange("Colour No", '*');
                                AssorColorSizeRatioNewRec.SetRange("Country Code", AssorDetailsPackCountryRec."Country Code");
                                //AssorColorSizeRatioNewRec.SetRange("Pack No", AssorDetailsPackCountryRec."Pack No");
                                // AssorColorSizeRatioNewRec."Country Code" := AssorDetailsPackCountryRec."Country Code";
                                // AssorColorSizeRatioNewRec."Country Name" := AssorDetailsPackCountryRec."Country Name";
                                AssorColorSizeRatioNewRec.FindSet();

                                //Size
                                AssorDetailsInseamRec.Reset();
                                AssorDetailsInseamRec.SetRange("Style No.", rec."Style No.");
                                AssorDetailsInseamRec.SetRange("lot No.", rec."lot No.");
                                AssorDetailsInseamRec.FindSet();

                                Seq := 0;

                                repeat
                                    Seq += 1;

                                    case Seq of
                                        1:
                                            AssorColorSizeRatioNewRec."1" := AssorDetailsInseamRec."GMT Size";
                                        2:
                                            AssorColorSizeRatioNewRec."2" := AssorDetailsInseamRec."GMT Size";
                                        3:
                                            AssorColorSizeRatioNewRec."3" := AssorDetailsInseamRec."GMT Size";
                                        4:
                                            AssorColorSizeRatioNewRec."4" := AssorDetailsInseamRec."GMT Size";
                                        5:
                                            AssorColorSizeRatioNewRec."5" := AssorDetailsInseamRec."GMT Size";
                                        6:
                                            AssorColorSizeRatioNewRec."6" := AssorDetailsInseamRec."GMT Size";
                                        7:
                                            AssorColorSizeRatioNewRec."7" := AssorDetailsInseamRec."GMT Size";
                                        8:
                                            AssorColorSizeRatioNewRec."8" := AssorDetailsInseamRec."GMT Size";
                                        9:
                                            AssorColorSizeRatioNewRec."9" := AssorDetailsInseamRec."GMT Size";
                                        10:
                                            AssorColorSizeRatioNewRec."10" := AssorDetailsInseamRec."GMT Size";
                                        11:
                                            AssorColorSizeRatioNewRec."11" := AssorDetailsInseamRec."GMT Size";
                                        12:
                                            AssorColorSizeRatioNewRec."12" := AssorDetailsInseamRec."GMT Size";
                                        13:
                                            AssorColorSizeRatioNewRec."13" := AssorDetailsInseamRec."GMT Size";
                                        14:
                                            AssorColorSizeRatioNewRec."14" := AssorDetailsInseamRec."GMT Size";
                                        15:
                                            AssorColorSizeRatioNewRec."15" := AssorDetailsInseamRec."GMT Size";
                                        16:
                                            AssorColorSizeRatioNewRec."16" := AssorDetailsInseamRec."GMT Size";
                                        17:
                                            AssorColorSizeRatioNewRec."17" := AssorDetailsInseamRec."GMT Size";
                                        18:
                                            AssorColorSizeRatioNewRec."18" := AssorDetailsInseamRec."GMT Size";
                                        19:
                                            AssorColorSizeRatioNewRec."19" := AssorDetailsInseamRec."GMT Size";
                                        20:
                                            AssorColorSizeRatioNewRec."20" := AssorDetailsInseamRec."GMT Size";
                                        21:
                                            AssorColorSizeRatioNewRec."21" := AssorDetailsInseamRec."GMT Size";
                                        22:
                                            AssorColorSizeRatioNewRec."22" := AssorDetailsInseamRec."GMT Size";
                                        23:
                                            AssorColorSizeRatioNewRec."23" := AssorDetailsInseamRec."GMT Size";
                                        24:
                                            AssorColorSizeRatioNewRec."24" := AssorDetailsInseamRec."GMT Size";
                                        25:
                                            AssorColorSizeRatioNewRec."25" := AssorDetailsInseamRec."GMT Size";
                                        26:
                                            AssorColorSizeRatioNewRec."26" := AssorDetailsInseamRec."GMT Size";
                                        27:
                                            AssorColorSizeRatioNewRec."27" := AssorDetailsInseamRec."GMT Size";
                                        28:
                                            AssorColorSizeRatioNewRec."28" := AssorDetailsInseamRec."GMT Size";
                                        29:
                                            AssorColorSizeRatioNewRec."29" := AssorDetailsInseamRec."GMT Size";
                                        30:
                                            AssorColorSizeRatioNewRec."30" := AssorDetailsInseamRec."GMT Size";
                                        31:
                                            AssorColorSizeRatioNewRec."31" := AssorDetailsInseamRec."GMT Size";
                                        32:
                                            AssorColorSizeRatioNewRec."32" := AssorDetailsInseamRec."GMT Size";
                                        33:
                                            AssorColorSizeRatioNewRec."33" := AssorDetailsInseamRec."GMT Size";
                                        34:
                                            AssorColorSizeRatioNewRec."34" := AssorDetailsInseamRec."GMT Size";
                                        35:
                                            AssorColorSizeRatioNewRec."35" := AssorDetailsInseamRec."GMT Size";
                                        36:
                                            AssorColorSizeRatioNewRec."36" := AssorDetailsInseamRec."GMT Size";
                                        37:
                                            AssorColorSizeRatioNewRec."37" := AssorDetailsInseamRec."GMT Size";
                                        38:
                                            AssorColorSizeRatioNewRec."38" := AssorDetailsInseamRec."GMT Size";
                                        39:
                                            AssorColorSizeRatioNewRec."39" := AssorDetailsInseamRec."GMT Size";
                                        40:
                                            AssorColorSizeRatioNewRec."40" := AssorDetailsInseamRec."GMT Size";
                                        41:
                                            AssorColorSizeRatioNewRec."41" := AssorDetailsInseamRec."GMT Size";
                                        42:
                                            AssorColorSizeRatioNewRec."42" := AssorDetailsInseamRec."GMT Size";
                                        43:
                                            AssorColorSizeRatioNewRec."43" := AssorDetailsInseamRec."GMT Size";
                                        44:
                                            AssorColorSizeRatioNewRec."44" := AssorDetailsInseamRec."GMT Size";
                                        45:
                                            AssorColorSizeRatioNewRec."45" := AssorDetailsInseamRec."GMT Size";
                                        46:
                                            AssorColorSizeRatioNewRec."46" := AssorDetailsInseamRec."GMT Size";
                                        47:
                                            AssorColorSizeRatioNewRec."47" := AssorDetailsInseamRec."GMT Size";
                                        48:
                                            AssorColorSizeRatioNewRec."48" := AssorDetailsInseamRec."GMT Size";
                                        49:
                                            AssorColorSizeRatioNewRec."49" := AssorDetailsInseamRec."GMT Size";
                                        50:
                                            AssorColorSizeRatioNewRec."50" := AssorDetailsInseamRec."GMT Size";
                                        51:
                                            AssorColorSizeRatioNewRec."51" := AssorDetailsInseamRec."GMT Size";
                                        52:
                                            AssorColorSizeRatioNewRec."52" := AssorDetailsInseamRec."GMT Size";
                                        53:
                                            AssorColorSizeRatioNewRec."53" := AssorDetailsInseamRec."GMT Size";
                                        54:
                                            AssorColorSizeRatioNewRec."54" := AssorDetailsInseamRec."GMT Size";
                                        55:
                                            AssorColorSizeRatioNewRec."55" := AssorDetailsInseamRec."GMT Size";
                                        56:
                                            AssorColorSizeRatioNewRec."56" := AssorDetailsInseamRec."GMT Size";
                                        57:
                                            AssorColorSizeRatioNewRec."57" := AssorDetailsInseamRec."GMT Size";
                                        58:
                                            AssorColorSizeRatioNewRec."58" := AssorDetailsInseamRec."GMT Size";
                                        59:
                                            AssorColorSizeRatioNewRec."59" := AssorDetailsInseamRec."GMT Size";
                                        60:
                                            AssorColorSizeRatioNewRec."60" := AssorDetailsInseamRec."GMT Size";
                                        61:
                                            AssorColorSizeRatioNewRec."61" := AssorDetailsInseamRec."GMT Size";
                                        62:
                                            AssorColorSizeRatioNewRec."62" := AssorDetailsInseamRec."GMT Size";
                                        63:
                                            AssorColorSizeRatioNewRec."63" := AssorDetailsInseamRec."GMT Size";
                                        64:
                                            AssorColorSizeRatioNewRec."64" := AssorDetailsInseamRec."GMT Size";
                                    end;
                                    AssorColorSizeRatioNewRec.Modify();
                                until AssorDetailsInseamRec.Next() = 0;
                            until AssorDetailsPackCountryRec.Next() = 0;


                            //Pack Country
                            AssorDetailsPackCountryRec.Reset();
                            AssorDetailsPackCountryRec.SetRange("Style No.", rec."Style No.");
                            AssorDetailsPackCountryRec.SetRange("lot No.", rec."lot No.");
                            AssorDetailsPackCountryRec.SetRange(Type, '2');
                            AssorDetailsPackCountryRec.FINDSET();

                            repeat
                                repeat
                                    //Add new record
                                    LineNo += 10000;

                                    if AssorColorSizeRatioNewRec."Country Code" = '' then
                                        Error('Invalid country');

                                    if AssorColorSizeRatioNewRec."Pack No" = '' then
                                        Error('Invalid Pack');

                                    AssorColorSizeRatioNewRec.Init();
                                    AssorColorSizeRatioNewRec."Style No." := rec."Style No.";
                                    AssorColorSizeRatioNewRec."Style Name" := StyleRec1."Style No.";
                                    AssorColorSizeRatioNewRec."PO No." := rec."PO No.";
                                    AssorColorSizeRatioNewRec."lot No." := rec."lot No.";
                                    AssorColorSizeRatioNewRec."Line No." := LineNo;
                                    AssorColorSizeRatioNewRec."Colour No" := AssorDetailsRec."Colour No";
                                    AssorColorSizeRatioNewRec."Colour Name" := AssorDetailsRec."Colour Name";
                                    AssorColorSizeRatioNewRec.Qty := StyleRec.Qty;

                                    AssorColorSizeRatioNewRec."1" := '0';
                                    AssorColorSizeRatioNewRec."2" := '0';
                                    AssorColorSizeRatioNewRec."3" := '0';
                                    AssorColorSizeRatioNewRec."4" := '0';
                                    AssorColorSizeRatioNewRec."5" := '0';
                                    AssorColorSizeRatioNewRec."6" := '0';
                                    AssorColorSizeRatioNewRec."7" := '0';
                                    AssorColorSizeRatioNewRec."8" := '0';
                                    AssorColorSizeRatioNewRec."9" := '0';
                                    AssorColorSizeRatioNewRec."10" := '0';
                                    AssorColorSizeRatioNewRec."11" := '0';
                                    AssorColorSizeRatioNewRec."12" := '0';
                                    AssorColorSizeRatioNewRec."13" := '0';
                                    AssorColorSizeRatioNewRec."14" := '0';
                                    AssorColorSizeRatioNewRec."15" := '0';
                                    AssorColorSizeRatioNewRec."16" := '0';
                                    AssorColorSizeRatioNewRec."17" := '0';
                                    AssorColorSizeRatioNewRec."18" := '0';
                                    AssorColorSizeRatioNewRec."19" := '0';
                                    AssorColorSizeRatioNewRec."20" := '0';
                                    AssorColorSizeRatioNewRec."21" := '0';
                                    AssorColorSizeRatioNewRec."22" := '0';
                                    AssorColorSizeRatioNewRec."23" := '0';
                                    AssorColorSizeRatioNewRec."24" := '0';
                                    AssorColorSizeRatioNewRec."25" := '0';
                                    AssorColorSizeRatioNewRec."26" := '0';
                                    AssorColorSizeRatioNewRec."27" := '0';
                                    AssorColorSizeRatioNewRec."28" := '0';
                                    AssorColorSizeRatioNewRec."29" := '0';
                                    AssorColorSizeRatioNewRec."30" := '0';
                                    AssorColorSizeRatioNewRec."31" := '0';
                                    AssorColorSizeRatioNewRec."32" := '0';
                                    AssorColorSizeRatioNewRec."33" := '0';
                                    AssorColorSizeRatioNewRec."34" := '0';
                                    AssorColorSizeRatioNewRec."35" := '0';
                                    AssorColorSizeRatioNewRec."36" := '0';
                                    AssorColorSizeRatioNewRec."37" := '0';
                                    AssorColorSizeRatioNewRec."38" := '0';
                                    AssorColorSizeRatioNewRec."39" := '0';
                                    AssorColorSizeRatioNewRec."40" := '0';
                                    AssorColorSizeRatioNewRec."41" := '0';
                                    AssorColorSizeRatioNewRec."42" := '0';
                                    AssorColorSizeRatioNewRec."43" := '0';
                                    AssorColorSizeRatioNewRec."44" := '0';
                                    AssorColorSizeRatioNewRec."45" := '0';
                                    AssorColorSizeRatioNewRec."46" := '0';
                                    AssorColorSizeRatioNewRec."47" := '0';
                                    AssorColorSizeRatioNewRec."48" := '0';
                                    AssorColorSizeRatioNewRec."49" := '0';
                                    AssorColorSizeRatioNewRec."50" := '0';
                                    AssorColorSizeRatioNewRec."51" := '0';
                                    AssorColorSizeRatioNewRec."52" := '0';
                                    AssorColorSizeRatioNewRec."53" := '0';
                                    AssorColorSizeRatioNewRec."54" := '0';
                                    AssorColorSizeRatioNewRec."55" := '0';
                                    AssorColorSizeRatioNewRec."56" := '0';
                                    AssorColorSizeRatioNewRec."57" := '0';
                                    AssorColorSizeRatioNewRec."58" := '0';
                                    AssorColorSizeRatioNewRec."59" := '0';
                                    AssorColorSizeRatioNewRec."60" := '0';
                                    AssorColorSizeRatioNewRec."61" := '0';
                                    AssorColorSizeRatioNewRec."62" := '0';
                                    AssorColorSizeRatioNewRec."63" := '0';
                                    AssorColorSizeRatioNewRec."64" := '0';

                                    AssorColorSizeRatioNewRec."Pack No" := AssorDetailsPackCountryRec."Pack No";
                                    AssorColorSizeRatioNewRec."Country Code" := AssorDetailsPackCountryRec."Country Code";
                                    AssorColorSizeRatioNewRec."Country Name" := AssorDetailsPackCountryRec."Country Name";
                                    AssorColorSizeRatioNewRec.ShipDate := StyleRec."Ship Date";
                                    AssorColorSizeRatioNewRec."Created User" := UserId;
                                    AssorColorSizeRatioNewRec."Created Date" := WorkDate();
                                    AssorColorSizeRatioNewRec.Insert();
                                until AssorDetailsRec.Next() = 0;

                                //Color
                                AssorDetailsRec.Reset();
                                AssorDetailsRec.SetRange("Style No.", rec."Style No.");
                                AssorDetailsRec.SetRange("lot No.", rec."lot No.");
                                AssorDetailsRec.SetRange(Type, '1');
                                AssorDetailsRec.FindSet();
                            until AssorDetailsPackCountryRec.Next() = 0;


                            //CurrPage.Update();
                            Message('Size/Color qty ratio completed');

                            //Delete blank record
                            AssorColorSizeRatioNewRec.Reset();
                            AssorColorSizeRatioNewRec.SetFilter("Style Name", '=%1', '');
                            if AssorColorSizeRatioNewRec.FindSet() then
                                AssorColorSizeRatioNewRec.Delete();

                        end;
                    end;
                end;
            }
        }
    }

    procedure CalTotal()
    var
        Count: Integer;
        Number: Integer;
        Tot: Integer;
        TotalLine: Integer;
        TotalLine1: Integer;
        StyleMasterPORec: Record "Style Master PO";
        AssoRec: Record AssorColorSizeRatio;
    begin

        CurrPage.Update();
        AssoRec.Reset();
        AssoRec.SetRange("Style No.", rec."Style No.");
        AssoRec.SetRange("lot No.", rec."lot No.");
        if AssoRec.FindSet() then begin
            repeat
                if AssoRec."Colour Name" <> '*' then begin
                    TotalLine := 0;
                    for Count := 1 To 64 do begin
                        case Count of
                            1:
                                if AssoRec."1" <> '' then
                                    Evaluate(Number, AssoRec."1")
                                else
                                    Number := 0;
                            2:
                                if AssoRec."2" <> '' then
                                    Evaluate(Number, AssoRec."2")
                                else
                                    Number := 0;
                            3:
                                if AssoRec."3" <> '' then
                                    Evaluate(Number, AssoRec."3")
                                else
                                    Number := 0;
                            4:
                                if AssoRec."4" <> '' then
                                    Evaluate(Number, AssoRec."4")
                                else
                                    Number := 0;
                            5:
                                if AssoRec."5" <> '' then
                                    Evaluate(Number, AssoRec."5")
                                else
                                    Number := 0;
                            6:
                                if AssoRec."6" <> '' then
                                    Evaluate(Number, AssoRec."6")
                                else
                                    Number := 0;
                            7:
                                if AssoRec."7" <> '' then
                                    Evaluate(Number, AssoRec."7")
                                else
                                    Number := 0;
                            8:
                                if AssoRec."8" <> '' then
                                    Evaluate(Number, AssoRec."8")
                                else
                                    Number := 0;
                            9:
                                if AssoRec."9" <> '' then
                                    Evaluate(Number, AssoRec."9")
                                else
                                    Number := 0;
                            10:
                                if AssoRec."10" <> '' then
                                    Evaluate(Number, AssoRec."10")
                                else
                                    Number := 0;
                            11:
                                if AssoRec."11" <> '' then
                                    Evaluate(Number, AssoRec."11")
                                else
                                    Number := 0;
                            12:
                                if AssoRec."12" <> '' then
                                    Evaluate(Number, AssoRec."12")
                                else
                                    Number := 0;
                            13:
                                if AssoRec."13" <> '' then
                                    Evaluate(Number, AssoRec."13")
                                else
                                    Number := 0;
                            14:
                                if AssoRec."14" <> '' then
                                    Evaluate(Number, AssoRec."14")
                                else
                                    Number := 0;
                            15:
                                if AssoRec."15" <> '' then
                                    Evaluate(Number, AssoRec."15")
                                else
                                    Number := 0;
                            16:
                                if AssoRec."16" <> '' then
                                    Evaluate(Number, AssoRec."16")
                                else
                                    Number := 0;
                            17:
                                if AssoRec."17" <> '' then
                                    Evaluate(Number, AssoRec."17")
                                else
                                    Number := 0;
                            18:
                                if AssoRec."18" <> '' then
                                    Evaluate(Number, AssoRec."18")
                                else
                                    Number := 0;
                            19:
                                if AssoRec."19" <> '' then
                                    Evaluate(Number, AssoRec."19")
                                else
                                    Number := 0;
                            20:
                                if AssoRec."20" <> '' then
                                    Evaluate(Number, AssoRec."20")
                                else
                                    Number := 0;
                            21:
                                if AssoRec."21" <> '' then
                                    Evaluate(Number, AssoRec."21")
                                else
                                    Number := 0;
                            22:
                                if AssoRec."22" <> '' then
                                    Evaluate(Number, AssoRec."22")
                                else
                                    Number := 0;
                            23:
                                if AssoRec."23" <> '' then
                                    Evaluate(Number, AssoRec."23")
                                else
                                    Number := 0;
                            24:
                                if AssoRec."24" <> '' then
                                    Evaluate(Number, AssoRec."24")
                                else
                                    Number := 0;
                            25:
                                if AssoRec."25" <> '' then
                                    Evaluate(Number, AssoRec."25")
                                else
                                    Number := 0;
                            26:
                                if AssoRec."26" <> '' then
                                    Evaluate(Number, AssoRec."26")
                                else
                                    Number := 0;
                            27:
                                if AssoRec."27" <> '' then
                                    Evaluate(Number, AssoRec."27")
                                else
                                    Number := 0;
                            28:
                                if AssoRec."28" <> '' then
                                    Evaluate(Number, AssoRec."28")
                                else
                                    Number := 0;
                            29:
                                if AssoRec."29" <> '' then
                                    Evaluate(Number, AssoRec."29")
                                else
                                    Number := 0;
                            30:
                                if AssoRec."30" <> '' then
                                    Evaluate(Number, AssoRec."30")
                                else
                                    Number := 0;
                            31:
                                if AssoRec."31" <> '' then
                                    Evaluate(Number, AssoRec."31")
                                else
                                    Number := 0;
                            32:
                                if AssoRec."32" <> '' then
                                    Evaluate(Number, AssoRec."32")
                                else
                                    Number := 0;
                            33:
                                if AssoRec."33" <> '' then
                                    Evaluate(Number, AssoRec."33")
                                else
                                    Number := 0;
                            34:
                                if AssoRec."34" <> '' then
                                    Evaluate(Number, AssoRec."34")
                                else
                                    Number := 0;
                            35:
                                if AssoRec."35" <> '' then
                                    Evaluate(Number, AssoRec."35")
                                else
                                    Number := 0;
                            36:
                                if AssoRec."36" <> '' then
                                    Evaluate(Number, AssoRec."36")
                                else
                                    Number := 0;
                            37:
                                if AssoRec."37" <> '' then
                                    Evaluate(Number, AssoRec."37")
                                else
                                    Number := 0;
                            38:
                                if AssoRec."38" <> '' then
                                    Evaluate(Number, AssoRec."38")
                                else
                                    Number := 0;
                            39:
                                if AssoRec."39" <> '' then
                                    Evaluate(Number, AssoRec."39")
                                else
                                    Number := 0;
                            40:
                                if AssoRec."40" <> '' then
                                    Evaluate(Number, AssoRec."40")
                                else
                                    Number := 0;
                            41:
                                if AssoRec."41" <> '' then
                                    Evaluate(Number, AssoRec."41")
                                else
                                    Number := 0;
                            42:
                                if AssoRec."42" <> '' then
                                    Evaluate(Number, AssoRec."42")
                                else
                                    Number := 0;
                            43:
                                if AssoRec."43" <> '' then
                                    Evaluate(Number, AssoRec."43")
                                else
                                    Number := 0;
                            44:
                                if AssoRec."44" <> '' then
                                    Evaluate(Number, AssoRec."44")
                                else
                                    Number := 0;
                            45:
                                if AssoRec."45" <> '' then
                                    Evaluate(Number, AssoRec."45")
                                else
                                    Number := 0;
                            46:
                                if AssoRec."46" <> '' then
                                    Evaluate(Number, AssoRec."46")
                                else
                                    Number := 0;
                            47:
                                if AssoRec."47" <> '' then
                                    Evaluate(Number, AssoRec."47")
                                else
                                    Number := 0;
                            48:
                                if AssoRec."48" <> '' then
                                    Evaluate(Number, AssoRec."48")
                                else
                                    Number := 0;
                            49:
                                if AssoRec."49" <> '' then
                                    Evaluate(Number, AssoRec."49")
                                else
                                    Number := 0;
                            50:
                                if AssoRec."50" <> '' then
                                    Evaluate(Number, AssoRec."50")
                                else
                                    Number := 0;
                            51:
                                if AssoRec."51" <> '' then
                                    Evaluate(Number, AssoRec."51")
                                else
                                    Number := 0;
                            52:
                                if AssoRec."52" <> '' then
                                    Evaluate(Number, AssoRec."52")
                                else
                                    Number := 0;
                            53:
                                if AssoRec."53" <> '' then
                                    Evaluate(Number, AssoRec."53")
                                else
                                    Number := 0;
                            54:
                                if AssoRec."54" <> '' then
                                    Evaluate(Number, AssoRec."54")
                                else
                                    Number := 0;
                            55:
                                if AssoRec."55" <> '' then
                                    Evaluate(Number, AssoRec."55")
                                else
                                    Number := 0;
                            56:
                                if AssoRec."56" <> '' then
                                    Evaluate(Number, AssoRec."56")
                                else
                                    Number := 0;
                            57:
                                if AssoRec."57" <> '' then
                                    Evaluate(Number, AssoRec."57")
                                else
                                    Number := 0;
                            58:
                                if AssoRec."58" <> '' then
                                    Evaluate(Number, AssoRec."58")
                                else
                                    Number := 0;
                            59:
                                if AssoRec."59" <> '' then
                                    Evaluate(Number, AssoRec."59")
                                else
                                    Number := 0;
                            60:
                                if AssoRec."60" <> '' then
                                    Evaluate(Number, AssoRec."60")
                                else
                                    Number := 0;
                            61:
                                if AssoRec."61" <> '' then
                                    Evaluate(Number, AssoRec."61")
                                else
                                    Number := 0;
                            62:
                                if AssoRec."62" <> '' then
                                    Evaluate(Number, AssoRec."62")
                                else
                                    Number := 0;
                            63:
                                if AssoRec."63" <> '' then
                                    Evaluate(Number, AssoRec."63")
                                else
                                    Number := 0;
                            64:
                                if AssoRec."64" <> '' then
                                    Evaluate(Number, AssoRec."64")
                                else
                                    Number := 0;
                        end;

                        TotalLine += Number;
                    end;

                    if (AssoRec."Colour Name" = rec."Colour Name") and (AssoRec."Country Name" = rec."Country Name") then
                        TotalLine1 := TotalLine;

                    Tot := Tot + TotalLine;
                end;

            until AssoRec.Next() = 0;
        end;

        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
        StyleMasterPORec.SetRange("lot No.", rec."lot No.");

        if StyleMasterPORec.FindSet() then begin
            if StyleMasterPORec.Qty < Tot then begin
                Error('Total quantity %1 is greater than the PO quantity %2', Tot, StyleMasterPORec.Qty);
                exit;
            end
            else begin
                rec.Total := TotalLine1;
                CurrPage.Update();
            end;
        end;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        AssorColorSizeRatioViewRec: Record AssorColorSizeRatioView;
        AssorColorSizeRatioPriceRec: Record AssorColorSizeRatioPrice;
    begin
        AssorColorSizeRatioViewRec.Reset();
        AssorColorSizeRatioViewRec.SetRange("Style No.", rec."Style No.");
        AssorColorSizeRatioViewRec.SetRange("lot No.", rec."lot No.");
        AssorColorSizeRatioViewRec.SetRange("Line No.", rec."Line No.");
        AssorColorSizeRatioViewRec.DeleteAll();

        AssorColorSizeRatioPriceRec.Reset();
        AssorColorSizeRatioPriceRec.SetRange("Style No.", rec."Style No.");
        AssorColorSizeRatioPriceRec.SetRange("lot No.", rec."lot No.");
        AssorColorSizeRatioPriceRec.SetRange("Line No.", rec."Line No.");
        AssorColorSizeRatioPriceRec.DeleteAll();
    end;


    trigger OnAfterGetRecord()
    var
        Rowcount: Integer;
        Count: Integer;
        AssoDetail: Record AssortmentDetailsInseam;
    begin
        StyleExprTxt := ChangeColor.ChangeColorAsso(Rec);

        // AssoDetail.Reset();
        // AssoDetail.SetRange("Style No.", rec."Style No.");
        // AssoDetail.SetRange("Lot No.", rec."lot No.");
        // AssoDetail.FindSet();
        // Rowcount := AssoDetail.Count;

        // for Count := 1 To 64 do begin
        //     case Count of
        //         1:
        //             if Rowcount >= Count then
        //                 SetVisible1 := true
        //             else
        //                 SetVisible1 := false;
        //         2:
        //             if Rowcount >= Count then
        //                 SetVisible2 := true
        //             else
        //                 SetVisible2 := false;
        //         3:
        //             if Rowcount >= Count then
        //                 SetVisible3 := true
        //             else
        //                 SetVisible3 := false;
        //         4:
        //             if Rowcount >= Count then
        //                 SetVisible4 := true
        //             else
        //                 SetVisible4 := false;
        //         5:
        //             if Rowcount >= Count then
        //                 SetVisible5 := true
        //             else
        //                 SetVisible5 := false;
        //         6:
        //             if Rowcount >= Count then
        //                 SetVisible6 := true
        //             else
        //                 SetVisible6 := false;
        //         7:
        //             if Rowcount >= Count then
        //                 SetVisible7 := true
        //             else
        //                 SetVisible7 := false;
        //         8:
        //             if Rowcount >= Count then
        //                 SetVisible8 := true
        //             else
        //                 SetVisible8 := false;
        //         9:
        //             if Rowcount >= Count then
        //                 SetVisible9 := true
        //             else
        //                 SetVisible9 := false;
        //         10:
        //             if Rowcount >= Count then
        //                 SetVisible10 := true
        //             else
        //                 SetVisible10 := false;
        //         11:
        //             if Rowcount >= Count then
        //                 SetVisible11 := true
        //             else
        //                 SetVisible11 := false;
        //         12:
        //             if Rowcount >= Count then
        //                 SetVisible12 := true
        //             else
        //                 SetVisible12 := false;
        //         13:
        //             if Rowcount >= Count then
        //                 SetVisible13 := true
        //             else
        //                 SetVisible13 := false;
        //         14:
        //             if Rowcount >= Count then
        //                 SetVisible14 := true
        //             else
        //                 SetVisible14 := false;
        //         15:
        //             if Rowcount >= Count then
        //                 SetVisible15 := true
        //             else
        //                 SetVisible15 := false;
        //         16:
        //             if Rowcount >= Count then
        //                 SetVisible16 := true
        //             else
        //                 SetVisible16 := false;
        //         17:
        //             if Rowcount >= Count then
        //                 SetVisible17 := true
        //             else
        //                 SetVisible17 := false;
        //         18:
        //             if Rowcount >= Count then
        //                 SetVisible18 := true
        //             else
        //                 SetVisible18 := false;
        //         19:
        //             if Rowcount >= Count then
        //                 SetVisible19 := true
        //             else
        //                 SetVisible19 := false;
        //         20:
        //             if Rowcount >= Count then
        //                 SetVisible20 := true
        //             else
        //                 SetVisible20 := false;
        //         21:
        //             if Rowcount >= Count then
        //                 SetVisible21 := true
        //             else
        //                 SetVisible21 := false;
        //         22:
        //             if Rowcount >= Count then
        //                 SetVisible22 := true
        //             else
        //                 SetVisible22 := false;
        //         23:
        //             if Rowcount >= Count then
        //                 SetVisible23 := true
        //             else
        //                 SetVisible23 := false;
        //         24:
        //             if Rowcount >= Count then
        //                 SetVisible24 := true
        //             else
        //                 SetVisible24 := false;
        //         25:
        //             if Rowcount >= Count then
        //                 SetVisible25 := true
        //             else
        //                 SetVisible25 := false;
        //         26:
        //             if Rowcount >= Count then
        //                 SetVisible26 := true
        //             else
        //                 SetVisible26 := false;
        //         27:
        //             if Rowcount >= Count then
        //                 SetVisible27 := true
        //             else
        //                 SetVisible27 := false;
        //         28:
        //             if Rowcount >= Count then
        //                 SetVisible28 := true
        //             else
        //                 SetVisible28 := false;
        //         29:
        //             if Rowcount >= Count then
        //                 SetVisible29 := true
        //             else
        //                 SetVisible29 := false;
        //         30:
        //             if Rowcount >= Count then
        //                 SetVisible30 := true
        //             else
        //                 SetVisible30 := false;
        //         31:
        //             if Rowcount >= Count then
        //                 SetVisible31 := true
        //             else
        //                 SetVisible31 := false;
        //         32:
        //             if Rowcount >= Count then
        //                 SetVisible32 := true
        //             else
        //                 SetVisible32 := false;
        //         33:
        //             if Rowcount >= Count then
        //                 SetVisible33 := true
        //             else
        //                 SetVisible33 := false;
        //         34:
        //             if Rowcount >= Count then
        //                 SetVisible34 := true
        //             else
        //                 SetVisible34 := false;
        //         35:
        //             if Rowcount >= Count then
        //                 SetVisible35 := true
        //             else
        //                 SetVisible35 := false;
        //         36:
        //             if Rowcount >= Count then
        //                 SetVisible36 := true
        //             else
        //                 SetVisible36 := false;
        //         37:
        //             if Rowcount >= Count then
        //                 SetVisible37 := true
        //             else
        //                 SetVisible37 := false;
        //         38:
        //             if Rowcount >= Count then
        //                 SetVisible38 := true
        //             else
        //                 SetVisible38 := false;
        //         39:
        //             if Rowcount >= Count then
        //                 SetVisible39 := true
        //             else
        //                 SetVisible39 := false;
        //         40:
        //             if Rowcount >= Count then
        //                 SetVisible40 := true
        //             else
        //                 SetVisible40 := false;
        //         41:
        //             if Rowcount >= Count then
        //                 SetVisible41 := true
        //             else
        //                 SetVisible41 := false;
        //         42:
        //             if Rowcount >= Count then
        //                 SetVisible42 := true
        //             else
        //                 SetVisible42 := false;
        //         43:
        //             if Rowcount >= Count then
        //                 SetVisible43 := true
        //             else
        //                 SetVisible43 := false;
        //         44:
        //             if Rowcount >= Count then
        //                 SetVisible44 := true
        //             else
        //                 SetVisible44 := false;
        //         45:
        //             if Rowcount >= Count then
        //                 SetVisible45 := true
        //             else
        //                 SetVisible45 := false;
        //         46:
        //             if Rowcount >= Count then
        //                 SetVisible46 := true
        //             else
        //                 SetVisible46 := false;
        //         47:
        //             if Rowcount >= Count then
        //                 SetVisible47 := true
        //             else
        //                 SetVisible47 := false;
        //         48:
        //             if Rowcount >= Count then
        //                 SetVisible48 := true
        //             else
        //                 SetVisible48 := false;
        //         49:
        //             if Rowcount >= Count then
        //                 SetVisible49 := true
        //             else
        //                 SetVisible49 := false;
        //         50:
        //             if Rowcount >= Count then
        //                 SetVisible50 := true
        //             else
        //                 SetVisible50 := false;
        //         51:
        //             if Rowcount >= Count then
        //                 SetVisible51 := true
        //             else
        //                 SetVisible51 := false;
        //         52:
        //             if Rowcount >= Count then
        //                 SetVisible52 := true
        //             else
        //                 SetVisible52 := false;
        //         53:
        //             if Rowcount >= Count then
        //                 SetVisible53 := true
        //             else
        //                 SetVisible53 := false;
        //         54:
        //             if Rowcount >= Count then
        //                 SetVisible54 := true
        //             else
        //                 SetVisible54 := false;
        //         55:
        //             if Rowcount >= Count then
        //                 SetVisible55 := true
        //             else
        //                 SetVisible55 := false;
        //         56:
        //             if Rowcount >= Count then
        //                 SetVisible56 := true
        //             else
        //                 SetVisible56 := false;
        //         57:
        //             if Rowcount >= Count then
        //                 SetVisible57 := true
        //             else
        //                 SetVisible57 := false;
        //         58:
        //             if Rowcount >= Count then
        //                 SetVisible58 := true
        //             else
        //                 SetVisible58 := false;
        //         59:
        //             if Rowcount >= Count then
        //                 SetVisible59 := true
        //             else
        //                 SetVisible59 := false;
        //         60:
        //             if Rowcount >= Count then
        //                 SetVisible60 := true
        //             else
        //                 SetVisible60 := false;
        //         61:
        //             if Rowcount >= Count then
        //                 SetVisible61 := true
        //             else
        //                 SetVisible61 := false;
        //         62:
        //             if Rowcount >= Count then
        //                 SetVisible62 := true
        //             else
        //                 SetVisible62 := false;
        //         63:
        //             if Rowcount >= Count then
        //                 SetVisible63 := true
        //             else
        //                 SetVisible63 := false;
        //         64:
        //             if Rowcount >= Count then
        //                 SetVisible64 := true
        //             else
        //                 SetVisible64 := false;
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


    trigger OnClosePage()
    var
        AssoRec: Record AssorColorSizeRatio;
        StylePORec: Record "Style Master PO";
        Total: BigInteger;
    begin

        //Get Po total
        StylePORec.Reset();
        StylePORec.SetRange("Style No.", rec."Style No.");
        if StylePORec.FindSet() then begin
            repeat
                Total := 0;
                AssoRec.Reset();
                AssoRec.SetRange("Style No.", StylePORec."Style No.");
                AssoRec.SetFilter("Colour Name", '<>%1', '*');
                AssoRec.SetRange("lot No.", StylePORec."Lot No.");
                if AssoRec.FindSet() then begin
                    repeat
                        Total += AssoRec.Total;
                    until AssoRec.Next() = 0;

                    if Total < StylePORec.Qty then
                        Error('Çolour/Size/Country wise quantity total is less than PO (%1) order qty (%2).', StylePORec."PO No.", StylePORec.Qty);

                    if Total > StylePORec.Qty then
                        Error('Çolour/Size/Country wise quantity total is greater than PO (%1) order qty (%2).', StylePORec."PO No.", StylePORec.Qty);

                end;
            until StylePORec.Next() = 0;
        end;

    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit: Boolean;
    // SetVisible1: Boolean;
    // SetVisible2: Boolean;
    // SetVisible3: Boolean;
    // SetVisible4: Boolean;
    // SetVisible5: Boolean;
    // SetVisible6: Boolean;
    // SetVisible7: Boolean;
    // SetVisible8: Boolean;
    // SetVisible9: Boolean;
    // SetVisible10: Boolean;
    // SetVisible11: Boolean;
    // SetVisible12: Boolean;
    // SetVisible13: Boolean;
    // SetVisible14: Boolean;
    // SetVisible15: Boolean;
    // SetVisible16: Boolean;
    // SetVisible17: Boolean;
    // SetVisible18: Boolean;
    // SetVisible19: Boolean;
    // SetVisible20: Boolean;
    // SetVisible21: Boolean;
    // SetVisible22: Boolean;
    // SetVisible23: Boolean;
    // SetVisible24: Boolean;
    // SetVisible25: Boolean;
    // SetVisible26: Boolean;
    // SetVisible27: Boolean;
    // SetVisible28: Boolean;
    // SetVisible29: Boolean;
    // SetVisible30: Boolean;
    // SetVisible31: Boolean;
    // SetVisible32: Boolean;
    // SetVisible33: Boolean;
    // SetVisible34: Boolean;
    // SetVisible35: Boolean;
    // SetVisible36: Boolean;
    // SetVisible37: Boolean;
    // SetVisible38: Boolean;
    // SetVisible39: Boolean;
    // SetVisible40: Boolean;
    // SetVisible41: Boolean;
    // SetVisible42: Boolean;
    // SetVisible43: Boolean;
    // SetVisible44: Boolean;
    // SetVisible45: Boolean;
    // SetVisible46: Boolean;
    // SetVisible47: Boolean;
    // SetVisible48: Boolean;
    // SetVisible49: Boolean;
    // SetVisible50: Boolean;
    // SetVisible51: Boolean;
    // SetVisible52: Boolean;
    // SetVisible53: Boolean;
    // SetVisible54: Boolean;
    // SetVisible55: Boolean;
    // SetVisible56: Boolean;
    // SetVisible57: Boolean;
    // SetVisible58: Boolean;
    // SetVisible59: Boolean;
    // SetVisible60: Boolean;
    // SetVisible61: Boolean;
    // SetVisible62: Boolean;
    // SetVisible63: Boolean;
    // SetVisible64: Boolean;
}