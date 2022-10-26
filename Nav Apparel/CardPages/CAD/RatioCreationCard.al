page 50604 "Ratio Creation Card"
{
    PageType = Card;
    SourceTable = RatioCreation;
    Caption = 'Ratio Creation';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(RatioCreNo; RatioCreNo)
                {
                    ApplicationArea = All;
                    Caption = 'Ratio Creation No';

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
                        StyleRec: Record "Style Master";
                    begin
                        StyleRec.Reset();
                        StyleRec.SetRange("Style No.", "Style Name");
                        if StyleRec.FindSet() then
                            "Style No." := StyleRec."No.";
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
                }

                field("Component Group"; "Component Group")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("UOM Code"; "UOM Code")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Of Meassure';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        UOMRec: Record "Unit of Measure";
                    begin
                        UOMRec.Reset();
                        UOMRec.SetRange(Code, "UOM Code");
                        UOMRec.FindSet();
                        UOM := UOMRec.Description;
                    end;
                }
            }


            group("Ratio Creation")
            {
                part("Ratio Creation ListPart"; "Ratio Creation ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "RatioCreNo" = FIELD(RatioCreNo), "Group ID" = field("Group ID");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Ratio")
            {
                ApplicationArea = All;
                Image = Relationship;

                trigger OnAction()
                var
                    SewJobCreLine4Rec: Record SewingJobCreationLine4;
                    SewJobCreLine4Rec1: Record SewingJobCreationLine4;
                    RatioCreLineRec: Record RatioCreationLine;
                    RatioCreRec: Record RatioCreation;
                    LineNo: Integer;
                    Number1: Integer;
                    Number2: Integer;
                    ColorTotal: Decimal;
                    UOM: Code[20];
                    UOMCode: Code[20];
                begin

                    //Get UOM
                    RatioCreRec.Reset();
                    RatioCreRec.SetRange(RatioCreNo, RatioCreNo);

                    if RatioCreRec.FindSet() then begin
                        UOM := RatioCreRec.UOM;
                        UOMCode := RatioCreRec."UOM Code";
                    end;


                    if ("Style Name" = '') then
                        Error('Invalid Style');

                    if ("Colour Name" = '') then
                        Error('Invalid Colour');

                    if ("Group ID" = 0) then
                        Error('Invalid Group');

                    if ("Component Group" = '') then
                        Error('Invalid Component');

                    // //Get Max line no
                    // RatioCreLineRec.Reset();
                    // RatioCreLineRec.SetRange(RatioCreNo, RatioCreNo);
                    // RatioCreLineRec.SetRange("Group ID", "Group ID");

                    // if RatioCreLineRec.FindLast() then
                    //     LineNo := RatioCreLineRec.LineNo;
                    LineNo := 0;

                    //Get selected records for the group
                    SewJobCreLine4Rec.Reset();
                    SewJobCreLine4Rec.SetRange("Style No.", "Style No.");
                    SewJobCreLine4Rec.SetFilter("Group ID", '=%1|=%2', "Group ID", 0);
                    SewJobCreLine4Rec.SetFilter("Colour No", '=%1|=%2', "Colour No", '*');
                    //SewJobCreLine4Rec.SetRange("Colour No", "Colour No");
                    SewJobCreLine4Rec.SetCurrentKey("Record Type");

                    if SewJobCreLine4Rec.FindSet() then begin

                        if (Dialog.CONFIRM('"Create Ratio" will earse old records. Do you want to continue?', true) = true) then begin

                            //Delete old records
                            RatioCreLineRec.Reset();
                            RatioCreLineRec.SetRange(RatioCreNo, RatioCreNo);
                            if RatioCreLineRec.FindSet() then
                                RatioCreLineRec.DeleteAll();

                            repeat

                                //if (SewJobCreLine4Rec."Record Type" = 'L') then begin                                

                                if (SewJobCreLine4Rec."Record Type" = 'H') then begin

                                    //Check for Header record (H)
                                    RatioCreLineRec.Reset();
                                    RatioCreLineRec.SetRange(RatioCreNo, RatioCreNo);
                                    RatioCreLineRec.SetRange("Style No.", SewJobCreLine4Rec."Style No.");
                                    //RatioCreLineRec.SetRange("Lot No.", SewJobCreLine4Rec."Lot No.");
                                    RatioCreLineRec.SetRange("Group ID", "Group ID");
                                    RatioCreLineRec.SetFilter("Record Type", '%1', 'H');

                                    if not RatioCreLineRec.FindSet() then begin

                                        //Get Size details
                                        SewJobCreLine4Rec1.Reset();
                                        SewJobCreLine4Rec1.SetRange("Style No.", SewJobCreLine4Rec."Style No.");
                                        //SewJobCreLine4Rec1.SetRange("Lot No.", SewJobCreLine4Rec."Lot No.");
                                        SewJobCreLine4Rec1.SetRange("Record Type", 'H');

                                        if SewJobCreLine4Rec1.FindSet() then begin
                                            LineNo += 1;
                                            RatioCreLineRec.Init();
                                            RatioCreLineRec.RatioCreNo := RatioCreNo;
                                            RatioCreLineRec."Created Date" := Today;
                                            RatioCreLineRec."Created User" := UserId;
                                            RatioCreLineRec."Group ID" := "Group ID";
                                            RatioCreLineRec.LineNo := LineNo;
                                            // RatioCreLineRec."Lot No." := SewJobCreLine4Rec1."Lot No.";
                                            // RatioCreLineRec."PO No." := SewJobCreLine4Rec1."PO No.";
                                            RatioCreLineRec.qty := 0;
                                            RatioCreLineRec."Record Type" := 'H';
                                            //RatioCreLineRec."Sewing Job No." := SewJobCreLine4Rec1."Sewing Job No.";
                                            //RatioCreLineRec.ShipDate := SewJobCreLine4Rec1.ShipDate;
                                            RatioCreLineRec."Style Name" := "Style Name";
                                            RatioCreLineRec."Style No." := "Style No.";
                                            //RatioCreLineRec."SubLotNo." := SewJobCreLine4Rec1."SubLotNo.";
                                            RatioCreLineRec."Component Group Code" := "Component Group";
                                            RatioCreLineRec.UOM := UOM;
                                            RatioCreLineRec."UOM Code" := UOMCode;
                                            RatioCreLineRec."Colour No" := "Colour No";
                                            RatioCreLineRec."Colour Name" := "Colour Name";

                                            RatioCreLineRec."1" := SewJobCreLine4Rec1."1";
                                            RatioCreLineRec."2" := SewJobCreLine4Rec1."2";
                                            RatioCreLineRec."3" := SewJobCreLine4Rec1."3";
                                            RatioCreLineRec."4" := SewJobCreLine4Rec1."4";
                                            RatioCreLineRec."5" := SewJobCreLine4Rec1."5";
                                            RatioCreLineRec."6" := SewJobCreLine4Rec1."6";
                                            RatioCreLineRec."7" := SewJobCreLine4Rec1."7";
                                            RatioCreLineRec."8" := SewJobCreLine4Rec1."8";
                                            RatioCreLineRec."9" := SewJobCreLine4Rec1."9";
                                            RatioCreLineRec."10" := SewJobCreLine4Rec1."10";
                                            RatioCreLineRec."11" := SewJobCreLine4Rec1."11";
                                            RatioCreLineRec."12" := SewJobCreLine4Rec1."12";
                                            RatioCreLineRec."13" := SewJobCreLine4Rec1."13";
                                            RatioCreLineRec."14" := SewJobCreLine4Rec1."14";
                                            RatioCreLineRec."15" := SewJobCreLine4Rec1."15";
                                            RatioCreLineRec."16" := SewJobCreLine4Rec1."16";
                                            RatioCreLineRec."17" := SewJobCreLine4Rec1."17";
                                            RatioCreLineRec."18" := SewJobCreLine4Rec1."18";
                                            RatioCreLineRec."19" := SewJobCreLine4Rec1."19";
                                            RatioCreLineRec."20" := SewJobCreLine4Rec1."20";
                                            RatioCreLineRec."21" := SewJobCreLine4Rec1."21";
                                            RatioCreLineRec."22" := SewJobCreLine4Rec1."22";
                                            RatioCreLineRec."23" := SewJobCreLine4Rec1."23";
                                            RatioCreLineRec."24" := SewJobCreLine4Rec1."24";
                                            RatioCreLineRec."25" := SewJobCreLine4Rec1."25";
                                            RatioCreLineRec."26" := SewJobCreLine4Rec1."26";
                                            RatioCreLineRec."27" := SewJobCreLine4Rec1."27";
                                            RatioCreLineRec."28" := SewJobCreLine4Rec1."28";
                                            RatioCreLineRec."29" := SewJobCreLine4Rec1."29";
                                            RatioCreLineRec."30" := SewJobCreLine4Rec1."30";
                                            RatioCreLineRec."31" := SewJobCreLine4Rec1."31";
                                            RatioCreLineRec."32" := SewJobCreLine4Rec1."32";
                                            RatioCreLineRec."33" := SewJobCreLine4Rec1."33";
                                            RatioCreLineRec."34" := SewJobCreLine4Rec1."34";
                                            RatioCreLineRec."35" := SewJobCreLine4Rec1."35";
                                            RatioCreLineRec."36" := SewJobCreLine4Rec1."36";
                                            RatioCreLineRec."37" := SewJobCreLine4Rec1."37";
                                            RatioCreLineRec."38" := SewJobCreLine4Rec1."38";
                                            RatioCreLineRec."39" := SewJobCreLine4Rec1."39";
                                            RatioCreLineRec."40" := SewJobCreLine4Rec1."40";
                                            RatioCreLineRec."41" := SewJobCreLine4Rec1."41";
                                            RatioCreLineRec."42" := SewJobCreLine4Rec1."42";
                                            RatioCreLineRec."43" := SewJobCreLine4Rec1."43";
                                            RatioCreLineRec."44" := SewJobCreLine4Rec1."44";
                                            RatioCreLineRec."45" := SewJobCreLine4Rec1."45";
                                            RatioCreLineRec."46" := SewJobCreLine4Rec1."46";
                                            RatioCreLineRec."47" := SewJobCreLine4Rec1."47";
                                            RatioCreLineRec."48" := SewJobCreLine4Rec1."48";
                                            RatioCreLineRec."49" := SewJobCreLine4Rec1."49";
                                            RatioCreLineRec."50" := SewJobCreLine4Rec1."50";
                                            RatioCreLineRec."51" := SewJobCreLine4Rec1."51";
                                            RatioCreLineRec."52" := SewJobCreLine4Rec1."52";
                                            RatioCreLineRec."53" := SewJobCreLine4Rec1."53";
                                            RatioCreLineRec."54" := SewJobCreLine4Rec1."54";
                                            RatioCreLineRec."55" := SewJobCreLine4Rec1."55";
                                            RatioCreLineRec."56" := SewJobCreLine4Rec1."56";
                                            RatioCreLineRec."57" := SewJobCreLine4Rec1."57";
                                            RatioCreLineRec."58" := SewJobCreLine4Rec1."58";
                                            RatioCreLineRec."59" := SewJobCreLine4Rec1."59";
                                            RatioCreLineRec."60" := SewJobCreLine4Rec1."60";
                                            RatioCreLineRec."61" := SewJobCreLine4Rec1."61";
                                            RatioCreLineRec."62" := SewJobCreLine4Rec1."62";
                                            RatioCreLineRec."63" := SewJobCreLine4Rec1."63";
                                            RatioCreLineRec."64" := SewJobCreLine4Rec1."64";

                                            RatioCreLineRec.Insert();
                                        end;

                                    end;
                                end;


                                if (SewJobCreLine4Rec."Record Type" = 'H1') then begin

                                    //Check Total Line (H1)                  
                                    RatioCreLineRec.Reset();
                                    RatioCreLineRec.SetRange(RatioCreNo, RatioCreNo);
                                    RatioCreLineRec.SetRange("Style No.", SewJobCreLine4Rec."Style No.");
                                    //RatioCreLineRec.SetRange("Lot No.", SewJobCreLine4Rec."Lot No.");
                                    RatioCreLineRec.SetRange("Group ID", "Group ID");
                                    RatioCreLineRec.SetFilter("Record Type", '%1', 'H1');

                                    //Insert Total Line (H1)                  
                                    if not RatioCreLineRec.FindSet() then begin

                                        LineNo += 1;
                                        RatioCreLineRec.Init();
                                        RatioCreLineRec.RatioCreNo := RatioCreNo;
                                        RatioCreLineRec."Created Date" := Today;
                                        RatioCreLineRec."Created User" := UserId;
                                        RatioCreLineRec."Group ID" := "Group ID";
                                        RatioCreLineRec.LineNo := LineNo;
                                        // RatioCreLineRec."Lot No." := SewJobCreLine4Rec."Lot No.";
                                        // RatioCreLineRec."PO No." := SewJobCreLine4Rec."PO No.";
                                        RatioCreLineRec.qty := 0;
                                        RatioCreLineRec."Record Type" := 'H1';
                                        //RatioCreLineRec."Sewing Job No." := SewJobCreLine4Rec."Sewing Job No.";
                                        //RatioCreLineRec.ShipDate := SewJobCreLine4Rec.ShipDate;
                                        RatioCreLineRec."Style Name" := "Style Name";
                                        RatioCreLineRec."Style No." := "Style No.";
                                        //RatioCreLineRec."SubLotNo." := SewJobCreLine4Rec."SubLotNo.";
                                        RatioCreLineRec."Component Group Code" := "Component Group";
                                        RatioCreLineRec.UOM := UOM;
                                        RatioCreLineRec."UOM Code" := UOMCode;
                                        RatioCreLineRec."Colour No" := "Colour No";
                                        RatioCreLineRec."Colour Name" := "Colour Name";
                                        RatioCreLineRec."1" := SewJobCreLine4Rec."1";
                                        RatioCreLineRec."2" := SewJobCreLine4Rec."2";
                                        RatioCreLineRec."3" := SewJobCreLine4Rec."3";
                                        RatioCreLineRec."4" := SewJobCreLine4Rec."4";
                                        RatioCreLineRec."5" := SewJobCreLine4Rec."5";
                                        RatioCreLineRec."6" := SewJobCreLine4Rec."6";
                                        RatioCreLineRec."7" := SewJobCreLine4Rec."7";
                                        RatioCreLineRec."8" := SewJobCreLine4Rec."8";
                                        RatioCreLineRec."9" := SewJobCreLine4Rec."9";
                                        RatioCreLineRec."10" := SewJobCreLine4Rec."10";
                                        RatioCreLineRec."11" := SewJobCreLine4Rec."11";
                                        RatioCreLineRec."12" := SewJobCreLine4Rec."12";
                                        RatioCreLineRec."13" := SewJobCreLine4Rec."13";
                                        RatioCreLineRec."14" := SewJobCreLine4Rec."14";
                                        RatioCreLineRec."15" := SewJobCreLine4Rec."15";
                                        RatioCreLineRec."16" := SewJobCreLine4Rec."16";
                                        RatioCreLineRec."17" := SewJobCreLine4Rec."17";
                                        RatioCreLineRec."18" := SewJobCreLine4Rec."18";
                                        RatioCreLineRec."19" := SewJobCreLine4Rec."19";
                                        RatioCreLineRec."20" := SewJobCreLine4Rec."20";
                                        RatioCreLineRec."21" := SewJobCreLine4Rec."21";
                                        RatioCreLineRec."22" := SewJobCreLine4Rec."22";
                                        RatioCreLineRec."23" := SewJobCreLine4Rec."23";
                                        RatioCreLineRec."24" := SewJobCreLine4Rec."24";
                                        RatioCreLineRec."25" := SewJobCreLine4Rec."25";
                                        RatioCreLineRec."26" := SewJobCreLine4Rec."26";
                                        RatioCreLineRec."27" := SewJobCreLine4Rec."27";
                                        RatioCreLineRec."28" := SewJobCreLine4Rec."28";
                                        RatioCreLineRec."29" := SewJobCreLine4Rec."29";
                                        RatioCreLineRec."30" := SewJobCreLine4Rec."30";
                                        RatioCreLineRec."31" := SewJobCreLine4Rec."31";
                                        RatioCreLineRec."32" := SewJobCreLine4Rec."32";
                                        RatioCreLineRec."33" := SewJobCreLine4Rec."33";
                                        RatioCreLineRec."34" := SewJobCreLine4Rec."34";
                                        RatioCreLineRec."35" := SewJobCreLine4Rec."35";
                                        RatioCreLineRec."36" := SewJobCreLine4Rec."36";
                                        RatioCreLineRec."37" := SewJobCreLine4Rec."37";
                                        RatioCreLineRec."38" := SewJobCreLine4Rec."38";
                                        RatioCreLineRec."39" := SewJobCreLine4Rec."39";
                                        RatioCreLineRec."40" := SewJobCreLine4Rec."40";
                                        RatioCreLineRec."41" := SewJobCreLine4Rec."41";
                                        RatioCreLineRec."42" := SewJobCreLine4Rec."42";
                                        RatioCreLineRec."43" := SewJobCreLine4Rec."43";
                                        RatioCreLineRec."44" := SewJobCreLine4Rec."44";
                                        RatioCreLineRec."45" := SewJobCreLine4Rec."45";
                                        RatioCreLineRec."46" := SewJobCreLine4Rec."46";
                                        RatioCreLineRec."47" := SewJobCreLine4Rec."47";
                                        RatioCreLineRec."48" := SewJobCreLine4Rec."48";
                                        RatioCreLineRec."49" := SewJobCreLine4Rec."49";
                                        RatioCreLineRec."50" := SewJobCreLine4Rec."50";
                                        RatioCreLineRec."51" := SewJobCreLine4Rec."51";
                                        RatioCreLineRec."52" := SewJobCreLine4Rec."52";
                                        RatioCreLineRec."53" := SewJobCreLine4Rec."53";
                                        RatioCreLineRec."54" := SewJobCreLine4Rec."54";
                                        RatioCreLineRec."55" := SewJobCreLine4Rec."55";
                                        RatioCreLineRec."56" := SewJobCreLine4Rec."56";
                                        RatioCreLineRec."57" := SewJobCreLine4Rec."57";
                                        RatioCreLineRec."58" := SewJobCreLine4Rec."58";
                                        RatioCreLineRec."59" := SewJobCreLine4Rec."59";
                                        RatioCreLineRec."60" := SewJobCreLine4Rec."60";
                                        RatioCreLineRec."61" := SewJobCreLine4Rec."61";
                                        RatioCreLineRec."62" := SewJobCreLine4Rec."62";
                                        RatioCreLineRec."63" := SewJobCreLine4Rec."63";
                                        RatioCreLineRec."64" := SewJobCreLine4Rec."64";

                                        RatioCreLineRec.Insert();

                                    end
                                    else begin

                                        //Modify Total Line (H1)      
                                        if (SewJobCreLine4Rec."1" <> '') and (SewJobCreLine4Rec."1" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."1");
                                            Evaluate(Number2, RatioCreLineRec."1");
                                            RatioCreLineRec."1" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."2" <> '') and (SewJobCreLine4Rec."2" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."2");
                                            Evaluate(Number2, RatioCreLineRec."2");
                                            RatioCreLineRec."2" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."3" <> '') and (SewJobCreLine4Rec."3" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."3");
                                            Evaluate(Number2, RatioCreLineRec."3");
                                            RatioCreLineRec."3" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."4" <> '') and (SewJobCreLine4Rec."4" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."4");
                                            Evaluate(Number2, RatioCreLineRec."4");
                                            RatioCreLineRec."4" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."5" <> '') and (SewJobCreLine4Rec."5" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."5");
                                            Evaluate(Number2, RatioCreLineRec."5");
                                            RatioCreLineRec."5" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."6" <> '') and (SewJobCreLine4Rec."6" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."6");
                                            Evaluate(Number2, RatioCreLineRec."6");
                                            RatioCreLineRec."6" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."7" <> '') and (SewJobCreLine4Rec."7" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."7");
                                            Evaluate(Number2, RatioCreLineRec."7");
                                            RatioCreLineRec."7" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."8" <> '') and (SewJobCreLine4Rec."8" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."8");
                                            Evaluate(Number2, RatioCreLineRec."8");
                                            RatioCreLineRec."8" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."9" <> '') and (SewJobCreLine4Rec."9" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."9");
                                            Evaluate(Number2, RatioCreLineRec."9");
                                            RatioCreLineRec."9" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."10" <> '') and (SewJobCreLine4Rec."10" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."10");
                                            Evaluate(Number2, RatioCreLineRec."10");
                                            RatioCreLineRec."10" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."11" <> '') and (SewJobCreLine4Rec."11" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."11");
                                            Evaluate(Number2, RatioCreLineRec."11");
                                            RatioCreLineRec."11" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."12" <> '') and (SewJobCreLine4Rec."12" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."12");
                                            Evaluate(Number2, RatioCreLineRec."12");
                                            RatioCreLineRec."12" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."13" <> '') and (SewJobCreLine4Rec."13" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."13");
                                            Evaluate(Number2, RatioCreLineRec."13");
                                            RatioCreLineRec."13" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."14" <> '') and (SewJobCreLine4Rec."14" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."14");
                                            Evaluate(Number2, RatioCreLineRec."14");
                                            RatioCreLineRec."14" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."15" <> '') and (SewJobCreLine4Rec."15" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."15");
                                            Evaluate(Number2, RatioCreLineRec."15");
                                            RatioCreLineRec."15" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."16" <> '') and (SewJobCreLine4Rec."16" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."16");
                                            Evaluate(Number2, RatioCreLineRec."16");
                                            RatioCreLineRec."16" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."17" <> '') and (SewJobCreLine4Rec."17" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."17");
                                            Evaluate(Number2, RatioCreLineRec."17");
                                            RatioCreLineRec."17" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."18" <> '') and (SewJobCreLine4Rec."18" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."18");
                                            Evaluate(Number2, RatioCreLineRec."18");
                                            RatioCreLineRec."18" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."19" <> '') and (SewJobCreLine4Rec."19" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."19");
                                            Evaluate(Number2, RatioCreLineRec."19");
                                            RatioCreLineRec."19" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."20" <> '') and (SewJobCreLine4Rec."20" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."20");
                                            Evaluate(Number2, RatioCreLineRec."20");
                                            RatioCreLineRec."20" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."21" <> '') and (SewJobCreLine4Rec."21" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."21");
                                            Evaluate(Number2, RatioCreLineRec."21");
                                            RatioCreLineRec."21" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."22" <> '') and (SewJobCreLine4Rec."22" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."22");
                                            Evaluate(Number2, RatioCreLineRec."22");
                                            RatioCreLineRec."22" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."23" <> '') and (SewJobCreLine4Rec."23" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."23");
                                            Evaluate(Number2, RatioCreLineRec."23");
                                            RatioCreLineRec."23" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."24" <> '') and (SewJobCreLine4Rec."24" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."24");
                                            Evaluate(Number2, RatioCreLineRec."24");
                                            RatioCreLineRec."24" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."25" <> '') and (SewJobCreLine4Rec."25" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."25");
                                            Evaluate(Number2, RatioCreLineRec."25");
                                            RatioCreLineRec."25" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."26" <> '') and (SewJobCreLine4Rec."26" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."26");
                                            Evaluate(Number2, RatioCreLineRec."26");
                                            RatioCreLineRec."26" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."27" <> '') and (SewJobCreLine4Rec."27" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."27");
                                            Evaluate(Number2, RatioCreLineRec."27");
                                            RatioCreLineRec."27" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."28" <> '') and (SewJobCreLine4Rec."28" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."28");
                                            Evaluate(Number2, RatioCreLineRec."28");
                                            RatioCreLineRec."28" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."29" <> '') and (SewJobCreLine4Rec."29" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."29");
                                            Evaluate(Number2, RatioCreLineRec."29");
                                            RatioCreLineRec."29" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."30" <> '') and (SewJobCreLine4Rec."30" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."30");
                                            Evaluate(Number2, RatioCreLineRec."30");
                                            RatioCreLineRec."30" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."31" <> '') and (SewJobCreLine4Rec."31" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."31");
                                            Evaluate(Number2, RatioCreLineRec."31");
                                            RatioCreLineRec."31" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."32" <> '') and (SewJobCreLine4Rec."32" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."32");
                                            Evaluate(Number2, RatioCreLineRec."32");
                                            RatioCreLineRec."32" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."33" <> '') and (SewJobCreLine4Rec."33" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."33");
                                            Evaluate(Number2, RatioCreLineRec."33");
                                            RatioCreLineRec."33" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."34" <> '') and (SewJobCreLine4Rec."34" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."34");
                                            Evaluate(Number2, RatioCreLineRec."34");
                                            RatioCreLineRec."34" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."35" <> '') and (SewJobCreLine4Rec."35" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."35");
                                            Evaluate(Number2, RatioCreLineRec."35");
                                            RatioCreLineRec."35" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."36" <> '') and (SewJobCreLine4Rec."36" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."36");
                                            Evaluate(Number2, RatioCreLineRec."36");
                                            RatioCreLineRec."36" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."37" <> '') and (SewJobCreLine4Rec."37" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."37");
                                            Evaluate(Number2, RatioCreLineRec."37");
                                            RatioCreLineRec."37" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."38" <> '') and (SewJobCreLine4Rec."38" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."38");
                                            Evaluate(Number2, RatioCreLineRec."38");
                                            RatioCreLineRec."38" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."39" <> '') and (SewJobCreLine4Rec."39" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."39");
                                            Evaluate(Number2, RatioCreLineRec."39");
                                            RatioCreLineRec."39" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."40" <> '') and (SewJobCreLine4Rec."40" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."40");
                                            Evaluate(Number2, RatioCreLineRec."40");
                                            RatioCreLineRec."40" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."41" <> '') and (SewJobCreLine4Rec."41" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."41");
                                            Evaluate(Number2, RatioCreLineRec."41");
                                            RatioCreLineRec."41" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."42" <> '') and (SewJobCreLine4Rec."42" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."42");
                                            Evaluate(Number2, RatioCreLineRec."42");
                                            RatioCreLineRec."42" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."43" <> '') and (SewJobCreLine4Rec."43" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."43");
                                            Evaluate(Number2, RatioCreLineRec."43");
                                            RatioCreLineRec."43" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."44" <> '') and (SewJobCreLine4Rec."44" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."44");
                                            Evaluate(Number2, RatioCreLineRec."44");
                                            RatioCreLineRec."44" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."45" <> '') and (SewJobCreLine4Rec."45" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."45");
                                            Evaluate(Number2, RatioCreLineRec."45");
                                            RatioCreLineRec."45" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."46" <> '') and (SewJobCreLine4Rec."46" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."46");
                                            Evaluate(Number2, RatioCreLineRec."46");
                                            RatioCreLineRec."46" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."47" <> '') and (SewJobCreLine4Rec."47" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."47");
                                            Evaluate(Number2, RatioCreLineRec."47");
                                            RatioCreLineRec."47" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."48" <> '') and (SewJobCreLine4Rec."48" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."48");
                                            Evaluate(Number2, RatioCreLineRec."48");
                                            RatioCreLineRec."48" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."49" <> '') and (SewJobCreLine4Rec."49" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."49");
                                            Evaluate(Number2, RatioCreLineRec."49");
                                            RatioCreLineRec."49" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."50" <> '') and (SewJobCreLine4Rec."50" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."50");
                                            Evaluate(Number2, RatioCreLineRec."50");
                                            RatioCreLineRec."50" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."51" <> '') and (SewJobCreLine4Rec."51" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."51");
                                            Evaluate(Number2, RatioCreLineRec."51");
                                            RatioCreLineRec."51" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."52" <> '') and (SewJobCreLine4Rec."52" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."52");
                                            Evaluate(Number2, RatioCreLineRec."52");
                                            RatioCreLineRec."52" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."53" <> '') and (SewJobCreLine4Rec."53" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."53");
                                            Evaluate(Number2, RatioCreLineRec."53");
                                            RatioCreLineRec."53" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."54" <> '') and (SewJobCreLine4Rec."54" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."54");
                                            Evaluate(Number2, RatioCreLineRec."54");
                                            RatioCreLineRec."54" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."55" <> '') and (SewJobCreLine4Rec."55" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."55");
                                            Evaluate(Number2, RatioCreLineRec."55");
                                            RatioCreLineRec."55" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."56" <> '') and (SewJobCreLine4Rec."56" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."56");
                                            Evaluate(Number2, RatioCreLineRec."56");
                                            RatioCreLineRec."56" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."57" <> '') and (SewJobCreLine4Rec."57" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."57");
                                            Evaluate(Number2, RatioCreLineRec."57");
                                            RatioCreLineRec."57" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."58" <> '') and (SewJobCreLine4Rec."58" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."58");
                                            Evaluate(Number2, RatioCreLineRec."58");
                                            RatioCreLineRec."58" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."59" <> '') and (SewJobCreLine4Rec."59" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."59");
                                            Evaluate(Number2, RatioCreLineRec."59");
                                            RatioCreLineRec."59" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."60" <> '') and (SewJobCreLine4Rec."60" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."60");
                                            Evaluate(Number2, RatioCreLineRec."60");
                                            RatioCreLineRec."60" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."61" <> '') and (SewJobCreLine4Rec."61" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."61");
                                            Evaluate(Number2, RatioCreLineRec."61");
                                            RatioCreLineRec."61" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."62" <> '') and (SewJobCreLine4Rec."62" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."62");
                                            Evaluate(Number2, RatioCreLineRec."62");
                                            RatioCreLineRec."62" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."63" <> '') and (SewJobCreLine4Rec."63" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."63");
                                            Evaluate(Number2, RatioCreLineRec."63");
                                            RatioCreLineRec."63" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."64" <> '') and (SewJobCreLine4Rec."64" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."64");
                                            Evaluate(Number2, RatioCreLineRec."64");
                                            RatioCreLineRec."64" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        RatioCreLineRec."Color Total" := ColorTotal;
                                        RatioCreLineRec.Modify();
                                    end;

                                end;

                                if (SewJobCreLine4Rec."Record Type" = 'L') then begin

                                    //Check Total Line (R)                  
                                    RatioCreLineRec.Reset();
                                    RatioCreLineRec.SetRange(RatioCreNo, RatioCreNo);
                                    RatioCreLineRec.SetRange("Style No.", SewJobCreLine4Rec."Style No.");
                                    //RatioCreLineRec.SetRange("Lot No.", SewJobCreLine4Rec."Lot No.");
                                    RatioCreLineRec.SetRange("Group ID", "Group ID");
                                    RatioCreLineRec.SetFilter("Record Type", '%1', 'R');

                                    //Insert Total Line (R)                  
                                    if not RatioCreLineRec.FindSet() then begin

                                        LineNo += 1;
                                        //Insert R Line
                                        RatioCreLineRec.Init();
                                        RatioCreLineRec."Created Date" := Today;
                                        RatioCreLineRec."Created User" := UserId;
                                        RatioCreLineRec."Group ID" := "Group ID";
                                        RatioCreLineRec.LineNo := LineNo;
                                        // RatioCreLineRec."Lot No." := SewJobCreLine4Rec."Lot No.";
                                        // RatioCreLineRec."PO No." := SewJobCreLine4Rec."PO No.";
                                        RatioCreLineRec.qty := 0;
                                        RatioCreLineRec."Record Type" := 'R';
                                        // RatioCreLineRec."Sewing Job No." := SewJobCreLine4Rec."Sewing Job No.";
                                        // RatioCreLineRec.ShipDate := SewJobCreLine4Rec.ShipDate;
                                        RatioCreLineRec."Style Name" := "Style Name";
                                        RatioCreLineRec."Style No." := "Style No.";
                                        //RatioCreLineRec."SubLotNo." := SewJobCreLine4Rec."SubLotNo.";
                                        RatioCreLineRec."Component Group Code" := "Component Group";
                                        RatioCreLineRec."Marker Name" := 'R1';
                                        RatioCreLineRec.UOM := UOM;
                                        RatioCreLineRec."UOM Code" := UOMCode;
                                        RatioCreLineRec."Colour No" := "Colour No";
                                        RatioCreLineRec."Colour Name" := "Colour Name";
                                        RatioCreLineRec.Plies := 0;

                                        RatioCreLineRec."1" := SewJobCreLine4Rec."1";
                                        RatioCreLineRec."2" := SewJobCreLine4Rec."2";
                                        RatioCreLineRec."3" := SewJobCreLine4Rec."3";
                                        RatioCreLineRec."4" := SewJobCreLine4Rec."4";
                                        RatioCreLineRec."5" := SewJobCreLine4Rec."5";
                                        RatioCreLineRec."6" := SewJobCreLine4Rec."6";
                                        RatioCreLineRec."7" := SewJobCreLine4Rec."7";
                                        RatioCreLineRec."8" := SewJobCreLine4Rec."8";
                                        RatioCreLineRec."9" := SewJobCreLine4Rec."9";
                                        RatioCreLineRec."10" := SewJobCreLine4Rec."10";
                                        RatioCreLineRec."11" := SewJobCreLine4Rec."11";
                                        RatioCreLineRec."12" := SewJobCreLine4Rec."12";
                                        RatioCreLineRec."13" := SewJobCreLine4Rec."13";
                                        RatioCreLineRec."14" := SewJobCreLine4Rec."14";
                                        RatioCreLineRec."15" := SewJobCreLine4Rec."15";
                                        RatioCreLineRec."16" := SewJobCreLine4Rec."16";
                                        RatioCreLineRec."17" := SewJobCreLine4Rec."17";
                                        RatioCreLineRec."18" := SewJobCreLine4Rec."18";
                                        RatioCreLineRec."19" := SewJobCreLine4Rec."19";
                                        RatioCreLineRec."20" := SewJobCreLine4Rec."20";
                                        RatioCreLineRec."21" := SewJobCreLine4Rec."21";
                                        RatioCreLineRec."22" := SewJobCreLine4Rec."22";
                                        RatioCreLineRec."23" := SewJobCreLine4Rec."23";
                                        RatioCreLineRec."24" := SewJobCreLine4Rec."24";
                                        RatioCreLineRec."25" := SewJobCreLine4Rec."25";
                                        RatioCreLineRec."26" := SewJobCreLine4Rec."26";
                                        RatioCreLineRec."27" := SewJobCreLine4Rec."27";
                                        RatioCreLineRec."28" := SewJobCreLine4Rec."28";
                                        RatioCreLineRec."29" := SewJobCreLine4Rec."29";
                                        RatioCreLineRec."30" := SewJobCreLine4Rec."30";
                                        RatioCreLineRec."31" := SewJobCreLine4Rec."31";
                                        RatioCreLineRec."32" := SewJobCreLine4Rec."32";
                                        RatioCreLineRec."33" := SewJobCreLine4Rec."33";
                                        RatioCreLineRec."34" := SewJobCreLine4Rec."34";
                                        RatioCreLineRec."35" := SewJobCreLine4Rec."35";
                                        RatioCreLineRec."36" := SewJobCreLine4Rec."36";
                                        RatioCreLineRec."37" := SewJobCreLine4Rec."37";
                                        RatioCreLineRec."38" := SewJobCreLine4Rec."38";
                                        RatioCreLineRec."39" := SewJobCreLine4Rec."39";
                                        RatioCreLineRec."40" := SewJobCreLine4Rec."40";
                                        RatioCreLineRec."41" := SewJobCreLine4Rec."41";
                                        RatioCreLineRec."42" := SewJobCreLine4Rec."42";
                                        RatioCreLineRec."43" := SewJobCreLine4Rec."43";
                                        RatioCreLineRec."44" := SewJobCreLine4Rec."44";
                                        RatioCreLineRec."45" := SewJobCreLine4Rec."45";
                                        RatioCreLineRec."46" := SewJobCreLine4Rec."46";
                                        RatioCreLineRec."47" := SewJobCreLine4Rec."47";
                                        RatioCreLineRec."48" := SewJobCreLine4Rec."48";
                                        RatioCreLineRec."49" := SewJobCreLine4Rec."49";
                                        RatioCreLineRec."50" := SewJobCreLine4Rec."50";
                                        RatioCreLineRec."51" := SewJobCreLine4Rec."51";
                                        RatioCreLineRec."52" := SewJobCreLine4Rec."52";
                                        RatioCreLineRec."53" := SewJobCreLine4Rec."53";
                                        RatioCreLineRec."54" := SewJobCreLine4Rec."54";
                                        RatioCreLineRec."55" := SewJobCreLine4Rec."55";
                                        RatioCreLineRec."56" := SewJobCreLine4Rec."56";
                                        RatioCreLineRec."57" := SewJobCreLine4Rec."57";
                                        RatioCreLineRec."58" := SewJobCreLine4Rec."58";
                                        RatioCreLineRec."59" := SewJobCreLine4Rec."59";
                                        RatioCreLineRec."60" := SewJobCreLine4Rec."60";
                                        RatioCreLineRec."61" := SewJobCreLine4Rec."61";
                                        RatioCreLineRec."62" := SewJobCreLine4Rec."62";
                                        RatioCreLineRec."63" := SewJobCreLine4Rec."63";
                                        RatioCreLineRec."64" := SewJobCreLine4Rec."64";

                                        RatioCreLineRec.Insert();
                                    end
                                    else begin

                                        //Modify Total Line (R)      
                                        if (SewJobCreLine4Rec."1" <> '') and (SewJobCreLine4Rec."1" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."1");
                                            Evaluate(Number2, RatioCreLineRec."1");
                                            RatioCreLineRec."1" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."2" <> '') and (SewJobCreLine4Rec."2" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."2");
                                            Evaluate(Number2, RatioCreLineRec."2");
                                            RatioCreLineRec."2" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."3" <> '') and (SewJobCreLine4Rec."3" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."3");
                                            Evaluate(Number2, RatioCreLineRec."3");
                                            RatioCreLineRec."3" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."4" <> '') and (SewJobCreLine4Rec."4" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."4");
                                            Evaluate(Number2, RatioCreLineRec."4");
                                            RatioCreLineRec."4" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."5" <> '') and (SewJobCreLine4Rec."5" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."5");
                                            Evaluate(Number2, RatioCreLineRec."5");
                                            RatioCreLineRec."5" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."6" <> '') and (SewJobCreLine4Rec."6" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."6");
                                            Evaluate(Number2, RatioCreLineRec."6");
                                            RatioCreLineRec."6" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."7" <> '') and (SewJobCreLine4Rec."7" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."7");
                                            Evaluate(Number2, RatioCreLineRec."7");
                                            RatioCreLineRec."7" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."8" <> '') and (SewJobCreLine4Rec."8" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."8");
                                            Evaluate(Number2, RatioCreLineRec."8");
                                            RatioCreLineRec."8" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."9" <> '') and (SewJobCreLine4Rec."9" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."9");
                                            Evaluate(Number2, RatioCreLineRec."9");
                                            RatioCreLineRec."9" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."10" <> '') and (SewJobCreLine4Rec."10" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."10");
                                            Evaluate(Number2, RatioCreLineRec."10");
                                            RatioCreLineRec."10" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."11" <> '') and (SewJobCreLine4Rec."11" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."11");
                                            Evaluate(Number2, RatioCreLineRec."11");
                                            RatioCreLineRec."11" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."12" <> '') and (SewJobCreLine4Rec."12" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."12");
                                            Evaluate(Number2, RatioCreLineRec."12");
                                            RatioCreLineRec."12" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."13" <> '') and (SewJobCreLine4Rec."13" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."13");
                                            Evaluate(Number2, RatioCreLineRec."13");
                                            RatioCreLineRec."13" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."14" <> '') and (SewJobCreLine4Rec."14" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."14");
                                            Evaluate(Number2, RatioCreLineRec."14");
                                            RatioCreLineRec."14" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."15" <> '') and (SewJobCreLine4Rec."15" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."15");
                                            Evaluate(Number2, RatioCreLineRec."15");
                                            RatioCreLineRec."15" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."16" <> '') and (SewJobCreLine4Rec."16" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."16");
                                            Evaluate(Number2, RatioCreLineRec."16");
                                            RatioCreLineRec."16" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."17" <> '') and (SewJobCreLine4Rec."17" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."17");
                                            Evaluate(Number2, RatioCreLineRec."17");
                                            RatioCreLineRec."17" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."18" <> '') and (SewJobCreLine4Rec."18" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."18");
                                            Evaluate(Number2, RatioCreLineRec."18");
                                            RatioCreLineRec."18" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."19" <> '') and (SewJobCreLine4Rec."19" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."19");
                                            Evaluate(Number2, RatioCreLineRec."19");
                                            RatioCreLineRec."19" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."20" <> '') and (SewJobCreLine4Rec."20" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."20");
                                            Evaluate(Number2, RatioCreLineRec."20");
                                            RatioCreLineRec."20" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."21" <> '') and (SewJobCreLine4Rec."21" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."21");
                                            Evaluate(Number2, RatioCreLineRec."21");
                                            RatioCreLineRec."21" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."22" <> '') and (SewJobCreLine4Rec."22" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."22");
                                            Evaluate(Number2, RatioCreLineRec."22");
                                            RatioCreLineRec."22" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."23" <> '') and (SewJobCreLine4Rec."23" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."23");
                                            Evaluate(Number2, RatioCreLineRec."23");
                                            RatioCreLineRec."23" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."24" <> '') and (SewJobCreLine4Rec."24" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."24");
                                            Evaluate(Number2, RatioCreLineRec."24");
                                            RatioCreLineRec."24" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."25" <> '') and (SewJobCreLine4Rec."25" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."25");
                                            Evaluate(Number2, RatioCreLineRec."25");
                                            RatioCreLineRec."25" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."26" <> '') and (SewJobCreLine4Rec."26" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."26");
                                            Evaluate(Number2, RatioCreLineRec."26");
                                            RatioCreLineRec."26" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."27" <> '') and (SewJobCreLine4Rec."27" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."27");
                                            Evaluate(Number2, RatioCreLineRec."27");
                                            RatioCreLineRec."27" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."28" <> '') and (SewJobCreLine4Rec."28" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."28");
                                            Evaluate(Number2, RatioCreLineRec."28");
                                            RatioCreLineRec."28" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."29" <> '') and (SewJobCreLine4Rec."29" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."29");
                                            Evaluate(Number2, RatioCreLineRec."29");
                                            RatioCreLineRec."29" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."30" <> '') and (SewJobCreLine4Rec."30" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."30");
                                            Evaluate(Number2, RatioCreLineRec."30");
                                            RatioCreLineRec."30" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."31" <> '') and (SewJobCreLine4Rec."31" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."31");
                                            Evaluate(Number2, RatioCreLineRec."31");
                                            RatioCreLineRec."31" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."32" <> '') and (SewJobCreLine4Rec."32" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."32");
                                            Evaluate(Number2, RatioCreLineRec."32");
                                            RatioCreLineRec."32" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."33" <> '') and (SewJobCreLine4Rec."33" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."33");
                                            Evaluate(Number2, RatioCreLineRec."33");
                                            RatioCreLineRec."33" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."34" <> '') and (SewJobCreLine4Rec."34" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."34");
                                            Evaluate(Number2, RatioCreLineRec."34");
                                            RatioCreLineRec."34" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."35" <> '') and (SewJobCreLine4Rec."35" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."35");
                                            Evaluate(Number2, RatioCreLineRec."35");
                                            RatioCreLineRec."35" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."36" <> '') and (SewJobCreLine4Rec."36" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."36");
                                            Evaluate(Number2, RatioCreLineRec."36");
                                            RatioCreLineRec."36" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."37" <> '') and (SewJobCreLine4Rec."37" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."37");
                                            Evaluate(Number2, RatioCreLineRec."37");
                                            RatioCreLineRec."37" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."38" <> '') and (SewJobCreLine4Rec."38" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."38");
                                            Evaluate(Number2, RatioCreLineRec."38");
                                            RatioCreLineRec."38" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."39" <> '') and (SewJobCreLine4Rec."39" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."39");
                                            Evaluate(Number2, RatioCreLineRec."39");
                                            RatioCreLineRec."39" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."40" <> '') and (SewJobCreLine4Rec."40" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."40");
                                            Evaluate(Number2, RatioCreLineRec."40");
                                            RatioCreLineRec."40" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."41" <> '') and (SewJobCreLine4Rec."41" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."41");
                                            Evaluate(Number2, RatioCreLineRec."41");
                                            RatioCreLineRec."41" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."42" <> '') and (SewJobCreLine4Rec."42" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."42");
                                            Evaluate(Number2, RatioCreLineRec."42");
                                            RatioCreLineRec."42" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."43" <> '') and (SewJobCreLine4Rec."43" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."43");
                                            Evaluate(Number2, RatioCreLineRec."43");
                                            RatioCreLineRec."43" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."44" <> '') and (SewJobCreLine4Rec."44" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."44");
                                            Evaluate(Number2, RatioCreLineRec."44");
                                            RatioCreLineRec."44" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."45" <> '') and (SewJobCreLine4Rec."45" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."45");
                                            Evaluate(Number2, RatioCreLineRec."45");
                                            RatioCreLineRec."45" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."46" <> '') and (SewJobCreLine4Rec."46" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."46");
                                            Evaluate(Number2, RatioCreLineRec."46");
                                            RatioCreLineRec."46" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."47" <> '') and (SewJobCreLine4Rec."47" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."47");
                                            Evaluate(Number2, RatioCreLineRec."47");
                                            RatioCreLineRec."47" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."48" <> '') and (SewJobCreLine4Rec."48" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."48");
                                            Evaluate(Number2, RatioCreLineRec."48");
                                            RatioCreLineRec."48" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."49" <> '') and (SewJobCreLine4Rec."49" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."49");
                                            Evaluate(Number2, RatioCreLineRec."49");
                                            RatioCreLineRec."49" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."50" <> '') and (SewJobCreLine4Rec."50" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."50");
                                            Evaluate(Number2, RatioCreLineRec."50");
                                            RatioCreLineRec."50" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."51" <> '') and (SewJobCreLine4Rec."51" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."51");
                                            Evaluate(Number2, RatioCreLineRec."51");
                                            RatioCreLineRec."51" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."52" <> '') and (SewJobCreLine4Rec."52" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."52");
                                            Evaluate(Number2, RatioCreLineRec."52");
                                            RatioCreLineRec."52" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."53" <> '') and (SewJobCreLine4Rec."53" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."53");
                                            Evaluate(Number2, RatioCreLineRec."53");
                                            RatioCreLineRec."53" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."54" <> '') and (SewJobCreLine4Rec."54" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."54");
                                            Evaluate(Number2, RatioCreLineRec."54");
                                            RatioCreLineRec."54" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."55" <> '') and (SewJobCreLine4Rec."55" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."55");
                                            Evaluate(Number2, RatioCreLineRec."55");
                                            RatioCreLineRec."55" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."56" <> '') and (SewJobCreLine4Rec."56" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."56");
                                            Evaluate(Number2, RatioCreLineRec."56");
                                            RatioCreLineRec."56" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."57" <> '') and (SewJobCreLine4Rec."57" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."57");
                                            Evaluate(Number2, RatioCreLineRec."57");
                                            RatioCreLineRec."57" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."58" <> '') and (SewJobCreLine4Rec."58" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."58");
                                            Evaluate(Number2, RatioCreLineRec."58");
                                            RatioCreLineRec."58" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."59" <> '') and (SewJobCreLine4Rec."59" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."59");
                                            Evaluate(Number2, RatioCreLineRec."59");
                                            RatioCreLineRec."59" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1
                                        end;

                                        if (SewJobCreLine4Rec."60" <> '') and (SewJobCreLine4Rec."60" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."60");
                                            Evaluate(Number2, RatioCreLineRec."60");
                                            RatioCreLineRec."60" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."61" <> '') and (SewJobCreLine4Rec."61" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."61");
                                            Evaluate(Number2, RatioCreLineRec."61");
                                            RatioCreLineRec."61" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."62" <> '') and (SewJobCreLine4Rec."62" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."62");
                                            Evaluate(Number2, RatioCreLineRec."62");
                                            RatioCreLineRec."62" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."63" <> '') and (SewJobCreLine4Rec."63" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."63");
                                            Evaluate(Number2, RatioCreLineRec."63");
                                            RatioCreLineRec."63" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        if (SewJobCreLine4Rec."64" <> '') and (SewJobCreLine4Rec."64" <> '0') then begin
                                            Evaluate(Number1, SewJobCreLine4Rec."64");
                                            Evaluate(Number2, RatioCreLineRec."64");
                                            RatioCreLineRec."64" := format(Number1 + Number2);
                                            ColorTotal := ColorTotal + Number1;
                                        end;

                                        RatioCreLineRec."Color Total" := ColorTotal;
                                        RatioCreLineRec.Modify();
                                    end;
                                end;

                            //end;

                            until SewJobCreLine4Rec.Next() = 0;

                            Message('Completed');

                        end;
                    end;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."RatioCre Nos.", xRec."RatioCreNo", "RatioCreNo") THEN BEGIN
            NoSeriesMngment.SetSeries(RatioCreNo);
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        CurCreLineRec: Record CutCreationLine;
        RatioLineRec: Record RatioCreationLine;
        FabRec: Record FabricRequsition;
    begin

        //Get Ratio lines
        RatioLineRec.Reset();
        RatioLineRec.SetRange(RatioCreNo, RatioCreNo);
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
        RatioLineRec.SetRange(RatioCreNo, RatioCreNo);
        if RatioLineRec.FindSet() then
            RatioLineRec.DeleteAll();
    end;
}


