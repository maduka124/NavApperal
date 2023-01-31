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
                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'Style';
                }

                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'Lot No';
                }

                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'PO No';
                }

                field("Colour Name"; Rec."Colour Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'Colour';
                }

                field("1"; Rec."1")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible1;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }
                field("2"; Rec."2")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible2;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("3"; Rec."3")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible3;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("4"; Rec."4")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible4;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("5"; Rec."5")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible5;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("6"; Rec."6")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible6;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("7"; Rec."7")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible7;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("8"; Rec."8")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible8;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("9"; Rec."9")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible9;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("10"; Rec."10")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible10;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("11"; Rec."11")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible11;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("12"; Rec."12")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible12;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("13"; Rec."13")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible13;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("14"; Rec."14")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible14;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("15"; Rec."15")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible15;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("16"; Rec."16")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible16;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("17"; Rec."17")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible17;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("18"; Rec."18")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible18;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("19"; Rec."19")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible19;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("20"; Rec."20")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible20;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("21"; Rec."21")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible21;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("22"; Rec."22")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible22;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("23"; Rec."23")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible23;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("24"; Rec."24")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible24;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("25"; Rec."25")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible25;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("26"; Rec."26")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible26;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("27"; Rec."27")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible27;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("28"; Rec."28")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible28;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("29"; Rec."29")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible29;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("30"; Rec."30")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible30;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("31"; Rec."31")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible31;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("32"; Rec."32")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible32;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("33"; Rec."33")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible33;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("34"; Rec."34")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible34;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("35"; Rec."35")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible35;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("36"; Rec."36")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible36;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("37"; Rec."37")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible37;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("38"; Rec."38")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible38;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("39"; Rec."39")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible39;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("40"; Rec."40")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible40;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("41"; Rec."41")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible41;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("42"; Rec."42")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible42;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("43"; Rec."43")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible43;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("44"; Rec."44")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible44;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("45"; Rec."45")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible45;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("46"; Rec."46")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible46;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("47"; Rec."47")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible47;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }



                field("48"; Rec."48")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible48;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("49"; Rec."49")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible49;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("50"; Rec."50")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible50;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("51"; Rec."51")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible51;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("52"; Rec."52")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible52;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("53"; Rec."53")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible53;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("54"; Rec."54")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible54;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("55"; Rec."55")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible55;


                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("56"; Rec."56")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible56;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("57"; Rec."57")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible57;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("58"; Rec."58")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible58;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("59"; Rec."59")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible59;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("60"; Rec."60")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible60;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("61"; Rec."61")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible61;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("62"; Rec."62")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible62;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("63"; Rec."63")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible63;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("64"; Rec."64")
                {
                    ApplicationArea = All;
                    Editable = SetEdit;
                    StyleExpr = StyleExprTxt;
                    Visible = SetVisible64;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field(Total; Rec.Total)
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
        if Rec."Colour Name" <> '*' then begin
            for Count := 1 To 64 do begin
                case Count of
                    1:
                        if Rec."1" <> '' then
                            Evaluate(Number, Rec."1")
                        else
                            Number := 0;
                    2:
                        if Rec."2" <> '' then
                            Evaluate(Number, Rec."2")
                        else
                            Number := 0;
                    3:
                        if Rec."3" <> '' then
                            Evaluate(Number, Rec."3")
                        else
                            Number := 0;
                    4:
                        if Rec."4" <> '' then
                            Evaluate(Number, Rec."4")
                        else
                            Number := 0;
                    5:
                        if Rec."5" <> '' then
                            Evaluate(Number, Rec."5")
                        else
                            Number := 0;
                    6:
                        if Rec."6" <> '' then
                            Evaluate(Number, Rec."6")
                        else
                            Number := 0;
                    7:
                        if Rec."7" <> '' then
                            Evaluate(Number, Rec."7")
                        else
                            Number := 0;
                    8:
                        if Rec."8" <> '' then
                            Evaluate(Number, Rec."8")
                        else
                            Number := 0;
                    9:
                        if Rec."9" <> '' then
                            Evaluate(Number, Rec."9")
                        else
                            Number := 0;
                    10:
                        if Rec."10" <> '' then
                            Evaluate(Number, Rec."10")
                        else
                            Number := 0;
                    11:
                        if Rec."11" <> '' then
                            Evaluate(Number, Rec."11")
                        else
                            Number := 0;
                    12:
                        if Rec."12" <> '' then
                            Evaluate(Number, Rec."12")
                        else
                            Number := 0;
                    13:
                        if Rec."13" <> '' then
                            Evaluate(Number, Rec."13")
                        else
                            Number := 0;
                    14:
                        if Rec."14" <> '' then
                            Evaluate(Number, Rec."14")
                        else
                            Number := 0;
                    15:
                        if Rec."15" <> '' then
                            Evaluate(Number, Rec."15")
                        else
                            Number := 0;
                    16:
                        if Rec."16" <> '' then
                            Evaluate(Number, Rec."16")
                        else
                            Number := 0;
                    17:
                        if Rec."17" <> '' then
                            Evaluate(Number, Rec."17")
                        else
                            Number := 0;
                    18:
                        if Rec."18" <> '' then
                            Evaluate(Number, Rec."18")
                        else
                            Number := 0;
                    19:
                        if Rec."19" <> '' then
                            Evaluate(Number, Rec."19")
                        else
                            Number := 0;
                    20:
                        if Rec."20" <> '' then
                            Evaluate(Number, Rec."20")
                        else
                            Number := 0;
                    21:
                        if Rec."21" <> '' then
                            Evaluate(Number, Rec."21")
                        else
                            Number := 0;
                    22:
                        if Rec."22" <> '' then
                            Evaluate(Number, Rec."22")
                        else
                            Number := 0;
                    23:
                        if Rec."23" <> '' then
                            Evaluate(Number, Rec."23")
                        else
                            Number := 0;
                    24:
                        if Rec."24" <> '' then
                            Evaluate(Number, Rec."24")
                        else
                            Number := 0;
                    25:
                        if Rec."25" <> '' then
                            Evaluate(Number, Rec."25")
                        else
                            Number := 0;
                    26:
                        if Rec."26" <> '' then
                            Evaluate(Number, Rec."26")
                        else
                            Number := 0;
                    27:
                        if Rec."27" <> '' then
                            Evaluate(Number, Rec."27")
                        else
                            Number := 0;
                    28:
                        if Rec."28" <> '' then
                            Evaluate(Number, Rec."28")
                        else
                            Number := 0;
                    29:
                        if Rec."29" <> '' then
                            Evaluate(Number, Rec."29")
                        else
                            Number := 0;
                    30:
                        if Rec."30" <> '' then
                            Evaluate(Number, Rec."30")
                        else
                            Number := 0;
                    31:
                        if Rec."31" <> '' then
                            Evaluate(Number, Rec."31")
                        else
                            Number := 0;
                    32:
                        if Rec."32" <> '' then
                            Evaluate(Number, Rec."32")
                        else
                            Number := 0;
                    33:
                        if Rec."33" <> '' then
                            Evaluate(Number, Rec."33")
                        else
                            Number := 0;
                    34:
                        if Rec."34" <> '' then
                            Evaluate(Number, Rec."34")
                        else
                            Number := 0;
                    35:
                        if Rec."35" <> '' then
                            Evaluate(Number, Rec."35")
                        else
                            Number := 0;
                    36:
                        if Rec."36" <> '' then
                            Evaluate(Number, Rec."36")
                        else
                            Number := 0;
                    37:
                        if Rec."37" <> '' then
                            Evaluate(Number, Rec."37")
                        else
                            Number := 0;
                    38:
                        if Rec."38" <> '' then
                            Evaluate(Number, Rec."38")
                        else
                            Number := 0;
                    39:
                        if Rec."39" <> '' then
                            Evaluate(Number, Rec."39")
                        else
                            Number := 0;
                    40:
                        if Rec."40" <> '' then
                            Evaluate(Number, Rec."40")
                        else
                            Number := 0;
                    41:
                        if Rec."41" <> '' then
                            Evaluate(Number, Rec."41")
                        else
                            Number := 0;
                    42:
                        if Rec."42" <> '' then
                            Evaluate(Number, Rec."42")
                        else
                            Number := 0;
                    43:
                        if Rec."43" <> '' then
                            Evaluate(Number, Rec."43")
                        else
                            Number := 0;
                    44:
                        if Rec."44" <> '' then
                            Evaluate(Number, Rec."44")
                        else
                            Number := 0;
                    45:
                        if Rec."45" <> '' then
                            Evaluate(Number, Rec."45")
                        else
                            Number := 0;
                    46:
                        if Rec."46" <> '' then
                            Evaluate(Number, Rec."46")
                        else
                            Number := 0;
                    47:
                        if Rec."47" <> '' then
                            Evaluate(Number, Rec."47")
                        else
                            Number := 0;
                    48:
                        if Rec."48" <> '' then
                            Evaluate(Number, Rec."48")
                        else
                            Number := 0;
                    49:
                        if Rec."49" <> '' then
                            Evaluate(Number, Rec."49")
                        else
                            Number := 0;
                    50:
                        if Rec."50" <> '' then
                            Evaluate(Number, Rec."50")
                        else
                            Number := 0;
                    51:
                        if Rec."51" <> '' then
                            Evaluate(Number, Rec."51")
                        else
                            Number := 0;
                    52:
                        if Rec."52" <> '' then
                            Evaluate(Number, Rec."52")
                        else
                            Number := 0;
                    53:
                        if Rec."53" <> '' then
                            Evaluate(Number, Rec."53")
                        else
                            Number := 0;
                    54:
                        if Rec."54" <> '' then
                            Evaluate(Number, Rec."54")
                        else
                            Number := 0;
                    55:
                        if Rec."55" <> '' then
                            Evaluate(Number, Rec."55")
                        else
                            Number := 0;
                    56:
                        if Rec."56" <> '' then
                            Evaluate(Number, Rec."56")
                        else
                            Number := 0;
                    57:
                        if Rec."57" <> '' then
                            Evaluate(Number, Rec."57")
                        else
                            Number := 0;
                    58:
                        if Rec."58" <> '' then
                            Evaluate(Number, Rec."58")
                        else
                            Number := 0;
                    59:
                        if Rec."59" <> '' then
                            Evaluate(Number, Rec."59")
                        else
                            Number := 0;
                    60:
                        if Rec."60" <> '' then
                            Evaluate(Number, Rec."60")
                        else
                            Number := 0;
                    61:
                        if Rec."61" <> '' then
                            Evaluate(Number, Rec."61")
                        else
                            Number := 0;
                    62:
                        if Rec."62" <> '' then
                            Evaluate(Number, Rec."62")
                        else
                            Number := 0;
                    63:
                        if Rec."63" <> '' then
                            Evaluate(Number, Rec."63")
                        else
                            Number := 0;
                    64:
                        if Rec."64" <> '' then
                            Evaluate(Number, Rec."64")
                        else
                            Number := 0;
                end;

                Tot := Tot + Number;
            end;
        end;

        Rec.Total := Tot;

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
        ProdOutHeaderRec.SetRange("No.", Rec."No.");

        if ProdOutHeaderRec.FindSet() then begin
            OutputQtyVar := ProdOutHeaderRec."Output Qty";
            InputQtyVar := ProdOutHeaderRec."Input Qty";
        end;

        LineTotal := 0;

        //Get In/out Total
        ProductionOutLine.Reset();
        ProductionOutLine.SetRange("No.", Rec."No.");
        ProductionOutLine.SetRange("Style No.", Rec."Style No.");
        ProductionOutLine.SetRange("Lot No.", Rec."Lot No.");
        ProductionOutLine.SetRange(Type, Rec.Type);
        ProductionOutLine.SetRange(In_Out, Rec.In_Out);

        if ProductionOutLine.FindSet() then begin
            repeat
                if ProductionOutLine."Colour No" <> '*' then
                    LineTotal += ProductionOutLine.Total;
            until ProductionOutLine.Next() = 0;
        end;

        if Rec.In_Out = 'IN' then
            if InputQtyVar < LineTotal then
                Error('Input quantity should match color/size total quantity.');

        if Rec.In_Out = 'OUT' then
            if OutputQtyVar < LineTotal then
                Error('Output quantity should match color/size total quantity.');


        LineTotal := 0;
        //Get In/out Total for the style and lot for all days (31/1/2023)
        ProductionOutLine.Reset();
        ProductionOutLine.SetRange("Style No.", Rec."Style No.");
        ProductionOutLine.SetRange("Lot No.", Rec."Lot No.");
        ProductionOutLine.SetRange(Type, Rec.Type);
        ProductionOutLine.SetRange(In_Out, Rec.In_Out);

        if ProductionOutLine.FindSet() then begin
            repeat
                if ProductionOutLine."Colour No" <> '*' then
                    LineTotal += ProductionOutLine.Total;
            until ProductionOutLine.Next() = 0;
        end;


        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange("Style No.", Rec."Style No.");
        StyleMasterPORec.SetRange("Lot No.", Rec."Lot No.");
        StyleMasterPORec.FindSet();

        CASE Rec.Type OF
            Rec.type::Saw:
                BEGIN
                    if Rec.In_Out = 'IN' then
                        StyleMasterPORec.ModifyAll("Sawing In Qty", LineTotal)
                    else
                        if Rec.In_Out = 'OUT' then
                            StyleMasterPORec.ModifyAll("Sawing Out Qty", LineTotal);
                END;
            Rec.type::Wash:
                begin
                    if Rec.In_Out = 'IN' then
                        StyleMasterPORec.ModifyAll("Wash In Qty", LineTotal)
                    else
                        if Rec.In_Out = 'OUT' then
                            StyleMasterPORec.ModifyAll("Wash Out Qty", LineTotal);
                end;
            Rec.type::Cut:
                begin
                    StyleMasterPORec.ModifyAll("Cut Out Qty", LineTotal);
                end;
            Rec.type::Emb:
                begin
                    if Rec.In_Out = 'IN' then
                        StyleMasterPORec.ModifyAll("Emb In Qty", LineTotal)
                    else
                        if Rec.In_Out = 'OUT' then
                            StyleMasterPORec.ModifyAll("Emb Out Qty", LineTotal);
                end;
            Rec.type::Print:
                begin
                    if Rec.In_Out = 'IN' then
                        StyleMasterPORec.ModifyAll("Print In Qty", LineTotal)
                    else
                        if Rec.In_Out = 'OUT' then
                            StyleMasterPORec.ModifyAll("print Out Qty", LineTotal);
                end;
            Rec.type::Fin:
                begin
                    StyleMasterPORec.ModifyAll("Finish Qty", LineTotal);
                end;
            Rec.type::Ship:
                begin
                    StyleMasterPORec.ModifyAll("Shipped Qty", LineTotal);
                end;
        END;

        CurrPage.Update();

    end;


    trigger OnAfterGetRecord()
    var
        Count: Integer;
        ProductionOutLineRec: Record ProductionOutLine;
    begin
        StyleExprTxt := ChangeColor.ChangeColorSewing(Rec);

        if Rec."Colour Name" = '*' then begin
            Clear(SetEdit);
            SetEdit := false;
        end
        ELSE begin
            Clear(SetEdit);
            SetEdit := true;
        end;

        ProductionOutLineRec.Reset();
        ProductionOutLineRec.SetRange("No.", Rec."No.");
        ProductionOutLineRec.SetRange(Type, Rec.Type);
        ProductionOutLineRec.SetFilter("Colour Name", '=%1', '*');
        if ProductionOutLineRec.FindSet() then begin

            for Count := 1 to 64 do begin
                case Count of

                    1:
                        if ProductionOutLineRec."1" <> '' then
                            SetVisible1 := true
                        else
                            SetVisible1 := false;
                    2:
                        if ProductionOutLineRec."2" <> '' then
                            SetVisible2 := true
                        else
                            SetVisible2 := false;
                    3:
                        if ProductionOutLineRec."3" <> '' then
                            SetVisible3 := true
                        else
                            SetVisible3 := false;
                    4:
                        if ProductionOutLineRec."4" <> '' then
                            SetVisible4 := true
                        else
                            SetVisible4 := false;
                    5:
                        if ProductionOutLineRec."5" <> '' then
                            SetVisible5 := true
                        else
                            SetVisible5 := false;
                    6:
                        if ProductionOutLineRec."6" <> '' then
                            SetVisible6 := true
                        else
                            SetVisible6 := false;
                    7:
                        if ProductionOutLineRec."7" <> '' then
                            SetVisible7 := true
                        else
                            SetVisible7 := false;
                    8:
                        if ProductionOutLineRec."8" <> '' then
                            SetVisible8 := true
                        else
                            SetVisible8 := false;
                    9:
                        if ProductionOutLineRec."9" <> '' then
                            SetVisible9 := true
                        else
                            SetVisible9 := false;
                    10:
                        if ProductionOutLineRec."10" <> '' then
                            SetVisible10 := true
                        else
                            SetVisible10 := false;
                    11:
                        if ProductionOutLineRec."11" <> '' then
                            SetVisible11 := true
                        else
                            SetVisible11 := false;
                    12:
                        if ProductionOutLineRec."12" <> '' then
                            SetVisible12 := true
                        else
                            SetVisible12 := false;
                    13:
                        if ProductionOutLineRec."13" <> '' then
                            SetVisible13 := true
                        else
                            SetVisible13 := false;
                    14:
                        if ProductionOutLineRec."14" <> '' then
                            SetVisible14 := true
                        else
                            SetVisible14 := false;
                    15:
                        if ProductionOutLineRec."15" <> '' then
                            SetVisible15 := true
                        else
                            SetVisible15 := false;
                    16:
                        if ProductionOutLineRec."16" <> '' then
                            SetVisible16 := true
                        else
                            SetVisible16 := false;
                    17:
                        if ProductionOutLineRec."17" <> '' then
                            SetVisible17 := true
                        else
                            SetVisible17 := false;
                    18:
                        if ProductionOutLineRec."18" <> '' then
                            SetVisible18 := true
                        else
                            SetVisible18 := false;
                    19:
                        if ProductionOutLineRec."19" <> '' then
                            SetVisible19 := true
                        else
                            SetVisible19 := false;
                    20:
                        if ProductionOutLineRec."20" <> '' then
                            SetVisible20 := true
                        else
                            SetVisible20 := false;
                    21:
                        if ProductionOutLineRec."21" <> '' then
                            SetVisible21 := true
                        else
                            SetVisible21 := false;
                    22:
                        if ProductionOutLineRec."22" <> '' then
                            SetVisible22 := true
                        else
                            SetVisible22 := false;
                    23:
                        if ProductionOutLineRec."23" <> '' then
                            SetVisible23 := true
                        else
                            SetVisible23 := false;
                    24:
                        if ProductionOutLineRec."24" <> '' then
                            SetVisible24 := true
                        else
                            SetVisible24 := false;
                    25:
                        if ProductionOutLineRec."25" <> '' then
                            SetVisible25 := true
                        else
                            SetVisible25 := false;
                    26:
                        if ProductionOutLineRec."26" <> '' then
                            SetVisible26 := true
                        else
                            SetVisible26 := false;
                    27:
                        if ProductionOutLineRec."27" <> '' then
                            SetVisible27 := true
                        else
                            SetVisible27 := false;
                    28:
                        if ProductionOutLineRec."28" <> '' then
                            SetVisible28 := true
                        else
                            SetVisible28 := false;
                    29:
                        if ProductionOutLineRec."29" <> '' then
                            SetVisible29 := true
                        else
                            SetVisible29 := false;
                    30:
                        if ProductionOutLineRec."30" <> '' then
                            SetVisible30 := true
                        else
                            SetVisible30 := false;
                    31:
                        if ProductionOutLineRec."31" <> '' then
                            SetVisible31 := true
                        else
                            SetVisible31 := false;
                    32:
                        if ProductionOutLineRec."32" <> '' then
                            SetVisible32 := true
                        else
                            SetVisible32 := false;
                    33:
                        if ProductionOutLineRec."33" <> '' then
                            SetVisible33 := true
                        else
                            SetVisible33 := false;
                    34:
                        if ProductionOutLineRec."34" <> '' then
                            SetVisible34 := true
                        else
                            SetVisible34 := false;
                    35:
                        if ProductionOutLineRec."35" <> '' then
                            SetVisible35 := true
                        else
                            SetVisible35 := false;
                    36:
                        if ProductionOutLineRec."36" <> '' then
                            SetVisible36 := true
                        else
                            SetVisible36 := false;
                    37:
                        if ProductionOutLineRec."37" <> '' then
                            SetVisible37 := true
                        else
                            SetVisible37 := false;
                    38:
                        if ProductionOutLineRec."38" <> '' then
                            SetVisible38 := true
                        else
                            SetVisible38 := false;
                    39:
                        if ProductionOutLineRec."39" <> '' then
                            SetVisible39 := true
                        else
                            SetVisible39 := false;
                    40:
                        if ProductionOutLineRec."40" <> '' then
                            SetVisible40 := true
                        else
                            SetVisible40 := false;
                    41:
                        if ProductionOutLineRec."41" <> '' then
                            SetVisible41 := true
                        else
                            SetVisible41 := false;
                    42:
                        if ProductionOutLineRec."42" <> '' then
                            SetVisible42 := true
                        else
                            SetVisible42 := false;
                    43:
                        if ProductionOutLineRec."43" <> '' then
                            SetVisible43 := true
                        else
                            SetVisible43 := false;
                    44:
                        if ProductionOutLineRec."44" <> '' then
                            SetVisible44 := true
                        else
                            SetVisible44 := false;
                    45:
                        if ProductionOutLineRec."45" <> '' then
                            SetVisible45 := true
                        else
                            SetVisible45 := false;
                    46:
                        if ProductionOutLineRec."46" <> '' then
                            SetVisible46 := true
                        else
                            SetVisible46 := false;
                    47:
                        if ProductionOutLineRec."47" <> '' then
                            SetVisible47 := true
                        else
                            SetVisible47 := false;
                    48:
                        if ProductionOutLineRec."48" <> '' then
                            SetVisible48 := true
                        else
                            SetVisible48 := false;
                    49:
                        if ProductionOutLineRec."49" <> '' then
                            SetVisible49 := true
                        else
                            SetVisible49 := false;
                    50:
                        if ProductionOutLineRec."50" <> '' then
                            SetVisible50 := true
                        else
                            SetVisible50 := false;
                    51:
                        if ProductionOutLineRec."51" <> '' then
                            SetVisible51 := true
                        else
                            SetVisible51 := false;
                    52:
                        if ProductionOutLineRec."52" <> '' then
                            SetVisible52 := true
                        else
                            SetVisible52 := false;
                    53:
                        if ProductionOutLineRec."53" <> '' then
                            SetVisible53 := true
                        else
                            SetVisible53 := false;
                    54:
                        if ProductionOutLineRec."54" <> '' then
                            SetVisible54 := true
                        else
                            SetVisible54 := false;
                    55:
                        if ProductionOutLineRec."55" <> '' then
                            SetVisible55 := true
                        else
                            SetVisible55 := false;
                    56:
                        if ProductionOutLineRec."56" <> '' then
                            SetVisible56 := true
                        else
                            SetVisible56 := false;
                    57:
                        if ProductionOutLineRec."57" <> '' then
                            SetVisible57 := true
                        else
                            SetVisible57 := false;
                    58:
                        if ProductionOutLineRec."58" <> '' then
                            SetVisible58 := true
                        else
                            SetVisible58 := false;
                    59:
                        if ProductionOutLineRec."59" <> '' then
                            SetVisible59 := true
                        else
                            SetVisible59 := false;
                    60:
                        if ProductionOutLineRec."60" <> '' then
                            SetVisible60 := true
                        else
                            SetVisible60 := false;
                    61:
                        if ProductionOutLineRec."61" <> '' then
                            SetVisible61 := true
                        else
                            SetVisible61 := false;
                    62:
                        if ProductionOutLineRec."62" <> '' then
                            SetVisible62 := true
                        else
                            SetVisible62 := false;
                    63:
                        if ProductionOutLineRec."63" <> '' then
                            SetVisible63 := true
                        else
                            SetVisible63 := false;
                    64:
                        if ProductionOutLineRec."64" <> '' then
                            SetVisible64 := true
                        else
                            SetVisible64 := false;
                end;


            end;

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