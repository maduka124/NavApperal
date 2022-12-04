page 51019 AssorColorSizeRatioListPart2
{
    PageType = ListPart;
    //AutoSplitKey = true;
    SourceTable = AssorColorSizeRatioView;
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
                    Editable = false;
                    Caption = 'Country';
                    StyleExpr = StyleExprTxt;
                }

                field("Pack No"; rec."Pack No")
                {
                    ApplicationArea = All;
                    Caption = 'Pack';
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;

                }

                field("SHID/LOT"; rec."SHID/LOT")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                }

                field("SHID/LOT Name"; rec."SHID/LOT Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
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

                field(Total; rec.Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Quantity Breakdown")
            {
                ApplicationArea = All;
                Image = BreakRulesList;

                trigger OnAction();
                var
                    AssorColorSizeRatioRec: Record AssorColorSizeRatio;
                    AssorColorSizeRatioViewRec: Record AssorColorSizeRatioView;
                    AssorColorSizeRatioPriceRec: Record AssorColorSizeRatioPrice;
                    BOMEstimateCostRec: record "BOM Estimate Cost";
                    StyleRec: Record "Style Master PO";
                    LineNo: Integer;
                    Color: Code[20];
                    Number1: Integer;
                    Number2: Integer;
                    PONO: Code[20];
                begin

                    StyleRec.Reset();
                    StyleRec.SetRange("Style No.", rec."Style No.");
                    StyleRec.SetRange("Lot No.", rec."Lot No.");
                    StyleRec.FindLast();

                    PONO := StyleRec."PO No.";

                    //Color/Size/Ratio
                    AssorColorSizeRatioRec.Reset();
                    AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioRec.SetRange("lot No.", rec."lot No.");

                    //View 
                    AssorColorSizeRatioViewRec.Reset();
                    AssorColorSizeRatioViewRec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioViewRec.SetRange("lot No.", rec."lot No.");
                    AssorColorSizeRatioViewRec.deleteAll();

                    if not AssorColorSizeRatioRec.FINDSET() then
                        Message('No size/color qty ratio found for PO %1', PONO)
                    else begin
                        repeat
                            AssorColorSizeRatioViewRec.Reset();
                            AssorColorSizeRatioViewRec.SetRange("Style No.", rec."Style No.");
                            AssorColorSizeRatioViewRec.SetRange("lot No.", rec."lot No.");
                            AssorColorSizeRatioViewRec.SetRange("Colour No", AssorColorSizeRatioRec."Colour No");
                            AssorColorSizeRatioViewRec.SetRange("Country Code", AssorColorSizeRatioRec."Country Code");

                            if AssorColorSizeRatioViewRec.FINDSET() then begin
                                if AssorColorSizeRatioRec."Colour Name" <> '*' then begin
                                    if AssorColorSizeRatioViewRec."1" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."1")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."1" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."1")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."1" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."2" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."2")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."2" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."2")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."2" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."3" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."3")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."3" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."3")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."3" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."4" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."4")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."4" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."4")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."4" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."5" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."5")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."5" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."5")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."5" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."6" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."6")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."6" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."6")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."6" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."7" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."7")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."7" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."7")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."7" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."8" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."8")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."8" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."8")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."8" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."9" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."9")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."9" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."9")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."9" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."10" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."10")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."10" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."10")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."10" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."11" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."11")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."11" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."11")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."11" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."12" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."12")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."12" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."12")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."12" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."13" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."13")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."13" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."13")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."13" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."14" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."14")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."14" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."14")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."14" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."15" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."15")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."15" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."15")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."15" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."16" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."16")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."16" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."16")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."16" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."17" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."17")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."17" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."17")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."17" := format(Number1 + Number2);


                                    if AssorColorSizeRatioViewRec."18" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."18")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."18" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."18")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."18" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."19" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."19")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."19" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."19")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."19" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."20" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."20")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."20" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."20")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."20" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."21" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."21")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."21" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."21")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."21" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."22" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."22")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."22" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."22")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."22" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."23" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."23")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."23" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."23")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."23" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."24" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."24")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."24" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."24")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."24" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."25" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."25")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."25" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."25")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."25" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."26" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."26")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."26" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."26")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."26" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."27" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."27")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."27" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."27")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."27" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."28" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."28")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."28" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."28")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."28" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."29" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."29")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."29" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."29")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."29" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."30" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."30")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."30" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."30")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."30" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."31" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."31")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."31" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."31")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."31" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."32" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."32")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."32" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."32")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."32" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."33" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."33")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."33" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."33")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."33" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."34" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."34")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."34" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."34")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."34" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."35" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."35")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."35" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."35")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."35" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."36" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."36")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."36" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."36")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."36" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."37" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."37")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."37" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."37")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."37" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."38" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."38")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."38" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."38")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."38" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."39" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."39")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."39" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."39")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."39" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."40" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."40")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."40" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."40")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."40" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."41" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."41")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."41" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."41")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."41" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."42" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."42")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."42" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."42")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."42" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."43" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."43")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."43" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."43")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."43" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."44" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."44")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."44" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."44")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."44" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."45" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."45")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."45" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."45")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."45" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."46" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."46")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."46" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."46")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."46" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."47" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."47")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."47" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."47")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."47" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."48" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."48")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."48" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."48")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."48" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."49" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."49")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."49" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."49")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."49" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."50" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."50")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."50" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."50")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."50" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."51" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."51")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."51" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."51")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."51" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."52" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."52")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."52" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."52")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."52" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."53" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."53")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."53" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."53")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."53" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."54" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."54")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."54" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."54")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."54" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."55" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."55")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."55" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."55")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."55" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."56" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."56")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."56" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."56")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."56" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."57" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."57")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."57" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."57")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."57" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."58" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."58")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."58" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."58")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."58" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."59" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."59")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."59" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."59")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."59" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."60" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."60")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."60" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."60")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."60" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."61" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."61")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."61" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."61")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."61" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."62" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."62")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."62" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."62")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."62" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."63" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."63")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."63" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."63")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."63" := format(Number1 + Number2);

                                    if AssorColorSizeRatioViewRec."64" <> '' then
                                        Evaluate(Number1, AssorColorSizeRatioViewRec."64")
                                    else
                                        Number1 := 0;

                                    if AssorColorSizeRatioRec."64" <> '' then
                                        Evaluate(Number2, AssorColorSizeRatioRec."64")
                                    else
                                        Number2 := 0;

                                    AssorColorSizeRatioViewRec."64" := format(Number1 + Number2);


                                    Number1 := AssorColorSizeRatioViewRec.Total;
                                    Number2 := AssorColorSizeRatioRec.Total;
                                    AssorColorSizeRatioViewRec."Total" := Number1 + Number2;

                                    AssorColorSizeRatioViewRec.Modify();
                                end;
                            end
                            else begin
                                LineNo += 10000;
                                //insert
                                AssorColorSizeRatioViewRec.Init();
                                AssorColorSizeRatioViewRec."Style No." := rec."Style No.";
                                AssorColorSizeRatioViewRec."PO No." := PONO;
                                AssorColorSizeRatioViewRec."lot No." := rec."lot No.";
                                AssorColorSizeRatioViewRec."Line No." := LineNo;
                                AssorColorSizeRatioViewRec."Colour No" := AssorColorSizeRatioRec."Colour No";
                                AssorColorSizeRatioViewRec."Colour Name" := AssorColorSizeRatioRec."Colour Name";
                                AssorColorSizeRatioViewRec.Qty := AssorColorSizeRatioRec.Qty;
                                AssorColorSizeRatioViewRec."SHID/LOT" := AssorColorSizeRatioRec."SHID/LOT";
                                AssorColorSizeRatioViewRec."1" := AssorColorSizeRatioRec."1";
                                AssorColorSizeRatioViewRec."2" := AssorColorSizeRatioRec."2";
                                AssorColorSizeRatioViewRec."3" := AssorColorSizeRatioRec."3";
                                AssorColorSizeRatioViewRec."4" := AssorColorSizeRatioRec."4";
                                AssorColorSizeRatioViewRec."5" := AssorColorSizeRatioRec."5";
                                AssorColorSizeRatioViewRec."6" := AssorColorSizeRatioRec."6";
                                AssorColorSizeRatioViewRec."7" := AssorColorSizeRatioRec."7";
                                AssorColorSizeRatioViewRec."8" := AssorColorSizeRatioRec."8";
                                AssorColorSizeRatioViewRec."9" := AssorColorSizeRatioRec."9";
                                AssorColorSizeRatioViewRec."10" := AssorColorSizeRatioRec."10";
                                AssorColorSizeRatioViewRec."11" := AssorColorSizeRatioRec."11";
                                AssorColorSizeRatioViewRec."12" := AssorColorSizeRatioRec."12";
                                AssorColorSizeRatioViewRec."13" := AssorColorSizeRatioRec."13";
                                AssorColorSizeRatioViewRec."14" := AssorColorSizeRatioRec."14";
                                AssorColorSizeRatioViewRec."15" := AssorColorSizeRatioRec."15";
                                AssorColorSizeRatioViewRec."16" := AssorColorSizeRatioRec."16";
                                AssorColorSizeRatioViewRec."17" := AssorColorSizeRatioRec."17";
                                AssorColorSizeRatioViewRec."18" := AssorColorSizeRatioRec."18";
                                AssorColorSizeRatioViewRec."19" := AssorColorSizeRatioRec."19";
                                AssorColorSizeRatioViewRec."20" := AssorColorSizeRatioRec."20";
                                AssorColorSizeRatioViewRec."21" := AssorColorSizeRatioRec."21";
                                AssorColorSizeRatioViewRec."22" := AssorColorSizeRatioRec."22";
                                AssorColorSizeRatioViewRec."23" := AssorColorSizeRatioRec."23";
                                AssorColorSizeRatioViewRec."24" := AssorColorSizeRatioRec."24";
                                AssorColorSizeRatioViewRec."25" := AssorColorSizeRatioRec."25";
                                AssorColorSizeRatioViewRec."26" := AssorColorSizeRatioRec."26";
                                AssorColorSizeRatioViewRec."27" := AssorColorSizeRatioRec."27";
                                AssorColorSizeRatioViewRec."28" := AssorColorSizeRatioRec."28";
                                AssorColorSizeRatioViewRec."29" := AssorColorSizeRatioRec."29";
                                AssorColorSizeRatioViewRec."30" := AssorColorSizeRatioRec."30";
                                AssorColorSizeRatioViewRec."31" := AssorColorSizeRatioRec."31";
                                AssorColorSizeRatioViewRec."32" := AssorColorSizeRatioRec."32";
                                AssorColorSizeRatioViewRec."33" := AssorColorSizeRatioRec."33";
                                AssorColorSizeRatioViewRec."34" := AssorColorSizeRatioRec."34";
                                AssorColorSizeRatioViewRec."35" := AssorColorSizeRatioRec."35";
                                AssorColorSizeRatioViewRec."36" := AssorColorSizeRatioRec."36";
                                AssorColorSizeRatioViewRec."37" := AssorColorSizeRatioRec."37";
                                AssorColorSizeRatioViewRec."38" := AssorColorSizeRatioRec."38";
                                AssorColorSizeRatioViewRec."39" := AssorColorSizeRatioRec."39";
                                AssorColorSizeRatioViewRec."40" := AssorColorSizeRatioRec."40";
                                AssorColorSizeRatioViewRec."41" := AssorColorSizeRatioRec."41";
                                AssorColorSizeRatioViewRec."42" := AssorColorSizeRatioRec."42";
                                AssorColorSizeRatioViewRec."43" := AssorColorSizeRatioRec."43";
                                AssorColorSizeRatioViewRec."44" := AssorColorSizeRatioRec."44";
                                AssorColorSizeRatioViewRec."45" := AssorColorSizeRatioRec."45";
                                AssorColorSizeRatioViewRec."46" := AssorColorSizeRatioRec."46";
                                AssorColorSizeRatioViewRec."47" := AssorColorSizeRatioRec."47";
                                AssorColorSizeRatioViewRec."48" := AssorColorSizeRatioRec."48";
                                AssorColorSizeRatioViewRec."49" := AssorColorSizeRatioRec."49";
                                AssorColorSizeRatioViewRec."50" := AssorColorSizeRatioRec."50";
                                AssorColorSizeRatioViewRec."51" := AssorColorSizeRatioRec."51";
                                AssorColorSizeRatioViewRec."52" := AssorColorSizeRatioRec."52";
                                AssorColorSizeRatioViewRec."53" := AssorColorSizeRatioRec."53";
                                AssorColorSizeRatioViewRec."54" := AssorColorSizeRatioRec."54";
                                AssorColorSizeRatioViewRec."55" := AssorColorSizeRatioRec."55";
                                AssorColorSizeRatioViewRec."56" := AssorColorSizeRatioRec."56";
                                AssorColorSizeRatioViewRec."57" := AssorColorSizeRatioRec."57";
                                AssorColorSizeRatioViewRec."58" := AssorColorSizeRatioRec."58";
                                AssorColorSizeRatioViewRec."59" := AssorColorSizeRatioRec."59";
                                AssorColorSizeRatioViewRec."60" := AssorColorSizeRatioRec."60";
                                AssorColorSizeRatioViewRec."61" := AssorColorSizeRatioRec."61";
                                AssorColorSizeRatioViewRec."62" := AssorColorSizeRatioRec."62";
                                AssorColorSizeRatioViewRec."63" := AssorColorSizeRatioRec."63";
                                AssorColorSizeRatioViewRec."64" := AssorColorSizeRatioRec."64";
                                AssorColorSizeRatioViewRec.Total := AssorColorSizeRatioRec.Total;
                                AssorColorSizeRatioViewRec."SHID/LOT Name" := AssorColorSizeRatioRec."SHID/LOT Name";
                                AssorColorSizeRatioViewRec."Country Code" := AssorColorSizeRatioRec."Country Code";
                                AssorColorSizeRatioViewRec."Country Name" := AssorColorSizeRatioRec."Country Name";
                                AssorColorSizeRatioViewRec."Pack No" := AssorColorSizeRatioRec."Pack No";
                                AssorColorSizeRatioViewRec."Created User" := UserId;
                                AssorColorSizeRatioViewRec."Created Date" := WorkDate();
                                AssorColorSizeRatioViewRec.Insert();
                            end;
                        until AssorColorSizeRatioRec.Next() = 0;

                        CurrPage.Update();
                    end;


                    //Generate Price  table
                    //Color/Size/Ratio view table
                    AssorColorSizeRatioViewRec.Reset();
                    AssorColorSizeRatioViewRec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioViewRec.SetRange("lot No.", rec."lot No.");

                    //Price table
                    AssorColorSizeRatioPriceRec.Reset();
                    AssorColorSizeRatioPriceRec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatioPriceRec.SetRange("lot No.", rec."lot No.");
                    AssorColorSizeRatioPriceRec.deleteAll();

                    BOMEstimateCostRec.Reset();
                    BOMEstimateCostRec.SetRange("Style No.", rec."Style No.");
                    if not BOMEstimateCostRec.FindSet() then
                        Error('Cannot find Estimate costing for the style: %1', rec."Style No.");

                    if AssorColorSizeRatioViewRec.FINDSET() then begin
                        repeat
                            AssorColorSizeRatioPriceRec.Init();
                            AssorColorSizeRatioPriceRec."Style No." := rec."Style No.";
                            AssorColorSizeRatioPriceRec."PO No." := PONO;
                            AssorColorSizeRatioPriceRec."lot No." := rec."lot No.";
                            AssorColorSizeRatioPriceRec."Line No." := AssorColorSizeRatioViewRec."Line No.";
                            AssorColorSizeRatioPriceRec."Colour No" := AssorColorSizeRatioViewRec."Colour No";
                            AssorColorSizeRatioPriceRec."Colour Name" := AssorColorSizeRatioViewRec."Colour Name";

                            if AssorColorSizeRatioViewRec."Colour Name" = '*' then begin
                                AssorColorSizeRatioPriceRec."1" := AssorColorSizeRatioViewRec."1";
                                AssorColorSizeRatioPriceRec."2" := AssorColorSizeRatioViewRec."2";
                                AssorColorSizeRatioPriceRec."3" := AssorColorSizeRatioViewRec."3";
                                AssorColorSizeRatioPriceRec."4" := AssorColorSizeRatioViewRec."4";
                                AssorColorSizeRatioPriceRec."5" := AssorColorSizeRatioViewRec."5";
                                AssorColorSizeRatioPriceRec."6" := AssorColorSizeRatioViewRec."6";
                                AssorColorSizeRatioPriceRec."7" := AssorColorSizeRatioViewRec."7";
                                AssorColorSizeRatioPriceRec."8" := AssorColorSizeRatioViewRec."8";
                                AssorColorSizeRatioPriceRec."9" := AssorColorSizeRatioViewRec."9";
                                AssorColorSizeRatioPriceRec."10" := AssorColorSizeRatioViewRec."10";
                                AssorColorSizeRatioPriceRec."11" := AssorColorSizeRatioViewRec."11";
                                AssorColorSizeRatioPriceRec."12" := AssorColorSizeRatioViewRec."12";
                                AssorColorSizeRatioPriceRec."13" := AssorColorSizeRatioViewRec."13";
                                AssorColorSizeRatioPriceRec."14" := AssorColorSizeRatioViewRec."14";
                                AssorColorSizeRatioPriceRec."15" := AssorColorSizeRatioViewRec."15";
                                AssorColorSizeRatioPriceRec."16" := AssorColorSizeRatioViewRec."16";
                                AssorColorSizeRatioPriceRec."17" := AssorColorSizeRatioViewRec."17";
                                AssorColorSizeRatioPriceRec."18" := AssorColorSizeRatioViewRec."18";
                                AssorColorSizeRatioPriceRec."19" := AssorColorSizeRatioViewRec."19";
                                AssorColorSizeRatioPriceRec."20" := AssorColorSizeRatioViewRec."20";
                                AssorColorSizeRatioPriceRec."21" := AssorColorSizeRatioViewRec."21";
                                AssorColorSizeRatioPriceRec."22" := AssorColorSizeRatioViewRec."22";
                                AssorColorSizeRatioPriceRec."23" := AssorColorSizeRatioViewRec."23";
                                AssorColorSizeRatioPriceRec."24" := AssorColorSizeRatioViewRec."24";
                                AssorColorSizeRatioPriceRec."25" := AssorColorSizeRatioViewRec."25";
                                AssorColorSizeRatioPriceRec."26" := AssorColorSizeRatioViewRec."26";
                                AssorColorSizeRatioPriceRec."27" := AssorColorSizeRatioViewRec."27";
                                AssorColorSizeRatioPriceRec."28" := AssorColorSizeRatioViewRec."28";
                                AssorColorSizeRatioPriceRec."29" := AssorColorSizeRatioViewRec."29";
                                AssorColorSizeRatioPriceRec."30" := AssorColorSizeRatioViewRec."30";
                                AssorColorSizeRatioPriceRec."31" := AssorColorSizeRatioViewRec."31";
                                AssorColorSizeRatioPriceRec."32" := AssorColorSizeRatioViewRec."32";
                                AssorColorSizeRatioPriceRec."33" := AssorColorSizeRatioViewRec."33";
                                AssorColorSizeRatioPriceRec."34" := AssorColorSizeRatioViewRec."34";
                                AssorColorSizeRatioPriceRec."35" := AssorColorSizeRatioViewRec."35";
                                AssorColorSizeRatioPriceRec."36" := AssorColorSizeRatioViewRec."36";
                                AssorColorSizeRatioPriceRec."37" := AssorColorSizeRatioViewRec."37";
                                AssorColorSizeRatioPriceRec."38" := AssorColorSizeRatioViewRec."38";
                                AssorColorSizeRatioPriceRec."39" := AssorColorSizeRatioViewRec."39";
                                AssorColorSizeRatioPriceRec."40" := AssorColorSizeRatioViewRec."40";
                                AssorColorSizeRatioPriceRec."41" := AssorColorSizeRatioViewRec."41";
                                AssorColorSizeRatioPriceRec."42" := AssorColorSizeRatioViewRec."42";
                                AssorColorSizeRatioPriceRec."43" := AssorColorSizeRatioViewRec."43";
                                AssorColorSizeRatioPriceRec."44" := AssorColorSizeRatioViewRec."44";
                                AssorColorSizeRatioPriceRec."45" := AssorColorSizeRatioViewRec."45";
                                AssorColorSizeRatioPriceRec."46" := AssorColorSizeRatioViewRec."46";
                                AssorColorSizeRatioPriceRec."47" := AssorColorSizeRatioViewRec."47";
                                AssorColorSizeRatioPriceRec."48" := AssorColorSizeRatioViewRec."48";
                                AssorColorSizeRatioPriceRec."49" := AssorColorSizeRatioViewRec."49";
                                AssorColorSizeRatioPriceRec."50" := AssorColorSizeRatioViewRec."50";
                                AssorColorSizeRatioPriceRec."51" := AssorColorSizeRatioViewRec."51";
                                AssorColorSizeRatioPriceRec."52" := AssorColorSizeRatioViewRec."52";
                                AssorColorSizeRatioPriceRec."53" := AssorColorSizeRatioViewRec."53";
                                AssorColorSizeRatioPriceRec."54" := AssorColorSizeRatioViewRec."54";
                                AssorColorSizeRatioPriceRec."55" := AssorColorSizeRatioViewRec."55";
                                AssorColorSizeRatioPriceRec."56" := AssorColorSizeRatioViewRec."56";
                                AssorColorSizeRatioPriceRec."57" := AssorColorSizeRatioViewRec."57";
                                AssorColorSizeRatioPriceRec."58" := AssorColorSizeRatioViewRec."58";
                                AssorColorSizeRatioPriceRec."59" := AssorColorSizeRatioViewRec."59";
                                AssorColorSizeRatioPriceRec."60" := AssorColorSizeRatioViewRec."60";
                                AssorColorSizeRatioPriceRec."61" := AssorColorSizeRatioViewRec."61";
                                AssorColorSizeRatioPriceRec."62" := AssorColorSizeRatioViewRec."62";
                                AssorColorSizeRatioPriceRec."63" := AssorColorSizeRatioViewRec."63";
                                AssorColorSizeRatioPriceRec."64" := AssorColorSizeRatioViewRec."64";
                            end
                            else begin
                                AssorColorSizeRatioPriceRec."1" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."2" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."3" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."4" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."5" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."6" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."7" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."8" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."9" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."10" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."11" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."12" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."13" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."14" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."15" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."16" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."17" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."18" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."19" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."20" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."21" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."22" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."23" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."24" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."25" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."26" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."27" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."28" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."29" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."30" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."31" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."32" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."33" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."34" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."35" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."36" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."37" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."38" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."39" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."40" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."41" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."42" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."43" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."44" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."45" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."46" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."47" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."48" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."49" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."50" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."51" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."52" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."53" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."54" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."55" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."56" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."57" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."58" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."59" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."60" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."61" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."62" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."63" := format(BOMEstimateCostRec."FOB Pcs");
                                AssorColorSizeRatioPriceRec."64" := format(BOMEstimateCostRec."FOB Pcs");
                            end;

                            AssorColorSizeRatioPriceRec."SHID/LOT" := AssorColorSizeRatioViewRec."SHID/LOT";
                            AssorColorSizeRatioPriceRec."SHID/LOT Name" := AssorColorSizeRatioViewRec."SHID/LOT Name";
                            AssorColorSizeRatioPriceRec."Country Code" := AssorColorSizeRatioViewRec."Country Code";
                            AssorColorSizeRatioPriceRec."Country Name" := AssorColorSizeRatioViewRec."Country Name";
                            AssorColorSizeRatioPriceRec."Pack No" := AssorColorSizeRatioViewRec."Pack No";
                            AssorColorSizeRatioPriceRec."Created User" := UserId;
                            AssorColorSizeRatioPriceRec."Created Date" := WorkDate();
                            AssorColorSizeRatioPriceRec.Insert();
                        until AssorColorSizeRatioViewRec.Next() = 0;
                    end;

                    //Delete blank record
                    AssorColorSizeRatioPriceRec.Reset();
                    AssorColorSizeRatioPriceRec.SetFilter("Colour Name", '=%1', '');
                    if AssorColorSizeRatioPriceRec.FindSet() then
                        AssorColorSizeRatioPriceRec.Delete();

                    CurrPage.Update();
                    Message('Quantity Breakdown completed');
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
        StyleExprTxt := ChangeColor.ChangeColorAssoRatio(Rec);

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