// begin

//                     //Get UOM
//                     RatioCreRec.Reset();
//                     RatioCreRec.SetRange(RatioCreNo, RatioCreNo);

//                     if RatioCreRec.FindSet() then begin
//                         UOM := RatioCreRec.UOM;
//                         UOMCode := RatioCreRec."UOM Code";
//                     end;


//                     if ("Style Name" = '') then
//                         Error('Invalid Style');

//                     if ("Colour Name" = '') then
//                         Error('Invalid Colour');

//                     if ("Group ID" = 0) then
//                         Error('Invalid Group');

//                     if ("Component Group" = '') then
//                         Error('Invalid Component');

//                     //Get Max line no
//                     RatioCreLineRec.Reset();
//                     RatioCreLineRec.SetRange(RatioCreNo, RatioCreNo);
//                     RatioCreLineRec.SetRange("Group ID", "Group ID");

//                     if RatioCreLineRec.FindLast() then
//                         LineNo := RatioCreLineRec.LineNo;


//                     //Get selected records for the group
//                     SewJobCreLine4Rec.Reset();
//                     SewJobCreLine4Rec.SetRange("Style No.", "Style No.");
//                     SewJobCreLine4Rec.SetRange("Group ID", "Group ID");
//                    

//                     if SewJobCreLine4Rec.FindSet() then begin

