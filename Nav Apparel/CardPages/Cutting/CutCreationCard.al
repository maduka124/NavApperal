page 50599 "Cut Creation Card"
{
    PageType = Card;
    SourceTable = CutCreation;
    Caption = 'Cut Creation';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(CutCreNo; CutCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Cut Creation No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then
                            "Style No." := StyleMasterRec."No.";
                    end;
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Color';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        AssoDetailsRec: Record AssortmentDetails;
                        Colour: Code[20];
                        colorRec: Record Colour;
                    begin
                        AssoDetailsRec.RESET;
                        AssoDetailsRec.SetCurrentKey("Colour No");
                        AssoDetailsRec.SetRange("Style No.", "Style No.");

                        IF AssoDetailsRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF Colour <> AssoDetailsRec."Colour No" THEN BEGIN
                                    Colour := AssoDetailsRec."Colour No";

                                    AssoDetailsRec.MARK(TRUE);
                                END;
                            UNTIL AssoDetailsRec.NEXT = 0;
                            AssoDetailsRec.MARKEDONLY(TRUE);

                            if Page.RunModal(71012677, AssoDetailsRec) = Action::LookupOK then begin
                                "Colour No" := AssoDetailsRec."Colour No";
                                colorRec.Reset();
                                colorRec.SetRange("No.", "Colour No");
                                colorRec.FindSet();
                                "Colour Name" := colorRec."Colour Name";
                            end;

                        END;
                    END;
                }

                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        SewJobLine4Rec: Record SewingJobCreationLine4;
                    begin
                        SewJobLine4Rec.Reset();
                        SewJobLine4Rec.SetRange("Style No.", "Style No.");
                        SewJobLine4Rec.SetRange("Colour No", "Colour No");
                        SewJobLine4Rec.SetRange("Group ID", "Group ID");
                        if SewJobLine4Rec.FindSet() then
                            "Po No." := SewJobLine4Rec."PO No."
                        else
                            Error('Cannot find sewing Job details for Style/Color/Group');

                        CurrPage.Update();
                    end;
                }

                field("Po No."; "Po No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Component Group"; "Component Group")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Marker Name"; "Marker Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Marker';
                }

                field("Ply Height"; "Ply Height")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'No. of Plies';
                }
            }

            group("Ratio Creation")
            {
                part("Cut Creation Line"; "Cut Creation Line")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "CutCreNo." = FIELD(CutCreNo);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Cut Creation")
            {
                ApplicationArea = All;
                Image = Create;

                trigger OnAction()
                var
                    RatioCreLineRec: Record RatioCreationLine;
                    CutCreationLineRec: Record CutCreationLine;
                    CutCreationLine1Rec: Record CutCreationLine;
                    CutCreationRec: Record CutCreation;
                    MaxCutNo: Integer;
                    CutNo: Integer;
                    LineNo: Integer;
                    Number1: Integer;
                    ColorTotal: Decimal;
                    Nooftimes: Integer;
                    Balance: Integer;
                    Count: Integer;
                    Plies: Integer;
                begin

                    if ("Style Name" = '') then
                        Error('Invalid Style');

                    if ("Group ID" = 0) then
                        Error('Invalid Group');

                    if ("Component Group" = '') then
                        Error('Invalid Component');

                    if ("Marker Name" = '') then
                        Error('Invalid Marker Name');

                    if ("Ply Height" = 0) then
                        Error('Invalid Ply Height');


                    //Delete old records
                    CutCreationLineRec.Reset();
                    CutCreationLineRec.SetRange("CutCreNo.", CutCreNo);
                    if CutCreationLineRec.FindSet() then
                        CutCreationLineRec.DeleteAll();


                    //Get Max line no
                    CutCreationLineRec.Reset();
                    CutCreationLineRec.SetRange("CutCreNo.", CutCreNo);

                    if CutCreationLineRec.FindLast() then
                        LineNo := CutCreationLineRec."Line No";


                    //Get records for the group and component group
                    RatioCreLineRec.Reset();
                    RatioCreLineRec.SetRange("Style No.", "Style No.");
                    RatioCreLineRec.SetRange("Group ID", "Group ID");
                    RatioCreLineRec.SetRange("Component Group Code", "Component Group");
                    RatioCreLineRec.SETFILTER("Record Type", 'H|H1');

                    if RatioCreLineRec.FindSet() then begin

                        repeat

                            LineNo += 1;

                            //Insert H1 and H
                            CutCreationLineRec.Init();
                            CutCreationLineRec."CutCreNo." := CutCreNo;
                            CutCreationLineRec."Created Date" := Today;
                            CutCreationLineRec."Created User" := UserId;
                            CutCreationLineRec."Group ID" := "Group ID";
                            CutCreationLineRec."line No" := LineNo;
                            CutCreationLineRec."Cut No" := 0;
                            CutCreationLineRec."Lot No." := RatioCreLineRec."Lot No.";
                            CutCreationLineRec."PO No." := RatioCreLineRec."PO No.";
                            CutCreationLineRec.qty := 0;
                            CutCreationLineRec.Plies := RatioCreLineRec.Plies;
                            CutCreationLineRec."Record Type" := RatioCreLineRec."Record Type";
                            CutCreationLineRec."Sewing Job No." := RatioCreLineRec."Sewing Job No.";
                            CutCreationLineRec.ShipDate := RatioCreLineRec.ShipDate;
                            CutCreationLineRec."Style Name" := RatioCreLineRec."Style Name";
                            CutCreationLineRec."Style No." := RatioCreLineRec."Style No.";
                            CutCreationLineRec."SubLotNo." := RatioCreLineRec."SubLotNo.";
                            CutCreationLineRec."Component Group Code" := RatioCreLineRec."Component Group Code";
                            CutCreationLineRec."Marker Name" := "Marker Name";
                            CutCreationLineRec."Colour No" := RatioCreLineRec."Colour No";
                            CutCreationLineRec."Colour Name" := RatioCreLineRec."Colour Name";

                            CutCreationLineRec."1" := RatioCreLineRec."1";
                            CutCreationLineRec."2" := RatioCreLineRec."2";
                            CutCreationLineRec."3" := RatioCreLineRec."3";
                            CutCreationLineRec."4" := RatioCreLineRec."4";
                            CutCreationLineRec."5" := RatioCreLineRec."5";
                            CutCreationLineRec."6" := RatioCreLineRec."6";
                            CutCreationLineRec."7" := RatioCreLineRec."7";
                            CutCreationLineRec."8" := RatioCreLineRec."8";
                            CutCreationLineRec."9" := RatioCreLineRec."9";
                            CutCreationLineRec."10" := RatioCreLineRec."10";
                            CutCreationLineRec."11" := RatioCreLineRec."11";
                            CutCreationLineRec."12" := RatioCreLineRec."12";
                            CutCreationLineRec."13" := RatioCreLineRec."13";
                            CutCreationLineRec."14" := RatioCreLineRec."14";
                            CutCreationLineRec."15" := RatioCreLineRec."15";
                            CutCreationLineRec."16" := RatioCreLineRec."16";
                            CutCreationLineRec."17" := RatioCreLineRec."17";
                            CutCreationLineRec."18" := RatioCreLineRec."18";
                            CutCreationLineRec."19" := RatioCreLineRec."19";
                            CutCreationLineRec."20" := RatioCreLineRec."20";
                            CutCreationLineRec."21" := RatioCreLineRec."21";
                            CutCreationLineRec."22" := RatioCreLineRec."22";
                            CutCreationLineRec."23" := RatioCreLineRec."23";
                            CutCreationLineRec."24" := RatioCreLineRec."24";
                            CutCreationLineRec."25" := RatioCreLineRec."25";
                            CutCreationLineRec."26" := RatioCreLineRec."26";
                            CutCreationLineRec."27" := RatioCreLineRec."27";
                            CutCreationLineRec."28" := RatioCreLineRec."28";
                            CutCreationLineRec."29" := RatioCreLineRec."29";
                            CutCreationLineRec."30" := RatioCreLineRec."30";
                            CutCreationLineRec."31" := RatioCreLineRec."31";
                            CutCreationLineRec."32" := RatioCreLineRec."32";
                            CutCreationLineRec."33" := RatioCreLineRec."33";
                            CutCreationLineRec."34" := RatioCreLineRec."34";
                            CutCreationLineRec."35" := RatioCreLineRec."35";
                            CutCreationLineRec."36" := RatioCreLineRec."36";
                            CutCreationLineRec."37" := RatioCreLineRec."37";
                            CutCreationLineRec."38" := RatioCreLineRec."38";
                            CutCreationLineRec."39" := RatioCreLineRec."39";
                            CutCreationLineRec."40" := RatioCreLineRec."40";
                            CutCreationLineRec."41" := RatioCreLineRec."41";
                            CutCreationLineRec."42" := RatioCreLineRec."42";
                            CutCreationLineRec."43" := RatioCreLineRec."43";
                            CutCreationLineRec."44" := RatioCreLineRec."44";
                            CutCreationLineRec."45" := RatioCreLineRec."45";
                            CutCreationLineRec."46" := RatioCreLineRec."46";
                            CutCreationLineRec."47" := RatioCreLineRec."47";
                            CutCreationLineRec."48" := RatioCreLineRec."48";
                            CutCreationLineRec."49" := RatioCreLineRec."49";
                            CutCreationLineRec."50" := RatioCreLineRec."50";
                            CutCreationLineRec."51" := RatioCreLineRec."51";
                            CutCreationLineRec."52" := RatioCreLineRec."52";
                            CutCreationLineRec."53" := RatioCreLineRec."53";
                            CutCreationLineRec."54" := RatioCreLineRec."54";
                            CutCreationLineRec."55" := RatioCreLineRec."55";
                            CutCreationLineRec."56" := RatioCreLineRec."56";
                            CutCreationLineRec."57" := RatioCreLineRec."57";
                            CutCreationLineRec."58" := RatioCreLineRec."58";
                            CutCreationLineRec."59" := RatioCreLineRec."59";
                            CutCreationLineRec."60" := RatioCreLineRec."60";
                            CutCreationLineRec."61" := RatioCreLineRec."61";
                            CutCreationLineRec."62" := RatioCreLineRec."62";
                            CutCreationLineRec."63" := RatioCreLineRec."63";
                            CutCreationLineRec."64" := RatioCreLineRec."64";

                            CutCreationLineRec.Insert();

                        until RatioCreLineRec.Next() = 0;


                        //Get records for the selected marker
                        RatioCreLineRec.Reset();
                        RatioCreLineRec.SetRange("Style No.", "Style No.");
                        RatioCreLineRec.SetRange("Group ID", "Group ID");
                        RatioCreLineRec.SetRange("Component Group Code", "Component Group");
                        RatioCreLineRec.SETFILTER("Marker Name", "Marker Name");

                        if RatioCreLineRec.FindSet() then begin

                            Plies := RatioCreLineRec.Plies;
                            LineNo += 1;

                            CutCreationLineRec.Init();
                            CutCreationLineRec."CutCreNo." := CutCreNo;
                            CutCreationLineRec."Created Date" := Today;
                            CutCreationLineRec."Created User" := UserId;
                            CutCreationLineRec."Group ID" := "Group ID";
                            CutCreationLineRec."line No" := LineNo;
                            CutCreationLineRec."Cut No" := 0;
                            CutCreationLineRec."Lot No." := RatioCreLineRec."Lot No.";
                            CutCreationLineRec."PO No." := RatioCreLineRec."PO No.";
                            CutCreationLineRec.qty := 0;
                            CutCreationLineRec.Plies := RatioCreLineRec.Plies;
                            //CutCreationLineRec."Record Type" := RatioCreLineRec."Record Type";
                            CutCreationLineRec."Record Type" := RatioCreLineRec."Record Type";
                            CutCreationLineRec."Sewing Job No." := RatioCreLineRec."Sewing Job No.";
                            CutCreationLineRec.ShipDate := RatioCreLineRec.ShipDate;
                            CutCreationLineRec."Style Name" := RatioCreLineRec."Style Name";
                            CutCreationLineRec."Style No." := RatioCreLineRec."Style No.";
                            CutCreationLineRec."SubLotNo." := RatioCreLineRec."SubLotNo.";
                            CutCreationLineRec."Component Group Code" := RatioCreLineRec."Component Group Code";
                            CutCreationLineRec."Marker Name" := "Marker Name";
                            CutCreationLineRec."Colour No" := RatioCreLineRec."Colour No";
                            CutCreationLineRec."Colour Name" := RatioCreLineRec."Colour Name";

                            CutCreationLineRec."1" := RatioCreLineRec."1";
                            CutCreationLineRec."2" := RatioCreLineRec."2";
                            CutCreationLineRec."3" := RatioCreLineRec."3";
                            CutCreationLineRec."4" := RatioCreLineRec."4";
                            CutCreationLineRec."5" := RatioCreLineRec."5";
                            CutCreationLineRec."6" := RatioCreLineRec."6";
                            CutCreationLineRec."7" := RatioCreLineRec."7";
                            CutCreationLineRec."8" := RatioCreLineRec."8";
                            CutCreationLineRec."9" := RatioCreLineRec."9";
                            CutCreationLineRec."10" := RatioCreLineRec."10";
                            CutCreationLineRec."11" := RatioCreLineRec."11";
                            CutCreationLineRec."12" := RatioCreLineRec."12";
                            CutCreationLineRec."13" := RatioCreLineRec."13";
                            CutCreationLineRec."14" := RatioCreLineRec."14";
                            CutCreationLineRec."15" := RatioCreLineRec."15";
                            CutCreationLineRec."16" := RatioCreLineRec."16";
                            CutCreationLineRec."17" := RatioCreLineRec."17";
                            CutCreationLineRec."18" := RatioCreLineRec."18";
                            CutCreationLineRec."19" := RatioCreLineRec."19";
                            CutCreationLineRec."20" := RatioCreLineRec."20";
                            CutCreationLineRec."21" := RatioCreLineRec."21";
                            CutCreationLineRec."22" := RatioCreLineRec."22";
                            CutCreationLineRec."23" := RatioCreLineRec."23";
                            CutCreationLineRec."24" := RatioCreLineRec."24";
                            CutCreationLineRec."25" := RatioCreLineRec."25";
                            CutCreationLineRec."26" := RatioCreLineRec."26";
                            CutCreationLineRec."27" := RatioCreLineRec."27";
                            CutCreationLineRec."28" := RatioCreLineRec."28";
                            CutCreationLineRec."29" := RatioCreLineRec."29";
                            CutCreationLineRec."30" := RatioCreLineRec."30";
                            CutCreationLineRec."31" := RatioCreLineRec."31";
                            CutCreationLineRec."32" := RatioCreLineRec."32";
                            CutCreationLineRec."33" := RatioCreLineRec."33";
                            CutCreationLineRec."34" := RatioCreLineRec."34";
                            CutCreationLineRec."35" := RatioCreLineRec."35";
                            CutCreationLineRec."36" := RatioCreLineRec."36";
                            CutCreationLineRec."37" := RatioCreLineRec."37";
                            CutCreationLineRec."38" := RatioCreLineRec."38";
                            CutCreationLineRec."39" := RatioCreLineRec."39";
                            CutCreationLineRec."40" := RatioCreLineRec."40";
                            CutCreationLineRec."41" := RatioCreLineRec."41";
                            CutCreationLineRec."42" := RatioCreLineRec."42";
                            CutCreationLineRec."43" := RatioCreLineRec."43";
                            CutCreationLineRec."44" := RatioCreLineRec."44";
                            CutCreationLineRec."45" := RatioCreLineRec."45";
                            CutCreationLineRec."46" := RatioCreLineRec."46";
                            CutCreationLineRec."47" := RatioCreLineRec."47";
                            CutCreationLineRec."48" := RatioCreLineRec."48";
                            CutCreationLineRec."49" := RatioCreLineRec."49";
                            CutCreationLineRec."50" := RatioCreLineRec."50";
                            CutCreationLineRec."51" := RatioCreLineRec."51";
                            CutCreationLineRec."52" := RatioCreLineRec."52";
                            CutCreationLineRec."53" := RatioCreLineRec."53";
                            CutCreationLineRec."54" := RatioCreLineRec."54";
                            CutCreationLineRec."55" := RatioCreLineRec."55";
                            CutCreationLineRec."56" := RatioCreLineRec."56";
                            CutCreationLineRec."57" := RatioCreLineRec."57";
                            CutCreationLineRec."58" := RatioCreLineRec."58";
                            CutCreationLineRec."59" := RatioCreLineRec."59";
                            CutCreationLineRec."60" := RatioCreLineRec."60";
                            CutCreationLineRec."61" := RatioCreLineRec."61";
                            CutCreationLineRec."62" := RatioCreLineRec."62";
                            CutCreationLineRec."63" := RatioCreLineRec."63";
                            CutCreationLineRec."64" := RatioCreLineRec."64";

                            CutCreationLineRec.Insert();

                        end;



                        //Generate cut nos
                        CutCreationLineRec.Reset();
                        CutCreationLineRec.SetCurrentKey("Cut No");
                        CutCreationLineRec.Ascending(true);
                        CutCreationLineRec.SetRange("Style No.", "Style No.");
                        if CutCreationLineRec.FindLast() then begin
                            MaxCutNo := CutCreationLineRec."Cut No";
                        end;


                        Nooftimes := Plies DIV "Ply Height";
                        Balance := Plies MOD "Ply Height";

                        CutCreationLine1Rec.Reset();
                        CutCreationLine1Rec.SetRange("CutCreNo.", CutCreNo);
                        CutCreationLine1Rec.SetRange("Record Type", 'R');
                        CutCreationLine1Rec.FindSet();

                        Count := 0;
                        if Nooftimes > 0 then begin

                            for Count := (MaxCutNo + 1) To (MaxCutNo + Nooftimes) DO begin

                                LineNo += 1;

                                //Insert Cut numbers
                                CutCreationLineRec.Init();
                                CutCreationLineRec."CutCreNo." := CutCreNo;
                                CutCreationLineRec."Created Date" := Today;
                                CutCreationLineRec."Created User" := UserId;
                                CutCreationLineRec."Group ID" := "Group ID";
                                CutCreationLineRec."Marker Name" := "Marker Name";
                                CutCreationLineRec."line No" := LineNo;
                                CutCreationLineRec."Cut No" := Count;
                                CutCreationLineRec."Lot No." := CutCreationLine1Rec."Lot No.";
                                CutCreationLineRec."PO No." := CutCreationLine1Rec."PO No.";
                                CutCreationLineRec.qty := 0;
                                CutCreationLineRec.Plies := "Ply Height";
                                CutCreationLineRec."Record Type" := 'R';
                                CutCreationLineRec."Sewing Job No." := CutCreationLine1Rec."Sewing Job No.";
                                CutCreationLineRec.ShipDate := CutCreationLine1Rec.ShipDate;
                                CutCreationLineRec."Style Name" := CutCreationLine1Rec."Style Name";
                                CutCreationLineRec."Style No." := CutCreationLine1Rec."Style No.";
                                CutCreationLineRec."SubLotNo." := CutCreationLine1Rec."SubLotNo.";
                                CutCreationLineRec."Component Group Code" := CutCreationLine1Rec."Component Group Code";
                                CutCreationLineRec."Colour No" := CutCreationLine1Rec."Colour No";
                                CutCreationLineRec."Colour Name" := CutCreationLine1Rec."Colour Name";

                                if CutCreationLine1Rec."1" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."1")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."1" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."2" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."2")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."2" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."3" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."3")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."3" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."4" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."4")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."4" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."5" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."5")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."5" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."6" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."6")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."6" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."7" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."7")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."7" := format(Number1 * "Ply Height");

                                ///////
                                if CutCreationLine1Rec."8" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."8")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."8" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."9" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."9")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."9" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."10" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."10")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."10" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."11" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."11")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."11" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."12" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."12")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."12" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."13" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."13")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."13" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."14" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."14")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."14" := format(Number1 * "Ply Height");


                                if CutCreationLine1Rec."15" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."15")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."15" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."16" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."16")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."16" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."17" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."17")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."17" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."18" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."18")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."18" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."19" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."19")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."19" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."20" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."20")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."20" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."21" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."21")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."21" := format(Number1 * "Ply Height");

                                ///////
                                if CutCreationLine1Rec."22" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."22")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."22" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."23" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."23")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."23" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."24" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."24")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."24" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."25" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."25")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."25" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."26" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."26")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."26" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."27" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."27")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."27" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."28" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."28")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."28" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."29" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."29")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."29" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."30" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."30")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."30" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."31" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."31")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."31" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."32" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."32")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."32" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."33" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."33")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."33" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."34" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."34")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."34" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."35" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."35")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."35" := format(Number1 * "Ply Height");

                                ///
                                if CutCreationLine1Rec."36" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."36")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."36" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."37" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."37")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."37" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."38" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."38")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."38" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."39" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."39")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."39" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."40" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."40")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."40" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."41" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."41")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."41" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."42" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."42")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."42" := format(Number1 * "Ply Height");

                                /////////////
                                if CutCreationLine1Rec."43" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."43")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."43" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."44" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."44")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."44" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."45" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."45")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."45" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."46" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."46")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."46" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."47" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."47")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."47" := format(Number1 * "Ply Height");

                                ////
                                if CutCreationLine1Rec."48" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."48")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."48" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."49" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."49")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."49" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."50" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."50")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."50" := format(Number1 * "Ply Height");

                                /////////////////
                                if CutCreationLine1Rec."51" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."51")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."51" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."52" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."52")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."52" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."53" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."53")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."53" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."54" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."54")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."54" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."55" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."55")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."55" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."56" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."56")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."56" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."57" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."57")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."57" := format(Number1 * "Ply Height");

                                /////////////////
                                if CutCreationLine1Rec."58" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."58")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."58" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."59" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."59")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."59" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."60" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."60")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."60" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."61" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."61")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."61" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."62" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."62")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."62" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."63" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."63")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."63" := format(Number1 * "Ply Height");

                                //////////
                                if CutCreationLine1Rec."64" <> '' then
                                    Evaluate(Number1, CutCreationLine1Rec."64")
                                else
                                    Number1 := 0;
                                CutCreationLineRec."64" := format(Number1 * "Ply Height");

                                CutCreationLineRec.Insert();

                            end;

                        end;

                        //Insert balance 
                        LineNo += 1;

                        //Insert Cut numbers
                        CutCreationLineRec.Init();
                        CutCreationLineRec."CutCreNo." := CutCreNo;
                        CutCreationLineRec."Created Date" := Today;
                        CutCreationLineRec."Created User" := UserId;
                        CutCreationLineRec."Group ID" := "Group ID";
                        CutCreationLineRec."Marker Name" := "Marker Name";
                        CutCreationLineRec."line No" := LineNo;
                        CutCreationLineRec."Cut No" := Count + 1;
                        CutCreationLineRec."Lot No." := CutCreationLine1Rec."Lot No.";
                        CutCreationLineRec."PO No." := CutCreationLine1Rec."PO No.";
                        CutCreationLineRec.qty := 0;
                        CutCreationLineRec.Plies := Balance;
                        CutCreationLineRec."Record Type" := 'R';
                        CutCreationLineRec."Sewing Job No." := CutCreationLine1Rec."Sewing Job No.";
                        CutCreationLineRec.ShipDate := CutCreationLine1Rec.ShipDate;
                        CutCreationLineRec."Style Name" := CutCreationLine1Rec."Style Name";
                        CutCreationLineRec."Style No." := CutCreationLine1Rec."Style No.";
                        CutCreationLineRec."SubLotNo." := CutCreationLine1Rec."SubLotNo.";
                        CutCreationLineRec."Component Group Code" := CutCreationLine1Rec."Component Group Code";
                        CutCreationLineRec."Colour No" := CutCreationLine1Rec."Colour No";
                        CutCreationLineRec."Colour Name" := CutCreationLine1Rec."Colour Name";

                        if CutCreationLine1Rec."1" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."1")
                        else
                            Number1 := 0;
                        CutCreationLineRec."1" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."2" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."2")
                        else
                            Number1 := 0;
                        CutCreationLineRec."2" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."3" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."3")
                        else
                            Number1 := 0;
                        CutCreationLineRec."3" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."4" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."4")
                        else
                            Number1 := 0;
                        CutCreationLineRec."4" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."5" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."5")
                        else
                            Number1 := 0;
                        CutCreationLineRec."5" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."6" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."6")
                        else
                            Number1 := 0;
                        CutCreationLineRec."6" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."7" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."7")
                        else
                            Number1 := 0;
                        CutCreationLineRec."7" := format(Number1 * Balance);

                        ///////
                        if CutCreationLine1Rec."8" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."8")
                        else
                            Number1 := 0;
                        CutCreationLineRec."8" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."9" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."9")
                        else
                            Number1 := 0;
                        CutCreationLineRec."9" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."10" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."10")
                        else
                            Number1 := 0;
                        CutCreationLineRec."10" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."11" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."11")
                        else
                            Number1 := 0;
                        CutCreationLineRec."11" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."12" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."12")
                        else
                            Number1 := 0;
                        CutCreationLineRec."12" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."13" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."13")
                        else
                            Number1 := 0;
                        CutCreationLineRec."13" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."14" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."14")
                        else
                            Number1 := 0;
                        CutCreationLineRec."14" := format(Number1 * Balance);


                        if CutCreationLine1Rec."15" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."15")
                        else
                            Number1 := 0;
                        CutCreationLineRec."15" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."16" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."16")
                        else
                            Number1 := 0;
                        CutCreationLineRec."16" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."17" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."17")
                        else
                            Number1 := 0;
                        CutCreationLineRec."17" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."18" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."18")
                        else
                            Number1 := 0;
                        CutCreationLineRec."18" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."19" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."19")
                        else
                            Number1 := 0;
                        CutCreationLineRec."19" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."20" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."20")
                        else
                            Number1 := 0;
                        CutCreationLineRec."20" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."21" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."21")
                        else
                            Number1 := 0;
                        CutCreationLineRec."21" := format(Number1 * Balance);

                        ///////
                        if CutCreationLine1Rec."22" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."22")
                        else
                            Number1 := 0;
                        CutCreationLineRec."22" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."23" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."23")
                        else
                            Number1 := 0;
                        CutCreationLineRec."23" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."24" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."24")
                        else
                            Number1 := 0;
                        CutCreationLineRec."24" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."25" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."25")
                        else
                            Number1 := 0;
                        CutCreationLineRec."25" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."26" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."26")
                        else
                            Number1 := 0;
                        CutCreationLineRec."26" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."27" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."27")
                        else
                            Number1 := 0;
                        CutCreationLineRec."27" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."28" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."28")
                        else
                            Number1 := 0;
                        CutCreationLineRec."28" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."29" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."29")
                        else
                            Number1 := 0;
                        CutCreationLineRec."29" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."30" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."30")
                        else
                            Number1 := 0;
                        CutCreationLineRec."30" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."31" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."31")
                        else
                            Number1 := 0;
                        CutCreationLineRec."31" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."32" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."32")
                        else
                            Number1 := 0;
                        CutCreationLineRec."32" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."33" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."33")
                        else
                            Number1 := 0;
                        CutCreationLineRec."33" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."34" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."34")
                        else
                            Number1 := 0;
                        CutCreationLineRec."34" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."35" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."35")
                        else
                            Number1 := 0;
                        CutCreationLineRec."35" := format(Number1 * Balance);

                        ///
                        if CutCreationLine1Rec."36" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."36")
                        else
                            Number1 := 0;
                        CutCreationLineRec."36" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."37" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."37")
                        else
                            Number1 := 0;
                        CutCreationLineRec."37" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."38" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."38")
                        else
                            Number1 := 0;
                        CutCreationLineRec."38" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."39" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."39")
                        else
                            Number1 := 0;
                        CutCreationLineRec."39" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."40" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."40")
                        else
                            Number1 := 0;
                        CutCreationLineRec."40" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."41" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."41")
                        else
                            Number1 := 0;
                        CutCreationLineRec."41" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."42" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."42")
                        else
                            Number1 := 0;
                        CutCreationLineRec."42" := format(Number1 * Balance);

                        /////////////
                        if CutCreationLine1Rec."43" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."43")
                        else
                            Number1 := 0;
                        CutCreationLineRec."43" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."44" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."44")
                        else
                            Number1 := 0;
                        CutCreationLineRec."44" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."45" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."45")
                        else
                            Number1 := 0;
                        CutCreationLineRec."45" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."46" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."46")
                        else
                            Number1 := 0;
                        CutCreationLineRec."46" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."47" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."47")
                        else
                            Number1 := 0;
                        CutCreationLineRec."47" := format(Number1 * Balance);

                        ////
                        if CutCreationLine1Rec."48" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."48")
                        else
                            Number1 := 0;
                        CutCreationLineRec."48" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."49" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."49")
                        else
                            Number1 := 0;
                        CutCreationLineRec."49" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."50" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."50")
                        else
                            Number1 := 0;
                        CutCreationLineRec."50" := format(Number1 * Balance);

                        /////////////////
                        if CutCreationLine1Rec."51" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."51")
                        else
                            Number1 := 0;
                        CutCreationLineRec."51" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."52" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."52")
                        else
                            Number1 := 0;
                        CutCreationLineRec."52" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."53" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."53")
                        else
                            Number1 := 0;
                        CutCreationLineRec."53" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."54" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."54")
                        else
                            Number1 := 0;
                        CutCreationLineRec."54" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."55" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."55")
                        else
                            Number1 := 0;
                        CutCreationLineRec."55" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."56" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."56")
                        else
                            Number1 := 0;
                        CutCreationLineRec."56" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."57" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."57")
                        else
                            Number1 := 0;
                        CutCreationLineRec."57" := format(Number1 * Balance);

                        /////////////////
                        if CutCreationLine1Rec."58" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."58")
                        else
                            Number1 := 0;
                        CutCreationLineRec."58" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."59" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."59")
                        else
                            Number1 := 0;
                        CutCreationLineRec."59" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."60" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."60")
                        else
                            Number1 := 0;
                        CutCreationLineRec."60" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."61" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."61")
                        else
                            Number1 := 0;
                        CutCreationLineRec."61" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."62" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."62")
                        else
                            Number1 := 0;
                        CutCreationLineRec."62" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."63" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."63")
                        else
                            Number1 := 0;
                        CutCreationLineRec."63" := format(Number1 * Balance);

                        //////////
                        if CutCreationLine1Rec."64" <> '' then
                            Evaluate(Number1, CutCreationLine1Rec."64")
                        else
                            Number1 := 0;
                        CutCreationLineRec."64" := format(Number1 * Balance);

                        CutCreationLineRec.Insert();

                    end;

                    Message('Completed');
                end;
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."CutCre Nos.", xRec."CutCreNo", "CutCreNo") THEN BEGIN
            NoSeriesMngment.SetSeries(CutCreNo);
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        CurCreLineRec: Record CutCreationLine;
        FabRec: Record FabricRequsition;
        TableRec: Record TableCreartionLine;
        LaySheetRec: Record LaySheetHeader;
    begin

        //Check fabric requsition
        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", CutCreNo);
        CurCreLineRec.SetFilter("Cut No", '<>%1', 0);

        if CurCreLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                FabRec.Reset();
                FabRec.SetRange("Marker Name", "Marker Name");
                FabRec.SetRange("Style No.", "Style No.");
                FabRec.SetRange("Colour No", "Colour No");
                FabRec.SetRange("Group ID", "Group ID");
                FabRec.SetRange("Component Group Code", "Component Group");
                FabRec.SetRange("Marker Name", "Marker Name");
                FabRec.SetRange("Cut No", CurCreLineRec."Cut No");

                if FabRec.FindSet() then begin
                    Message('Cannot delete. Cut No already used in the Fabric Requsition No : %1', FabRec."FabReqNo.");
                    exit(false);
                end;
            until CurCreLineRec.Next() = 0;
        end;


        //Check Table creation
        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", CutCreNo);
        CurCreLineRec.SetFilter("Cut No", '<>%1', 0);

        if CurCreLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                TableRec.Reset();
                TableRec.SetRange("Marker Name", "Marker Name");
                TableRec.SetRange("Style No.", "Style No.");
                TableRec.SetRange("Colour No", "Colour No");
                TableRec.SetRange("Group ID", "Group ID");
                TableRec.SetRange("Component Group", "Component Group");
                TableRec.SetRange("Marker Name", "Marker Name");
                TableRec.SetRange("Cut No", CurCreLineRec."Cut No");

                if TableRec.FindSet() then begin
                    Message('Cannot delete. Cut No already used in the Cutting Table Creation : %1', TableRec."TableCreNo.");
                    exit(false);
                end;
            until CurCreLineRec.Next() = 0;
        end;


        //Check LaySheet
        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", CutCreNo);
        CurCreLineRec.SetFilter("Record Type", '=%1', 'R');

        if CurCreLineRec.FindSet() then begin
            repeat

                //Check for cut creation
                LaySheetRec.Reset();
                LaySheetRec.SetRange("Marker Name", "Marker Name");
                LaySheetRec.SetRange("Style No.", "Style No.");
                LaySheetRec.SetRange("Color No.", "Colour No");
                LaySheetRec.SetRange("Group ID", "Group ID");
                LaySheetRec.SetRange("Component Group Code", "Component Group");
                LaySheetRec.SetRange("Cut No.", CurCreLineRec."Cut No");

                if LaySheetRec.FindSet() then begin
                    Message('Cannot delete. Cut No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
                    exit(false);
                end;
            until CurCreLineRec.Next() = 0;
        end;


        CurCreLineRec.Reset();
        CurCreLineRec.SetRange("CutCreNo.", CutCreNo);
        if CurCreLineRec.FindSet() then
            CurCreLineRec.DeleteAll();
    end;
}