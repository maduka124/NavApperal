page 50835 PreProductionfollowup
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Per-Production Follow Up';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Factory; Factory)
                {
                    ApplicationArea = All;
                    TableRelation = Location.Code;

                    trigger OnValidate()
                    var
                        locationRec: Record Location;
                    begin

                        locationRec.Reset();
                        locationRec.SetRange(Code, Factory);

                        if locationRec.FindSet() then
                            "Factory Name" := locationRec.Name;
                    end;
                }
            }

            part(PreProductionFallowLineL; PreProductionFallowLine)
            {
                ApplicationArea = All;
                Caption = '  ';

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
                    NavPlaningLine: Record "NavApp Planning Lines";
                    PreProductionFallowline: Record PreProductionFollowUpline;
                    StyleMasterRec: Record "Style Master";
                    "Min Date": Date;
                    "Max Date": Date;
                begin

                    NavPlaningLine.Reset();
                    NavPlaningLine.SetRange(Factory, Factory);
                    NavPlaningLine.SetCurrentKey("Style No.");
                    NavPlaningLine.Ascending(true);

                    if NavPlaningLine.FindSet() then begin

                        repeat

                            PreProductionFallowline.Reset();
                            PreProductionFallowline.SetRange("Style No", NavPlaningLine."Style No.");

                            if not PreProductionFallowline.FindSet() then begin

                                StyleMasterRec.Reset();
                                StyleMasterRec.SetRange("No.", NavPlaningLine."Style No.");

                                if StyleMasterRec.FindSet() then begin
                                    NavPlaningLine.SetCurrentKey("Start Date");
                                    NavPlaningLine.Ascending(true);

                                    if NavPlaningLine.FindFirst() then
                                        "Min Date" := NavPlaningLine."Start Date";

                                    NavPlaningLine.SetCurrentKey("End Date");
                                    NavPlaningLine.Ascending(true);

                                    if NavPlaningLine.FindLast() then
                                        "Max Date" := NavPlaningLine."End Date";

                                    PreProductionFallowline.Init();
                                    PreProductionFallowline.Factory := NavPlaningLine.Factory;
                                    PreProductionFallowline."Factory Code" := Factory;
                                    PreProductionFallowline.Buyer := StyleMasterRec."Buyer Name";
                                    PreProductionFallowline."Buyer No" := StyleMasterRec."Buyer No.";
                                    PreProductionFallowline.Style := NavPlaningLine."Style Name";
                                    PreProductionFallowline."Style No" := NavPlaningLine."Style No.";
                                    PreProductionFallowline."Order Qty" := StyleMasterRec."Order Qty";
                                    PreProductionFallowline."Ship Date" := StyleMasterRec."Ship Date";
                                    PreProductionFallowline."Start Date" := "Min Date";
                                    PreProductionFallowline."End Date" := "Max Date";
                                    PreProductionFallowline.Insert();

                                end;
                            end;

                        until NavPlaningLine.Next() = 0;
                    end;
                end;
            }
        }
    }

    var
        Factory: Text[20];
        "Factory Name": Code[20];

}