//                         if (Dialog.CONFIRM('"Create Ratio" will earse old records. Do you want to continue?', true) = true) then begin

//                             //Delete old records
//                             RatioCreLineRec.Reset();
//                             RatioCreLineRec.SetRange(RatioCreNo, RatioCreNo);
//                             RatioCreLineRec.DeleteAll();

//                             repeat

//                                 if (SewJobCreLine4Rec."Record Type" = 'L') then begin

//                                     LineNo += 1;

//                                     //Check for Header record (H)
//                                     RatioCreLineRec.Reset();
//                                     RatioCreLineRec.SetRange(RatioCreNo, RatioCreNo);
//                                     RatioCreLineRec.SetRange("Style No.", SewJobCreLine4Rec."Style No.");
//                                     RatioCreLineRec.SetRange("Lot No.", SewJobCreLine4Rec."Lot No.");
//                                     RatioCreLineRec.SetRange("Group ID", "Group ID");
//                                     RatioCreLineRec.SetFilter("Record Type", '%1', 'H');

//                                     if not RatioCreLineRec.FindSet() then begin

//                                         //Get Size details
//                                         SewJobCreLine4Rec1.Reset();
//                                         SewJobCreLine4Rec1.SetRange("Style No.", SewJobCreLine4Rec."Style No.");
//                                         SewJobCreLine4Rec1.SetRange("Lot No.", SewJobCreLine4Rec."Lot No.");
//                                         SewJobCreLine4Rec1.SetRange("Record Type", 'H');

