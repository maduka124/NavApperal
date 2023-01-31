page 51225 DailyCuttingOutListPart_SawOut
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
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_1;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }
                field("2"; Rec."2")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_2;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("3"; Rec."3")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_3;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("4"; Rec."4")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_4;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("5"; Rec."5")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_5;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("6"; Rec."6")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_6;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("7"; Rec."7")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_7;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("8"; Rec."8")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_8;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("9"; Rec."9")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_9;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("10"; Rec."10")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_10;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("11"; Rec."11")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_11;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("12"; Rec."12")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_12;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("13"; Rec."13")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_13;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("14"; Rec."14")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_14;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("15"; Rec."15")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_15;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("16"; Rec."16")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_16;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("17"; Rec."17")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_17;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("18"; Rec."18")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_18;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("19"; Rec."19")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_19;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("20"; Rec."20")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_20;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("21"; Rec."21")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_21;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("22"; Rec."22")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_22;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("23"; Rec."23")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_23;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("24"; Rec."24")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_24;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("25"; Rec."25")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_25;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("26"; Rec."26")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_26;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("27"; Rec."27")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_27;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("28"; Rec."28")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_28;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("29"; Rec."29")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_29;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("30"; Rec."30")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_30;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("31"; Rec."31")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_31;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("32"; Rec."32")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_32;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("33"; Rec."33")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_33;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("34"; Rec."34")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_34;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("35"; Rec."35")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_35;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("36"; Rec."36")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_36;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("37"; Rec."37")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_37;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("38"; Rec."38")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_38;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("39"; Rec."39")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_39;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("40"; Rec."40")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_40;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("41"; Rec."41")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_41;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("42"; Rec."42")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_42;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("43"; Rec."43")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_43;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("44"; Rec."44")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_44;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("45"; Rec."45")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_45;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("46"; Rec."46")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_46;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("47"; Rec."47")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_47;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }



                field("48"; Rec."48")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_48;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("49"; Rec."49")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_49;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("50"; Rec."50")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_50;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("51"; Rec."51")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_51;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("52"; Rec."52")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_52;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("53"; Rec."53")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_53;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("54"; Rec."54")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_54;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("55"; Rec."55")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_55;


                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("56"; Rec."56")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_56;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("57"; Rec."57")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_57;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("58"; Rec."58")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_58;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("59"; Rec."59")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_59;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("60"; Rec."60")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_60;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("61"; Rec."61")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_61;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("62"; Rec."62")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_62;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("63"; Rec."63")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_63;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("64"; Rec."64")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                    StyleExpr = StyleExprTxt1;
                    Visible = SetVisible_64;

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


        //Get In/out Total for the style and lot for all days (31/1/2023)
        LineTotal := 0;
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
        StyleExprTxt1 := ChangeColor1.ChangeColorSewing(Rec);

        if Rec."Colour Name" = '*' then begin
            Clear(SetEdit1);
            SetEdit1 := false;
        end
        ELSE begin
            Clear(SetEdit1);
            SetEdit1 := true;
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
                            SetVisible_1 := true
                        else
                            SetVisible_1 := false;
                    2:
                        if ProductionOutLineRec."2" <> '' then
                            SetVisible_2 := true
                        else
                            SetVisible_2 := false;
                    3:
                        if ProductionOutLineRec."3" <> '' then
                            SetVisible_3 := true
                        else
                            SetVisible_3 := false;
                    4:
                        if ProductionOutLineRec."4" <> '' then
                            SetVisible_4 := true
                        else
                            SetVisible_4 := false;
                    5:
                        if ProductionOutLineRec."5" <> '' then
                            SetVisible_5 := true
                        else
                            SetVisible_5 := false;
                    6:
                        if ProductionOutLineRec."6" <> '' then
                            SetVisible_6 := true
                        else
                            SetVisible_6 := false;
                    7:
                        if ProductionOutLineRec."7" <> '' then
                            SetVisible_7 := true
                        else
                            SetVisible_7 := false;
                    8:
                        if ProductionOutLineRec."8" <> '' then
                            SetVisible_8 := true
                        else
                            SetVisible_8 := false;
                    9:
                        if ProductionOutLineRec."9" <> '' then
                            SetVisible_9 := true
                        else
                            SetVisible_9 := false;
                    10:
                        if ProductionOutLineRec."10" <> '' then
                            SetVisible_10 := true
                        else
                            SetVisible_10 := false;
                    11:
                        if ProductionOutLineRec."11" <> '' then
                            SetVisible_11 := true
                        else
                            SetVisible_11 := false;
                    12:
                        if ProductionOutLineRec."12" <> '' then
                            SetVisible_12 := true
                        else
                            SetVisible_12 := false;
                    13:
                        if ProductionOutLineRec."13" <> '' then
                            SetVisible_13 := true
                        else
                            SetVisible_13 := false;
                    14:
                        if ProductionOutLineRec."14" <> '' then
                            SetVisible_14 := true
                        else
                            SetVisible_14 := false;
                    15:
                        if ProductionOutLineRec."15" <> '' then
                            SetVisible_15 := true
                        else
                            SetVisible_15 := false;
                    16:
                        if ProductionOutLineRec."16" <> '' then
                            SetVisible_16 := true
                        else
                            SetVisible_16 := false;
                    17:
                        if ProductionOutLineRec."17" <> '' then
                            SetVisible_17 := true
                        else
                            SetVisible_17 := false;
                    18:
                        if ProductionOutLineRec."18" <> '' then
                            SetVisible_18 := true
                        else
                            SetVisible_18 := false;
                    19:
                        if ProductionOutLineRec."19" <> '' then
                            SetVisible_19 := true
                        else
                            SetVisible_19 := false;
                    20:
                        if ProductionOutLineRec."20" <> '' then
                            SetVisible_20 := true
                        else
                            SetVisible_20 := false;
                    21:
                        if ProductionOutLineRec."21" <> '' then
                            SetVisible_21 := true
                        else
                            SetVisible_21 := false;
                    22:
                        if ProductionOutLineRec."22" <> '' then
                            SetVisible_22 := true
                        else
                            SetVisible_22 := false;
                    23:
                        if ProductionOutLineRec."23" <> '' then
                            SetVisible_23 := true
                        else
                            SetVisible_23 := false;
                    24:
                        if ProductionOutLineRec."24" <> '' then
                            SetVisible_24 := true
                        else
                            SetVisible_24 := false;
                    25:
                        if ProductionOutLineRec."25" <> '' then
                            SetVisible_25 := true
                        else
                            SetVisible_25 := false;
                    26:
                        if ProductionOutLineRec."26" <> '' then
                            SetVisible_26 := true
                        else
                            SetVisible_26 := false;
                    27:
                        if ProductionOutLineRec."27" <> '' then
                            SetVisible_27 := true
                        else
                            SetVisible_27 := false;
                    28:
                        if ProductionOutLineRec."28" <> '' then
                            SetVisible_28 := true
                        else
                            SetVisible_28 := false;
                    29:
                        if ProductionOutLineRec."29" <> '' then
                            SetVisible_29 := true
                        else
                            SetVisible_29 := false;
                    30:
                        if ProductionOutLineRec."30" <> '' then
                            SetVisible_30 := true
                        else
                            SetVisible_30 := false;
                    31:
                        if ProductionOutLineRec."31" <> '' then
                            SetVisible_31 := true
                        else
                            SetVisible_31 := false;
                    32:
                        if ProductionOutLineRec."32" <> '' then
                            SetVisible_32 := true
                        else
                            SetVisible_32 := false;
                    33:
                        if ProductionOutLineRec."33" <> '' then
                            SetVisible_33 := true
                        else
                            SetVisible_33 := false;
                    34:
                        if ProductionOutLineRec."34" <> '' then
                            SetVisible_34 := true
                        else
                            SetVisible_34 := false;
                    35:
                        if ProductionOutLineRec."35" <> '' then
                            SetVisible_35 := true
                        else
                            SetVisible_35 := false;
                    36:
                        if ProductionOutLineRec."36" <> '' then
                            SetVisible_36 := true
                        else
                            SetVisible_36 := false;
                    37:
                        if ProductionOutLineRec."37" <> '' then
                            SetVisible_37 := true
                        else
                            SetVisible_37 := false;
                    38:
                        if ProductionOutLineRec."38" <> '' then
                            SetVisible_38 := true
                        else
                            SetVisible_38 := false;
                    39:
                        if ProductionOutLineRec."39" <> '' then
                            SetVisible_39 := true
                        else
                            SetVisible_39 := false;
                    40:
                        if ProductionOutLineRec."40" <> '' then
                            SetVisible_40 := true
                        else
                            SetVisible_40 := false;
                    41:
                        if ProductionOutLineRec."41" <> '' then
                            SetVisible_41 := true
                        else
                            SetVisible_41 := false;
                    42:
                        if ProductionOutLineRec."42" <> '' then
                            SetVisible_42 := true
                        else
                            SetVisible_42 := false;
                    43:
                        if ProductionOutLineRec."43" <> '' then
                            SetVisible_43 := true
                        else
                            SetVisible_43 := false;
                    44:
                        if ProductionOutLineRec."44" <> '' then
                            SetVisible_44 := true
                        else
                            SetVisible_44 := false;
                    45:
                        if ProductionOutLineRec."45" <> '' then
                            SetVisible_45 := true
                        else
                            SetVisible_45 := false;
                    46:
                        if ProductionOutLineRec."46" <> '' then
                            SetVisible_46 := true
                        else
                            SetVisible_46 := false;
                    47:
                        if ProductionOutLineRec."47" <> '' then
                            SetVisible_47 := true
                        else
                            SetVisible_47 := false;
                    48:
                        if ProductionOutLineRec."48" <> '' then
                            SetVisible_48 := true
                        else
                            SetVisible_48 := false;
                    49:
                        if ProductionOutLineRec."49" <> '' then
                            SetVisible_49 := true
                        else
                            SetVisible_49 := false;
                    50:
                        if ProductionOutLineRec."50" <> '' then
                            SetVisible_50 := true
                        else
                            SetVisible_50 := false;
                    51:
                        if ProductionOutLineRec."51" <> '' then
                            SetVisible_51 := true
                        else
                            SetVisible_51 := false;
                    52:
                        if ProductionOutLineRec."52" <> '' then
                            SetVisible_52 := true
                        else
                            SetVisible_52 := false;
                    53:
                        if ProductionOutLineRec."53" <> '' then
                            SetVisible_53 := true
                        else
                            SetVisible_53 := false;
                    54:
                        if ProductionOutLineRec."54" <> '' then
                            SetVisible_54 := true
                        else
                            SetVisible_54 := false;
                    55:
                        if ProductionOutLineRec."55" <> '' then
                            SetVisible_55 := true
                        else
                            SetVisible_55 := false;
                    56:
                        if ProductionOutLineRec."56" <> '' then
                            SetVisible_56 := true
                        else
                            SetVisible_56 := false;
                    57:
                        if ProductionOutLineRec."57" <> '' then
                            SetVisible_57 := true
                        else
                            SetVisible_57 := false;
                    58:
                        if ProductionOutLineRec."58" <> '' then
                            SetVisible_58 := true
                        else
                            SetVisible_58 := false;
                    59:
                        if ProductionOutLineRec."59" <> '' then
                            SetVisible_59 := true
                        else
                            SetVisible_59 := false;
                    60:
                        if ProductionOutLineRec."60" <> '' then
                            SetVisible_60 := true
                        else
                            SetVisible_60 := false;
                    61:
                        if ProductionOutLineRec."61" <> '' then
                            SetVisible_61 := true
                        else
                            SetVisible_61 := false;
                    62:
                        if ProductionOutLineRec."62" <> '' then
                            SetVisible_62 := true
                        else
                            SetVisible_62 := false;
                    63:
                        if ProductionOutLineRec."63" <> '' then
                            SetVisible_63 := true
                        else
                            SetVisible_63 := false;
                    64:
                        if ProductionOutLineRec."64" <> '' then
                            SetVisible_64 := true
                        else
                            SetVisible_64 := false;
                end;
            end;

        end;
    end;

    var
        StyleExprTxt1: Text[50];
        ChangeColor1: Codeunit NavAppCodeUnit;
        SetEdit1: Boolean;
        SetVisible_1: Boolean;
        SetVisible_2: Boolean;
        SetVisible_3: Boolean;
        SetVisible_4: Boolean;
        SetVisible_5: Boolean;
        SetVisible_6: Boolean;
        SetVisible_7: Boolean;
        SetVisible_8: Boolean;
        SetVisible_9: Boolean;
        SetVisible_10: Boolean;
        SetVisible_11: Boolean;
        SetVisible_12: Boolean;
        SetVisible_13: Boolean;
        SetVisible_14: Boolean;
        SetVisible_15: Boolean;
        SetVisible_16: Boolean;
        SetVisible_17: Boolean;
        SetVisible_18: Boolean;
        SetVisible_19: Boolean;
        SetVisible_20: Boolean;
        SetVisible_21: Boolean;
        SetVisible_22: Boolean;
        SetVisible_23: Boolean;
        SetVisible_24: Boolean;
        SetVisible_25: Boolean;
        SetVisible_26: Boolean;
        SetVisible_27: Boolean;
        SetVisible_28: Boolean;
        SetVisible_29: Boolean;
        SetVisible_30: Boolean;
        SetVisible_31: Boolean;
        SetVisible_32: Boolean;
        SetVisible_33: Boolean;
        SetVisible_34: Boolean;
        SetVisible_35: Boolean;
        SetVisible_36: Boolean;
        SetVisible_37: Boolean;
        SetVisible_38: Boolean;
        SetVisible_39: Boolean;
        SetVisible_40: Boolean;
        SetVisible_41: Boolean;
        SetVisible_42: Boolean;
        SetVisible_43: Boolean;
        SetVisible_44: Boolean;
        SetVisible_45: Boolean;
        SetVisible_46: Boolean;
        SetVisible_47: Boolean;
        SetVisible_48: Boolean;
        SetVisible_49: Boolean;
        SetVisible_50: Boolean;
        SetVisible_51: Boolean;
        SetVisible_52: Boolean;
        SetVisible_53: Boolean;
        SetVisible_54: Boolean;
        SetVisible_55: Boolean;
        SetVisible_56: Boolean;
        SetVisible_57: Boolean;
        SetVisible_58: Boolean;
        SetVisible_59: Boolean;
        SetVisible_60: Boolean;
        SetVisible_61: Boolean;
        SetVisible_62: Boolean;
        SetVisible_63: Boolean;
        SetVisible_64: Boolean;

}