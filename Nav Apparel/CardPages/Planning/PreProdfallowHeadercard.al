page 50835 PreProductionfollowup
{
    PageType = Card;
    Caption = 'Pre-Production Follow Up';
    SourceTable = PreProductionFollowUpHeader;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Factory Name"; "Factory Name")
                {
                    Caption = 'Factory';
                    ApplicationArea = All;

                    trigger OnLookup(var text: Text): Boolean
                    var
                        LocationRec: Record "Location";
                        UsersRec: Record "User Setup";
                    begin

                        UsersRec.Reset();
                        UsersRec.SetRange("User ID", UserId());
                        UsersRec.FindSet();

                        LocationRec.Reset();
                        LocationRec.SetRange("code", UsersRec."Factory Code");
                        LocationRec.SetFilter("Sewing Unit", '=%1', true);

                        if Page.RunModal(50517, LocationRec) = Action::LookupOK then begin
                            "Factory Code" := LocationRec.Code;
                            "Factory Name" := LocationRec.Name;
                            LoadData();
                        end;

                    end;
                }
            }

            part(PreProductionFallowLineL; PreProductionFallowLine)
            {
                ApplicationArea = All;
                Caption = '  ';
                SubPageLink = "Factory Code" = field("Factory Code");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Load")
            {
                ApplicationArea = All;
                Image = GetLines;

                trigger OnAction()
                var
                begin
                    LoadData();
                end;
            }
        }
    }

    procedure LoadData()
    var
        NavPlaningLineRec: Record "NavApp Planning Lines";
        NavPlaningLine2Rec: Record "NavApp Planning Lines";
        PreProductionFallowline: Record PreProductionFollowUpline;
        PreProductionFallowline1: Record PreProductionFollowUpline;
        StyleMasterRec: Record "Style Master";
        locationRec: Record Location;
        "Min Date": Date;
        "Max Date": Date;
        MaxNo: BigInteger;
    begin
        locationRec.Reset();
        locationRec.SetRange(Code, "Factory Code");
        locationRec.FindSet();

        NavPlaningLineRec.Reset();
        NavPlaningLineRec.SetRange(Factory, "Factory Code");
        NavPlaningLineRec.SetCurrentKey("Style No.");
        NavPlaningLineRec.Ascending(true);

        if NavPlaningLineRec.FindSet() then begin

            repeat
                //Get style details
                StyleMasterRec.Reset();
                StyleMasterRec.SetRange("No.", NavPlaningLineRec."Style No.");
                StyleMasterRec.FindSet();

                //Get min date (start date)
                NavPlaningLine2Rec.Reset();
                NavPlaningLine2Rec.SetRange(Factory, "Factory Code");
                NavPlaningLine2Rec.SetRange("Style No.", StyleMasterRec."No.");
                NavPlaningLine2Rec.SetCurrentKey("Start Date");
                NavPlaningLine2Rec.Ascending(true);

                if NavPlaningLine2Rec.FindFirst() then
                    "Min Date" := NavPlaningLine2Rec."Start Date";

                //Get max date (finish date)
                NavPlaningLine2Rec.Reset();
                NavPlaningLine2Rec.SetRange(Factory, "Factory Code");
                NavPlaningLine2Rec.SetRange("Style No.", StyleMasterRec."No.");
                NavPlaningLine2Rec.SetCurrentKey("End Date");
                NavPlaningLine2Rec.Ascending(false);

                if NavPlaningLine2Rec.FindFirst() then
                    "Max Date" := NavPlaningLine2Rec."End Date";

                //Get max line no for the factory and style
                MaxNo := 0;
                PreProductionFallowline1.Reset();
                PreProductionFallowline1.SetRange("Factory Code", "Factory Code");
                PreProductionFallowline1.SetRange("Style No", NavPlaningLineRec."Style No.");
                if PreProductionFallowline1.FindLast() then
                    MaxNo := PreProductionFallowline1."Line No";

                MaxNo += 1;

                PreProductionFallowline.Reset();
                PreProductionFallowline.SetRange("Factory Code", "Factory Code");
                PreProductionFallowline.SetRange("Style No", NavPlaningLineRec."Style No.");

                if not PreProductionFallowline.FindSet() then begin
                    PreProductionFallowline.Init();
                    PreProductionFallowline."Line No" := MaxNo;
                    PreProductionFallowline."Factory Name" := "Factory Name";
                    PreProductionFallowline."Factory Code" := "Factory Code";
                    PreProductionFallowline.Buyer := StyleMasterRec."Buyer Name";
                    PreProductionFallowline."Buyer No" := StyleMasterRec."Buyer No.";
                    PreProductionFallowline.Style := StyleMasterRec."Style No.";
                    PreProductionFallowline."Style No" := StyleMasterRec."No.";
                    PreProductionFallowline."Order Qty" := StyleMasterRec."Order Qty";
                    PreProductionFallowline."Ship Date" := StyleMasterRec."Ship Date";
                    PreProductionFallowline."Start Date" := "Min Date";
                    PreProductionFallowline."End Date" := "Max Date";
                    PreProductionFallowline.Insert();
                end
                else begin
                    PreProductionFallowline."Start Date" := "Min Date";
                    PreProductionFallowline."End Date" := "Max Date";
                    PreProductionFallowline.Modify();
                end;

            until NavPlaningLineRec.Next() = 0;
        end
    end;

}