//                                         if SewJobCreLine4Rec1.FindSet() then begin
//                                             RatioCreLineRec.Init();
//                                             RatioCreLineRec.RatioCreNo := RatioCreNo;
//                                             RatioCreLineRec."Created Date" := Today;
//                                             RatioCreLineRec."Created User" := UserId;
//                                             RatioCreLineRec."Group ID" := "Group ID";
//                                             RatioCreLineRec.LineNo := LineNo;
//                                             RatioCreLineRec."Lot No." := SewJobCreLine4Rec1."Lot No.";
//                                             RatioCreLineRec."PO No." := SewJobCreLine4Rec1."PO No.";
//                                             RatioCreLineRec.qty := 0;
//                                             RatioCreLineRec."Record Type" := 'H';
//                                             RatioCreLineRec."Sewing Job No." := SewJobCreLine4Rec1."Sewing Job No.";
//                                             RatioCreLineRec.ShipDate := SewJobCreLine4Rec1.ShipDate;
//                                             RatioCreLineRec."Style Name" := "Style Name";
//                                             RatioCreLineRec."Style No." := "Style No.";
//                                             RatioCreLineRec."SubLotNo." := SewJobCreLine4Rec1."SubLotNo.";
//                                             RatioCreLineRec."Component Group Code" := "Component Group";
//                                             RatioCreLineRec.UOM := UOM;
//                                             RatioCreLineRec."UOM Code" := UOMCode;
//                                             RatioCreLineRec."Colour No" := "Colour No";
//                                             RatioCreLineRec."Colour Name" := "Colour Name";

