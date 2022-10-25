page 50647 "LaySheetCard"
{
    PageType = Card;
    SourceTable = LaySheetHeader;
    Caption = 'Lay Sheet';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("LaySheetNo."; "LaySheetNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Lay Sheet No';
                }

                field("FabReqNo."; "FabReqNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Requsition No';
                    ShowMandatory = true;

                    trigger onvalidate()
                    var
                        FabricRequRec: Record FabricRequsition;
                        FabricMapRec: Record FabricMapping;
                        TableRec: Record TableCreartionLine;
                    begin

                        //Get details
                        FabricRequRec.Reset();
                        FabricRequRec.SetRange("FabReqNo.", "FabReqNo.");

                        if FabricRequRec.FindSet() then begin
                            "Cut No." := FabricRequRec."Cut No";
                            "Style No." := FabricRequRec."Style No.";
                            "Style Name" := FabricRequRec."Style Name";
                            "Group ID" := FabricRequRec."Group ID";
                            Color := FabricRequRec."Colour Name";
                            "Color No." := FabricRequRec."Colour No";
                            "Component Group Name" := FabricRequRec."Component Group Name";
                            "Component Group Code" := FabricRequRec."Component Group Code";
                            "Marker Name" := FabricRequRec."Marker Name";
                        end;

                        // Get item name
                        FabricMapRec.Reset();
                        FabricMapRec.SetRange("Style No.", "Style No.");
                        FabricMapRec.SetRange("Colour No", "Color No.");
                        FabricMapRec.SetRange("Component Group", "Component Group Code");

                        if FabricMapRec.FindSet() then
                            "Item Name" := FabricMapRec."Item Name";


                        //Get plan date
                        TableRec.Reset();
                        TableRec.SetRange("Style No.", "Style No.");
                        TableRec.SetRange("Colour No", "Color No.");
                        TableRec.SetRange("Component Group", "Component Group Code");
                        TableRec.SetRange("Group ID", "Group ID");
                        TableRec.SetRange("Marker Name", "Marker Name");
                        TableRec.SetRange("Cut No", "Cut No.");

                        if TableRec.FindSet() then
                            "Plan Date" := DT2Date(TableRec."Cut Start Date/Time");

                        Insert_Lines1();
                        Insert_Lines2();
                        Insert_Lines3_4();
                        Insert_Lines5();

                    end;

                }

                field("Cut No."; "Cut No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Cut No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Sew. Group ID';
                }

                field(Color; Color)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Component Group Name"; "Component Group Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Component Group';
                }

                field("Marker Name"; "Marker Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Marker';
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Fab Direction"; "Fab Direction")
                {
                    ApplicationArea = All;
                }

                field("Plan Date"; "Plan Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Size/Ratio/Qty")
            {
                part("Lay Sheet Line1"; "Lay Sheet Line1")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
                }
            }

            group("Fabric Width/Length")
            {
                part("Lay Sheet Line2"; "Lay Sheet Line2")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
                }
            }

            group("Roll/Shade Summary")
            {
                part("Lay Sheet Line3"; "Lay Sheet Line3")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
                }
            }

            group("Roll/Shade Details")
            {
                part("Lay Sheet Line4"; "Lay Sheet Line4")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
                }
            }

            group(" ")
            {
                part("Lay Sheet Line5"; "Lay Sheet Line5")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "LaySheetNo." = FIELD("LaySheetNo.");
                }
            }
        }
    }


    // procedure AssistEdit(): Boolean
    // var
    //     NavAppSetup: Record "NavApp Setup";
    //     NoSeriesMngment: Codeunit NoSeriesManagement;
    // begin
    //     NavAppSetup.Get('0001');
    //     IF NoSeriesMngment.SelectSeries(NavAppSetup."LaySheet Nos.", xRec."LaySheetNo.", "LaySheetNo.") THEN BEGIN
    //         NoSeriesMngment.SetSeries("LaySheetNo.");
    //         CurrPage.Update();
    //         EXIT(TRUE);
    //     END;
    // end;


    trigger OnDeleteRecord(): Boolean
    var
        LaySheetLine1Rec: Record LaySheetLine1;
        LaySheetLine2Rec: Record LaySheetLine2;
        LaySheetLine3Rec: Record LaySheetLine3;
        LaySheetLine4Rec: Record LaySheetLine4;
        LaySheetLine5Rec: Record LaySheetLine5;
        CutProRec: Record CuttingProgressHeader;
        BundleGuideRec: Record BundleGuideHeader;
    begin

        //Check in the cutting progress
        CutProRec.Reset();
        CutProRec.SetRange(LaySheetNo, "LaySheetNo.");

        if CutProRec.FindSet() then begin
            Message('Cannot delete. Lay Sheet No already used in the Cutting Progress No : %1', CutProRec."CutProNo.");
            exit(false);
        end;


        //Check in the Lay SHeet
        BundleGuideRec.Reset();
        BundleGuideRec.SetRange("Style No.", "Style No.");
        BundleGuideRec.SetRange("Color No", "Color No.");
        BundleGuideRec.SetRange("Group ID", "Group ID");
        BundleGuideRec.SetRange("Component Group", "Component Group Code");
        BundleGuideRec.SetRange("Cut No", "Cut No.");

        if BundleGuideRec.FindSet() then begin
            Message('Cannot delete. Lay Sheet details already used in the Bundle Guide No : %1', BundleGuideRec."BundleGuideNo.");
            exit(false);
        end;



        LaySheetLine1Rec.SetRange("LaySheetNo.", "LaySheetNo.");
        LaySheetLine1Rec.DeleteAll();

        LaySheetLine2Rec.SetRange("LaySheetNo.", "LaySheetNo.");
        LaySheetLine2Rec.DeleteAll();

        LaySheetLine3Rec.SetRange("LaySheetNo.", "LaySheetNo.");
        LaySheetLine3Rec.DeleteAll();

        LaySheetLine4Rec.SetRange("LaySheetNo.", "LaySheetNo.");
        LaySheetLine4Rec.DeleteAll();

        LaySheetLine5Rec.SetRange("LaySheetNo.", "LaySheetNo.");
        LaySheetLine5Rec.DeleteAll();
    end;

    procedure Insert_Lines1()
    var
        CutCreLineRec: Record CutCreationLine;
        LaySheetLine1Rec: Record LaySheetLine1;
    begin

        //Delete old records
        LaySheetLine1Rec.Reset();
        LaySheetLine1Rec.SetRange("LaySheetNo.", "LaySheetNo.");
        LaySheetLine1Rec.DeleteAll();

        //Get Sizes
        CutCreLineRec.Reset();
        CutCreLineRec.SetRange("Style No.", "Style No.");
        CutCreLineRec.SetRange("Colour No", "Color No.");
        CutCreLineRec.SetRange("Group ID", "Group ID");
        CutCreLineRec.SetRange("Component Group Code", "Component Group Code");
        CutCreLineRec.SetRange("Record Type", 'H');

        if CutCreLineRec.FindSet() then begin

            LaySheetLine1Rec.Init();
            LaySheetLine1Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine1Rec."Line No" := 1;
            LaySheetLine1Rec."Record Type" := 'SIZE';
            LaySheetLine1Rec."1" := CutCreLineRec."1";
            LaySheetLine1Rec."2" := CutCreLineRec."2";
            LaySheetLine1Rec."3" := CutCreLineRec."3";
            LaySheetLine1Rec."4" := CutCreLineRec."4";
            LaySheetLine1Rec."5" := CutCreLineRec."5";
            LaySheetLine1Rec."6" := CutCreLineRec."6";
            LaySheetLine1Rec."7" := CutCreLineRec."7";
            LaySheetLine1Rec."8" := CutCreLineRec."8";
            LaySheetLine1Rec."9" := CutCreLineRec."9";
            LaySheetLine1Rec."10" := CutCreLineRec."10";
            LaySheetLine1Rec."11" := CutCreLineRec."11";
            LaySheetLine1Rec."12" := CutCreLineRec."12";
            LaySheetLine1Rec."13" := CutCreLineRec."13";
            LaySheetLine1Rec."14" := CutCreLineRec."14";
            LaySheetLine1Rec."15" := CutCreLineRec."15";
            LaySheetLine1Rec."16" := CutCreLineRec."16";
            LaySheetLine1Rec."17" := CutCreLineRec."17";
            LaySheetLine1Rec."18" := CutCreLineRec."18";
            LaySheetLine1Rec."19" := CutCreLineRec."19";
            LaySheetLine1Rec."20" := CutCreLineRec."20";
            LaySheetLine1Rec."21" := CutCreLineRec."21";
            LaySheetLine1Rec."22" := CutCreLineRec."22";
            LaySheetLine1Rec."23" := CutCreLineRec."23";
            LaySheetLine1Rec."24" := CutCreLineRec."24";
            LaySheetLine1Rec."25" := CutCreLineRec."25";
            LaySheetLine1Rec."26" := CutCreLineRec."26";
            LaySheetLine1Rec."27" := CutCreLineRec."27";
            LaySheetLine1Rec."28" := CutCreLineRec."28";
            LaySheetLine1Rec."29" := CutCreLineRec."29";
            LaySheetLine1Rec."30" := CutCreLineRec."30";
            LaySheetLine1Rec."31" := CutCreLineRec."31";
            LaySheetLine1Rec."32" := CutCreLineRec."32";
            LaySheetLine1Rec."33" := CutCreLineRec."33";
            LaySheetLine1Rec."34" := CutCreLineRec."34";
            LaySheetLine1Rec."35" := CutCreLineRec."35";
            LaySheetLine1Rec."36" := CutCreLineRec."36";
            LaySheetLine1Rec."37" := CutCreLineRec."37";
            LaySheetLine1Rec."38" := CutCreLineRec."38";
            LaySheetLine1Rec."39" := CutCreLineRec."39";
            LaySheetLine1Rec."40" := CutCreLineRec."40";
            LaySheetLine1Rec."41" := CutCreLineRec."41";
            LaySheetLine1Rec."42" := CutCreLineRec."42";
            LaySheetLine1Rec."43" := CutCreLineRec."43";
            LaySheetLine1Rec."44" := CutCreLineRec."44";
            LaySheetLine1Rec."45" := CutCreLineRec."45";
            LaySheetLine1Rec."46" := CutCreLineRec."46";
            LaySheetLine1Rec."47" := CutCreLineRec."47";
            LaySheetLine1Rec."48" := CutCreLineRec."48";
            LaySheetLine1Rec."49" := CutCreLineRec."49";
            LaySheetLine1Rec."50" := CutCreLineRec."50";
            LaySheetLine1Rec."51" := CutCreLineRec."51";
            LaySheetLine1Rec."52" := CutCreLineRec."52";
            LaySheetLine1Rec."53" := CutCreLineRec."53";
            LaySheetLine1Rec."54" := CutCreLineRec."54";
            LaySheetLine1Rec."55" := CutCreLineRec."55";
            LaySheetLine1Rec."56" := CutCreLineRec."56";
            LaySheetLine1Rec."57" := CutCreLineRec."57";
            LaySheetLine1Rec."58" := CutCreLineRec."58";
            LaySheetLine1Rec."59" := CutCreLineRec."59";
            LaySheetLine1Rec."60" := CutCreLineRec."60";
            LaySheetLine1Rec."61" := CutCreLineRec."61";
            LaySheetLine1Rec."62" := CutCreLineRec."62";
            LaySheetLine1Rec."63" := CutCreLineRec."63";
            LaySheetLine1Rec."64" := CutCreLineRec."64";
            LaySheetLine1Rec."Color Total" := CutCreLineRec."Color Total";
            LaySheetLine1Rec."Created User" := UserId;
            LaySheetLine1Rec.Insert();

        end
        else
            Error('Cannot find Cut Creation details.');


        //Get ratio
        CutCreLineRec.Reset();
        CutCreLineRec.SetRange("Style No.", "Style No.");
        CutCreLineRec.SetRange("Colour No", "Color No.");
        CutCreLineRec.SetRange("Group ID", "Group ID");
        CutCreLineRec.SetRange("Component Group Code", "Component Group Code");
        CutCreLineRec.SetRange("Record Type", 'R');
        CutCreLineRec.SetRange("Cut No", 0);
        CutCreLineRec.SetRange("Marker Name", "Marker Name");

        if CutCreLineRec.FindSet() then begin

            LaySheetLine1Rec.Init();
            LaySheetLine1Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine1Rec."Line No" := 2;
            LaySheetLine1Rec."Record Type" := 'RATIO';
            LaySheetLine1Rec."1" := CutCreLineRec."1";
            LaySheetLine1Rec."2" := CutCreLineRec."2";
            LaySheetLine1Rec."3" := CutCreLineRec."3";
            LaySheetLine1Rec."4" := CutCreLineRec."4";
            LaySheetLine1Rec."5" := CutCreLineRec."5";
            LaySheetLine1Rec."6" := CutCreLineRec."6";
            LaySheetLine1Rec."7" := CutCreLineRec."7";
            LaySheetLine1Rec."8" := CutCreLineRec."8";
            LaySheetLine1Rec."9" := CutCreLineRec."9";
            LaySheetLine1Rec."10" := CutCreLineRec."10";
            LaySheetLine1Rec."11" := CutCreLineRec."11";
            LaySheetLine1Rec."12" := CutCreLineRec."12";
            LaySheetLine1Rec."13" := CutCreLineRec."13";
            LaySheetLine1Rec."14" := CutCreLineRec."14";
            LaySheetLine1Rec."15" := CutCreLineRec."15";
            LaySheetLine1Rec."16" := CutCreLineRec."16";
            LaySheetLine1Rec."17" := CutCreLineRec."17";
            LaySheetLine1Rec."18" := CutCreLineRec."18";
            LaySheetLine1Rec."19" := CutCreLineRec."19";
            LaySheetLine1Rec."20" := CutCreLineRec."20";
            LaySheetLine1Rec."21" := CutCreLineRec."21";
            LaySheetLine1Rec."22" := CutCreLineRec."22";
            LaySheetLine1Rec."23" := CutCreLineRec."23";
            LaySheetLine1Rec."24" := CutCreLineRec."24";
            LaySheetLine1Rec."25" := CutCreLineRec."25";
            LaySheetLine1Rec."26" := CutCreLineRec."26";
            LaySheetLine1Rec."27" := CutCreLineRec."27";
            LaySheetLine1Rec."28" := CutCreLineRec."28";
            LaySheetLine1Rec."29" := CutCreLineRec."29";
            LaySheetLine1Rec."30" := CutCreLineRec."30";
            LaySheetLine1Rec."31" := CutCreLineRec."31";
            LaySheetLine1Rec."32" := CutCreLineRec."32";
            LaySheetLine1Rec."33" := CutCreLineRec."33";
            LaySheetLine1Rec."34" := CutCreLineRec."34";
            LaySheetLine1Rec."35" := CutCreLineRec."35";
            LaySheetLine1Rec."36" := CutCreLineRec."36";
            LaySheetLine1Rec."37" := CutCreLineRec."37";
            LaySheetLine1Rec."38" := CutCreLineRec."38";
            LaySheetLine1Rec."39" := CutCreLineRec."39";
            LaySheetLine1Rec."40" := CutCreLineRec."40";
            LaySheetLine1Rec."41" := CutCreLineRec."41";
            LaySheetLine1Rec."42" := CutCreLineRec."42";
            LaySheetLine1Rec."43" := CutCreLineRec."43";
            LaySheetLine1Rec."44" := CutCreLineRec."44";
            LaySheetLine1Rec."45" := CutCreLineRec."45";
            LaySheetLine1Rec."46" := CutCreLineRec."46";
            LaySheetLine1Rec."47" := CutCreLineRec."47";
            LaySheetLine1Rec."48" := CutCreLineRec."48";
            LaySheetLine1Rec."49" := CutCreLineRec."49";
            LaySheetLine1Rec."50" := CutCreLineRec."50";
            LaySheetLine1Rec."51" := CutCreLineRec."51";
            LaySheetLine1Rec."52" := CutCreLineRec."52";
            LaySheetLine1Rec."53" := CutCreLineRec."53";
            LaySheetLine1Rec."54" := CutCreLineRec."54";
            LaySheetLine1Rec."55" := CutCreLineRec."55";
            LaySheetLine1Rec."56" := CutCreLineRec."56";
            LaySheetLine1Rec."57" := CutCreLineRec."57";
            LaySheetLine1Rec."58" := CutCreLineRec."58";
            LaySheetLine1Rec."59" := CutCreLineRec."59";
            LaySheetLine1Rec."60" := CutCreLineRec."60";
            LaySheetLine1Rec."61" := CutCreLineRec."61";
            LaySheetLine1Rec."62" := CutCreLineRec."62";
            LaySheetLine1Rec."63" := CutCreLineRec."63";
            LaySheetLine1Rec."64" := CutCreLineRec."64";
            LaySheetLine1Rec."Color Total" := CutCreLineRec."Color Total";
            LaySheetLine1Rec."Created User" := UserId;
            LaySheetLine1Rec.Insert();

        end
        else
            Error('Cannot find Cut Creation details.');


        //Get Quantity
        CutCreLineRec.Reset();
        CutCreLineRec.SetRange("Style No.", "Style No.");
        CutCreLineRec.SetRange("Colour No", "Color No.");
        CutCreLineRec.SetRange("Group ID", "Group ID");
        CutCreLineRec.SetRange("Component Group Code", "Component Group Code");
        CutCreLineRec.SetRange("Record Type", 'R');
        CutCreLineRec.SetRange("Marker Name", "Marker Name");
        CutCreLineRec.SetRange("Cut No", "Cut No.");

        if CutCreLineRec.FindSet() then begin

            LaySheetLine1Rec.Init();
            LaySheetLine1Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine1Rec."Line No" := 3;
            LaySheetLine1Rec."Record Type" := 'QTY';
            LaySheetLine1Rec."1" := CutCreLineRec."1";
            LaySheetLine1Rec."2" := CutCreLineRec."2";
            LaySheetLine1Rec."3" := CutCreLineRec."3";
            LaySheetLine1Rec."4" := CutCreLineRec."4";
            LaySheetLine1Rec."5" := CutCreLineRec."5";
            LaySheetLine1Rec."6" := CutCreLineRec."6";
            LaySheetLine1Rec."7" := CutCreLineRec."7";
            LaySheetLine1Rec."8" := CutCreLineRec."8";
            LaySheetLine1Rec."9" := CutCreLineRec."9";
            LaySheetLine1Rec."10" := CutCreLineRec."10";
            LaySheetLine1Rec."11" := CutCreLineRec."11";
            LaySheetLine1Rec."12" := CutCreLineRec."12";
            LaySheetLine1Rec."13" := CutCreLineRec."13";
            LaySheetLine1Rec."14" := CutCreLineRec."14";
            LaySheetLine1Rec."15" := CutCreLineRec."15";
            LaySheetLine1Rec."16" := CutCreLineRec."16";
            LaySheetLine1Rec."17" := CutCreLineRec."17";
            LaySheetLine1Rec."18" := CutCreLineRec."18";
            LaySheetLine1Rec."19" := CutCreLineRec."19";
            LaySheetLine1Rec."20" := CutCreLineRec."20";
            LaySheetLine1Rec."21" := CutCreLineRec."21";
            LaySheetLine1Rec."22" := CutCreLineRec."22";
            LaySheetLine1Rec."23" := CutCreLineRec."23";
            LaySheetLine1Rec."24" := CutCreLineRec."24";
            LaySheetLine1Rec."25" := CutCreLineRec."25";
            LaySheetLine1Rec."26" := CutCreLineRec."26";
            LaySheetLine1Rec."27" := CutCreLineRec."27";
            LaySheetLine1Rec."28" := CutCreLineRec."28";
            LaySheetLine1Rec."29" := CutCreLineRec."29";
            LaySheetLine1Rec."30" := CutCreLineRec."30";
            LaySheetLine1Rec."31" := CutCreLineRec."31";
            LaySheetLine1Rec."32" := CutCreLineRec."32";
            LaySheetLine1Rec."33" := CutCreLineRec."33";
            LaySheetLine1Rec."34" := CutCreLineRec."34";
            LaySheetLine1Rec."35" := CutCreLineRec."35";
            LaySheetLine1Rec."36" := CutCreLineRec."36";
            LaySheetLine1Rec."37" := CutCreLineRec."37";
            LaySheetLine1Rec."38" := CutCreLineRec."38";
            LaySheetLine1Rec."39" := CutCreLineRec."39";
            LaySheetLine1Rec."40" := CutCreLineRec."40";
            LaySheetLine1Rec."41" := CutCreLineRec."41";
            LaySheetLine1Rec."42" := CutCreLineRec."42";
            LaySheetLine1Rec."43" := CutCreLineRec."43";
            LaySheetLine1Rec."44" := CutCreLineRec."44";
            LaySheetLine1Rec."45" := CutCreLineRec."45";
            LaySheetLine1Rec."46" := CutCreLineRec."46";
            LaySheetLine1Rec."47" := CutCreLineRec."47";
            LaySheetLine1Rec."48" := CutCreLineRec."48";
            LaySheetLine1Rec."49" := CutCreLineRec."49";
            LaySheetLine1Rec."50" := CutCreLineRec."50";
            LaySheetLine1Rec."51" := CutCreLineRec."51";
            LaySheetLine1Rec."52" := CutCreLineRec."52";
            LaySheetLine1Rec."53" := CutCreLineRec."53";
            LaySheetLine1Rec."54" := CutCreLineRec."54";
            LaySheetLine1Rec."55" := CutCreLineRec."55";
            LaySheetLine1Rec."56" := CutCreLineRec."56";
            LaySheetLine1Rec."57" := CutCreLineRec."57";
            LaySheetLine1Rec."58" := CutCreLineRec."58";
            LaySheetLine1Rec."59" := CutCreLineRec."59";
            LaySheetLine1Rec."60" := CutCreLineRec."60";
            LaySheetLine1Rec."61" := CutCreLineRec."61";
            LaySheetLine1Rec."62" := CutCreLineRec."62";
            LaySheetLine1Rec."63" := CutCreLineRec."63";
            LaySheetLine1Rec."64" := CutCreLineRec."64";
            LaySheetLine1Rec."Color Total" := CutCreLineRec."Color Total";
            LaySheetLine1Rec."Created User" := UserId;
            LaySheetLine1Rec.Insert();

        end
        else
            Error('Cannot find Cut Creation details.');

    end;

    procedure Insert_Lines2()
    var
        FabReqRec: Record FabricRequsition;
        RatioCreRec: Record RatioCreationLine;
        LaySheetLine2Rec: Record LaySheetLine2;
    begin

        //Delete old records
        LaySheetLine2Rec.Reset();
        LaySheetLine2Rec.SetRange("LaySheetNo.", "LaySheetNo.");
        LaySheetLine2Rec.DeleteAll();

        LaySheetLine2Rec.Init();
        LaySheetLine2Rec."LaySheetNo." := "LaySheetNo.";
        LaySheetLine2Rec."Line No" := 1;

        //Get details from Ratio Creation
        RatioCreRec.Reset();
        RatioCreRec.SetRange("Style No.", "Style No.");
        RatioCreRec.SetRange("Colour No", "Color No.");
        RatioCreRec.SetRange("Group ID", "Group ID");
        RatioCreRec.SetRange("Component Group Code", "Component Group Code");
        RatioCreRec.SetRange("Marker Name", "Marker Name");
        RatioCreRec.SetRange("Record Type", 'R');

        if RatioCreRec.FindSet() then begin

            LaySheetLine2Rec."Pattern Version" := RatioCreRec."Pattern Version";
            LaySheetLine2Rec."No of Plies" := RatioCreRec.Plies;

            if RatioCreRec."UOM Code" = 'YDS' then
                LaySheetLine2Rec.LayLength := (RatioCreRec.Length + ((RatioCreRec."Length Tollarance  " * 2) / 36))
            else
                if RatioCreRec."UOM Code" = 'MTS' then
                    LaySheetLine2Rec.LayLength := (RatioCreRec.Length + ((RatioCreRec."Length Tollarance  " * 2) / 100));

            LaySheetLine2Rec."UOM Code" := RatioCreRec."UOM Code";
            LaySheetLine2Rec."UOM" := RatioCreRec."UOM";

        end
        else
            Error('Cannot find Ratio details.');


        //Get details from FabricRequsitionLine
        FabReqRec.Reset();
        FabReqRec.SetRange("Style No.", "Style No.");
        FabReqRec.SetRange("Colour No", "Color No.");
        FabReqRec.SetRange("Group ID", "Group ID");
        FabReqRec.SetRange("Component Group Code", "Component Group Code");
        FabReqRec.SetRange("Marker Name", "Marker Name");
        FabReqRec.SetRange("Cut No", "Cut No.");

        if FabReqRec.FindSet() then begin
            LaySheetLine2Rec."Fab. Req. For Lay" := FabReqRec."Required Length";
            LaySheetLine2Rec."Act. Width" := FabReqRec."Marker Width";
        end
        else
            Error('Cannot find Fabric Requisition details.');


        LaySheetLine2Rec."Created User" := UserId;
        LaySheetLine2Rec.Insert();

    end;

    procedure Insert_Lines3_4()
    var
        RoleIssHeadeRec: Record RoleIssuingNoteHeader;
        RoleIssRec: Record RoleIssuingNoteLine;
        LaySheetLine3Rec: Record LaySheetLine3;
        LaySheetLine4Rec: Record LaySheetLine4;
        UOM: text[20];
        UOMCode: code[20];
        LIneNo: Integer;
        LIneNo1: Integer;
        Shade: Code[20];
        TotalQty: Decimal;
    begin

        //Delete old records
        LaySheetLine3Rec.Reset();
        LaySheetLine3Rec.SetRange("LaySheetNo.", "LaySheetNo.");
        LaySheetLine3Rec.DeleteAll();

        //Delete old records
        LaySheetLine4Rec.Reset();
        LaySheetLine4Rec.SetRange("LaySheetNo.", "LaySheetNo.");
        LaySheetLine4Rec.DeleteAll();

        RoleIssHeadeRec.Reset();
        RoleIssHeadeRec.SetRange("RoleIssuNo.", "LaySheetNo.");
        if RoleIssHeadeRec.FindSet() then begin
            UOM := RoleIssHeadeRec.UOM;
            UOMCode := RoleIssHeadeRec."UOM Code";
        end;

        //Get details from FabricRequsitionLine
        RoleIssRec.Reset();
        RoleIssRec.SetRange("RoleIssuNo.", "LaySheetNo.");
        RoleIssRec.SetCurrentKey("Shade No");
        RoleIssRec.Ascending(true);

        if RoleIssRec.FindSet() then begin

            repeat

                LIneNo += 1;
                LaySheetLine4Rec.Init();
                LaySheetLine4Rec."LaySheetNo." := "LaySheetNo.";
                LaySheetLine4Rec."Line No." := LIneNo;
                LaySheetLine4Rec."Shade No" := RoleIssRec."Shade No";
                LaySheetLine4Rec.Shade := RoleIssRec.Shade;
                LaySheetLine4Rec.Batch := RoleIssRec."Supplier Batch No.";
                LaySheetLine4Rec."Role ID" := RoleIssRec."Role ID";
                LaySheetLine4Rec."Ticket Length" := RoleIssRec."Length Tag";
                LaySheetLine4Rec."Allocated Qty" := RoleIssRec."Length Allocated";
                LaySheetLine4Rec.UOM := UOM;
                LaySheetLine4Rec."UOM Code" := UOMCode;
                LaySheetLine4Rec."Created User" := UserId;
                LaySheetLine4Rec.Insert();

                if Shade <> RoleIssRec.Shade then begin

                    TotalQty := 0;
                    LIneNo1 += 1;
                    LaySheetLine3Rec.Init();
                    LaySheetLine3Rec."LaySheetNo." := "LaySheetNo.";
                    LaySheetLine3Rec."LineNo." := LIneNo1;
                    LaySheetLine3Rec."Shade No" := RoleIssRec."Shade No";
                    LaySheetLine3Rec.Shade := RoleIssRec.Shade;
                    LaySheetLine3Rec."Shade Wise Total Fab (Meters)" := RoleIssRec."Length Allocated";
                    LaySheetLine3Rec."No of Plies From Shade" := 0;
                    LaySheetLine3Rec."Created User" := UserId;
                    LaySheetLine3Rec.Insert();

                end
                else begin

                    TotalQty += RoleIssRec."Length Allocated";

                    LaySheetLine3Rec.Reset();
                    LaySheetLine3Rec.SetRange("LaySheetNo.", "LaySheetNo.");
                    LaySheetLine3Rec.SetRange("LineNo.", LIneNo1);

                    if LaySheetLine3Rec.FindSet() then
                        LaySheetLine3Rec.ModifyAll("Shade Wise Total Fab (Meters)", TotalQty);

                end;

                Shade := RoleIssRec.Shade;

            until RoleIssRec.Next() = 0;

        end;

    end;

    procedure Insert_Lines5()
    var
        LaySheetLine5Rec: Record LaySheetLine5;
    begin
        LaySheetLine5Rec.Reset();
        LaySheetLine5Rec.SetRange("LaySheetNo.", "LaySheetNo.");

        if not LaySheetLine5Rec.FindSet() then begin

            LaySheetLine5Rec.Init();
            LaySheetLine5Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine5Rec.Type := 'Team';
            LaySheetLine5Rec."Created Date" := Today;
            LaySheetLine5Rec."Created User" := UserId;
            LaySheetLine5Rec.Insert();

            LaySheetLine5Rec.Init();
            LaySheetLine5Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine5Rec.Type := 'Emp No1';
            LaySheetLine5Rec."Created Date" := Today;
            LaySheetLine5Rec."Created User" := UserId;
            LaySheetLine5Rec.Insert();

            LaySheetLine5Rec.Init();
            LaySheetLine5Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine5Rec.Type := 'Emp No2';
            LaySheetLine5Rec."Created Date" := Today;
            LaySheetLine5Rec."Created User" := UserId;
            LaySheetLine5Rec.Insert();

            LaySheetLine5Rec.Init();
            LaySheetLine5Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine5Rec.Type := 'Emp No3';
            LaySheetLine5Rec."Created Date" := Today;
            LaySheetLine5Rec."Created User" := UserId;
            LaySheetLine5Rec.Insert();

            LaySheetLine5Rec.Init();
            LaySheetLine5Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine5Rec.Type := 'Emp No4';
            LaySheetLine5Rec."Created Date" := Today;
            LaySheetLine5Rec."Created User" := UserId;
            LaySheetLine5Rec.Insert();

            LaySheetLine5Rec.Init();
            LaySheetLine5Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine5Rec.Type := 'Emp No5';
            LaySheetLine5Rec."Created Date" := Today;
            LaySheetLine5Rec."Created User" := UserId;
            LaySheetLine5Rec.Insert();

            LaySheetLine5Rec.Init();
            LaySheetLine5Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine5Rec.Type := 'Date';
            LaySheetLine5Rec."Created Date" := Today;
            LaySheetLine5Rec."Created User" := UserId;
            LaySheetLine5Rec.Insert();

            LaySheetLine5Rec.Init();
            LaySheetLine5Rec."LaySheetNo." := "LaySheetNo.";
            LaySheetLine5Rec.Type := 'Time';
            LaySheetLine5Rec."Created Date" := Today;
            LaySheetLine5Rec."Created User" := UserId;
            LaySheetLine5Rec.Insert();

        end;

    end;
}