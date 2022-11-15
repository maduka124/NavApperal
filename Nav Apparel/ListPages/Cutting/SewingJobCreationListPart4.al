page 50594 "Sewing Job Creation ListPart4"
{
    PageType = ListPart;
    SourceTable = SewingJobCreationLine4;
    SourceTableView = sorting("SJCNo.", "Style No.", "Lot No.", "SubLotNo.", LineNo) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Select)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SJC4: Record SewingJobCreationLine4;
                    begin
                        if ("Record Type" = 'H') then
                            Error('Cannot select header record');

                        if ("Record Type" = 'H1') and (Select = true) then begin
                            SJC4.Reset();
                            SJC4.SetRange("SJCNo.", "SJCNo.");
                            SJC4.SetRange("Colour No", "Colour No");
                            SJC4.SetFilter("Record Type", '=%1', 'L');
                            SJC4.SetFilter("Group ID", '=%1', 0);

                            if SJC4.FindSet() then
                                SJC4.ModifyAll(Select, true);
                        end;

                        if ("Record Type" = 'H1') and (Select = false) then begin
                            SJC4.Reset();
                            SJC4.SetRange("SJCNo.", "SJCNo.");
                            SJC4.SetRange("Colour No", "Colour No");
                            SJC4.SetFilter("Record Type", '=%1', 'L');
                            SJC4.SetFilter("Group ID", '=%1', 0);

                            if SJC4.FindSet() then
                                SJC4.ModifyAll(Select, false);
                        end;

                        if ("Group ID" <> 0) and (Select = true) then
                            Error('This sewing job already allocated.');
                    end;
                }

                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Caption = 'Lot No';

                    trigger OnValidate()
                    var
                    begin
                        "Style Name" := StyleName;
                    end;
                }

                field("SubLotNo."; "SubLotNo.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Caption = 'Sub Lot No';

                    trigger OnValidate()
                    var
                        AssoRec: Record AssorColorSizeRatio;
                        SJC3: Record SewingJobCreationLine3;
                        SJC4: Record SewingJobCreationLine4;
                        Status: Boolean;
                    begin

                        SJC4.Reset();
                        SJC4.SetRange("SJCNo.", "SJCNo.");
                        SJC4.SetRange("Style No.", "Style No.");
                        SJC4.SetRange("Lot No.", "Lot No.");
                        SJC4.SetRange("SubLotNo.", "SubLotNo.");
                        SJC4.SetFilter("Record Type", '=%1', 'H');

                        if not SJC4.FindSet() then begin

                            //Get Color * details
                            AssoRec.Reset();
                            AssoRec.SetRange("Style No.", "Style No.");
                            AssoRec.SetRange("Lot No.", "Lot No.");

                            if AssoRec.FindSet() then begin
                                repeat
                                    if (AssoRec."Colour No" = '*') and (Status = false) then begin

                                        "Colour No" := AssoRec."Colour No";
                                        "Colour Name" := AssoRec."Colour Name";
                                        ShipDate := AssoRec.ShipDate;
                                        "Country Code" := AssoRec."Country Code";
                                        "Country Name" := AssoRec."Country Name";
                                        "PO No." := AssoRec."PO No.";
                                        "1" := AssoRec."1";
                                        "2" := AssoRec."2";
                                        "3" := AssoRec."3";
                                        "4" := AssoRec."4";
                                        "5" := AssoRec."5";
                                        "6" := AssoRec."6";
                                        "7" := AssoRec."7";
                                        "8" := AssoRec."8";
                                        "9" := AssoRec."9";
                                        "10" := AssoRec."10";
                                        "11" := AssoRec."11";
                                        "12" := AssoRec."12";
                                        "13" := AssoRec."13";
                                        "14" := AssoRec."14";
                                        "15" := AssoRec."15";
                                        "16" := AssoRec."16";
                                        "17" := AssoRec."17";
                                        "18" := AssoRec."18";
                                        "19" := AssoRec."19";
                                        "20" := AssoRec."20";
                                        "21" := AssoRec."21";
                                        "22" := AssoRec."22";
                                        "23" := AssoRec."23";
                                        "24" := AssoRec."24";
                                        "25" := AssoRec."25";
                                        "26" := AssoRec."26";
                                        "27" := AssoRec."27";
                                        "28" := AssoRec."28";
                                        "29" := AssoRec."29";
                                        "30" := AssoRec."30";
                                        "31" := AssoRec."31";
                                        "32" := AssoRec."32";
                                        "33" := AssoRec."33";
                                        "34" := AssoRec."34";
                                        "35" := AssoRec."35";
                                        "36" := AssoRec."36";
                                        "37" := AssoRec."37";
                                        "38" := AssoRec."38";
                                        "39" := AssoRec."39";
                                        "40" := AssoRec."40";
                                        "41" := AssoRec."41";
                                        "42" := AssoRec."42";
                                        "43" := AssoRec."43";
                                        "44" := AssoRec."44";
                                        "45" := AssoRec."45";
                                        "46" := AssoRec."46";
                                        "47" := AssoRec."47";
                                        "48" := AssoRec."48";
                                        "49" := AssoRec."49";
                                        "50" := AssoRec."50";
                                        "51" := AssoRec."51";
                                        "52" := AssoRec."52";
                                        "53" := AssoRec."53";
                                        "54" := AssoRec."54";
                                        "55" := AssoRec."55";
                                        "56" := AssoRec."56";
                                        "57" := AssoRec."57";
                                        "58" := AssoRec."58";
                                        "59" := AssoRec."59";
                                        "60" := AssoRec."60";
                                        "61" := AssoRec."61";
                                        "62" := AssoRec."62";
                                        "63" := AssoRec."63";
                                        "64" := AssoRec."64";
                                        "Color Total" := AssoRec.Total;
                                        "Record Type" := 'H';
                                        LineNo := 1;
                                        CurrPage.Update();


                                        SJC4.Init();
                                        SJC4."SJCNo." := "SJCNo.";
                                        SJC4."Style No." := "Style No.";
                                        SJC4."Style Name" := "Style Name";
                                        SJC4."Lot No." := "Lot No.";
                                        SJC4."PO No." := AssoRec."PO No.";
                                        SJC4.ShipDate := AssoRec.ShipDate;
                                        SJC4."SubLotNo." := "SubLotNo.";
                                        //SJC3."Record Type" := 'H1';
                                        SJC4.LineNo := 2;
                                        SJC4."Created Date" := Today;
                                        SJC4."Created User" := UserId;
                                        SJC4.Insert();

                                        Status := true;

                                    end;
                                until AssoRec.Next() = 0;
                            end;
                        end
                        else begin

                            //Get max line no
                            SJC4.Reset();
                            SJC4.SetRange("SJCNo.", "SJCNo.");
                            SJC4.SetRange("Style No.", "Style No.");
                            SJC4.SetRange("Lot No.", "Lot No.");
                            SJC4.SetRange("SubLotNo.", "SubLotNo.");
                            SJC4.FindLast();

                            ShipDate := SJC4.ShipDate;
                            "Resource No." := SJC4."Resource No.";
                            "Resource Name" := SJC4."Resource Name";
                            "PO No." := SJC4."PO No.";
                            LineNo := SJC4.LineNo + 1;
                            "Created Date" := Today;
                            "Created User" := UserId;
                            CurrPage.Update();

                        end;

                    end;
                }

                field("Sewing Job No."; "Sewing Job No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Caption = 'Sewing Job No';
                }

                field("Resource Name"; "Resource Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Line';
                    Editable = SetEdit;

                    trigger OnValidate()
                    var
                        StyleColorRec: Record StyleColor;
                        WorkCenterRec: Record "Work Center";
                        AssoRec: Record AssorColorSizeRatio;
                        Color: Code[20];
                    begin
                        //Get Po details
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetFilter("Planning Line", '=%1', true);
                        WorkCenterRec.SetRange(Name, "Resource Name");

                        if WorkCenterRec.FindSet() then
                            "Resource No." := WorkCenterRec."No.";


                        //Deleet old recorsd
                        StyleColorRec.Reset();
                        StyleColorRec.SetRange("User ID", UserId);
                        if StyleColorRec.FindSet() then
                            StyleColorRec.DeleteAll();

                        //Get Colors for the style
                        AssoRec.Reset();
                        AssoRec.SetCurrentKey("Style No.", "Colour Name");
                        AssoRec.SetRange("Style No.", "Style No.");
                        AssoRec.SetFilter("Colour Name", '<>%1', '*');

                        if AssoRec.FindSet() then begin
                            repeat
                                if Color <> AssoRec."Colour No" then begin
                                    StyleColorRec.Init();
                                    StyleColorRec."User ID" := UserId;
                                    StyleColorRec."Color No." := AssoRec."Colour No";
                                    StyleColorRec.Color := AssoRec."Colour Name";
                                    StyleColorRec.Insert();
                                    Color := AssoRec."Colour No";
                                end;
                            until AssoRec.Next() = 0;
                        end;

                        CurrPage.Update();
                    end;
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Colour';
                    Editable = SetEdit;

                    trigger OnValidate()
                    var
                        AssoRec: Record AssorColorSizeRatio;
                        colorRec: Record Colour;
                        SJC2: Record SewingJobCreationLine2;
                        SJC3: Record SewingJobCreationLine3;
                        SJC4: Record SewingJobCreationLine4;
                        SJC4New: Record SewingJobCreationLine4;
                        Waistage: Decimal;
                        TempQty: Decimal;
                        TempTarget: Decimal;
                        Nooftimes: Integer;
                        Balance: Decimal;
                        Count: Integer;
                        LineNo: Integer;
                        StartDate: Date;
                        Number: Integer;
                        ColorTotal: Decimal;
                    begin

                        if "Resource No." <> '' then begin

                            if "Colour Name" <> '*' then begin

                                Waistage := 0.1;
                                //Get color name
                                colorRec.Reset();
                                colorRec.SetRange("Colour Name", "Colour Name");

                                if colorRec.FindSet() then begin
                                    "Colour No" := colorRec."No.";
                                    CurrPage.Update();

                                    if "SubLotNo." = '' then
                                        Error('SubLotNo is blank');

                                    if "Lot No." = '' then
                                        Error('LotNo is blank');


                                    SJC4.Reset();
                                    SJC4.SetRange("SJCNo.", "SJCNo.");
                                    SJC4.SetRange("Style No.", "Style No.");
                                    SJC4.SetRange("Lot No.", "Lot No.");
                                    SJC4.SetRange("SubLotNo.", "SubLotNo.");
                                    SJC4.SetRange("Colour No", colorRec."No.");
                                    SJC4.SetRange("Record Type", 'H1');

                                    if not SJC4.FindSet() then
                                        "Record Type" := 'H1'
                                    else
                                        "Record Type" := 'L';

                                    CurrPage.Update();


                                    //Fill Header sizes                               
                                    SJC3.Reset();
                                    SJC3.SetRange("SJCNo.", "SJCNo.");
                                    SJC3.SetRange("Style No.", "Style No.");
                                    SJC3.SetRange("Lot No.", "Lot No.");
                                    SJC3.SetRange("SubLotNo.", "SubLotNo.");
                                    SJC3.SetRange("Colour No", colorRec."No.");
                                    SJC3.SetRange("Resource No.", "Resource No.");

                                    if SJC3.FindSet() then begin

                                        Qty := SJC3.Qty + (SJC3.Qty * Waistage) / 100;
                                        TempQty := Qty;

                                        if "Record Type" = 'H1' then begin
                                            if SJC3."1" <> '' then
                                                Evaluate(Number, SJC3."1");

                                            "1" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."2" <> '' then
                                                Evaluate(Number, SJC3."2");

                                            "2" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."3" <> '' then
                                                Evaluate(Number, SJC3."3");

                                            "3" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."4" <> '' then
                                                Evaluate(Number, SJC3."4");

                                            "4" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."5" <> '' then
                                                Evaluate(Number, SJC3."5");

                                            "5" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."6" <> '' then
                                                Evaluate(Number, SJC3."6");

                                            "6" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);

                                            Number := 0;
                                            if SJC3."7" <> '' then
                                                Evaluate(Number, SJC3."7");

                                            "7" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."8" <> '' then
                                                Evaluate(Number, SJC3."8");

                                            "8" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."9" <> '' then
                                                Evaluate(Number, SJC3."9");

                                            "9" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."10" <> '' then
                                                Evaluate(Number, SJC3."10");

                                            "10" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."11" <> '' then
                                                Evaluate(Number, SJC3."11");

                                            "11" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."12" <> '' then
                                                Evaluate(Number, SJC3."12");

                                            "12" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."13" <> '' then
                                                Evaluate(Number, SJC3."13");

                                            "13" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."14" <> '' then
                                                Evaluate(Number, SJC3."14");

                                            "14" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);

                                            Number := 0;
                                            if SJC3."15" <> '' then
                                                Evaluate(Number, SJC3."15");

                                            "15" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."16" <> '' then
                                                Evaluate(Number, SJC3."16");

                                            "16" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."17" <> '' then
                                                Evaluate(Number, SJC3."17");

                                            "17" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."18" <> '' then
                                                Evaluate(Number, SJC3."18");

                                            "18" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."19" <> '' then
                                                Evaluate(Number, SJC3."19");

                                            "19" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."20" <> '' then
                                                Evaluate(Number, SJC3."20");

                                            "20" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."21" <> '' then
                                                Evaluate(Number, SJC3."21");

                                            "21" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."22" <> '' then
                                                Evaluate(Number, SJC3."22");

                                            "22" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);

                                            Number := 0;
                                            if SJC3."23" <> '' then
                                                Evaluate(Number, SJC3."23");

                                            "23" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."24" <> '' then
                                                Evaluate(Number, SJC3."24");

                                            "24" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."25" <> '' then
                                                Evaluate(Number, SJC3."25");

                                            "25" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."26" <> '' then
                                                Evaluate(Number, SJC3."26");

                                            "26" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."27" <> '' then
                                                Evaluate(Number, SJC3."27");

                                            "27" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."28" <> '' then
                                                Evaluate(Number, SJC3."28");

                                            "28" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."29" <> '' then
                                                Evaluate(Number, SJC3."29");

                                            "29" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."30" <> '' then
                                                Evaluate(Number, SJC3."30");

                                            "30" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);

                                            Number := 0;
                                            if SJC3."31" <> '' then
                                                Evaluate(Number, SJC3."31");

                                            "31" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."32" <> '' then
                                                Evaluate(Number, SJC3."32");

                                            "32" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."33" <> '' then
                                                Evaluate(Number, SJC3."33");

                                            "33" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."34" <> '' then
                                                Evaluate(Number, SJC3."34");

                                            "34" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."35" <> '' then
                                                Evaluate(Number, SJC3."35");

                                            "35" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."36" <> '' then
                                                Evaluate(Number, SJC3."36");

                                            "36" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."37" <> '' then
                                                Evaluate(Number, SJC3."37");

                                            "37" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."38" <> '' then
                                                Evaluate(Number, SJC3."38");

                                            "38" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);

                                            Number := 0;
                                            if SJC3."39" <> '' then
                                                Evaluate(Number, SJC3."39");

                                            "39" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."40" <> '' then
                                                Evaluate(Number, SJC3."40");

                                            "40" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."41" <> '' then
                                                Evaluate(Number, SJC3."41");

                                            "41" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."42" <> '' then
                                                Evaluate(Number, SJC3."42");

                                            "42" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."43" <> '' then
                                                Evaluate(Number, SJC3."43");

                                            "43" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."44" <> '' then
                                                Evaluate(Number, SJC3."44");

                                            "44" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."45" <> '' then
                                                Evaluate(Number, SJC3."45");

                                            "45" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."46" <> '' then
                                                Evaluate(Number, SJC3."46");

                                            "46" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);

                                            Number := 0;
                                            if SJC3."47" <> '' then
                                                Evaluate(Number, SJC3."47");

                                            "47" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."48" <> '' then
                                                Evaluate(Number, SJC3."48");

                                            "48" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."49" <> '' then
                                                Evaluate(Number, SJC3."49");

                                            "49" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."50" <> '' then
                                                Evaluate(Number, SJC3."50");

                                            "50" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."51" <> '' then
                                                Evaluate(Number, SJC3."51");

                                            "51" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."52" <> '' then
                                                Evaluate(Number, SJC3."52");

                                            "52" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."53" <> '' then
                                                Evaluate(Number, SJC3."53");

                                            "53" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."54" <> '' then
                                                Evaluate(Number, SJC3."54");

                                            "54" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);

                                            Number := 0;
                                            if SJC3."55" <> '' then
                                                Evaluate(Number, SJC3."55");

                                            "55" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."56" <> '' then
                                                Evaluate(Number, SJC3."56");

                                            "56" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."57" <> '' then
                                                Evaluate(Number, SJC3."57");

                                            "57" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."58" <> '' then
                                                Evaluate(Number, SJC3."58");

                                            "58" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."59" <> '' then
                                                Evaluate(Number, SJC3."59");

                                            "59" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."60" <> '' then
                                                Evaluate(Number, SJC3."60");

                                            "60" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."61" <> '' then
                                                Evaluate(Number, SJC3."61");

                                            "61" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."62" <> '' then
                                                Evaluate(Number, SJC3."62");

                                            "62" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);

                                            Number := 0;
                                            if SJC3."63" <> '' then
                                                Evaluate(Number, SJC3."63");

                                            "63" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                            if SJC3."64" <> '' then
                                                Evaluate(Number, SJC3."64");

                                            "64" := format(round(Number + (Number * Waistage) / 100, 1));
                                            ColorTotal += round(Number + (Number * Waistage) / 100, 1);
                                            Number := 0;

                                        end;

                                        "Color Total" := ColorTotal;
                                    end;

                                    CurrPage.Update();


                                    //Get Max target qty / Plan date
                                    SJC2.Reset();
                                    SJC2.SetRange("SJCNo.", "SJCNo.");
                                    SJC2.SetRange("Style No.", "Style No.");
                                    SJC2.SetRange("Lot No.", "Lot No.");
                                    SJC2.SetRange("Line No.", "Resource No.");

                                    if SJC2.FindSet() then begin
                                        TempTarget := SJC2."Day Max Target";
                                        StartDate := SJC2."Start Date";
                                        StartDate := StartDate + 2;
                                    end;

                                    if TempTarget = 0 then
                                        Error('Day Max Target is zero. cannot proceed');

                                    Nooftimes := TempQty DIV TempTarget;
                                    Balance := TempQty MOD TempTarget;


                                    //Get max line no
                                    SJC4.Reset();
                                    SJC4.SetRange("SJCNo.", "SJCNo.");
                                    SJC4.SetRange("Style No.", "Style No.");
                                    SJC4.SetRange("Lot No.", "Lot No.");
                                    SJC4.SetRange("SubLotNo.", "SubLotNo.");
                                    SJC4.FindLast();

                                    LineNo := SJC4.LineNo;

                                    for Count := 1 To Nooftimes DO begin

                                        LineNo += 1;
                                        StartDate += 1;
                                        ColorTotal := 0;

                                        SJC4.Init();
                                        SJC4."SJCNo." := "SJCNo.";
                                        SJC4."Style No." := "Style No.";
                                        SJC4."Style Name" := "Style Name";
                                        SJC4."Sewing Job No." := "SubLotNo." + '-' + format(Count);
                                        SJC4."Lot No." := "Lot No.";
                                        SJC4."SubLotNo." := "SubLotNo.";
                                        SJC4.LineNo := LineNo;
                                        SJC4."PO No." := "PO No.";
                                        SJC4."Created Date" := Today;
                                        SJC4."Created User" := UserId;
                                        SJC4.Qty := TempTarget;
                                        SJC4.ShipDate := ShipDate;
                                        SJC4."Colour No" := "Colour No";
                                        SJC4."Colour Name" := "Colour Name";
                                        SJC4."Record Type" := 'L';
                                        SJC4."Resource No." := "Resource No.";
                                        SJC4."Resource Name" := "Resource Name";
                                        SJC4."Plan Date" := StartDate;
                                        SJC4."Plan Target" := TempTarget;

                                        //Get size details
                                        SJC4New.Reset();
                                        SJC4New.SetRange("SJCNo.", "SJCNo.");
                                        SJC4New.SetRange("Style No.", "Style No.");
                                        SJC4New.SetRange("Lot No.", "Lot No.");
                                        SJC4New.SetRange("SubLotNo.", "SubLotNo.");
                                        SJC4New.SetRange("Colour No", colorRec."No.");
                                        SJC4New.SetFilter("Record Type", '%1', 'H1');
                                        SJC4New.FindLast();

                                        if SJC4New."1" <> '' then
                                            Evaluate(Number, SJC4New."1");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."1" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."1" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."1" := '0';

                                        Evaluate(Number, SJC4."1");
                                        ColorTotal += Number;
                                        Number := 0;


                                        if SJC4New."2" <> '' then
                                            Evaluate(Number, SJC4New."2");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."2" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."2" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."2" := '0';

                                        Evaluate(Number, SJC4."2");
                                        ColorTotal += Number;
                                        Number := 0;


                                        if SJC4New."3" <> '' then
                                            Evaluate(Number, SJC4New."3");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."3" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."3" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."3" := '0';

                                        Evaluate(Number, SJC4."3");
                                        ColorTotal += Number;
                                        Number := 0;


                                        if SJC4New."4" <> '' then
                                            Evaluate(Number, SJC4New."4");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."4" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."4" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."4" := '0';

                                        Evaluate(Number, SJC4."4");
                                        ColorTotal += Number;
                                        Number := 0;


                                        if SJC4New."5" <> '' then
                                            Evaluate(Number, SJC4New."5");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."5" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."5" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."5" := '0';

                                        Evaluate(Number, SJC4."5");
                                        ColorTotal += Number;
                                        Number := 0;


                                        if SJC4New."6" <> '' then
                                            Evaluate(Number, SJC4New."6");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."6" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."6" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."6" := '0';

                                        Evaluate(Number, SJC4."6");
                                        ColorTotal += Number;
                                        Number := 0;


                                        if SJC4New."7" <> '' then
                                            Evaluate(Number, SJC4New."7");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."7" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."7" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."7" := '0';

                                        Evaluate(Number, SJC4."7");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."8" <> '' then
                                            Evaluate(Number, SJC4New."8");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."8" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."8" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."8" := '0';

                                        Evaluate(Number, SJC4."8");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."9" <> '' then
                                            Evaluate(Number, SJC4New."9");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."9" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."9" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."9" := '0';

                                        Evaluate(Number, SJC4."9");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."10" <> '' then
                                            Evaluate(Number, SJC4New."10");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."10" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."10" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."10" := '0';

                                        Evaluate(Number, SJC4."10");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."11" <> '' then
                                            Evaluate(Number, SJC4New."11");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."11" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."11" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."11" := '0';

                                        Evaluate(Number, SJC4."11");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."12" <> '' then
                                            Evaluate(Number, SJC4New."12");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."12" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."12" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."12" := '0';

                                        Evaluate(Number, SJC4."12");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."13" <> '' then
                                            Evaluate(Number, SJC4New."13");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."13" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."13" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."13" := '0';

                                        Evaluate(Number, SJC4."13");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."14" <> '' then
                                            Evaluate(Number, SJC4New."14");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."14" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."14" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."14" := '0';

                                        Evaluate(Number, SJC4."14");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."15" <> '' then
                                            Evaluate(Number, SJC4New."15");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."15" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."15" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."15" := '0';

                                        Evaluate(Number, SJC4."15");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."16" <> '' then
                                            Evaluate(Number, SJC4New."16");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."16" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."16" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."16" := '0';

                                        Evaluate(Number, SJC4."16");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."17" <> '' then
                                            Evaluate(Number, SJC4New."17");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."17" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."17" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."17" := '0';

                                        Evaluate(Number, SJC4."17");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."18" <> '' then
                                            Evaluate(Number, SJC4New."18");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."18" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."18" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."18" := '0';

                                        Evaluate(Number, SJC4."18");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."19" <> '' then
                                            Evaluate(Number, SJC4New."19");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."19" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."19" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."19" := '0';

                                        Evaluate(Number, SJC4."19");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."20" <> '' then
                                            Evaluate(Number, SJC4New."20");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."20" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."20" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."20" := '0';

                                        Evaluate(Number, SJC4."20");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."21" <> '' then
                                            Evaluate(Number, SJC4New."21");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."21" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."21" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."21" := '0';

                                        Evaluate(Number, SJC4."21");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."22" <> '' then
                                            Evaluate(Number, SJC4New."22");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."22" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."22" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."22" := '0';

                                        Evaluate(Number, SJC4."22");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."23" <> '' then
                                            Evaluate(Number, SJC4New."23");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."23" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."23" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."23" := '0';

                                        Evaluate(Number, SJC4."23");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."24" <> '' then
                                            Evaluate(Number, SJC4New."24");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."24" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."24" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."24" := '0';

                                        Evaluate(Number, SJC4."24");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."25" <> '' then
                                            Evaluate(Number, SJC4New."25");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."25" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."25" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."25" := '0';

                                        Evaluate(Number, SJC4."25");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."26" <> '' then
                                            Evaluate(Number, SJC4New."26");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."26" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."26" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."26" := '0';

                                        Evaluate(Number, SJC4."26");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."27" <> '' then
                                            Evaluate(Number, SJC4New."27");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."27" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."27" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."27" := '0';

                                        Evaluate(Number, SJC4."27");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."28" <> '' then
                                            Evaluate(Number, SJC4New."28");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."28" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."28" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."28" := '0';

                                        Evaluate(Number, SJC4."28");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 

                                        if SJC4New."29" <> '' then
                                            Evaluate(Number, SJC4New."29");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."29" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."29" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."29" := '0';

                                        Evaluate(Number, SJC4."29");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."30" <> '' then
                                            Evaluate(Number, SJC4New."30");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."30" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."30" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."30" := '0';

                                        Evaluate(Number, SJC4."30");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."31" <> '' then
                                            Evaluate(Number, SJC4New."31");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."31" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."31" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."31" := '0';

                                        Evaluate(Number, SJC4."31");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."32" <> '' then
                                            Evaluate(Number, SJC4New."32");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."32" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."32" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."32" := '0';

                                        Evaluate(Number, SJC4."32");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."33" <> '' then
                                            Evaluate(Number, SJC4New."33");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."33" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."33" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."33" := '0';

                                        Evaluate(Number, SJC4."33");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."34" <> '' then
                                            Evaluate(Number, SJC4New."34");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."34" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."34" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."34" := '0';

                                        Evaluate(Number, SJC4."34");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."35" <> '' then
                                            Evaluate(Number, SJC4New."35");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."35" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."35" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."35" := '0';

                                        Evaluate(Number, SJC4."35");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."36" <> '' then
                                            Evaluate(Number, SJC4New."36");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."36" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."36" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."36" := '0';

                                        Evaluate(Number, SJC4."36");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."37" <> '' then
                                            Evaluate(Number, SJC4New."37");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."37" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."37" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."37" := '0';

                                        Evaluate(Number, SJC4."37");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."38" <> '' then
                                            Evaluate(Number, SJC4New."38");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."38" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."38" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."38" := '0';

                                        Evaluate(Number, SJC4."38");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."39" <> '' then
                                            Evaluate(Number, SJC4New."39");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."39" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."39" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."39" := '0';

                                        Evaluate(Number, SJC4."39");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."40" <> '' then
                                            Evaluate(Number, SJC4New."40");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."40" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."40" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."40" := '0';

                                        Evaluate(Number, SJC4."40");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."41" <> '' then
                                            Evaluate(Number, SJC4New."41");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."41" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."41" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."41" := '0';

                                        Evaluate(Number, SJC4."41");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."42" <> '' then
                                            Evaluate(Number, SJC4New."42");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."42" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."42" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."42" := '0';

                                        Evaluate(Number, SJC4."42");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."43" <> '' then
                                            Evaluate(Number, SJC4New."43");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."43" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."43" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."43" := '0';

                                        Evaluate(Number, SJC4."43");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////
                                        /// 
                                        if SJC4New."44" <> '' then
                                            Evaluate(Number, SJC4New."44");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."44" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."44" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."44" := '0';

                                        Evaluate(Number, SJC4."44");
                                        ColorTotal += Number;
                                        Number := 0;

                                        ////////////////////////                                    
                                        if SJC4New."45" <> '' then
                                            Evaluate(Number, SJC4New."45");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."45" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."45" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."45" := '0';

                                        Evaluate(Number, SJC4."45");
                                        ColorTotal += Number;
                                        Number := 0;

                                        ////////////////////////                                    
                                        if SJC4New."46" <> '' then
                                            Evaluate(Number, SJC4New."46");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."46" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."46" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."46" := '0';

                                        Evaluate(Number, SJC4."46");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."47" <> '' then
                                            Evaluate(Number, SJC4New."47");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."47" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."47" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."47" := '0';

                                        Evaluate(Number, SJC4."47");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."48" <> '' then
                                            Evaluate(Number, SJC4New."48");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."48" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."48" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."48" := '0';

                                        Evaluate(Number, SJC4."48");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."49" <> '' then
                                            Evaluate(Number, SJC4New."49");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."49" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."49" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."49" := '0';

                                        Evaluate(Number, SJC4."49");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."50" <> '' then
                                            Evaluate(Number, SJC4New."50");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."50" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."50" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."50" := '0';

                                        Evaluate(Number, SJC4."50");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."51" <> '' then
                                            Evaluate(Number, SJC4New."51");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."51" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."51" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."51" := '0';

                                        Evaluate(Number, SJC4."51");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."52" <> '' then
                                            Evaluate(Number, SJC4New."52");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."52" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."52" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."52" := '0';

                                        Evaluate(Number, SJC4."52");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."53" <> '' then
                                            Evaluate(Number, SJC4New."53");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."53" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."53" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."53" := '0';

                                        Evaluate(Number, SJC4."53");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."54" <> '' then
                                            Evaluate(Number, SJC4New."54");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."54" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."54" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."54" := '0';

                                        Evaluate(Number, SJC4."54");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."55" <> '' then
                                            Evaluate(Number, SJC4New."55");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."55" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."55" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."55" := '0';

                                        Evaluate(Number, SJC4."55");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."56" <> '' then
                                            Evaluate(Number, SJC4New."56");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."56" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."56" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."56" := '0';

                                        Evaluate(Number, SJC4."56");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."57" <> '' then
                                            Evaluate(Number, SJC4New."57");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."57" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."57" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."57" := '0';

                                        Evaluate(Number, SJC4."57");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."58" <> '' then
                                            Evaluate(Number, SJC4New."58");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."58" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."58" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."58" := '0';

                                        Evaluate(Number, SJC4."58");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."59" <> '' then
                                            Evaluate(Number, SJC4New."59");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."59" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."59" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."59" := '0';

                                        Evaluate(Number, SJC4."59");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."60" <> '' then
                                            Evaluate(Number, SJC4New."60");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."60" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."60" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."60" := '0';

                                        Evaluate(Number, SJC4."60");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."61" <> '' then
                                            Evaluate(Number, SJC4New."61");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."61" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."61" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."61" := '0';

                                        Evaluate(Number, SJC4."61");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."62" <> '' then
                                            Evaluate(Number, SJC4New."62");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."62" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."62" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."62" := '0';

                                        Evaluate(Number, SJC4."62");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."63" <> '' then
                                            Evaluate(Number, SJC4New."63");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."63" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."63" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."63" := '0';

                                        Evaluate(Number, SJC4."63");
                                        ColorTotal += Number;
                                        Number := 0;
                                        ////////////////////////                                    
                                        if SJC4New."64" <> '' then
                                            Evaluate(Number, SJC4New."64");

                                        if Number <> 0 then
                                            if TempTarget MOD (TempQty / Number) <> 0 then
                                                SJC4."64" := format((TempTarget DIV (TempQty / Number)) + 1)
                                            else
                                                SJC4."64" := format(TempTarget DIV (TempQty / Number))
                                        else
                                            SJC4."64" := '0';

                                        Evaluate(Number, SJC4."64");
                                        ColorTotal += Number;
                                        Number := 0;


                                        SJC4."Color Total" := ColorTotal;
                                        SJC4.Insert();

                                    end;


                                    //insert balance qty
                                    LineNo += 1;
                                    StartDate += 1;
                                    ColorTotal := 0;

                                    SJC4.Init();
                                    SJC4."SJCNo." := "SJCNo.";
                                    SJC4."Style No." := "Style No.";
                                    SJC4."Style Name" := "Style Name";
                                    SJC4."Sewing Job No." := "SubLotNo." + '-' + format(Count + 1);
                                    SJC4."Lot No." := "Lot No.";
                                    SJC4."SubLotNo." := "SubLotNo.";
                                    SJC4.LineNo := LineNo;
                                    SJC4."PO No." := "PO No.";
                                    SJC4."Created Date" := Today;
                                    SJC4."Created User" := UserId;
                                    SJC4.Qty := Balance;
                                    SJC4.ShipDate := ShipDate;
                                    SJC4."Colour No" := colorRec."No.";
                                    SJC4."Colour Name" := "Colour Name";
                                    SJC4."Record Type" := 'L';
                                    SJC4."Resource No." := "Resource No.";
                                    SJC4."Resource Name" := "Resource Name";
                                    SJC4."Plan Date" := StartDate;
                                    SJC4."Plan Target" := Balance;

                                    //Get size details
                                    SJC4New.Reset();
                                    SJC4New.SetRange("SJCNo.", "SJCNo.");
                                    SJC4New.SetRange("Style No.", "Style No.");
                                    SJC4New.SetRange("Lot No.", "Lot No.");
                                    SJC4New.SetRange("SubLotNo.", "SubLotNo.");
                                    SJC4New.SetRange("Colour No", colorRec."No.");
                                    SJC4New.SetFilter("Record Type", '%1', 'H1');
                                    SJC4New.FindLast();

                                    if SJC4New."1" <> '' then
                                        Evaluate(Number, SJC4New."1");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."1" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."1" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."1" := '0';

                                    Evaluate(Number, SJC4."1");
                                    ColorTotal += Number;
                                    Number := 0;


                                    if SJC4New."2" <> '' then
                                        Evaluate(Number, SJC4New."2");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."2" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."2" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."2" := '0';

                                    Evaluate(Number, SJC4."2");
                                    ColorTotal += Number;
                                    Number := 0;


                                    if SJC4New."3" <> '' then
                                        Evaluate(Number, SJC4New."3");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."3" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."3" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."3" := '0';

                                    Evaluate(Number, SJC4."3");
                                    ColorTotal += Number;
                                    Number := 0;


                                    if SJC4New."4" <> '' then
                                        Evaluate(Number, SJC4New."4");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."4" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."4" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."4" := '0';

                                    Evaluate(Number, SJC4."4");
                                    ColorTotal += Number;
                                    Number := 0;


                                    if SJC4New."5" <> '' then
                                        Evaluate(Number, SJC4New."5");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."5" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."5" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."5" := '0';

                                    Evaluate(Number, SJC4."5");
                                    ColorTotal += Number;
                                    Number := 0;


                                    if SJC4New."6" <> '' then
                                        Evaluate(Number, SJC4New."6");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."6" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."6" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."6" := '0';

                                    Evaluate(Number, SJC4."6");
                                    ColorTotal += Number;
                                    Number := 0;


                                    if SJC4New."7" <> '' then
                                        Evaluate(Number, SJC4New."7");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."7" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."7" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."7" := '0';

                                    Evaluate(Number, SJC4."7");
                                    ColorTotal += Number;
                                    Number := 0;


                                    ////////////////////////
                                    /// 
                                    if SJC4New."8" <> '' then
                                        Evaluate(Number, SJC4New."8");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."8" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."8" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."8" := '0';

                                    Evaluate(Number, SJC4."8");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."9" <> '' then
                                        Evaluate(Number, SJC4New."9");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."9" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."9" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."9" := '0';

                                    Evaluate(Number, SJC4."9");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."10" <> '' then
                                        Evaluate(Number, SJC4New."10");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."10" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."10" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."10" := '0';

                                    Evaluate(Number, SJC4."10");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."11" <> '' then
                                        Evaluate(Number, SJC4New."11");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."11" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."11" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."11" := '0';

                                    Evaluate(Number, SJC4."11");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."12" <> '' then
                                        Evaluate(Number, SJC4New."12");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."12" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."12" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."12" := '0';

                                    Evaluate(Number, SJC4."12");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."13" <> '' then
                                        Evaluate(Number, SJC4New."13");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."13" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."13" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."13" := '0';

                                    Evaluate(Number, SJC4."13");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."14" <> '' then
                                        Evaluate(Number, SJC4New."14");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."14" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."14" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."14" := '0';

                                    Evaluate(Number, SJC4."14");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."15" <> '' then
                                        Evaluate(Number, SJC4New."15");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."15" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."15" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."15" := '0';

                                    Evaluate(Number, SJC4."15");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."16" <> '' then
                                        Evaluate(Number, SJC4New."16");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."16" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."16" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."16" := '0';

                                    Evaluate(Number, SJC4."16");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."17" <> '' then
                                        Evaluate(Number, SJC4New."17");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."17" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."17" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."17" := '0';

                                    Evaluate(Number, SJC4."17");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."18" <> '' then
                                        Evaluate(Number, SJC4New."18");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."18" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."18" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."18" := '0';

                                    Evaluate(Number, SJC4."18");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."19" <> '' then
                                        Evaluate(Number, SJC4New."19");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."19" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."19" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."19" := '0';

                                    Evaluate(Number, SJC4."19");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."20" <> '' then
                                        Evaluate(Number, SJC4New."20");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."20" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."20" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."20" := '0';

                                    Evaluate(Number, SJC4."20");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."21" <> '' then
                                        Evaluate(Number, SJC4New."21");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."21" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."21" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."21" := '0';

                                    Evaluate(Number, SJC4."21");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."22" <> '' then
                                        Evaluate(Number, SJC4New."22");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."22" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."22" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."22" := '0';

                                    Evaluate(Number, SJC4."22");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."23" <> '' then
                                        Evaluate(Number, SJC4New."23");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."23" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."23" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."23" := '0';

                                    Evaluate(Number, SJC4."23");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."24" <> '' then
                                        Evaluate(Number, SJC4New."24");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."24" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."24" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."24" := '0';

                                    Evaluate(Number, SJC4."24");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."25" <> '' then
                                        Evaluate(Number, SJC4New."25");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."25" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."25" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."25" := '0';

                                    Evaluate(Number, SJC4."25");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."26" <> '' then
                                        Evaluate(Number, SJC4New."26");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."26" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."26" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."26" := '0';

                                    Evaluate(Number, SJC4."26");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."27" <> '' then
                                        Evaluate(Number, SJC4New."27");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."27" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."27" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."27" := '0';

                                    Evaluate(Number, SJC4."27");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."28" <> '' then
                                        Evaluate(Number, SJC4New."28");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."28" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."28" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."28" := '0';

                                    Evaluate(Number, SJC4."28");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 

                                    if SJC4New."29" <> '' then
                                        Evaluate(Number, SJC4New."29");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."29" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."29" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."29" := '0';

                                    Evaluate(Number, SJC4."29");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."30" <> '' then
                                        Evaluate(Number, SJC4New."30");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."30" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."30" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."30" := '0';

                                    Evaluate(Number, SJC4."30");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."31" <> '' then
                                        Evaluate(Number, SJC4New."31");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."31" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."31" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."31" := '0';

                                    Evaluate(Number, SJC4."31");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."32" <> '' then
                                        Evaluate(Number, SJC4New."32");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."32" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."32" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."32" := '0';

                                    Evaluate(Number, SJC4."32");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."33" <> '' then
                                        Evaluate(Number, SJC4New."33");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."33" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."33" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."33" := '0';

                                    Evaluate(Number, SJC4."33");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."34" <> '' then
                                        Evaluate(Number, SJC4New."34");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."34" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."34" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."34" := '0';

                                    Evaluate(Number, SJC4."34");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."35" <> '' then
                                        Evaluate(Number, SJC4New."35");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."35" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."35" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."35" := '0';

                                    Evaluate(Number, SJC4."35");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."36" <> '' then
                                        Evaluate(Number, SJC4New."36");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."36" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."36" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."36" := '0';

                                    Evaluate(Number, SJC4."36");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."37" <> '' then
                                        Evaluate(Number, SJC4New."37");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."37" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."37" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."37" := '0';

                                    Evaluate(Number, SJC4."37");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."38" <> '' then
                                        Evaluate(Number, SJC4New."38");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."38" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."38" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."38" := '0';

                                    Evaluate(Number, SJC4."38");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."39" <> '' then
                                        Evaluate(Number, SJC4New."39");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."39" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."39" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."39" := '0';

                                    Evaluate(Number, SJC4."39");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."40" <> '' then
                                        Evaluate(Number, SJC4New."40");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."40" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."40" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."40" := '0';

                                    Evaluate(Number, SJC4."40");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."41" <> '' then
                                        Evaluate(Number, SJC4New."41");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."41" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."41" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."41" := '0';

                                    Evaluate(Number, SJC4."41");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."42" <> '' then
                                        Evaluate(Number, SJC4New."42");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."42" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."42" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."42" := '0';

                                    Evaluate(Number, SJC4."42");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."43" <> '' then
                                        Evaluate(Number, SJC4New."43");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."43" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."43" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."43" := '0';

                                    Evaluate(Number, SJC4."43");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////
                                    /// 
                                    if SJC4New."44" <> '' then
                                        Evaluate(Number, SJC4New."44");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."44" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."44" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."44" := '0';

                                    Evaluate(Number, SJC4."44");
                                    ColorTotal += Number;
                                    Number := 0;

                                    ////////////////////////                                    
                                    if SJC4New."45" <> '' then
                                        Evaluate(Number, SJC4New."45");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."45" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."45" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."45" := '0';

                                    Evaluate(Number, SJC4."45");
                                    ColorTotal += Number;
                                    Number := 0;

                                    ////////////////////////                                    
                                    if SJC4New."46" <> '' then
                                        Evaluate(Number, SJC4New."46");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."46" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."46" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."46" := '0';

                                    Evaluate(Number, SJC4."46");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."47" <> '' then
                                        Evaluate(Number, SJC4New."47");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."47" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."47" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."47" := '0';

                                    Evaluate(Number, SJC4."47");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."48" <> '' then
                                        Evaluate(Number, SJC4New."48");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."48" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."48" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."48" := '0';

                                    Evaluate(Number, SJC4."48");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."49" <> '' then
                                        Evaluate(Number, SJC4New."49");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."49" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."49" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."49" := '0';

                                    Evaluate(Number, SJC4."49");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."50" <> '' then
                                        Evaluate(Number, SJC4New."50");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."50" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."50" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."50" := '0';

                                    Evaluate(Number, SJC4."50");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."51" <> '' then
                                        Evaluate(Number, SJC4New."51");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."51" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."51" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."51" := '0';

                                    Evaluate(Number, SJC4."51");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."52" <> '' then
                                        Evaluate(Number, SJC4New."52");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."52" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."52" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."52" := '0';

                                    Evaluate(Number, SJC4."52");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."53" <> '' then
                                        Evaluate(Number, SJC4New."53");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."53" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."53" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."53" := '0';

                                    Evaluate(Number, SJC4."53");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."54" <> '' then
                                        Evaluate(Number, SJC4New."54");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."54" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."54" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."54" := '0';

                                    Evaluate(Number, SJC4."54");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."55" <> '' then
                                        Evaluate(Number, SJC4New."55");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."55" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."55" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."55" := '0';

                                    Evaluate(Number, SJC4."55");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."56" <> '' then
                                        Evaluate(Number, SJC4New."56");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."56" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."56" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."56" := '0';

                                    Evaluate(Number, SJC4."56");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."57" <> '' then
                                        Evaluate(Number, SJC4New."57");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."57" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."57" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."57" := '0';

                                    Evaluate(Number, SJC4."57");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."58" <> '' then
                                        Evaluate(Number, SJC4New."58");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."58" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."58" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."58" := '0';

                                    Evaluate(Number, SJC4."58");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."59" <> '' then
                                        Evaluate(Number, SJC4New."59");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."59" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."59" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."59" := '0';

                                    Evaluate(Number, SJC4."59");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."60" <> '' then
                                        Evaluate(Number, SJC4New."60");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."60" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."60" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."60" := '0';

                                    Evaluate(Number, SJC4."60");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."61" <> '' then
                                        Evaluate(Number, SJC4New."61");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."61" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."61" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."61" := '0';

                                    Evaluate(Number, SJC4."61");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."62" <> '' then
                                        Evaluate(Number, SJC4New."62");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."62" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."62" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."62" := '0';

                                    Evaluate(Number, SJC4."62");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."63" <> '' then
                                        Evaluate(Number, SJC4New."63");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."63" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."63" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."63" := '0';

                                    Evaluate(Number, SJC4."63");
                                    ColorTotal += Number;
                                    Number := 0;
                                    ////////////////////////                                    
                                    if SJC4New."64" <> '' then
                                        Evaluate(Number, SJC4New."64");

                                    if Number <> 0 then
                                        if Balance MOD (TempQty / Number) <> 0 then
                                            SJC4."64" := format((Balance DIV (TempQty / Number)) + 1)
                                        else
                                            SJC4."64" := format(Balance DIV (TempQty / Number))
                                    else
                                        SJC4."64" := '0';

                                    Evaluate(Number, SJC4."64");
                                    ColorTotal += Number;
                                    Number := 0;
                                    SJC4."Color Total" := ColorTotal;
                                    SJC4.Insert();

                                    CurrPage.Update();
                                end;

                            end
                            else
                                Error('Invalid colour');
                        end
                        else
                            Error('Select a machine line.');

                    end;
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Caption = 'PO No';
                }

                field(ShipDate; ShipDate)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Ship Date';
                    Editable = false;
                }

                field("Plan Date"; "Plan Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }

                field("Plan Target"; "Plan Target")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Caption = 'Order Qty';
                }

                field("Color Total"; "Color Total")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }

                field("1"; "1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible1;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }
                field("2"; "2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible2;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("3"; "3")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible3;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("4"; "4")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible4;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("5"; "5")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible5;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("6"; "6")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible6;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("7"; "7")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible7;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("8"; "8")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible8;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("9"; "9")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible9;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("10"; "10")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible10;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("11"; "11")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible11;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("12"; "12")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible12;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("13"; "13")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible13;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("14"; "14")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible14;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("15"; "15")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible15;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("16"; "16")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible16;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("17"; "17")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible17;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("18"; "18")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible18;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("19"; "19")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible19;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("20"; "20")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible20;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("21"; "21")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible21;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("22"; "22")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible22;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("23"; "23")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible23;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("24"; "24")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible24;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("25"; "25")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible25;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("26"; "26")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible26;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("27"; "27")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible27;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("28"; "28")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible28;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("29"; "29")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible29;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("30"; "30")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible30;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("31"; "31")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible31;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("32"; "32")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible32;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("33"; "33")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible33;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("34"; "34")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible34;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("35"; "35")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible35;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("36"; "36")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible36;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("37"; "37")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible37;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("38"; "38")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible38;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("39"; "39")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible39;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("40"; "40")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible40;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("41"; "41")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible41;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("42"; "42")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible42;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("43"; "43")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible43;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("44"; "44")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible44;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("45"; "45")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible45;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("46"; "46")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible46;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }


                field("47"; "47")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible47;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("48"; "48")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible48;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("49"; "49")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible49;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("50"; "50")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible50;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("51"; "51")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible51;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("52"; "52")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible52;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("53"; "53")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible53;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("54"; "54")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible54;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("55"; "55")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible55;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("56"; "56")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible56;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("57"; "57")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible57;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("58"; "58")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible58;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("59"; "59")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible59;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("60"; "60")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible60;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("61"; "61")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible61;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("62"; "62")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible62;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("63"; "63")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible63;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

                field("64"; "64")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Visible = SetVisible64;

                    trigger OnValidate()
                    var
                    begin
                        CalTotal();
                    end;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Group")
            {
                ApplicationArea = All;
                Image = Relationship;

                trigger OnAction();
                var
                    SewJobCreLine4Rec: Record SewingJobCreationLine4;
                    GroupMasterRec: Record GroupMaster;
                    SewJobCreRec: Record SewingJobCreation;
                    GroupID: BigInteger;
                    LineNo: BigInteger;
                    Number1: Decimal;
                    Number2: Decimal;
                    ColorTotal: Decimal;
                begin

                    //Get Max Group ID
                    GroupMasterRec.Reset();

                    if GroupMasterRec.FindLast() then
                        GroupID := GroupMasterRec."Group ID";

                    GroupID += 1;

                    //Get selected records
                    SewJobCreLine4Rec.Reset();
                    SewJobCreLine4Rec.SetRange("SJCNo.", "SJCNo.");
                    SewJobCreLine4Rec.SetRange(Select, true);

                    if SewJobCreLine4Rec.FindSet() then begin

                        repeat

                            if (SewJobCreLine4Rec."Group ID" = 0) and (SewJobCreLine4Rec."Record Type" = 'L') then begin

                                //Update Master table - group id 
                                SewJobCreRec.Reset();
                                SewJobCreRec.SetRange("SJCNo", "SJCNo.");
                                SewJobCreRec.FindSet();
                                SewJobCreRec.ModifyAll("Group ID", GroupID);

                                //Check for existance
                                GroupMasterRec.Reset();
                                GroupMasterRec.SetRange("Group ID", GroupID);

                                if not GroupMasterRec.FindSet() then begin

                                    //Create new group
                                    GroupMasterRec.Reset();
                                    GroupMasterRec.Init();
                                    GroupMasterRec."Group ID" := GroupID;
                                    GroupMasterRec."Style No." := "Style No.";
                                    GroupMasterRec."Style Name" := "Style Name";
                                    GroupMasterRec.Insert();

                                end;

                                //Update Group id SewJobCreLine4Rec table                            
                                SewJobCreLine4Rec.ModifyAll("Group ID", GroupID);

                            end;

                        until SewJobCreLine4Rec.Next() = 0;

                    end
                    else
                        Error('Select lines.');

                    //Set select flag to 'False'
                    SewJobCreLine4Rec.Reset();
                    SewJobCreLine4Rec.SetRange("SJCNo.", "SJCNo.");
                    SewJobCreLine4Rec.SetRange(Select, true);
                    SewJobCreLine4Rec.FindSet();
                    SewJobCreLine4Rec.ModifyAll(Select, false);

                    Message('Completed');

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
        StyleExprTxt := ChangeColor.ChangeColorSJC4(Rec);

        AssoDetail.Reset();
        AssoDetail.SetRange("Style No.", "Style No.");
        AssoDetail.SetRange("Lot No.", "lot No.");
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

        if "Colour Name" = '*' then begin
            Clear(SetEdit);
            SetEdit := false;
        end
        ELSE begin
            Clear(SetEdit);
            SetEdit := true;
        end;

        //Only for the sizes
        if ("Record Type" = 'H1') or ("Colour Name" = '*') then begin
            Clear(SetEdit1);
            SetEdit1 := false;
        end
        ELSE begin
            Clear(SetEdit1);
            SetEdit1 := true;
        end;

    end;


    trigger OnAfterGetCurrRecord()
    var
        StyleMasterRec: record "Style Master";
        SewJobCreRec: Record SewingJobCreation;
        Rowcount: Integer;
        Count: Integer;
        AssoDetail: Record AssortmentDetailsInseam;
    begin
        StyleMasterRec.Reset();
        StyleMasterRec.SetRange("No.", "Style No.");

        if StyleMasterRec.FindSet() then
            StyleName := StyleMasterRec."Style No.";

        AssoDetail.Reset();
        AssoDetail.SetRange("Style No.", "Style No.");
        AssoDetail.SetRange("Lot No.", "lot No.");
        if AssoDetail.FindSet() then begin
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
        end;

        if "Colour Name" = '*' then begin
            Clear(SetEdit);
            SetEdit := false;
        end
        ELSE begin
            Clear(SetEdit);
            SetEdit := true;
        end;

        //Only for the sizes
        if ("Record Type" = 'H1') or ("Colour Name" = '*') then begin
            Clear(SetEdit1);
            SetEdit1 := false;
        end
        ELSE begin
            Clear(SetEdit1);
            SetEdit1 := true;
        end;

    end;


    procedure CalTotal()
    var
        Count: Integer;
        Number: Integer;
        Tot: Decimal;
        SJC4: Record SewingJobCreationLine4;
        MainColorTotal: Decimal;
        ColorTotalLines: Decimal;
    begin
        if "Colour Name" <> '*' then begin
            for Count := 1 To 64 do begin
                case Count of
                    1:
                        if "1" <> '' then
                            Evaluate(Number, "1")
                        else
                            Number := 0;
                    2:
                        if "2" <> '' then
                            Evaluate(Number, "2")
                        else
                            Number := 0;
                    3:
                        if "3" <> '' then
                            Evaluate(Number, "3")
                        else
                            Number := 0;
                    4:
                        if "4" <> '' then
                            Evaluate(Number, "4")
                        else
                            Number := 0;
                    5:
                        if "5" <> '' then
                            Evaluate(Number, "5")
                        else
                            Number := 0;
                    6:
                        if "6" <> '' then
                            Evaluate(Number, "6")
                        else
                            Number := 0;
                    7:
                        if "7" <> '' then
                            Evaluate(Number, "7")
                        else
                            Number := 0;
                    8:
                        if "8" <> '' then
                            Evaluate(Number, "8")
                        else
                            Number := 0;
                    9:
                        if "9" <> '' then
                            Evaluate(Number, "9")
                        else
                            Number := 0;
                    10:
                        if "10" <> '' then
                            Evaluate(Number, "10")
                        else
                            Number := 0;
                    11:
                        if "11" <> '' then
                            Evaluate(Number, "11")
                        else
                            Number := 0;
                    12:
                        if "12" <> '' then
                            Evaluate(Number, "12")
                        else
                            Number := 0;
                    13:
                        if "13" <> '' then
                            Evaluate(Number, "13")
                        else
                            Number := 0;
                    14:
                        if "14" <> '' then
                            Evaluate(Number, "14")
                        else
                            Number := 0;
                    15:
                        if "15" <> '' then
                            Evaluate(Number, "15")
                        else
                            Number := 0;
                    16:
                        if "16" <> '' then
                            Evaluate(Number, "16")
                        else
                            Number := 0;
                    17:
                        if "17" <> '' then
                            Evaluate(Number, "17")
                        else
                            Number := 0;
                    18:
                        if "18" <> '' then
                            Evaluate(Number, "18")
                        else
                            Number := 0;
                    19:
                        if "19" <> '' then
                            Evaluate(Number, "19")
                        else
                            Number := 0;
                    20:
                        if "20" <> '' then
                            Evaluate(Number, "20")
                        else
                            Number := 0;
                    21:
                        if "21" <> '' then
                            Evaluate(Number, "21")
                        else
                            Number := 0;
                    22:
                        if "22" <> '' then
                            Evaluate(Number, "22")
                        else
                            Number := 0;
                    23:
                        if "23" <> '' then
                            Evaluate(Number, "23")
                        else
                            Number := 0;
                    24:
                        if "24" <> '' then
                            Evaluate(Number, "24")
                        else
                            Number := 0;
                    25:
                        if "25" <> '' then
                            Evaluate(Number, "25")
                        else
                            Number := 0;
                    26:
                        if "26" <> '' then
                            Evaluate(Number, "26")
                        else
                            Number := 0;
                    27:
                        if "27" <> '' then
                            Evaluate(Number, "27")
                        else
                            Number := 0;
                    28:
                        if "28" <> '' then
                            Evaluate(Number, "28")
                        else
                            Number := 0;
                    29:
                        if "29" <> '' then
                            Evaluate(Number, "29")
                        else
                            Number := 0;
                    30:
                        if "30" <> '' then
                            Evaluate(Number, "30")
                        else
                            Number := 0;
                    31:
                        if "31" <> '' then
                            Evaluate(Number, "31")
                        else
                            Number := 0;
                    32:
                        if "32" <> '' then
                            Evaluate(Number, "32")
                        else
                            Number := 0;
                    33:
                        if "33" <> '' then
                            Evaluate(Number, "33")
                        else
                            Number := 0;
                    34:
                        if "34" <> '' then
                            Evaluate(Number, "34")
                        else
                            Number := 0;
                    35:
                        if "35" <> '' then
                            Evaluate(Number, "35")
                        else
                            Number := 0;
                    36:
                        if "36" <> '' then
                            Evaluate(Number, "36")
                        else
                            Number := 0;
                    37:
                        if "37" <> '' then
                            Evaluate(Number, "37")
                        else
                            Number := 0;
                    38:
                        if "38" <> '' then
                            Evaluate(Number, "38")
                        else
                            Number := 0;
                    39:
                        if "39" <> '' then
                            Evaluate(Number, "39")
                        else
                            Number := 0;
                    40:
                        if "40" <> '' then
                            Evaluate(Number, "40")
                        else
                            Number := 0;
                    41:
                        if "41" <> '' then
                            Evaluate(Number, "41")
                        else
                            Number := 0;
                    42:
                        if "42" <> '' then
                            Evaluate(Number, "42")
                        else
                            Number := 0;
                    43:
                        if "43" <> '' then
                            Evaluate(Number, "43")
                        else
                            Number := 0;
                    44:
                        if "44" <> '' then
                            Evaluate(Number, "44")
                        else
                            Number := 0;
                    45:
                        if "45" <> '' then
                            Evaluate(Number, "45")
                        else
                            Number := 0;
                    46:
                        if "46" <> '' then
                            Evaluate(Number, "46")
                        else
                            Number := 0;
                    47:
                        if "47" <> '' then
                            Evaluate(Number, "47")
                        else
                            Number := 0;
                    48:
                        if "48" <> '' then
                            Evaluate(Number, "48")
                        else
                            Number := 0;
                    49:
                        if "49" <> '' then
                            Evaluate(Number, "49")
                        else
                            Number := 0;
                    50:
                        if "50" <> '' then
                            Evaluate(Number, "50")
                        else
                            Number := 0;
                    51:
                        if "51" <> '' then
                            Evaluate(Number, "51")
                        else
                            Number := 0;
                    52:
                        if "52" <> '' then
                            Evaluate(Number, "52")
                        else
                            Number := 0;
                    53:
                        if "53" <> '' then
                            Evaluate(Number, "53")
                        else
                            Number := 0;
                    54:
                        if "54" <> '' then
                            Evaluate(Number, "54")
                        else
                            Number := 0;
                    55:
                        if "55" <> '' then
                            Evaluate(Number, "55")
                        else
                            Number := 0;
                    56:
                        if "56" <> '' then
                            Evaluate(Number, "56")
                        else
                            Number := 0;
                    57:
                        if "57" <> '' then
                            Evaluate(Number, "57")
                        else
                            Number := 0;
                    58:
                        if "58" <> '' then
                            Evaluate(Number, "58")
                        else
                            Number := 0;
                    59:
                        if "59" <> '' then
                            Evaluate(Number, "59")
                        else
                            Number := 0;
                    60:
                        if "60" <> '' then
                            Evaluate(Number, "60")
                        else
                            Number := 0;
                    61:
                        if "61" <> '' then
                            Evaluate(Number, "61")
                        else
                            Number := 0;
                    62:
                        if "62" <> '' then
                            Evaluate(Number, "62")
                        else
                            Number := 0;
                    63:
                        if "63" <> '' then
                            Evaluate(Number, "63")
                        else
                            Number := 0;
                    64:
                        if "64" <> '' then
                            Evaluate(Number, "64")
                        else
                            Number := 0;
                end;

                Tot += Number;
            end;

            "Color Total" := Tot;
            CurrPage.Update();


            if qty < "Color Total" then
                Error('Total quantity for the color is greater than the po order quantity');

            SJC4.Reset();
            SJC4.SetRange("SJCNo.", "SJCNo.");
            SJC4.SetRange("Style No.", "Style No.");
            SJC4.SetRange("Lot No.", "Lot No.");
            SJC4.SetRange("SubLotNo.", "SubLotNo.");
            SJC4.SetRange("Colour No", "Colour No");
            SJC4.SetFilter("Record Type", '=%1', 'H1');

            if SJC4.FindSet() then
                MainColorTotal := SJC4.Qty;

            SJC4.Reset();
            SJC4.SetRange("SJCNo.", "SJCNo.");
            SJC4.SetRange("Style No.", "Style No.");
            SJC4.SetRange("Lot No.", "Lot No.");
            SJC4.SetRange("SubLotNo.", "SubLotNo.");
            SJC4.SetRange("Colour No", "Colour No");
            SJC4.SetFilter("Record Type", '=%1', 'L');

            if SJC4.FindSet() then begin
                repeat
                    ColorTotalLines += SJC4."Color Total";
                until SJC4.Next() = 0;
            end;

            if MainColorTotal < ColorTotalLines then
                Error('PO colour quantity excceds Total colour total');

        end;

    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit: Boolean;
        SetEdit1: Boolean;
        StyleName: Text[50];
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


    trigger OnInit()
    var

    begin
        SetEdit := true;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        SJC4: Record SewingJobCreationLine4;
        GroupMasterRec: Record GroupMaster;
        GroupMaster1Rec: Record GroupMaster;
        QuestionH: Text;
        QuestionL: Text;
        TextH: Label 'This will erase all the records for "LOT" %1 in "DAILY LINE REQUIRMENT". Do you want to delete?';
        TextL: Label 'This will erase all the records for "SUB LOT" %1 "DAILY LINE REQUIRMENT". Do you want to delete?';
        RatioRec: Record RatioCreation;
    begin

        if ("Record Type" = 'L') then begin

            RatioRec.Reset();
            RatioRec.SetRange("Style Name", "Style No.");
            RatioRec.SetRange("Group ID", "Group ID");
            RatioRec.SetRange("Colour No", "Colour No");

            if RatioRec.FindSet() then begin
                Message('Cannot delete. Ratio already created for the style %1 ,Group ID %2 , Color %3 ', "Style Name", "Group ID", "Colour Name");
                exit(false);
            end;

            //Check for the group id count
            SJC4.Reset();
            SJC4.SetRange("SJCNo.", "SJCNo.");
            SJC4.SetRange("Style No.", "Style No.");
            SJC4.SetRange("Group ID", "Group ID");

            if SJC4.FindSet() then begin
                if SJC4.Count = 1 then begin

                    //delete group master record
                    GroupMasterRec.Reset();
                    GroupMasterRec.SetRange("Style No.", "Style No.");
                    GroupMasterRec.SetRange("Group ID", "Group ID");
                    if GroupMasterRec.FindSet() then
                        GroupMasterRec.DeleteAll();

                end;
            end;
        end;


        if ("Record Type" = 'H') or ("Record Type" = 'H1') then begin
            QuestionH := TextH;

            if (Dialog.Confirm(QuestionH, true, "Lot No.") = true) then begin

                //Check whether ratio created or not
                SJC4.Reset();
                SJC4.SetRange("SJCNo.", "SJCNo.");
                SJC4.SetRange("Style No.", "Style No.");
                SJC4.SetRange("Lot No.", "Lot No.");
                SJC4.SetRange("SubLotNo.", "SubLotNo.");
                SJC4.SetFilter("Record Type", '=%1', 'L');

                if SJC4.FindSet() then begin
                    repeat
                        RatioRec.Reset();
                        RatioRec.SetRange("Style No.", "Style No.");
                        RatioRec.SetRange("Group ID", SJC4."Group ID");
                        RatioRec.SetRange("Colour No", SJC4."Colour No");

                        if RatioRec.FindSet() then begin
                            Message('Cannot delete. Ratio already created for the style %1 ,Group ID %2 , Color %3 ', "Style Name", SJC4."Group ID", SJC4."Colour Name");
                            exit(false);
                        end;
                    until SJC4.Next() = 0;
                end;


                //Delete "DAILY LINE REQUIRMENT"
                SJC4.Reset();
                SJC4.SetRange("SJCNo.", "SJCNo.");
                SJC4.SetRange("Style No.", "Style No.");
                SJC4.SetRange("Lot No.", "Lot No.");
                if SJC4.FindSet() then
                    SJC4.DeleteAll();


                //Get all the groups for the style
                GroupMasterRec.Reset();
                GroupMasterRec.SetRange("Style No.", "Style No.");

                if GroupMasterRec.FindSet() then begin

                    repeat
                        SJC4.Reset();
                        SJC4.SetRange("SJCNo.", "SJCNo.");
                        SJC4.SetRange("Style No.", "Style No.");
                        SJC4.SetRange("Group ID", GroupMasterRec."Group ID");

                        if not SJC4.FindSet() then begin

                            //delete group master record
                            GroupMaster1Rec.Reset();
                            GroupMaster1Rec.SetRange("Style No.", "Style No.");
                            GroupMaster1Rec.SetRange("Group ID", GroupMasterRec."Group ID");
                            if GroupMaster1Rec.FindSet() then
                                GroupMaster1Rec.DeleteAll();

                        end;

                    until GroupMasterRec.Next() = 0;

                end;
                // Message('Completed');
            end
            else
                exit(false);
        end

    end;

}