//                                             RatioCreLineRec."1" := SewJobCreLine4Rec1."1";
//                                             RatioCreLineRec."2" := SewJobCreLine4Rec1."2";
//                                             RatioCreLineRec."3" := SewJobCreLine4Rec1."3";
//                                             RatioCreLineRec."4" := SewJobCreLine4Rec1."4";
//                                             RatioCreLineRec."5" := SewJobCreLine4Rec1."5";
//                                             RatioCreLineRec."6" := SewJobCreLine4Rec1."6";
//                                             RatioCreLineRec."7" := SewJobCreLine4Rec1."7";
//                                             RatioCreLineRec."8" := SewJobCreLine4Rec1."8";
//                                             RatioCreLineRec."9" := SewJobCreLine4Rec1."9";
//                                             RatioCreLineRec."10" := SewJobCreLine4Rec1."10";
//                                             RatioCreLineRec."11" := SewJobCreLine4Rec1."11";
//                                             RatioCreLineRec."12" := SewJobCreLine4Rec1."12";
//                                             RatioCreLineRec."13" := SewJobCreLine4Rec1."13";
//                                             RatioCreLineRec."14" := SewJobCreLine4Rec1."14";
//                                             RatioCreLineRec."15" := SewJobCreLine4Rec1."15";
//                                             RatioCreLineRec."16" := SewJobCreLine4Rec1."16";
//                                             RatioCreLineRec."17" := SewJobCreLine4Rec1."17";
//                                             RatioCreLineRec."18" := SewJobCreLine4Rec1."18";
//                                             RatioCreLineRec."19" := SewJobCreLine4Rec1."19";
//                                             RatioCreLineRec."20" := SewJobCreLine4Rec1."20";
//                                             RatioCreLineRec."21" := SewJobCreLine4Rec1."21";
//                                             RatioCreLineRec."22" := SewJobCreLine4Rec1."22";
//                                             RatioCreLineRec."23" := SewJobCreLine4Rec1."23";
//                                             RatioCreLineRec."24" := SewJobCreLine4Rec1."24";
//                                             RatioCreLineRec."25" := SewJobCreLine4Rec1."25";
//                                             RatioCreLineRec."26" := SewJobCreLine4Rec1."26";
//                                             RatioCreLineRec."27" := SewJobCreLine4Rec1."27";
//                                             RatioCreLineRec."28" := SewJobCreLine4Rec1."28";
//                                             RatioCreLineRec."29" := SewJobCreLine4Rec1."29";
//                                             RatioCreLineRec."30" := SewJobCreLine4Rec1."30";
//                                             RatioCreLineRec."31" := SewJobCreLine4Rec1."31";
//                                             RatioCreLineRec."32" := SewJobCreLine4Rec1."32";
//                                             RatioCreLineRec."33" := SewJobCreLine4Rec1."33";
//                                             RatioCreLineRec."34" := SewJobCreLine4Rec1."34";
//                                             RatioCreLineRec."35" := SewJobCreLine4Rec1."35";
//                                             RatioCreLineRec."36" := SewJobCreLine4Rec1."36";
//                                             RatioCreLineRec."37" := SewJobCreLine4Rec1."37";
//                                             RatioCreLineRec."38" := SewJobCreLine4Rec1."38";
//                                             RatioCreLineRec."39" := SewJobCreLine4Rec1."39";
//                                             RatioCreLineRec."40" := SewJobCreLine4Rec1."40";
//                                             RatioCreLineRec."41" := SewJobCreLine4Rec1."41";
//                                             RatioCreLineRec."42" := SewJobCreLine4Rec1."42";
//                                             RatioCreLineRec."43" := SewJobCreLine4Rec1."43";
//                                             RatioCreLineRec."44" := SewJobCreLine4Rec1."44";
//                                             RatioCreLineRec."45" := SewJobCreLine4Rec1."45";
//                                             RatioCreLineRec."46" := SewJobCreLine4Rec1."46";
//                                             RatioCreLineRec."47" := SewJobCreLine4Rec1."47";
//                                             RatioCreLineRec."48" := SewJobCreLine4Rec1."48";
//                                             RatioCreLineRec."49" := SewJobCreLine4Rec1."49";
//                                             RatioCreLineRec."50" := SewJobCreLine4Rec1."50";
//                                             RatioCreLineRec."51" := SewJobCreLine4Rec1."51";
//                                             RatioCreLineRec."52" := SewJobCreLine4Rec1."52";
//                                             RatioCreLineRec."53" := SewJobCreLine4Rec1."53";
//                                             RatioCreLineRec."54" := SewJobCreLine4Rec1."54";
//                                             RatioCreLineRec."55" := SewJobCreLine4Rec1."55";
//                                             RatioCreLineRec."56" := SewJobCreLine4Rec1."56";
//                                             RatioCreLineRec."57" := SewJobCreLine4Rec1."57";
//                                             RatioCreLineRec."58" := SewJobCreLine4Rec1."58";
//                                             RatioCreLineRec."59" := SewJobCreLine4Rec1."59";
//                                             RatioCreLineRec."60" := SewJobCreLine4Rec1."60";
//                                             RatioCreLineRec."61" := SewJobCreLine4Rec1."61";
//                                             RatioCreLineRec."62" := SewJobCreLine4Rec1."62";
//                                             RatioCreLineRec."63" := SewJobCreLine4Rec1."63";
//                                             RatioCreLineRec."64" := SewJobCreLine4Rec1."64";

