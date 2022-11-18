page 50835 PreProductionfollowup
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Pre-Production Follow Up';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Factory Code"; "Factory Code")
                {
                    Caption = 'Factory';
                    ApplicationArea = All;
                    TableRelation = Location.Code where("Sewing Unit" = filter(1));

                    trigger OnValidate()
                    var
                        locationRec: Record Location;
                    begin

                        locationRec.Reset();
                        locationRec.SetRange(Code, "Factory Code");

                        if locationRec.FindSet() then
                            "Factory Name" := locationRec.Name;
                    end;
                }
            }

            part(PreProductionFallowLineL; PreProductionFallowLine)
            {
                ApplicationArea = All;
                Caption = '  ';
                // SubPageLink=Factory=field()

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

                trigger OnAction()
                var
                    NavPlaningLineRec: Record "NavApp Planning Lines";
                    NavPlaningLine2Rec: Record "NavApp Planning Lines";
                    PreProductionFallowline: Record PreProductionFollowUpline;
                    StyleMasterRec: Record "Style Master";
                    //StyleMaster1Rec: Record "Style Master";
                    "Min Date": Date;
                    "Max Date": Date;
                    MaxNo: BigInteger;


                begin

                    NavPlaningLineRec.Reset();
                    NavPlaningLineRec.SetRange(Factory, "Factory Code");
                    NavPlaningLineRec.SetCurrentKey("Style No.");
                    NavPlaningLineRec.Ascending(true);
                    MaxNo := 0;
                    if NavPlaningLineRec.FindSet() then begin

                        repeat

                            PreProductionFallowline.Reset();
                            PreProductionFallowline.SetRange("Factory Code", "Factory Code");
                            PreProductionFallowline.SetRange("Style No", NavPlaningLineRec."Style No.");

                            if not PreProductionFallowline.FindSet() then begin

                                StyleMasterRec.Reset();
                                StyleMasterRec.SetRange("No.", NavPlaningLineRec."Style No.");

                                if StyleMasterRec.FindSet() then begin

                                    NavPlaningLine2Rec.Reset();
                                    NavPlaningLine2Rec.SetRange(Factory, "Factory Code");
                                    NavPlaningLine2Rec.SetRange("Style No.", StyleMasterRec."No.");
                                    NavPlaningLine2Rec.SetCurrentKey("Start Date");
                                    NavPlaningLine2Rec.Ascending(true);

                                    if NavPlaningLine2Rec.FindFirst() then
                                        "Min Date" := NavPlaningLine2Rec."Start Date";


                                    NavPlaningLine2Rec.Reset();
                                    NavPlaningLine2Rec.SetRange(Factory, "Factory Code");
                                    NavPlaningLine2Rec.SetRange("Style No.", StyleMasterRec."No.");
                                    NavPlaningLine2Rec.SetCurrentKey("End Date");
                                    NavPlaningLine2Rec.Ascending(false);

                                    if NavPlaningLine2Rec.FindFirst() then
                                        "Max Date" := NavPlaningLine2Rec."End Date";

                                    if PreProductionFallowline.FindLast() then begin

                                        MaxNo := PreProductionFallowline."Line No";
                                    end;

                                    MaxNo += 1;

                                    PreProductionFallowline.Init();
                                    PreProductionFallowline."Line No" := MaxNo;
                                    PreProductionFallowline.Factory := "Factory Name";
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

                                end;
                            end;
                        until NavPlaningLineRec.Next() = 0;
                    end
                end;
            }
        }
    }

    var
        "Factory Code": Text[20];
        "Factory Name": Code[20];

}