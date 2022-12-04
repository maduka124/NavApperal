page 50596 "Ratio Creation ListPart"
{
    PageType = ListPart;
    SourceTable = RatioCreationLine;
    SourceTableView = sorting(RatioCreNo, "Group ID", LineNo) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Marker Name"; Rec."Marker Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Caption = 'Marker';

                    trigger OnValidate()
                    var
                        RatioCreationLineRec: Record RatioCreationLine;
                        RatioCreationLineRec1: Record RatioCreationLine;
                        LineNo1: Integer;
                        ComponentGroupCode: Code[20];
                        UOMVar: Code[20];
                        UOMCodeVar: Code[20];
                    begin

                        if Rec.LineNo = 0 then begin

                            //Get Component group no
                            RatioCreationLineRec.Reset();
                            RatioCreationLineRec.SetRange(RatioCreNo, Rec."RatioCreNo");
                            RatioCreationLineRec.SetFilter("Record Type", '%1', 'H');

                            if RatioCreationLineRec.FindSet() then begin
                                ComponentGroupCode := RatioCreationLineRec."Component Group Code";
                                UOMVar := RatioCreationLineRec.UOM;
                                UOMCodeVar := RatioCreationLineRec."UOM Code";
                            end;

                            //Get Max line no
                            RatioCreationLineRec.Reset();
                            RatioCreationLineRec.SetRange(RatioCreNo, Rec."RatioCreNo");
                            RatioCreationLineRec.SetRange("Group ID", Rec."Group ID");

                            if RatioCreationLineRec.FindLast() then
                                LineNo1 := RatioCreationLineRec.LineNo;

                            Rec.LineNo := LineNo1 + 1;

                            // Get detalis of existing line                 
                            RatioCreationLineRec1.Reset();
                            RatioCreationLineRec1.SetRange("RatioCreNo", Rec."RatioCreNo");
                            RatioCreationLineRec1.SetRange("Group ID", Rec."Group ID");
                            RatioCreationLineRec1.SetRange(LineNo, LineNo1 - 1);
                            RatioCreationLineRec1.SetFilter("Record Type", '%1', 'R');

                            if RatioCreationLineRec1.FindSet() then begin

                                //Insert R1 Line                        
                                Rec."Created Date" := Today;
                                Rec."Created User" := UserId;
                                Rec."Group ID" := Rec."Group ID";
                                Rec."Lot No." := RatioCreationLineRec1."Lot No.";
                                Rec."PO No." := RatioCreationLineRec1."PO No.";
                                Rec.qty := 0;
                                Rec."Record Type" := 'R';
                                Rec."Sewing Job No." := RatioCreationLineRec1."Sewing Job No.";
                                Rec.ShipDate := RatioCreationLineRec1.ShipDate;
                                Rec."Style Name" := RatioCreationLineRec1."Style Name";
                                Rec."Style No." := RatioCreationLineRec1."Style No.";
                                Rec."SubLotNo." := RatioCreationLineRec1."SubLotNo.";
                                Rec."Colour No" := RatioCreationLineRec1."Colour No";
                                Rec."Colour Name" := RatioCreationLineRec1."Colour Name";
                                Rec."Component Group Code" := ComponentGroupCode;
                                Rec.UOM := UOMVar;
                                Rec."UOM Code" := UOMCodeVar;
                                Rec.Plies := 0;
                                Rec."1" := '0';
                                Rec."2" := '0';
                                Rec."3" := '0';
                                Rec."4" := '0';
                                Rec."5" := '0';
                                Rec."6" := '0';
                                Rec."7" := '0';
                                Rec."8" := '0';
                                Rec."9" := '0';
                                Rec."10" := '0';
                                Rec."11" := '0';
                                Rec."12" := '0';
                                Rec."13" := '0';
                                Rec."14" := '0';
                                Rec."15" := '0';
                                Rec."16" := '0';
                                Rec."17" := '0';
                                Rec."18" := '0';
                                Rec."19" := '0';
                                Rec."20" := '0';
                                Rec."21" := '0';
                                Rec."22" := '0';
                                Rec."23" := '0';
                                Rec."24" := '0';
                                Rec."25" := '0';
                                Rec."26" := '0';
                                Rec."27" := '0';
                                Rec."28" := '0';
                                Rec."29" := '0';
                                Rec."30" := '0';
                                Rec."31" := '0';
                                Rec."32" := '0';
                                Rec."33" := '0';
                                Rec."34" := '0';
                                Rec."35" := '0';
                                Rec."36" := '0';
                                Rec."37" := '0';
                                Rec."38" := '0';
                                Rec."39" := '0';
                                Rec."40" := '0';
                                Rec."41" := '0';
                                Rec."42" := '0';
                                Rec."43" := '0';
                                Rec."44" := '0';
                                Rec."45" := '0';
                                Rec."46" := '0';
                                Rec."47" := '0';
                                Rec."48" := '0';
                                Rec."49" := '0';
                                Rec."50" := '0';
                                Rec."51" := '0';
                                Rec."52" := '0';
                                Rec."53" := '0';
                                Rec."54" := '0';
                                Rec."55" := '0';
                                Rec."56" := '0';
                                Rec."57" := '0';
                                Rec."58" := '0';
                                Rec."59" := '0';
                                Rec."60" := '0';
                                Rec."61" := '0';
                                Rec."62" := '0';
                                Rec."63" := '0';
                                Rec."64" := '0';

                                CurrPage.Update();
                            end;
                        end;

                    end;
                }

                field("Pattern Version"; Rec."Pattern Version")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }

                field("Length Tollarance  "; Rec."Length Tollarance  ")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Caption = 'Length Tollarance (cm/inch)';
                }

                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }

                field("Width Tollarance"; Rec."Width Tollarance")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Caption = 'Width Tollarance (cm/inch)';
                }

                field(Efficiency; Rec.Efficiency)
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

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                        CurrPage.Update();
                    end;
                }

                field("Color Total"; Rec."Color Total")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }

                field("1"; Rec."1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible1;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }
                field("2"; Rec."2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible2;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("3"; Rec."3")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible3;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("4"; Rec."4")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible4;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("5"; Rec."5")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible5;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("6"; Rec."6")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible6;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("7"; Rec."7")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible7;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("8"; Rec."8")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible8;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("9"; Rec."9")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible9;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("10"; Rec."10")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible10;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("11"; Rec."11")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible11;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("12"; Rec."12")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible12;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("13"; Rec."13")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible13;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("14"; Rec."14")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible14;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("15"; Rec."15")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible15;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("16"; Rec."16")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible16;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("17"; Rec."17")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible17;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("18"; Rec."18")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible18;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("19"; Rec."19")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible19;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("20"; Rec."20")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible20;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("21"; Rec."21")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible21;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("22"; Rec."22")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible22;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("23"; Rec."23")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible23;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("24"; Rec."24")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible24;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("25"; Rec."25")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible25;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("26"; Rec."26")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible26;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("27"; Rec."27")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible27;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("28"; Rec."28")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible28;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("29"; Rec."29")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible29;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("30"; Rec."30")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible30;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("31"; Rec."31")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible31;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("32"; Rec."32")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible32;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("33"; Rec."33")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible33;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("34"; Rec."34")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible34;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("35"; Rec."35")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible35;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("36"; Rec."36")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible36;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("37"; Rec."37")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible37;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("38"; Rec."38")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible38;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("39"; Rec."39")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible39;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("40"; Rec."40")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible40;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("41"; Rec."41")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible41;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("42"; Rec."42")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible42;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("43"; Rec."43")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible43;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("44"; Rec."44")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible44;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("45"; Rec."45")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible45;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }


                field("46"; Rec."46")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible46;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("47"; Rec."47")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible47;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("48"; Rec."48")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible48;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("49"; Rec."49")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible49;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("50"; Rec."50")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible50;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("51"; Rec."51")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible51;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("52"; Rec."52")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible52;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("53"; Rec."53")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible53;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("54"; Rec."54")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible54;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("55"; Rec."55")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible55;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("56"; Rec."56")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible56;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("57"; Rec."57")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible57;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("58"; Rec."58")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible58;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("59"; Rec."59")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible59;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("60"; Rec."60")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible60;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("61"; Rec."61")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible61;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("62"; Rec."62")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible62;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("63"; Rec."63")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible63;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }

                field("64"; Rec."64")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible64;

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                        Cal_Balance();
                    end;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    var
        Rowcount: Integer;
        Count: Integer;
        RatioCreLineRec: Record RatioCreationLine;
    begin
        StyleExprTxt := ChangeColor.ChangeColorRatioCreation(Rec);
        RatioCreLineRec.Reset();
        RatioCreLineRec.SetRange(RatioCreNo, Rec.RatioCreNo);
        RatioCreLineRec.SetFilter("Record Type", '=%1', 'H');
        RatioCreLineRec.FindSet();

        for Count := 1 To 64 do begin
            case Count of
                1:
                    if RatioCreLineRec."1" <> '' then
                        SetVisible1 := true
                    else
                        SetVisible1 := false;
                2:
                    if RatioCreLineRec."2" <> '' then
                        SetVisible2 := true
                    else
                        SetVisible2 := false;
                3:
                    if RatioCreLineRec."3" <> '' then
                        SetVisible3 := true
                    else
                        SetVisible3 := false;
                4:
                    if RatioCreLineRec."4" <> '' then
                        SetVisible4 := true
                    else
                        SetVisible4 := false;
                5:
                    if RatioCreLineRec."5" <> '' then
                        SetVisible5 := true
                    else
                        SetVisible5 := false;
                6:
                    if RatioCreLineRec."6" <> '' then
                        SetVisible6 := true
                    else
                        SetVisible6 := false;
                7:
                    if RatioCreLineRec."7" <> '' then
                        SetVisible7 := true
                    else
                        SetVisible7 := false;
                8:
                    if RatioCreLineRec."8" <> '' then
                        SetVisible8 := true
                    else
                        SetVisible8 := false;
                9:
                    if RatioCreLineRec."9" <> '' then
                        SetVisible9 := true
                    else
                        SetVisible9 := false;
                10:
                    if RatioCreLineRec."10" <> '' then
                        SetVisible10 := true
                    else
                        SetVisible10 := false;
                11:
                    if RatioCreLineRec."11" <> '' then
                        SetVisible11 := true
                    else
                        SetVisible11 := false;
                12:
                    if RatioCreLineRec."12" <> '' then
                        SetVisible12 := true
                    else
                        SetVisible12 := false;
                13:
                    if RatioCreLineRec."13" <> '' then
                        SetVisible13 := true
                    else
                        SetVisible13 := false;
                14:
                    if RatioCreLineRec."14" <> '' then
                        SetVisible14 := true
                    else
                        SetVisible14 := false;
                15:
                    if RatioCreLineRec."15" <> '' then
                        SetVisible15 := true
                    else
                        SetVisible15 := false;
                16:
                    if RatioCreLineRec."16" <> '' then
                        SetVisible16 := true
                    else
                        SetVisible16 := false;
                17:
                    if RatioCreLineRec."17" <> '' then
                        SetVisible17 := true
                    else
                        SetVisible17 := false;
                18:
                    if RatioCreLineRec."18" <> '' then
                        SetVisible18 := true
                    else
                        SetVisible18 := false;
                19:
                    if RatioCreLineRec."19" <> '' then
                        SetVisible19 := true
                    else
                        SetVisible19 := false;
                20:
                    if RatioCreLineRec."20" <> '' then
                        SetVisible20 := true
                    else
                        SetVisible20 := false;
                21:
                    if RatioCreLineRec."21" <> '' then
                        SetVisible21 := true
                    else
                        SetVisible21 := false;
                22:
                    if RatioCreLineRec."22" <> '' then
                        SetVisible22 := true
                    else
                        SetVisible22 := false;
                23:
                    if RatioCreLineRec."23" <> '' then
                        SetVisible23 := true
                    else
                        SetVisible23 := false;
                24:
                    if RatioCreLineRec."24" <> '' then
                        SetVisible24 := true
                    else
                        SetVisible24 := false;
                25:
                    if RatioCreLineRec."25" <> '' then
                        SetVisible25 := true
                    else
                        SetVisible25 := false;
                26:
                    if RatioCreLineRec."26" <> '' then
                        SetVisible26 := true
                    else
                        SetVisible26 := false;
                27:
                    if RatioCreLineRec."27" <> '' then
                        SetVisible27 := true
                    else
                        SetVisible27 := false;
                28:
                    if RatioCreLineRec."28" <> '' then
                        SetVisible28 := true
                    else
                        SetVisible28 := false;
                29:
                    if RatioCreLineRec."29" <> '' then
                        SetVisible29 := true
                    else
                        SetVisible29 := false;
                30:
                    if RatioCreLineRec."30" <> '' then
                        SetVisible30 := true
                    else
                        SetVisible30 := false;
                31:
                    if RatioCreLineRec."31" <> '' then
                        SetVisible31 := true
                    else
                        SetVisible31 := false;
                32:
                    if RatioCreLineRec."32" <> '' then
                        SetVisible32 := true
                    else
                        SetVisible32 := false;
                33:
                    if RatioCreLineRec."33" <> '' then
                        SetVisible33 := true
                    else
                        SetVisible33 := false;
                34:
                    if RatioCreLineRec."34" <> '' then
                        SetVisible34 := true
                    else
                        SetVisible34 := false;
                35:
                    if RatioCreLineRec."35" <> '' then
                        SetVisible35 := true
                    else
                        SetVisible35 := false;
                36:
                    if RatioCreLineRec."36" <> '' then
                        SetVisible36 := true
                    else
                        SetVisible36 := false;
                37:
                    if RatioCreLineRec."37" <> '' then
                        SetVisible37 := true
                    else
                        SetVisible37 := false;
                38:
                    if RatioCreLineRec."38" <> '' then
                        SetVisible38 := true
                    else
                        SetVisible38 := false;
                39:
                    if RatioCreLineRec."39" <> '' then
                        SetVisible39 := true
                    else
                        SetVisible39 := false;
                40:
                    if RatioCreLineRec."40" <> '' then
                        SetVisible40 := true
                    else
                        SetVisible40 := false;
                41:
                    if RatioCreLineRec."41" <> '' then
                        SetVisible41 := true
                    else
                        SetVisible41 := false;
                42:
                    if RatioCreLineRec."42" <> '' then
                        SetVisible42 := true
                    else
                        SetVisible42 := false;
                43:
                    if RatioCreLineRec."43" <> '' then
                        SetVisible43 := true
                    else
                        SetVisible43 := false;
                44:
                    if RatioCreLineRec."44" <> '' then
                        SetVisible44 := true
                    else
                        SetVisible44 := false;
                45:
                    if RatioCreLineRec."45" <> '' then
                        SetVisible45 := true
                    else
                        SetVisible45 := false;
                46:
                    if RatioCreLineRec."46" <> '' then
                        SetVisible46 := true
                    else
                        SetVisible46 := false;
                47:
                    if RatioCreLineRec."47" <> '' then
                        SetVisible47 := true
                    else
                        SetVisible47 := false;
                48:
                    if RatioCreLineRec."48" <> '' then
                        SetVisible48 := true
                    else
                        SetVisible48 := false;
                49:
                    if RatioCreLineRec."49" <> '' then
                        SetVisible49 := true
                    else
                        SetVisible49 := false;
                50:
                    if RatioCreLineRec."50" <> '' then
                        SetVisible50 := true
                    else
                        SetVisible50 := false;
                51:
                    if RatioCreLineRec."51" <> '' then
                        SetVisible51 := true
                    else
                        SetVisible51 := false;
                52:
                    if RatioCreLineRec."52" <> '' then
                        SetVisible52 := true
                    else
                        SetVisible52 := false;
                53:
                    if RatioCreLineRec."53" <> '' then
                        SetVisible53 := true
                    else
                        SetVisible53 := false;
                54:
                    if RatioCreLineRec."54" <> '' then
                        SetVisible54 := true
                    else
                        SetVisible54 := false;
                55:
                    if RatioCreLineRec."55" <> '' then
                        SetVisible55 := true
                    else
                        SetVisible55 := false;
                56:
                    if RatioCreLineRec."56" <> '' then
                        SetVisible56 := true
                    else
                        SetVisible56 := false;
                57:
                    if RatioCreLineRec."57" <> '' then
                        SetVisible57 := true
                    else
                        SetVisible57 := false;
                58:
                    if RatioCreLineRec."58" <> '' then
                        SetVisible58 := true
                    else
                        SetVisible58 := false;
                59:
                    if RatioCreLineRec."59" <> '' then
                        SetVisible59 := true
                    else
                        SetVisible59 := false;
                60:
                    if RatioCreLineRec."60" <> '' then
                        SetVisible60 := true
                    else
                        SetVisible60 := false;
                61:
                    if RatioCreLineRec."61" <> '' then
                        SetVisible61 := true
                    else
                        SetVisible61 := false;
                62:
                    if RatioCreLineRec."62" <> '' then
                        SetVisible62 := true
                    else
                        SetVisible62 := false;
                63:
                    if RatioCreLineRec."63" <> '' then
                        SetVisible63 := true
                    else
                        SetVisible63 := false;
                64:
                    if RatioCreLineRec."64" <> '' then
                        SetVisible64 := true
                    else
                        SetVisible64 := false;
            end;
        end;

        if (Rec."Record Type" = 'R') or (Rec."Record Type" = '') then begin
            Clear(SetEdit1);
            SetEdit1 := true;
        end
        ELSE begin
            Clear(SetEdit1);
            SetEdit1 := false;
        end;
    end;


    trigger OnAfterGetCurrRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorRatioCreation(Rec);

        if (Rec."Record Type" = 'R') or (Rec."Record Type" = '') then begin
            Clear(SetEdit1);
            SetEdit1 := true;
        end
        ELSE begin
            Clear(SetEdit1);
            SetEdit1 := false;
        end;
    end;


    procedure Cal_Balance()
    var
        RatioCreationLineRec: Record RatioCreationLine;
        RatioCreationLineRec1: Record RatioCreationLine;
        RatioCreationLineRec2: Record RatioCreationLine;
        LineNo1: Integer;
        MaxLineNo: Integer;
        Number: Decimal;
        Number1: Decimal;
    begin

        if Rec.Plies <> 0 then begin

            LineNo1 := Rec.LineNo;

            //Get max line no
            RatioCreationLineRec.Reset();
            RatioCreationLineRec.SetRange(RatioCreNo, Rec.RatioCreNo);

            if RatioCreationLineRec.FindLast() then
                MaxLineNo := RatioCreationLineRec.Count;

            repeat

                RatioCreationLineRec.Reset();
                RatioCreationLineRec.SetRange(RatioCreNo, Rec.RatioCreNo);
                RatioCreationLineRec.SetRange("Group ID", Rec."Group ID");
                RatioCreationLineRec.SetRange(Ref, LineNo1);
                RatioCreationLineRec.SetRange("Marker Name", 'Balance');

                //Insert balance record
                if not RatioCreationLineRec.FindSet() then begin
                    //Insert balance line with zero values
                    RatioCreationLineRec.Init();
                    RatioCreationLineRec."Created Date" := Today;
                    RatioCreationLineRec."Created User" := UserId;
                    RatioCreationLineRec."Group ID" := Rec."Group ID";
                    RatioCreationLineRec.LineNo := LineNo1 + 1;
                    RatioCreationLineRec."Lot No." := Rec."Lot No.";
                    RatioCreationLineRec."PO No." := Rec."PO No.";
                    RatioCreationLineRec.qty := 0;
                    RatioCreationLineRec."Record Type" := 'B';
                    RatioCreationLineRec."Sewing Job No." := Rec."Sewing Job No.";
                    RatioCreationLineRec."Component Group Code" := Rec."Component Group Code";
                    RatioCreationLineRec.ShipDate := Rec.ShipDate;
                    RatioCreationLineRec."RatioCreNo" := Rec."RatioCreNo";
                    RatioCreationLineRec."Style Name" := Rec."Style Name";
                    RatioCreationLineRec."Style No." := Rec."Style No.";
                    RatioCreationLineRec."SubLotNo." := Rec."SubLotNo.";
                    RatioCreationLineRec."Marker Name" := 'Balance';
                    RatioCreationLineRec.Ref := LineNo1;
                    RatioCreationLineRec."Colour No" := Rec."Colour No";
                    RatioCreationLineRec."Colour Name" := Rec."Colour Name";
                    RatioCreationLineRec."1" := '0';
                    RatioCreationLineRec."2" := '0';
                    RatioCreationLineRec."3" := '0';
                    RatioCreationLineRec."4" := '0';
                    RatioCreationLineRec."5" := '0';
                    RatioCreationLineRec."6" := '0';
                    RatioCreationLineRec."7" := '0';
                    RatioCreationLineRec."8" := '0';
                    RatioCreationLineRec."9" := '0';
                    RatioCreationLineRec."10" := '0';
                    RatioCreationLineRec."11" := '0';
                    RatioCreationLineRec."12" := '0';
                    RatioCreationLineRec."13" := '0';
                    RatioCreationLineRec."14" := '0';
                    RatioCreationLineRec."15" := '0';
                    RatioCreationLineRec."16" := '0';
                    RatioCreationLineRec."17" := '0';
                    RatioCreationLineRec."18" := '0';
                    RatioCreationLineRec."19" := '0';
                    RatioCreationLineRec."20" := '0';
                    RatioCreationLineRec."21" := '0';
                    RatioCreationLineRec."22" := '0';
                    RatioCreationLineRec."23" := '0';
                    RatioCreationLineRec."24" := '0';
                    RatioCreationLineRec."25" := '0';
                    RatioCreationLineRec."26" := '0';
                    RatioCreationLineRec."27" := '0';
                    RatioCreationLineRec."28" := '0';
                    RatioCreationLineRec."29" := '0';
                    RatioCreationLineRec."30" := '0';
                    RatioCreationLineRec."31" := '0';
                    RatioCreationLineRec."32" := '0';
                    RatioCreationLineRec."33" := '0';
                    RatioCreationLineRec."34" := '0';
                    RatioCreationLineRec."35" := '0';
                    RatioCreationLineRec."36" := '0';
                    RatioCreationLineRec."37" := '0';
                    RatioCreationLineRec."38" := '0';
                    RatioCreationLineRec."39" := '0';
                    RatioCreationLineRec."40" := '0';
                    RatioCreationLineRec."41" := '0';
                    RatioCreationLineRec."42" := '0';
                    RatioCreationLineRec."43" := '0';
                    RatioCreationLineRec."44" := '0';
                    RatioCreationLineRec."45" := '0';
                    RatioCreationLineRec."46" := '0';
                    RatioCreationLineRec."47" := '0';
                    RatioCreationLineRec."48" := '0';
                    RatioCreationLineRec."49" := '0';
                    RatioCreationLineRec."50" := '0';
                    RatioCreationLineRec."51" := '0';
                    RatioCreationLineRec."52" := '0';
                    RatioCreationLineRec."53" := '0';
                    RatioCreationLineRec."54" := '0';
                    RatioCreationLineRec."55" := '0';
                    RatioCreationLineRec."56" := '0';
                    RatioCreationLineRec."57" := '0';
                    RatioCreationLineRec."58" := '0';
                    RatioCreationLineRec."59" := '0';
                    RatioCreationLineRec."60" := '0';
                    RatioCreationLineRec."61" := '0';
                    RatioCreationLineRec."62" := '0';
                    RatioCreationLineRec."63" := '0';
                    RatioCreationLineRec."64" := '0';
                    RatioCreationLineRec.Insert();
                end;

                //Get balance line record
                RatioCreationLineRec1.Reset();
                RatioCreationLineRec1.SetRange(RatioCreNo, Rec.RatioCreNo);
                RatioCreationLineRec1.SetRange("Group ID", Rec."Group ID");
                RatioCreationLineRec1.SetRange(LineNo, LineNo1 + 1);
                RatioCreationLineRec1.FindSet();


                //Get Current line
                RatioCreationLineRec2.Reset();
                RatioCreationLineRec2.SetRange(RatioCreNo, Rec.RatioCreNo);
                RatioCreationLineRec2.SetRange("Group ID", Rec."Group ID");
                RatioCreationLineRec2.SetRange(LineNo, LineNo1);
                RatioCreationLineRec2.FindSet();


                //Get totals of before line
                RatioCreationLineRec.Reset();
                RatioCreationLineRec.SetRange(RatioCreNo, Rec.RatioCreNo);
                RatioCreationLineRec.SetRange("Group ID", Rec."Group ID");
                RatioCreationLineRec.SetRange(LineNo, LineNo1 - 1);

                if RatioCreationLineRec.FindSet() then begin

                    if (RatioCreationLineRec."1" <> '') and (RatioCreationLineRec2."1" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."1");
                        Evaluate(Number1, RatioCreationLineRec2."1");
                        RatioCreationLineRec1."1" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."1" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."2" <> '') and (RatioCreationLineRec2."2" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."2");
                        Evaluate(Number1, RatioCreationLineRec2."2");
                        RatioCreationLineRec1."2" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."2" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."3" <> '') and (RatioCreationLineRec2."3" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."3");
                        Evaluate(Number1, RatioCreationLineRec2."3");
                        RatioCreationLineRec1."3" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."3" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."4" <> '') and (RatioCreationLineRec2."4" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."4");
                        Evaluate(Number1, RatioCreationLineRec2."4");
                        RatioCreationLineRec1."4" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."4" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."5" <> '') and (RatioCreationLineRec2."5" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."5");
                        Evaluate(Number1, RatioCreationLineRec2."5");
                        RatioCreationLineRec1."5" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."5" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."6" <> '') and (RatioCreationLineRec2."6" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."6");
                        Evaluate(Number1, RatioCreationLineRec2."6");
                        RatioCreationLineRec1."6" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."6" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."7" <> '') and (RatioCreationLineRec2."7" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."7");
                        Evaluate(Number1, RatioCreationLineRec2."7");
                        RatioCreationLineRec1."7" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."7" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."8" <> '') and (RatioCreationLineRec2."8" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."8");
                        Evaluate(Number1, RatioCreationLineRec2."8");
                        RatioCreationLineRec1."8" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."8" := '0';
                    ///////////////
                    /// 

                    if (RatioCreationLineRec."9" <> '') and (RatioCreationLineRec2."9" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."9");
                        Evaluate(Number1, RatioCreationLineRec2."9");
                        RatioCreationLineRec1."9" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."9" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."10" <> '') and (RatioCreationLineRec2."10" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."10");
                        Evaluate(Number1, RatioCreationLineRec2."10");
                        RatioCreationLineRec1."10" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."10" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."11" <> '') and (RatioCreationLineRec2."11" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."11");
                        Evaluate(Number1, RatioCreationLineRec2."11");
                        RatioCreationLineRec1."11" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."11" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."12" <> '') and (RatioCreationLineRec2."12" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."12");
                        Evaluate(Number1, RatioCreationLineRec2."12");
                        RatioCreationLineRec1."12" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."12" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."13" <> '') and (RatioCreationLineRec2."13" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."13");
                        Evaluate(Number1, RatioCreationLineRec2."13");
                        RatioCreationLineRec1."13" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."13" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."14" <> '') and (RatioCreationLineRec2."14" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."14");
                        Evaluate(Number1, RatioCreationLineRec2."14");
                        RatioCreationLineRec1."14" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."14" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."15" <> '') and (RatioCreationLineRec2."15" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."15");
                        Evaluate(Number1, RatioCreationLineRec2."15");
                        RatioCreationLineRec1."15" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."15" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."16" <> '') and (RatioCreationLineRec2."16" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."16");
                        Evaluate(Number1, RatioCreationLineRec2."16");
                        RatioCreationLineRec1."16" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."16" := '0';

                    if (RatioCreationLineRec."17" <> '') and (RatioCreationLineRec2."17" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."17");
                        Evaluate(Number1, RatioCreationLineRec2."17");
                        RatioCreationLineRec1."17" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."17" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."18" <> '') and (RatioCreationLineRec2."18" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."18");
                        Evaluate(Number1, RatioCreationLineRec2."18");
                        RatioCreationLineRec1."18" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."18" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."19" <> '') and (RatioCreationLineRec2."19" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."19");
                        Evaluate(Number1, RatioCreationLineRec2."19");
                        RatioCreationLineRec1."19" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."19" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."20" <> '') and (RatioCreationLineRec2."20" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."20");
                        Evaluate(Number1, RatioCreationLineRec2."20");
                        RatioCreationLineRec1."20" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."20" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."21" <> '') and (RatioCreationLineRec2."21" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."21");
                        Evaluate(Number1, RatioCreationLineRec2."21");
                        RatioCreationLineRec1."21" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."21" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."22" <> '') and (RatioCreationLineRec2."22" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."22");
                        Evaluate(Number1, RatioCreationLineRec2."22");
                        RatioCreationLineRec1."22" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."22" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."23" <> '') and (RatioCreationLineRec2."23" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."23");
                        Evaluate(Number1, RatioCreationLineRec2."23");
                        RatioCreationLineRec1."23" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."23" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."24" <> '') and (RatioCreationLineRec2."24" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."24");
                        Evaluate(Number1, RatioCreationLineRec2."24");
                        RatioCreationLineRec1."24" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."24" := '0';

                    if (RatioCreationLineRec."25" <> '') and (RatioCreationLineRec2."25" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."25");
                        Evaluate(Number1, RatioCreationLineRec2."25");
                        RatioCreationLineRec1."25" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."25" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."26" <> '') and (RatioCreationLineRec2."26" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."26");
                        Evaluate(Number1, RatioCreationLineRec2."26");
                        RatioCreationLineRec1."26" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."26" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."27" <> '') and (RatioCreationLineRec2."27" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."27");
                        Evaluate(Number1, RatioCreationLineRec2."27");
                        RatioCreationLineRec1."27" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."27" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."28" <> '') and (RatioCreationLineRec2."28" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."28");
                        Evaluate(Number1, RatioCreationLineRec2."28");
                        RatioCreationLineRec1."28" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."28" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."29" <> '') and (RatioCreationLineRec2."29" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."29");
                        Evaluate(Number1, RatioCreationLineRec2."29");
                        RatioCreationLineRec1."29" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."29" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."30" <> '') and (RatioCreationLineRec2."30" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."30");
                        Evaluate(Number1, RatioCreationLineRec2."30");
                        RatioCreationLineRec1."30" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."30" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."31" <> '') and (RatioCreationLineRec2."31" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."31");
                        Evaluate(Number1, RatioCreationLineRec2."31");
                        RatioCreationLineRec1."31" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."31" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."32" <> '') and (RatioCreationLineRec2."32" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."32");
                        Evaluate(Number1, RatioCreationLineRec2."32");
                        RatioCreationLineRec1."32" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."32" := '0';

                    if (RatioCreationLineRec."33" <> '') and (RatioCreationLineRec2."33" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."33");
                        Evaluate(Number1, RatioCreationLineRec2."33");
                        RatioCreationLineRec1."33" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."33" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."34" <> '') and (RatioCreationLineRec2."34" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."34");
                        Evaluate(Number1, RatioCreationLineRec2."34");
                        RatioCreationLineRec1."34" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."34" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."35" <> '') and (RatioCreationLineRec2."35" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."35");
                        Evaluate(Number1, RatioCreationLineRec2."35");
                        RatioCreationLineRec1."35" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."35" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."36" <> '') and (RatioCreationLineRec2."36" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."36");
                        Evaluate(Number1, RatioCreationLineRec2."36");
                        RatioCreationLineRec1."36" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."36" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."37" <> '') and (RatioCreationLineRec2."37" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."37");
                        Evaluate(Number1, RatioCreationLineRec2."37");
                        RatioCreationLineRec1."37" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."37" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."38" <> '') and (RatioCreationLineRec2."38" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."38");
                        Evaluate(Number1, RatioCreationLineRec2."38");
                        RatioCreationLineRec1."38" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."38" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."39" <> '') and (RatioCreationLineRec2."39" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."39");
                        Evaluate(Number1, RatioCreationLineRec2."39");
                        RatioCreationLineRec1."39" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."39" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."40" <> '') and (RatioCreationLineRec2."40" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."40");
                        Evaluate(Number1, RatioCreationLineRec2."40");
                        RatioCreationLineRec1."40" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."40" := '0';

                    if (RatioCreationLineRec."41" <> '') and (RatioCreationLineRec2."41" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."41");
                        Evaluate(Number1, RatioCreationLineRec2."41");
                        RatioCreationLineRec1."41" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."41" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."42" <> '') and (RatioCreationLineRec2."42" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."42");
                        Evaluate(Number1, RatioCreationLineRec2."42");
                        RatioCreationLineRec1."42" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."42" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."43" <> '') and (RatioCreationLineRec2."43" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."43");
                        Evaluate(Number1, RatioCreationLineRec2."43");
                        RatioCreationLineRec1."43" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."43" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."44" <> '') and (RatioCreationLineRec2."44" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."44");
                        Evaluate(Number1, RatioCreationLineRec2."44");
                        RatioCreationLineRec1."44" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."44" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."45" <> '') and (RatioCreationLineRec2."45" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."45");
                        Evaluate(Number1, RatioCreationLineRec2."45");
                        RatioCreationLineRec1."45" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."45" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."46" <> '') and (RatioCreationLineRec2."46" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."46");
                        Evaluate(Number1, RatioCreationLineRec2."46");
                        RatioCreationLineRec1."46" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."46" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."47" <> '') and (RatioCreationLineRec2."47" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."47");
                        Evaluate(Number1, RatioCreationLineRec2."47");
                        RatioCreationLineRec1."47" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."47" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."48" <> '') and (RatioCreationLineRec2."48" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."48");
                        Evaluate(Number1, RatioCreationLineRec2."48");
                        RatioCreationLineRec1."48" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."48" := '0';

                    if (RatioCreationLineRec."49" <> '') and (RatioCreationLineRec2."49" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."49");
                        Evaluate(Number1, RatioCreationLineRec2."49");
                        RatioCreationLineRec1."49" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."49" := '0';
                    ///////////////
                    ///
                    if (RatioCreationLineRec."50" <> '') and (RatioCreationLineRec2."50" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."50");
                        Evaluate(Number1, RatioCreationLineRec2."50");
                        RatioCreationLineRec1."50" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."50" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."51" <> '') and (RatioCreationLineRec2."51" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."51");
                        Evaluate(Number1, RatioCreationLineRec2."51");
                        RatioCreationLineRec1."51" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."51" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."52" <> '') and (RatioCreationLineRec2."52" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."52");
                        Evaluate(Number1, RatioCreationLineRec2."52");
                        RatioCreationLineRec1."52" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."52" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."53" <> '') and (RatioCreationLineRec2."53" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."53");
                        Evaluate(Number1, RatioCreationLineRec2."53");
                        RatioCreationLineRec1."53" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."53" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."54" <> '') and (RatioCreationLineRec2."54" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."54");
                        Evaluate(Number1, RatioCreationLineRec2."54");
                        RatioCreationLineRec1."54" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."54" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."55" <> '') and (RatioCreationLineRec2."55" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."55");
                        Evaluate(Number1, RatioCreationLineRec2."55");
                        RatioCreationLineRec1."55" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."55" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."56" <> '') and (RatioCreationLineRec2."56" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."56");
                        Evaluate(Number1, RatioCreationLineRec2."56");
                        RatioCreationLineRec1."56" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."56" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."57" <> '') and (RatioCreationLineRec2."57" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."57");
                        Evaluate(Number1, RatioCreationLineRec2."57");
                        RatioCreationLineRec1."57" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."57" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."58" <> '') and (RatioCreationLineRec2."58" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."58");
                        Evaluate(Number1, RatioCreationLineRec2."58");
                        RatioCreationLineRec1."58" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."58" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."59" <> '') and (RatioCreationLineRec2."59" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."59");
                        Evaluate(Number1, RatioCreationLineRec2."59");
                        RatioCreationLineRec1."59" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."59" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."60" <> '') and (RatioCreationLineRec2."60" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."60");
                        Evaluate(Number1, RatioCreationLineRec2."60");
                        RatioCreationLineRec1."60" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."60" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."61" <> '') and (RatioCreationLineRec2."61" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."61");
                        Evaluate(Number1, RatioCreationLineRec2."61");
                        RatioCreationLineRec1."61" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."61" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."62" <> '') and (RatioCreationLineRec2."62" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."62");
                        Evaluate(Number1, RatioCreationLineRec2."62");
                        RatioCreationLineRec1."62" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."62" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."63" <> '') and (RatioCreationLineRec2."63" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."63");
                        Evaluate(Number1, RatioCreationLineRec2."63");
                        RatioCreationLineRec1."63" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."63" := '0';
                    ///////////////
                    /// 
                    if (RatioCreationLineRec."64" <> '') and (RatioCreationLineRec2."64" <> '') then begin
                        Evaluate(Number, RatioCreationLineRec."64");
                        Evaluate(Number1, RatioCreationLineRec2."64");
                        RatioCreationLineRec1."64" := format(Number - (RatioCreationLineRec2.Plies * Number1));
                        Number := 0;
                        Number1 := 0;
                    end
                    else
                        RatioCreationLineRec1."64" := '0';


                    RatioCreationLineRec1.Modify();

                end;

                LineNo1 += 2;

            until MaxLineNo < LineNo1;

        end;

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


    trigger OnDeleteRecord(): Boolean
    var
        CurCreLineRec: Record CutCreationLine;
        RatioLineRec: Record RatioCreationLine;
        FabRec: Record FabricRequsition;
    begin

        if (Rec."Record Type" = 'R') then begin

            //Check for cut creation
            CurCreLineRec.Reset();
            CurCreLineRec.SetRange("Marker Name", Rec."Marker Name");
            CurCreLineRec.SetRange("Style No.", Rec."Style No.");
            CurCreLineRec.SetRange("Colour No", Rec."Colour No");
            CurCreLineRec.SetRange("Group ID", Rec."Group ID");
            CurCreLineRec.SetRange("Component Group Code", Rec."Component Group Code");

            if CurCreLineRec.FindSet() then begin
                Message('Cannot delete. Cut creation already created for this Marker : %1', Rec."Marker Name");
                exit(false);
            end;

            //Check for Fabric Requsition
            FabRec.Reset();
            FabRec.SetRange("Marker Name", Rec."Marker Name");
            FabRec.SetRange("Style No.", Rec."Style No.");
            FabRec.SetRange("Group ID", Rec."Group ID");
            FabRec.SetRange("Component Group Code", Rec."Component Group Code");

            if FabRec.FindSet() then begin
                Message('Cannot delete. Fabric requsition has created for this Ratio');
                exit(false);
            end;

        end;

        if (Rec."Record Type" = 'B') then begin

            //Get marker name            
            RatioLineRec.Reset();
            RatioLineRec.SetRange(RatioCreNo, Rec.RatioCreNo);
            RatioLineRec.SetRange("Group ID", Rec."Group ID");
            RatioLineRec.SetRange("Style No.", Rec."Style No.");
            RatioLineRec.SetRange("Colour No", Rec."Colour No");
            RatioLineRec.SetRange("Component Group Code", Rec."Component Group Code");
            RatioLineRec.SetRange(LineNo, Rec.ref);
            RatioLineRec.FindSet();

            CurCreLineRec.Reset();
            CurCreLineRec.SetRange("Marker Name", RatioLineRec."Marker Name");
            CurCreLineRec.SetRange("Style No.", Rec."Style No.");
            CurCreLineRec.SetRange("Colour No", Rec."Colour No");
            CurCreLineRec.SetRange("Group ID", Rec."Group ID");
            CurCreLineRec.SetRange("Component Group Code", Rec."Component Group Code");

            if CurCreLineRec.FindSet() then begin
                Message('Cannot delete. Cut creation already created for this Marker : %1', Rec."Marker Name");
                exit(false);
            end;

        end;


        if (Rec."Record Type" = 'H') or (Rec."Record Type" = 'H1') then begin

            //Get Ration lines
            RatioLineRec.Reset();
            RatioLineRec.SetRange(RatioCreNo, Rec.RatioCreNo);
            RatioLineRec.SetRange("Group ID", Rec."Group ID");
            RatioLineRec.SetRange("Style No.", Rec."Style No.");
            RatioLineRec.SetRange("Colour No", Rec."Colour No");
            RatioLineRec.SetRange("Component Group Code", Rec."Component Group Code");
            RatioLineRec.SetFilter("Record Type", '=%1', 'R');

            if RatioLineRec.FindSet() then begin
                repeat

                    //Check for cut creation
                    CurCreLineRec.Reset();
                    CurCreLineRec.SetRange("Marker Name", RatioLineRec."Marker Name");
                    CurCreLineRec.SetRange("Style No.", RatioLineRec."Style No.");
                    CurCreLineRec.SetRange("Colour No", RatioLineRec."Colour No");
                    CurCreLineRec.SetRange("Group ID", RatioLineRec."Group ID");
                    CurCreLineRec.SetRange("Component Group Code", RatioLineRec."Component Group Code");

                    if CurCreLineRec.FindSet() then begin
                        Message('Cannot delete. Cut creation already created for this Marker %1', RatioLineRec."Marker Name");
                        exit(false);
                    end;

                    //Check for Fabric Requsition
                    FabRec.Reset();
                    FabRec.SetRange("Marker Name", RatioLineRec."Marker Name");
                    FabRec.SetRange("Style No.", RatioLineRec."Style No.");
                    FabRec.SetRange("Group ID", RatioLineRec."Group ID");
                    FabRec.SetRange("Component Group Code", RatioLineRec."Component Group Code");

                    if FabRec.FindSet() then begin
                        Message('Cannot delete. Fabric requsition has created for this Ratio');
                        exit(false);
                    end;

                until RatioLineRec.Next() = 0;
            end;

            //Delete all Ratio lines
            RatioLineRec.Reset();
            RatioLineRec.SetRange(RatioCreNo, Rec.RatioCreNo);
            if RatioLineRec.FindSet() then
                RatioLineRec.DeleteAll();

        end;

    end;

}