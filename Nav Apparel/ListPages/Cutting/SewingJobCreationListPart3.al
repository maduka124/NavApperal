page 50591 "Sewing Job Creation ListPart3"
{
    PageType = ListPart;
    SourceTable = SewingJobCreationLine3;
    SourceTableView = sorting("SJCNo.", "Style No.", "Lot No.", LineNo) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit;
                    Caption = 'Lot No';

                    trigger OnValidate()
                    var
                        AssoRec: Record AssorColorSizeRatio;
                        StyleMasterPORec: Record "Style Master PO";
                        SJC3: Record SewingJobCreationLine3;
                        ShipDate1: Date;
                        pono: Code[20];
                        Status: Boolean;
                    begin

                        SJC3.Reset();
                        SJC3.SetRange("SJCNo.", Rec."SJCNo.");
                        //SJC3.SetFilter("Lot No.", '<>%1', "Lot No.");
                        SJC3.SetFilter("Lot No.", '<>%1&<>%2', Rec."Lot No.", '');
                        if SJC3.FindSet() then
                            Error('You cannot put two different Lot Nos.');


                        Rec."Style Name" := StyleName;

                        //Get Po details
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", Rec."Style No.");
                        StyleMasterPORec.SetRange("Lot No.", Rec."Lot No.");

                        if StyleMasterPORec.FindSet() then begin
                            ShipDate1 := StyleMasterPORec."Ship Date";
                            pono := StyleMasterPORec."PO No.";
                        end;


                        SJC3.Reset();
                        SJC3.SetRange("SJCNo.", Rec."SJCNo.");
                        SJC3.SetRange("Style No.", Rec."Style No.");
                        SJC3.SetRange("Lot No.", Rec."Lot No.");
                        SJC3.SetFilter("Record Type", '=%1', 'H');

                        if not SJC3.FindSet() then begin

                            //Get Color size details
                            AssoRec.Reset();
                            AssoRec.SetRange("Style No.", Rec."Style No.");
                            AssoRec.SetRange("Lot No.", Rec."Lot No.");

                            if AssoRec.FindSet() then begin

                                repeat

                                    if (AssoRec."Colour No" = '*') and (Status = false) then begin

                                        Rec."Colour No" := AssoRec."Colour No";
                                        Rec."Colour Name" := AssoRec."Colour Name";
                                        Rec.ShipDate := ShipDate1;
                                        Rec."Country Code" := AssoRec."Country Code";
                                        Rec."Country Name" := AssoRec."Country Name";
                                        Rec."PO No." := pono;
                                        Rec."1" := AssoRec."1";
                                        Rec."2" := AssoRec."2";
                                        Rec."3" := AssoRec."3";
                                        Rec."4" := AssoRec."4";
                                        Rec."5" := AssoRec."5";
                                        Rec."6" := AssoRec."6";
                                        Rec."7" := AssoRec."7";
                                        Rec."8" := AssoRec."8";
                                        Rec."9" := AssoRec."9";
                                        Rec."10" := AssoRec."10";
                                        Rec."11" := AssoRec."11";
                                        Rec."12" := AssoRec."12";
                                        Rec."13" := AssoRec."13";
                                        Rec."14" := AssoRec."14";
                                        Rec."15" := AssoRec."15";
                                        Rec."16" := AssoRec."16";
                                        Rec."17" := AssoRec."17";
                                        Rec."18" := AssoRec."18";
                                        Rec."19" := AssoRec."19";
                                        Rec."20" := AssoRec."20";
                                        Rec."21" := AssoRec."21";
                                        Rec."22" := AssoRec."22";
                                        Rec."23" := AssoRec."23";
                                        Rec."24" := AssoRec."24";
                                        Rec."25" := AssoRec."25";
                                        Rec."26" := AssoRec."26";
                                        Rec."27" := AssoRec."27";
                                        Rec."28" := AssoRec."28";
                                        Rec."29" := AssoRec."29";
                                        Rec."30" := AssoRec."30";
                                        Rec."31" := AssoRec."31";
                                        Rec."32" := AssoRec."32";
                                        Rec."33" := AssoRec."33";
                                        Rec."34" := AssoRec."34";
                                        Rec."35" := AssoRec."35";
                                        Rec."36" := AssoRec."36";
                                        Rec."37" := AssoRec."37";
                                        Rec."38" := AssoRec."38";
                                        Rec."39" := AssoRec."39";
                                        Rec."40" := AssoRec."40";
                                        Rec."41" := AssoRec."41";
                                        Rec."42" := AssoRec."42";
                                        Rec."43" := AssoRec."43";
                                        Rec."44" := AssoRec."44";
                                        Rec."45" := AssoRec."45";
                                        Rec."46" := AssoRec."46";
                                        Rec."47" := AssoRec."47";
                                        Rec."48" := AssoRec."48";
                                        Rec."49" := AssoRec."49";
                                        Rec."50" := AssoRec."50";
                                        Rec."51" := AssoRec."51";
                                        Rec."52" := AssoRec."52";
                                        Rec."53" := AssoRec."53";
                                        Rec."54" := AssoRec."54";
                                        Rec."55" := AssoRec."55";
                                        Rec."56" := AssoRec."56";
                                        Rec."57" := AssoRec."57";
                                        Rec."58" := AssoRec."58";
                                        Rec."59" := AssoRec."59";
                                        Rec."60" := AssoRec."60";
                                        Rec."61" := AssoRec."61";
                                        Rec."62" := AssoRec."62";
                                        Rec."63" := AssoRec."63";
                                        Rec."64" := AssoRec."64";
                                        Rec."Color Total" := AssoRec.Total;
                                        Rec."Record Type" := 'H';
                                        Rec.LineNo := 1;
                                        CurrPage.Update();


                                        SJC3.Init();
                                        SJC3."SJCNo." := Rec."SJCNo.";
                                        SJC3."Style No." := Rec."Style No.";
                                        SJC3."Style Name" := Rec."Style Name";
                                        SJC3."Lot No." := Rec."Lot No.";
                                        SJC3."PO No." := pono;
                                        SJC3.ShipDate := ShipDate1;
                                        //SJC3."Record Type" := 'H1';
                                        SJC3.LineNo := 2;
                                        SJC3."Created Date" := Today;
                                        SJC3."Created User" := UserId;
                                        SJC3.Insert();

                                        Status := true;

                                    end;

                                until AssoRec.Next() = 0;

                            end;
                        end
                        else begin

                            //Get max line no
                            SJC3.Reset();
                            SJC3.SetRange("SJCNo.", Rec."SJCNo.");
                            SJC3.SetRange("Style No.", Rec."Style No.");
                            SJC3.SetRange("Lot No.", Rec."Lot No.");
                            SJC3.FindLast();

                            Rec.ShipDate := ShipDate1;
                            Rec."PO No." := pono;
                            Rec."Resource No." := SJC3."Resource No.";
                            Rec."Resource Name" := SJC3."Resource Name";
                            Rec.LineNo := SJC3.LineNo + 1;
                            Rec."Created Date" := Today;
                            Rec."Created User" := UserId;
                            CurrPage.Update();

                        end;

                    end;
                }

                field("SubLotNo."; Rec."SubLotNo.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                    Caption = 'Sub Lot No';
                }

                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Line';

                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                    begin
                        if Rec."SubLotNo." = '' then
                            Error('SubLotNo is blank');

                        //Get Po details
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetFilter("Planning Line", '=%1', true);
                        WorkCenterRec.SetRange(Name, Rec."Resource Name");

                        if WorkCenterRec.FindSet() then
                            Rec."Resource No." := WorkCenterRec."No.";

                        CurrPage.Update();
                    end;
                }

                field("Colour Name"; Rec."Colour Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Colour';

                    trigger OnValidate()
                    var
                        AssoRec: Record AssorColorSizeRatio;
                        colorRec: Record Colour;
                        StyleMasterPORec: Record "Style Master PO";
                        SJC3: Record SewingJobCreationLine3;
                        WastageRec: Record Wastage;
                        Waistage: Decimal;
                        ShipDate: Date;
                        pono: Code[20];
                        Number: Decimal;
                        ColorTotal: Decimal;
                    begin

                        if Rec."Colour Name" <> '*' then begin

                            //Check for different colors 
                            SJC3.Reset();
                            SJC3.SetRange("SJCNo.", Rec."SJCNo.");
                            SJC3.SetRange("Style No.", Rec."Style No.");
                            SJC3.SetRange("Lot No.", Rec."Lot No.");
                            SJC3.SetFilter("Colour Name", '<>%1&<>%2&<>%3', Rec."Colour Name", '*', '');

                            if SJC3.FindSet() then
                                Error('You cannot use two different colors in one sub scheduling.');


                            //Get color name
                            colorRec.Reset();
                            colorRec.SetRange("Colour Name", Rec."Colour Name");

                            if colorRec.FindSet() then begin
                                Rec."Colour No" := colorRec."No.";
                                CurrPage.Update();

                                //Get Po details
                                StyleMasterPORec.Reset();
                                StyleMasterPORec.SetRange("Style No.", Rec."Style No.");
                                StyleMasterPORec.SetRange("Lot No.", Rec."Lot No.");

                                if StyleMasterPORec.FindSet() then begin

                                    //Get the wastage from wastage table
                                    WastageRec.Reset();
                                    WastageRec.SetFilter("Start Qty", '<=%1', StyleMasterPORec.Qty);
                                    WastageRec.SetFilter("Finish Qty", '>=%1', StyleMasterPORec.Qty);

                                    if WastageRec.FindSet() then
                                        Waistage := WastageRec.Percentage;

                                    ShipDate := StyleMasterPORec."Ship Date";
                                    pono := StyleMasterPORec."PO No.";

                                end;
                                CurrPage.Update();

                                SJC3.Reset();
                                SJC3.SetRange("SJCNo.", Rec."SJCNo.");
                                SJC3.SetRange("Style No.", Rec."Style No.");
                                SJC3.SetRange("Lot No.", Rec."Lot No.");
                                SJC3.SetRange("Colour No", colorRec."No.");
                                SJC3.SetRange("Record Type", 'H1');

                                if not SJC3.FindSet() then begin
                                    Rec."Record Type" := 'H1';
                                end
                                else
                                    Rec."Record Type" := 'L';

                                CurrPage.Update();

                                //Get Color size details
                                AssoRec.Reset();
                                AssoRec.SetRange("Style No.", Rec."Style No.");
                                AssoRec.SetRange("Lot No.", Rec."Lot No.");
                                AssoRec.SetRange("Colour No", colorRec."No.");

                                if AssoRec.FindSet() then begin

                                    Rec.Qty := AssoRec.Qty + (AssoRec.Qty * Waistage) / 100;
                                    Rec.Qty := round(Rec.Qty, 1);

                                    if Rec."Record Type" = 'H1' then begin
                                        if AssoRec."1" <> '' then
                                            Evaluate(Number, AssoRec."1");

                                        Rec."1" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."2" <> '' then
                                            Evaluate(Number, AssoRec."2");

                                        Rec."2" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."3" <> '' then
                                            Evaluate(Number, AssoRec."3");

                                        Rec."3" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."4" <> '' then
                                            Evaluate(Number, AssoRec."4");

                                        Rec."4" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."5" <> '' then
                                            Evaluate(Number, AssoRec."5");

                                        Rec."5" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."6" <> '' then
                                            Evaluate(Number, AssoRec."6");

                                        Rec."6" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);

                                        Number := 0;
                                        if AssoRec."7" <> '' then
                                            Evaluate(Number, AssoRec."7");

                                        Rec."7" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."8" <> '' then
                                            Evaluate(Number, AssoRec."8");

                                        Rec."8" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."9" <> '' then
                                            Evaluate(Number, AssoRec."9");

                                        Rec."9" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."10" <> '' then
                                            Evaluate(Number, AssoRec."10");

                                        Rec."10" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."11" <> '' then
                                            Evaluate(Number, AssoRec."11");

                                        Rec."11" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."12" <> '' then
                                            Evaluate(Number, AssoRec."12");

                                        Rec."12" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."13" <> '' then
                                            Evaluate(Number, AssoRec."13");

                                        Rec."13" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."14" <> '' then
                                            Evaluate(Number, AssoRec."14");

                                        Rec."14" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);

                                        Number := 0;
                                        if AssoRec."15" <> '' then
                                            Evaluate(Number, AssoRec."15");

                                        Rec."15" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."16" <> '' then
                                            Evaluate(Number, AssoRec."16");

                                        Rec."16" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."17" <> '' then
                                            Evaluate(Number, AssoRec."17");

                                        Rec."17" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."18" <> '' then
                                            Evaluate(Number, AssoRec."18");

                                        Rec."18" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."19" <> '' then
                                            Evaluate(Number, AssoRec."19");

                                        Rec."19" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."20" <> '' then
                                            Evaluate(Number, AssoRec."20");

                                        Rec."20" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."21" <> '' then
                                            Evaluate(Number, AssoRec."21");

                                        Rec."21" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."22" <> '' then
                                            Evaluate(Number, AssoRec."22");

                                        Rec."22" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);

                                        Number := 0;
                                        if AssoRec."23" <> '' then
                                            Evaluate(Number, AssoRec."23");

                                        Rec."23" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."24" <> '' then
                                            Evaluate(Number, AssoRec."24");

                                        Rec."24" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."25" <> '' then
                                            Evaluate(Number, AssoRec."25");

                                        Rec."25" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."26" <> '' then
                                            Evaluate(Number, AssoRec."26");

                                        Rec."26" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."27" <> '' then
                                            Evaluate(Number, AssoRec."27");

                                        Rec."27" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."28" <> '' then
                                            Evaluate(Number, AssoRec."28");

                                        Rec."28" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."29" <> '' then
                                            Evaluate(Number, AssoRec."29");

                                        Rec."29" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."30" <> '' then
                                            Evaluate(Number, AssoRec."30");

                                        Rec."30" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);

                                        Number := 0;
                                        if AssoRec."31" <> '' then
                                            Evaluate(Number, AssoRec."31");

                                        Rec."31" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."32" <> '' then
                                            Evaluate(Number, AssoRec."32");

                                        Rec."32" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."33" <> '' then
                                            Evaluate(Number, AssoRec."33");

                                        Rec."33" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."34" <> '' then
                                            Evaluate(Number, AssoRec."34");

                                        Rec."34" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."35" <> '' then
                                            Evaluate(Number, AssoRec."35");

                                        Rec."35" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."36" <> '' then
                                            Evaluate(Number, AssoRec."36");

                                        Rec."36" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."37" <> '' then
                                            Evaluate(Number, AssoRec."37");

                                        Rec."37" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."38" <> '' then
                                            Evaluate(Number, AssoRec."38");

                                        Rec."38" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);

                                        Number := 0;
                                        if AssoRec."39" <> '' then
                                            Evaluate(Number, AssoRec."39");

                                        Rec."39" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."40" <> '' then
                                            Evaluate(Number, AssoRec."40");

                                        Rec."40" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."41" <> '' then
                                            Evaluate(Number, AssoRec."41");

                                        Rec."41" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."42" <> '' then
                                            Evaluate(Number, AssoRec."42");

                                        Rec."42" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."43" <> '' then
                                            Evaluate(Number, AssoRec."43");

                                        Rec."43" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."44" <> '' then
                                            Evaluate(Number, AssoRec."44");

                                        Rec."44" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."45" <> '' then
                                            Evaluate(Number, AssoRec."45");

                                        Rec."45" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."46" <> '' then
                                            Evaluate(Number, AssoRec."46");

                                        Rec."46" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);

                                        Number := 0;
                                        if AssoRec."47" <> '' then
                                            Evaluate(Number, AssoRec."47");

                                        Rec."47" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."48" <> '' then
                                            Evaluate(Number, AssoRec."48");

                                        Rec."48" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."49" <> '' then
                                            Evaluate(Number, AssoRec."49");

                                        Rec."49" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."50" <> '' then
                                            Evaluate(Number, AssoRec."50");

                                        Rec."50" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."51" <> '' then
                                            Evaluate(Number, AssoRec."51");

                                        Rec."51" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."52" <> '' then
                                            Evaluate(Number, AssoRec."52");

                                        Rec."52" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."53" <> '' then
                                            Evaluate(Number, AssoRec."53");

                                        Rec."53" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."54" <> '' then
                                            Evaluate(Number, AssoRec."54");

                                        Rec."54" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);

                                        Number := 0;
                                        if AssoRec."55" <> '' then
                                            Evaluate(Number, AssoRec."55");

                                        Rec."55" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."56" <> '' then
                                            Evaluate(Number, AssoRec."56");

                                        Rec."56" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."57" <> '' then
                                            Evaluate(Number, AssoRec."57");

                                        Rec."57" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."58" <> '' then
                                            Evaluate(Number, AssoRec."58");

                                        Rec."58" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."59" <> '' then
                                            Evaluate(Number, AssoRec."59");

                                        Rec."59" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."60" <> '' then
                                            Evaluate(Number, AssoRec."60");

                                        Rec."60" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."61" <> '' then
                                            Evaluate(Number, AssoRec."61");

                                        Rec."61" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."62" <> '' then
                                            Evaluate(Number, AssoRec."62");

                                        Rec."62" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);

                                        Number := 0;
                                        if AssoRec."63" <> '' then
                                            Evaluate(Number, AssoRec."63");

                                        Rec."63" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                        if AssoRec."64" <> '' then
                                            Evaluate(Number, AssoRec."64");

                                        Rec."64" := format(Number + round((Number * Waistage) / 100, 1));
                                        ColorTotal += Number + round((Number * Waistage) / 100, 1);
                                        Number := 0;

                                    end;

                                    Rec."Color Total" := ColorTotal;
                                end;

                                CurrPage.Update();

                            end;

                        end
                        else
                            Error('Invalid colour');
                    end;
                }

                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Caption = 'PO No';
                }

                field(ShipDate; Rec.ShipDate)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Ship Date';
                    Editable = false;
                }

                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                    Caption = 'Order Qty';
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
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
                        CalTotal();
                    end;
                }

            }
        }
    }


    trigger OnAfterGetRecord()
    var
        Rowcount: Integer;
        Count: Integer;
        AssoDetail: Record AssortmentDetailsInseam;
    begin
        StyleExprTxt := ChangeColor.ChangeColorSJC(Rec);

        AssoDetail.Reset();
        AssoDetail.SetRange("Style No.", Rec."Style No.");
        AssoDetail.SetRange("Lot No.", Rec."lot No.");
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


        if Rec."Colour Name" = '*' then begin
            Clear(SetEdit);
            SetEdit := false;
        end
        ELSE begin
            Clear(SetEdit);
            SetEdit := true;
        end;

        //Only for the sizes
        if (Rec."Record Type" = 'H1') or (Rec."Colour Name" = '*') then begin
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
        Rowcount: Integer;
        Count: Integer;
        AssoDetail: Record AssortmentDetailsInseam;
    begin
        StyleMasterRec.Reset();
        StyleMasterRec.SetRange("No.", Rec."Style No.");

        if StyleMasterRec.FindSet() then
            StyleName := StyleMasterRec."Style No.";

        AssoDetail.Reset();
        AssoDetail.SetRange("Style No.", Rec."Style No.");
        AssoDetail.SetRange("Lot No.", Rec."lot No.");

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

        if Rec."Colour Name" = '*' then begin
            Clear(SetEdit);
            SetEdit := false;
        end
        ELSE begin
            Clear(SetEdit);
            SetEdit := true;
        end;

        //Only for the sizes
        if (Rec."Record Type" = 'H1') or (Rec."Colour Name" = '*') then begin
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
        SJC3: Record SewingJobCreationLine3;
        MainColorTotal: Decimal;
        ColorTotalLines: Decimal;
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

                Tot += Number;
            end;

            Rec."Color Total" := Tot;
            CurrPage.Update();


            if Rec.qty < Rec."Color Total" then
                Error('Total quantity for the color is greater than the po order quantity');

            SJC3.Reset();
            SJC3.SetRange("SJCNo.", Rec."SJCNo.");
            SJC3.SetRange("Style No.", Rec."Style No.");
            SJC3.SetRange("Lot No.", Rec."Lot No.");
            SJC3.SetRange("Colour No", Rec."Colour No");
            SJC3.SetFilter("Record Type", '=%1', 'H1');

            if SJC3.FindSet() then
                MainColorTotal := SJC3.Qty;

            SJC3.Reset();
            SJC3.SetRange("SJCNo.", Rec."SJCNo.");
            SJC3.SetRange("Style No.", Rec."Style No.");
            SJC3.SetRange("Lot No.", Rec."Lot No.");
            SJC3.SetRange("Colour No", Rec."Colour No");
            SJC3.SetFilter("Record Type", '=%1', 'L');

            if SJC3.FindSet() then begin
                repeat
                    ColorTotalLines += SJC3."Color Total";
                until SJC3.Next() = 0;
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
        SJC3: Record SewingJobCreationLine3;
        SJC4: Record SewingJobCreationLine4;
        RatioRec: Record RatioCreation;
        QuestionH: Text;
        QuestionL: Text;
        TextH: Label 'This will erase all the records for "LOT" %1 in "SUB SCHEDULING" and "DAILY LINE REQUIRMENT". Do you want to delete?';
        TextL: Label 'This will erase all the records for "SUB LOT" %1 in "SUB SCHEDULING" and "DAILY LINE REQUIRMENT". Do you want to delete?';
    begin

        if (Rec."Record Type" = 'H') or (Rec."Record Type" = 'H1') then begin
            QuestionH := TextH;

            if (Dialog.Confirm(QuestionH, true, Rec."Lot No.") = true) then begin

                //Get all "L" records
                SJC3.Reset();
                SJC3.SetRange("SJCNo.", Rec."SJCNo.");
                SJC3.SetRange("Style No.", Rec."Style No.");
                SJC3.SetRange("Lot No.", Rec."Lot No.");
                SJC3.SetFilter("Record Type", '=%1', 'L');

                if SJC3.FindSet() then begin
                    repeat

                        SJC4.Reset();
                        SJC4.SetRange("SJCNo.", Rec."SJCNo.");
                        SJC4.SetRange("Style No.", Rec."Style No.");
                        SJC4.SetRange("Lot No.", SJC3."Lot No.");
                        SJC4.SetRange("SubLotNo.", SJC3."SubLotNo.");
                        SJC4.SetFilter("Record Type", '=%1', 'L');

                        if SJC4.FindSet() then begin
                            repeat
                                RatioRec.Reset();
                                RatioRec.SetRange("Style No.", Rec."Style No.");
                                RatioRec.SetRange("Group ID", SJC4."Group ID");
                                RatioRec.SetRange("Colour No", SJC4."Colour No");

                                if RatioRec.FindSet() then begin
                                    Message('Cannot delete. Ratio already created for the style %1 ,Group ID %2 , Color %3 ', Rec."Style Name", SJC4."Group ID", SJC4."Colour Name");
                                    exit(false);
                                end;
                            until SJC4.Next() = 0;
                        end;

                    until SJC3.Next() = 0;
                end;


                SJC4.Reset();
                SJC4.SetRange("SJCNo.", Rec."SJCNo.");
                SJC4.SetRange("Style No.", Rec."Style No.");
                SJC4.SetRange("Lot No.", Rec."Lot No.");
                if SJC4.FindSet() then
                    SJC4.DeleteAll();

                SJC3.Reset();
                SJC3.SetRange("SJCNo.", Rec."SJCNo.");
                SJC3.SetRange("Style No.", Rec."Style No.");
                SJC3.SetRange("Lot No.", Rec."Lot No.");
                if SJC3.FindSet() then
                    SJC3.DeleteAll();

                // Message('Completed');

            end
            else
                exit(false);

        end
        else begin

            if (Rec."Record Type" = 'L') then begin
                QuestionL := TextL;

                if (Dialog.Confirm(QuestionL, true, Rec."SubLotNo.") = true) then begin

                    SJC4.Reset();
                    SJC4.SetRange("SJCNo.", Rec."SJCNo.");
                    SJC4.SetRange("Style No.", Rec."Style No.");
                    SJC4.SetRange("Lot No.", Rec."Lot No.");
                    SJC4.SetRange("SubLotNo.", Rec."SubLotNo.");
                    SJC4.SetFilter("Record Type", '=%1', 'L');

                    if SJC4.FindSet() then begin
                        repeat
                            RatioRec.Reset();
                            RatioRec.SetRange("Style No.", Rec."Style No.");
                            RatioRec.SetRange("Group ID", SJC4."Group ID");
                            RatioRec.SetRange("Colour No", SJC4."Colour No");

                            if RatioRec.FindSet() then begin
                                Message('Cannot delete. Ratio already created for the style %1 ,Group ID %2 , Color %3 ', Rec."Style Name", SJC4."Group ID", SJC4."Colour Name");
                                exit(false);
                            end;
                        until SJC4.Next() = 0;
                    end;

                    SJC4.Reset();
                    SJC4.SetRange("SJCNo.", Rec."SJCNo.");
                    SJC4.SetRange("Style No.", Rec."Style No.");
                    SJC4.SetRange("Lot No.", Rec."Lot No.");
                    SJC4.SetRange("SubLotNo.", Rec."SubLotNo.");
                    SJC4.SetFilter("Record Type", '=%1', 'L');
                    if SJC4.FindSet() then
                        SJC4.DeleteAll();

                    //Message('Completed');

                end
                else
                    exit(false);
            end;

        end;
    end;
}