//                                             RatioCreLineRec.Insert();
//                                         end;

//                                     end;

//                                     //Check Total Line (H1)                  
//                                     RatioCreLineRec.Reset();
//                                     RatioCreLineRec.SetRange(RatioCreNo, RatioCreNo);
//                                     RatioCreLineRec.SetRange("Style No.", SewJobCreLine4Rec."Style No.");
//                                     RatioCreLineRec.SetRange("Lot No.", SewJobCreLine4Rec."Lot No.");
//                                     RatioCreLineRec.SetRange("Group ID", "Group ID");
//                                     RatioCreLineRec.SetFilter("Record Type", '%1', 'H1');

//                                     //Insert Total Line (H1)                  
//                                     if not RatioCreLineRec.FindSet() then begin

//                                         RatioCreLineRec.Init();
//                                         RatioCreLineRec.RatioCreNo := RatioCreNo;
//                                         RatioCreLineRec."Created Date" := Today;
//                                         RatioCreLineRec."Created User" := UserId;
//                                         RatioCreLineRec."Group ID" := "Group ID";
//                                         RatioCreLineRec.LineNo := LineNo + 1;
//                                         RatioCreLineRec."Lot No." := SewJobCreLine4Rec."Lot No.";
//                                         RatioCreLineRec."PO No." := SewJobCreLine4Rec."PO No.";
//                                         RatioCreLineRec.qty := 0;
//                                         RatioCreLineRec."Record Type" := 'H1';
//                                         RatioCreLineRec."Sewing Job No." := SewJobCreLine4Rec."Sewing Job No.";
//                                         RatioCreLineRec.ShipDate := SewJobCreLine4Rec.ShipDate;
//                                         RatioCreLineRec."Style Name" := "Style Name";
//                                         RatioCreLineRec."Style No." := "Style No.";
//                                         RatioCreLineRec."SubLotNo." := SewJobCreLine4Rec."SubLotNo.";
//                                         RatioCreLineRec."Component Group Code" := "Component Group";
//                                         RatioCreLineRec.UOM := UOM;
//                                         RatioCreLineRec."UOM Code" := UOMCode;
//                                         RatioCreLineRec."Colour No" := "Colour No";
//                                         RatioCreLineRec."Colour Name" := "Colour Name";
//                                         RatioCreLineRec."1" := SewJobCreLine4Rec."1";
//                                         RatioCreLineRec."2" := SewJobCreLine4Rec."2";
//                                         RatioCreLineRec."3" := SewJobCreLine4Rec."3";
//                                         RatioCreLineRec."4" := SewJobCreLine4Rec."4";
//                                         RatioCreLineRec."5" := SewJobCreLine4Rec."5";
//                                         RatioCreLineRec."6" := SewJobCreLine4Rec."6";
//                                         RatioCreLineRec."7" := SewJobCreLine4Rec."7";
//                                         RatioCreLineRec."8" := SewJobCreLine4Rec."8";
//                                         RatioCreLineRec."9" := SewJobCreLine4Rec."9";
//                                         RatioCreLineRec."10" := SewJobCreLine4Rec."10";
//                                         RatioCreLineRec."11" := SewJobCreLine4Rec."11";
//                                         RatioCreLineRec."12" := SewJobCreLine4Rec."12";
//                                         RatioCreLineRec."13" := SewJobCreLine4Rec."13";
//                                         RatioCreLineRec."14" := SewJobCreLine4Rec."14";
//                                         RatioCreLineRec."15" := SewJobCreLine4Rec."15";
//                                         RatioCreLineRec."16" := SewJobCreLine4Rec."16";
//                                         RatioCreLineRec."17" := SewJobCreLine4Rec."17";
//                                         RatioCreLineRec."18" := SewJobCreLine4Rec."18";
//                                         RatioCreLineRec."19" := SewJobCreLine4Rec."19";
//                                         RatioCreLineRec."20" := SewJobCreLine4Rec."20";
//                                         RatioCreLineRec."21" := SewJobCreLine4Rec."21";
//                                         RatioCreLineRec."22" := SewJobCreLine4Rec."22";
//                                         RatioCreLineRec."23" := SewJobCreLine4Rec."23";
//                                         RatioCreLineRec."24" := SewJobCreLine4Rec."24";
//                                         RatioCreLineRec."25" := SewJobCreLine4Rec."25";
//                                         RatioCreLineRec."26" := SewJobCreLine4Rec."26";
//                                         RatioCreLineRec."27" := SewJobCreLine4Rec."27";
//                                         RatioCreLineRec."28" := SewJobCreLine4Rec."28";
//                                         RatioCreLineRec."29" := SewJobCreLine4Rec."29";
//                                         RatioCreLineRec."30" := SewJobCreLine4Rec."30";
//                                         RatioCreLineRec."31" := SewJobCreLine4Rec."31";
//                                         RatioCreLineRec."32" := SewJobCreLine4Rec."32";
//                                         RatioCreLineRec."33" := SewJobCreLine4Rec."33";
//                                         RatioCreLineRec."34" := SewJobCreLine4Rec."34";
//                                         RatioCreLineRec."35" := SewJobCreLine4Rec."35";
//                                         RatioCreLineRec."36" := SewJobCreLine4Rec."36";
//                                         RatioCreLineRec."37" := SewJobCreLine4Rec."37";
//                                         RatioCreLineRec."38" := SewJobCreLine4Rec."38";
//                                         RatioCreLineRec."39" := SewJobCreLine4Rec."39";
//                                         RatioCreLineRec."40" := SewJobCreLine4Rec."40";
//                                         RatioCreLineRec."41" := SewJobCreLine4Rec."41";
//                                         RatioCreLineRec."42" := SewJobCreLine4Rec."42";
//                                         RatioCreLineRec."43" := SewJobCreLine4Rec."43";
//                                         RatioCreLineRec."44" := SewJobCreLine4Rec."44";
//                                         RatioCreLineRec."45" := SewJobCreLine4Rec."45";
//                                         RatioCreLineRec."46" := SewJobCreLine4Rec."46";
//                                         RatioCreLineRec."47" := SewJobCreLine4Rec."47";
//                                         RatioCreLineRec."48" := SewJobCreLine4Rec."48";
//                                         RatioCreLineRec."49" := SewJobCreLine4Rec."49";
//                                         RatioCreLineRec."50" := SewJobCreLine4Rec."50";
//                                         RatioCreLineRec."51" := SewJobCreLine4Rec."51";
//                                         RatioCreLineRec."52" := SewJobCreLine4Rec."52";
//                                         RatioCreLineRec."53" := SewJobCreLine4Rec."53";
//                                         RatioCreLineRec."54" := SewJobCreLine4Rec."54";
//                                         RatioCreLineRec."55" := SewJobCreLine4Rec."55";
//                                         RatioCreLineRec."56" := SewJobCreLine4Rec."56";
//                                         RatioCreLineRec."57" := SewJobCreLine4Rec."57";
//                                         RatioCreLineRec."58" := SewJobCreLine4Rec."58";
//                                         RatioCreLineRec."59" := SewJobCreLine4Rec."59";
//                                         RatioCreLineRec."60" := SewJobCreLine4Rec."60";
//                                         RatioCreLineRec."61" := SewJobCreLine4Rec."61";
//                                         RatioCreLineRec."62" := SewJobCreLine4Rec."62";
//                                         RatioCreLineRec."63" := SewJobCreLine4Rec."63";
//                                         RatioCreLineRec."64" := SewJobCreLine4Rec."64";

