page 50661 "Lay Sheet Line1"
{
    PageType = ListPart;
    SourceTable = LaySheetLine1;
    SourceTableView = sorting("LaySheetNo.", "Line No") order(ascending);
    InsertAllowed = false;
    DeleteAllowed = false;
    //ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Record Type"; Rec."Record Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'Type';
                }

                field("Color Total"; Rec."Color Total")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Total';
                    DecimalPlaces = 0;
                }

                field("1"; Rec."1")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("2"; Rec."2")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("3"; Rec."3")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("4"; Rec."4")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("5"; Rec."5")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("6"; Rec."6")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("7"; Rec."7")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("8"; Rec."8")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("9"; Rec."9")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("10"; Rec."10")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("11"; Rec."11")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("12"; Rec."12")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("13"; Rec."13")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("14"; Rec."14")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("15"; Rec."15")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("16"; Rec."16")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }
                field("17"; Rec."17")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("18"; Rec."18")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("19"; Rec."19")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("20"; Rec."20")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("21"; Rec."21")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("22"; Rec."22")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("23"; Rec."23")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("24"; Rec."24")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("25"; Rec."25")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("26"; Rec."26")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("27"; Rec."27")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("28"; Rec."28")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("29"; Rec."29")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("30"; Rec."30")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("31"; Rec."31")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("32"; Rec."32")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("33"; Rec."33")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("34"; Rec."34")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("35"; Rec."35")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("36"; Rec."36")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("37"; Rec."37")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("38"; Rec."38")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("39"; Rec."39")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("40"; Rec."40")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("41"; Rec."41")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("42"; Rec."42")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("43"; Rec."43")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("44"; Rec."44")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("45"; Rec."45")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }


                field("46"; Rec."46")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("47"; Rec."47")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("48"; Rec."48")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("49"; Rec."49")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }
                field("50"; Rec."50")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("51"; Rec."51")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("52"; Rec."52")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("53"; Rec."53")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("54"; Rec."54")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("55"; Rec."55")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("56"; Rec."56")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("57"; Rec."57")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("58"; Rec."58")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("59"; Rec."59")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("60"; Rec."60")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("61"; Rec."61")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("62"; Rec."62")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("63"; Rec."63")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }

                field("64"; Rec."64")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        CalToatl();
                    end;
                }
            }
        }
    }

    procedure CalToatl()
    var
        Count: Integer;
        Number: Integer;
        Tot: Integer;
    begin
        if Rec."Record Type" = 'RATIO' then begin
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

        Rec."Color Total" := Tot;
        CurrPage.Update();
    end;


    // trigger OnAfterGetRecord()
    // var
    // begin
    //     StyleExprTxt := ChangeColor.ChangeColorCutCreation(Rec);

    //     // if ("Record Type" = 'R') then begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := true;
    //     // end
    //     // ELSE begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := false;
    //     // end;
    // end;


    // trigger OnAfterGetCurrRecord()
    // var
    // begin
    //     StyleExprTxt := ChangeColor.ChangeColorCutCreation(Rec);

    //     // if ("Record Type" = 'R') then begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := true;
    //     // end
    //     // ELSE begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := false;
    //     // end;
    // end;


    // var
    //     StyleExprTxt: Text[50];
    //     ChangeColor: Codeunit NavAppCodeUnit;
    //     SetEdit1: Boolean;

}