//                                         RatioCreLineRec.Insert();

//                                         //Insert R1 Line
//                                         RatioCreLineRec.Init();
//                                         RatioCreLineRec."Created Date" := Today;
//                                         RatioCreLineRec."Created User" := UserId;
//                                         RatioCreLineRec."Group ID" := "Group ID";
//                                         RatioCreLineRec.LineNo := LineNo + 2;
//                                         RatioCreLineRec."Lot No." := SewJobCreLine4Rec."Lot No.";
//                                         RatioCreLineRec."PO No." := SewJobCreLine4Rec."PO No.";
//                                         RatioCreLineRec.qty := 0;
//                                         RatioCreLineRec."Record Type" := 'R';
//                                         RatioCreLineRec."Sewing Job No." := SewJobCreLine4Rec."Sewing Job No.";
//                                         RatioCreLineRec.ShipDate := SewJobCreLine4Rec.ShipDate;
//                                         RatioCreLineRec."Style Name" := "Style Name";
//                                         RatioCreLineRec."Style No." := "Style No.";
//                                         RatioCreLineRec."SubLotNo." := SewJobCreLine4Rec."SubLotNo.";
//                                         RatioCreLineRec."Component Group Code" := "Component Group";
//                                         RatioCreLineRec."Marker Name" := 'R1';
//                                         RatioCreLineRec.UOM := UOM;
//                                         RatioCreLineRec."UOM Code" := UOMCode;
//                                         RatioCreLineRec."Colour No" := "Colour No";
//                                         RatioCreLineRec."Colour Name" := "Colour Name";
//                                         RatioCreLineRec.Plies := 0;
//                                         RatioCreLineRec."1" := '0';
//                                         RatioCreLineRec."2" := '0';
//                                         RatioCreLineRec."3" := '0';
//                                         RatioCreLineRec."4" := '0';
//                                         RatioCreLineRec."5" := '0';
//                                         RatioCreLineRec."6" := '0';
//                                         RatioCreLineRec."7" := '0';
//                                         RatioCreLineRec."8" := '0';
//                                         RatioCreLineRec."9" := '0';
//                                         RatioCreLineRec."10" := '0';
//                                         RatioCreLineRec."11" := '0';
//                                         RatioCreLineRec."12" := '0';
//                                         RatioCreLineRec."13" := '0';
//                                         RatioCreLineRec."14" := '0';
//                                         RatioCreLineRec."15" := '0';
//                                         RatioCreLineRec."16" := '0';
//                                         RatioCreLineRec."17" := '0';
//                                         RatioCreLineRec."18" := '0';
//                                         RatioCreLineRec."19" := '0';
//                                         RatioCreLineRec."20" := '0';
//                                         RatioCreLineRec."21" := '0';
//                                         RatioCreLineRec."22" := '0';
//                                         RatioCreLineRec."23" := '0';
//                                         RatioCreLineRec."24" := '0';
//                                         RatioCreLineRec."25" := '0';
//                                         RatioCreLineRec."26" := '0';
//                                         RatioCreLineRec."27" := '0';
//                                         RatioCreLineRec."28" := '0';
//                                         RatioCreLineRec."29" := '0';
//                                         RatioCreLineRec."30" := '0';
//                                         RatioCreLineRec."31" := '0';
//                                         RatioCreLineRec."32" := '0';
//                                         RatioCreLineRec."33" := '0';
//                                         RatioCreLineRec."34" := '0';
//                                         RatioCreLineRec."35" := '0';
//                                         RatioCreLineRec."36" := '0';
//                                         RatioCreLineRec."37" := '0';
//                                         RatioCreLineRec."38" := '0';
//                                         RatioCreLineRec."39" := '0';
//                                         RatioCreLineRec."40" := '0';
//                                         RatioCreLineRec."41" := '0';
//                                         RatioCreLineRec."42" := '0';
//                                         RatioCreLineRec."43" := '0';
//                                         RatioCreLineRec."44" := '0';
//                                         RatioCreLineRec."45" := '0';
//                                         RatioCreLineRec."46" := '0';
//                                         RatioCreLineRec."47" := '0';
//                                         RatioCreLineRec."48" := '0';
//                                         RatioCreLineRec."49" := '0';
//                                         RatioCreLineRec."50" := '0';
//                                         RatioCreLineRec."51" := '0';
//                                         RatioCreLineRec."52" := '0';
//                                         RatioCreLineRec."53" := '0';
//                                         RatioCreLineRec."54" := '0';
//                                         RatioCreLineRec."55" := '0';
//                                         RatioCreLineRec."56" := '0';
//                                         RatioCreLineRec."57" := '0';
//                                         RatioCreLineRec."58" := '0';
//                                         RatioCreLineRec."59" := '0';
//                                         RatioCreLineRec."60" := '0';
//                                         RatioCreLineRec."61" := '0';
//                                         RatioCreLineRec."62" := '0';
//                                         RatioCreLineRec."63" := '0';
//                                         RatioCreLineRec."64" := '0';

//                                         RatioCreLineRec.Insert();
//                                     end
//                                     else begin  //Modify Total Line (H1)                  

//                                         if (SewJobCreLine4Rec."1" <> '') and (SewJobCreLine4Rec."1" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."1");
//                                             Evaluate(Number2, RatioCreLineRec."1");
//                                             RatioCreLineRec."1" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."2" <> '') and (SewJobCreLine4Rec."2" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."2");
//                                             Evaluate(Number2, RatioCreLineRec."2");
//                                             RatioCreLineRec."2" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."3" <> '') and (SewJobCreLine4Rec."3" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."3");
//                                             Evaluate(Number2, RatioCreLineRec."3");
//                                             RatioCreLineRec."3" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1
//                                         end;

//                                         if (SewJobCreLine4Rec."4" <> '') and (SewJobCreLine4Rec."4" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."4");
//                                             Evaluate(Number2, RatioCreLineRec."4");
//                                             RatioCreLineRec."4" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."5" <> '') and (SewJobCreLine4Rec."5" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."5");
//                                             Evaluate(Number2, RatioCreLineRec."5");
//                                             RatioCreLineRec."5" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."6" <> '') and (SewJobCreLine4Rec."6" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."6");
//                                             Evaluate(Number2, RatioCreLineRec."6");
//                                             RatioCreLineRec."6" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."7" <> '') and (SewJobCreLine4Rec."7" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."7");
//                                             Evaluate(Number2, RatioCreLineRec."7");
//                                             RatioCreLineRec."7" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."8" <> '') and (SewJobCreLine4Rec."8" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."8");
//                                             Evaluate(Number2, RatioCreLineRec."8");
//                                             RatioCreLineRec."8" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."9" <> '') and (SewJobCreLine4Rec."9" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."9");
//                                             Evaluate(Number2, RatioCreLineRec."9");
//                                             RatioCreLineRec."9" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."10" <> '') and (SewJobCreLine4Rec."10" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."10");
//                                             Evaluate(Number2, RatioCreLineRec."10");
//                                             RatioCreLineRec."10" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."11" <> '') and (SewJobCreLine4Rec."11" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."11");
//                                             Evaluate(Number2, RatioCreLineRec."11");
//                                             RatioCreLineRec."11" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1
//                                         end;

//                                         if (SewJobCreLine4Rec."12" <> '') and (SewJobCreLine4Rec."12" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."12");
//                                             Evaluate(Number2, RatioCreLineRec."12");
//                                             RatioCreLineRec."12" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."13" <> '') and (SewJobCreLine4Rec."13" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."13");
//                                             Evaluate(Number2, RatioCreLineRec."13");
//                                             RatioCreLineRec."13" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."14" <> '') and (SewJobCreLine4Rec."14" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."14");
//                                             Evaluate(Number2, RatioCreLineRec."14");
//                                             RatioCreLineRec."14" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."15" <> '') and (SewJobCreLine4Rec."15" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."15");
//                                             Evaluate(Number2, RatioCreLineRec."15");
//                                             RatioCreLineRec."15" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."16" <> '') and (SewJobCreLine4Rec."16" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."16");
//                                             Evaluate(Number2, RatioCreLineRec."16");
//                                             RatioCreLineRec."16" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."17" <> '') and (SewJobCreLine4Rec."17" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."17");
//                                             Evaluate(Number2, RatioCreLineRec."17");
//                                             RatioCreLineRec."17" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."18" <> '') and (SewJobCreLine4Rec."18" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."18");
//                                             Evaluate(Number2, RatioCreLineRec."18");
//                                             RatioCreLineRec."18" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."19" <> '') and (SewJobCreLine4Rec."19" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."19");
//                                             Evaluate(Number2, RatioCreLineRec."19");
//                                             RatioCreLineRec."19" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1
//                                         end;

//                                         if (SewJobCreLine4Rec."20" <> '') and (SewJobCreLine4Rec."20" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."20");
//                                             Evaluate(Number2, RatioCreLineRec."20");
//                                             RatioCreLineRec."20" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."21" <> '') and (SewJobCreLine4Rec."21" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."21");
//                                             Evaluate(Number2, RatioCreLineRec."21");
//                                             RatioCreLineRec."21" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."22" <> '') and (SewJobCreLine4Rec."22" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."22");
//                                             Evaluate(Number2, RatioCreLineRec."22");
//                                             RatioCreLineRec."22" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."23" <> '') and (SewJobCreLine4Rec."23" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."23");
//                                             Evaluate(Number2, RatioCreLineRec."23");
//                                             RatioCreLineRec."23" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."24" <> '') and (SewJobCreLine4Rec."24" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."24");
//                                             Evaluate(Number2, RatioCreLineRec."24");
//                                             RatioCreLineRec."24" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."25" <> '') and (SewJobCreLine4Rec."25" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."25");
//                                             Evaluate(Number2, RatioCreLineRec."25");
//                                             RatioCreLineRec."25" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."26" <> '') and (SewJobCreLine4Rec."26" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."26");
//                                             Evaluate(Number2, RatioCreLineRec."26");
//                                             RatioCreLineRec."26" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."27" <> '') and (SewJobCreLine4Rec."27" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."27");
//                                             Evaluate(Number2, RatioCreLineRec."27");
//                                             RatioCreLineRec."27" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1
//                                         end;

//                                         if (SewJobCreLine4Rec."28" <> '') and (SewJobCreLine4Rec."28" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."28");
//                                             Evaluate(Number2, RatioCreLineRec."28");
//                                             RatioCreLineRec."28" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."29" <> '') and (SewJobCreLine4Rec."29" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."29");
//                                             Evaluate(Number2, RatioCreLineRec."29");
//                                             RatioCreLineRec."29" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."30" <> '') and (SewJobCreLine4Rec."30" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."30");
//                                             Evaluate(Number2, RatioCreLineRec."30");
//                                             RatioCreLineRec."30" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."31" <> '') and (SewJobCreLine4Rec."31" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."31");
//                                             Evaluate(Number2, RatioCreLineRec."31");
//                                             RatioCreLineRec."31" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."32" <> '') and (SewJobCreLine4Rec."32" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."32");
//                                             Evaluate(Number2, RatioCreLineRec."32");
//                                             RatioCreLineRec."32" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."33" <> '') and (SewJobCreLine4Rec."33" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."33");
//                                             Evaluate(Number2, RatioCreLineRec."33");
//                                             RatioCreLineRec."33" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."34" <> '') and (SewJobCreLine4Rec."34" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."34");
//                                             Evaluate(Number2, RatioCreLineRec."34");
//                                             RatioCreLineRec."34" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."35" <> '') and (SewJobCreLine4Rec."35" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."35");
//                                             Evaluate(Number2, RatioCreLineRec."35");
//                                             RatioCreLineRec."35" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1
//                                         end;

//                                         if (SewJobCreLine4Rec."36" <> '') and (SewJobCreLine4Rec."36" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."36");
//                                             Evaluate(Number2, RatioCreLineRec."36");
//                                             RatioCreLineRec."36" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."37" <> '') and (SewJobCreLine4Rec."37" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."37");
//                                             Evaluate(Number2, RatioCreLineRec."37");
//                                             RatioCreLineRec."37" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."38" <> '') and (SewJobCreLine4Rec."38" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."38");
//                                             Evaluate(Number2, RatioCreLineRec."38");
//                                             RatioCreLineRec."38" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."39" <> '') and (SewJobCreLine4Rec."39" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."39");
//                                             Evaluate(Number2, RatioCreLineRec."39");
//                                             RatioCreLineRec."39" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."40" <> '') and (SewJobCreLine4Rec."40" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."40");
//                                             Evaluate(Number2, RatioCreLineRec."40");
//                                             RatioCreLineRec."40" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."41" <> '') and (SewJobCreLine4Rec."41" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."41");
//                                             Evaluate(Number2, RatioCreLineRec."41");
//                                             RatioCreLineRec."41" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."42" <> '') and (SewJobCreLine4Rec."42" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."42");
//                                             Evaluate(Number2, RatioCreLineRec."42");
//                                             RatioCreLineRec."42" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."43" <> '') and (SewJobCreLine4Rec."43" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."43");
//                                             Evaluate(Number2, RatioCreLineRec."43");
//                                             RatioCreLineRec."43" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1
//                                         end;

//                                         if (SewJobCreLine4Rec."44" <> '') and (SewJobCreLine4Rec."44" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."44");
//                                             Evaluate(Number2, RatioCreLineRec."44");
//                                             RatioCreLineRec."44" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."45" <> '') and (SewJobCreLine4Rec."45" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."45");
//                                             Evaluate(Number2, RatioCreLineRec."45");
//                                             RatioCreLineRec."45" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."46" <> '') and (SewJobCreLine4Rec."46" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."46");
//                                             Evaluate(Number2, RatioCreLineRec."46");
//                                             RatioCreLineRec."46" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."47" <> '') and (SewJobCreLine4Rec."47" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."47");
//                                             Evaluate(Number2, RatioCreLineRec."47");
//                                             RatioCreLineRec."47" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."48" <> '') and (SewJobCreLine4Rec."48" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."48");
//                                             Evaluate(Number2, RatioCreLineRec."48");
//                                             RatioCreLineRec."48" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."49" <> '') and (SewJobCreLine4Rec."49" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."49");
//                                             Evaluate(Number2, RatioCreLineRec."49");
//                                             RatioCreLineRec."49" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."50" <> '') and (SewJobCreLine4Rec."50" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."50");
//                                             Evaluate(Number2, RatioCreLineRec."50");
//                                             RatioCreLineRec."50" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."51" <> '') and (SewJobCreLine4Rec."51" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."51");
//                                             Evaluate(Number2, RatioCreLineRec."51");
//                                             RatioCreLineRec."51" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1
//                                         end;

//                                         if (SewJobCreLine4Rec."52" <> '') and (SewJobCreLine4Rec."52" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."52");
//                                             Evaluate(Number2, RatioCreLineRec."52");
//                                             RatioCreLineRec."52" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."53" <> '') and (SewJobCreLine4Rec."53" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."53");
//                                             Evaluate(Number2, RatioCreLineRec."53");
//                                             RatioCreLineRec."53" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."54" <> '') and (SewJobCreLine4Rec."54" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."54");
//                                             Evaluate(Number2, RatioCreLineRec."54");
//                                             RatioCreLineRec."54" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."55" <> '') and (SewJobCreLine4Rec."55" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."55");
//                                             Evaluate(Number2, RatioCreLineRec."55");
//                                             RatioCreLineRec."55" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."56" <> '') and (SewJobCreLine4Rec."56" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."56");
//                                             Evaluate(Number2, RatioCreLineRec."56");
//                                             RatioCreLineRec."56" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."57" <> '') and (SewJobCreLine4Rec."57" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."57");
//                                             Evaluate(Number2, RatioCreLineRec."57");
//                                             RatioCreLineRec."57" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."58" <> '') and (SewJobCreLine4Rec."58" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."58");
//                                             Evaluate(Number2, RatioCreLineRec."58");
//                                             RatioCreLineRec."58" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."59" <> '') and (SewJobCreLine4Rec."59" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."59");
//                                             Evaluate(Number2, RatioCreLineRec."59");
//                                             RatioCreLineRec."59" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1
//                                         end;

//                                         if (SewJobCreLine4Rec."60" <> '') and (SewJobCreLine4Rec."60" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."60");
//                                             Evaluate(Number2, RatioCreLineRec."60");
//                                             RatioCreLineRec."60" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."61" <> '') and (SewJobCreLine4Rec."61" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."61");
//                                             Evaluate(Number2, RatioCreLineRec."61");
//                                             RatioCreLineRec."61" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."62" <> '') and (SewJobCreLine4Rec."62" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."62");
//                                             Evaluate(Number2, RatioCreLineRec."62");
//                                             RatioCreLineRec."62" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."63" <> '') and (SewJobCreLine4Rec."63" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."63");
//                                             Evaluate(Number2, RatioCreLineRec."63");
//                                             RatioCreLineRec."63" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;

//                                         if (SewJobCreLine4Rec."64" <> '') and (SewJobCreLine4Rec."64" <> '0') then begin
//                                             Evaluate(Number1, SewJobCreLine4Rec."64");
//                                             Evaluate(Number2, RatioCreLineRec."64");
//                                             RatioCreLineRec."64" := format(Number1 + Number2);
//                                             ColorTotal := ColorTotal + Number1;
//                                         end;


//                                         RatioCreLineRec."Color Total" := ColorTotal;
//                                         RatioCreLineRec.Modify();
//                                     end;

//                                 end;

//                             until SewJobCreLine4Rec.Next() = 0;

//                             Message('Completed');

//                         end;
//                     end;
//                 end;