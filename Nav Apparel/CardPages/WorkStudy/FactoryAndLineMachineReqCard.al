page 51368 FactoryAndLineMachineReqCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = FactoryandlinemachineReqlist;
    Caption = 'Planned Machine Requirment';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Factory Name"; Rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    Editable = false;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }

                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }

                field(VisibleGB; VisibleGB)
                {
                    ApplicationArea = All;
                    Caption = 'Filter By Line';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();

                        if VisibleGB = true then
                            VisibleGB2 := false;
                        if VisibleGB = false then begin
                            VisibleGB2 := true;
                            Rec."Resource Name" := '';
                            Rec."Resource No." := '';
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = all;
                    Caption = 'Line';
                    Editable = VisibleGB;

                    trigger OnValidate()
                    var
                        WorkcenterRec: Record "Work Center";
                    begin
                        WorkcenterRec.Reset();
                        WorkcenterRec.SetRange(Name, Rec."Resource Name");
                        if WorkcenterRec.FindSet() then
                            Rec."Resource No." := WorkcenterRec."No.";
                    end;
                }
            }

            group("Machine Requirement - Factory Wise")
            {
                part(StyleWiseMachineReqLine2; StyleWiseMachineReqLine2)
                {
                    ApplicationArea = all;
                    Caption = ' ';
                    SubPageLink = Factory = field("Factory Name");
                    Visible = VisibleGB2;
                }
            }

            group("Machine Requirement - Line Wise")
            {
                part(StyleWiseMachineReqLine3; StyleWiseMachineReqLine3)
                {
                    ApplicationArea = all;
                    Caption = ' ';
                    SubPageLink = Factory = field("Factory Name");
                    Visible = VisibleGB;
                }
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
                Image = MachineCenter;

                trigger OnAction()
                var
                    NavAppPlanProdLineRec: Record "NavApp Prod Plans Details";
                    StyleWiseMachineLineRec: Record StyleWiseMachineLine;
                    StyleWiseMachineLine1Rec: Record StyleWiseMachineLine;
                    FactoryAndLineRec: Record FactoryAndLineMachineLine;
                    FactoryAndLine1Rec: Record FactoryAndLineMachineLine;
                    FactoryAndLineTotRec: Record FactoryAndLineMachineLine;
                    FactoryAndLine2Rec: Record FactoryAndLineMachine2Line;
                    FactoryAndLine2TotaRec: Record FactoryAndLineMachine2Line;
                    WorkCenterRec: Record "Work Center";
                    LineNo: Integer;
                    Y: Integer;
                    M: Integer;
                    D: Integer;
                    MonthText: Text[50];
                    PreResourceNo: code[20];
                    PreDate: Integer;
                    PreVal: Decimal;
                    PrevStyleNo: code[20];
                begin
                    if REc."Start Date" = 0D then
                        Error('Start Date is blank.');

                    if REc."End Date" = 0D then
                        Error('Start Date is blank.');

                    if Rec."End Date" < Rec."Start Date" then
                        Error('Invalid date range.');

                    if VisibleGB = true then begin
                        if Rec."Resource Name" = '' then
                            Error('Resource Name is blank.');
                    end;

                    PreResourceNo := '';
                    PreDate := 0;
                    PreVal := 0;

                    FactoryAndLineRec.Reset();
                    FactoryAndLineRec.SetRange(Factory, Rec."Factory Name");
                    if FactoryAndLineRec.FindSet() then
                        FactoryAndLineRec.DeleteAll();

                    FactoryAndLine2Rec.Reset();
                    FactoryAndLine2Rec.SetRange(Factory, Rec."Factory Name");
                    if FactoryAndLine2Rec.FindSet() then
                        FactoryAndLine2Rec.DeleteAll();

                    if Rec."Resource No." = '' then begin   //Filter by line option not clicked

                        //Get all planning lines for the date period
                        NavAppPlanProdLineRec.Reset();
                        NavAppPlanProdLineRec.SetRange("Factory No.", Rec."Factory Code");
                        NavAppPlanProdLineRec.SetRange(PlanDate, Rec."Start Date", Rec."End Date");
                        NavAppPlanProdLineRec.SetCurrentKey("Resource No.", PlanDate);
                        NavAppPlanProdLineRec.Ascending(True);
                        if NavAppPlanProdLineRec.FindSet() then begin

                            repeat
                                evaluate(Y, copystr(Format(NavAppPlanProdLineRec.PlanDate), 7, 2));
                                evaluate(M, copystr(Format(NavAppPlanProdLineRec.PlanDate), 4, 2));
                                evaluate(D, copystr(Format(NavAppPlanProdLineRec.PlanDate), 1, 2));

                                Y := Y + 2000;

                                If M = 1 then
                                    MonthText := 'January';
                                If M = 2 then
                                    MonthText := 'February';
                                If M = 3 then
                                    MonthText := 'March';
                                If M = 4 then
                                    MonthText := 'April';
                                If M = 5 then
                                    MonthText := 'May';
                                If M = 6 then
                                    MonthText := 'June';
                                If M = 7 then
                                    MonthText := 'July';
                                If M = 8 then
                                    MonthText := 'August';
                                If M = 9 then
                                    MonthText := 'September';
                                If M = 10 then
                                    MonthText := 'October';
                                If M = 11 then
                                    MonthText := 'November';
                                If M = 12 then
                                    MonthText := 'December';

                                //Get Style wise machine requirment
                                StyleWiseMachineLineRec.Reset();
                                StyleWiseMachineLineRec.SetRange("Style No", NavAppPlanProdLineRec."Style No.");
                                StyleWiseMachineLineRec.SetRange(Factory, rec."Factory Code");
                                StyleWiseMachineLineRec.SetFilter("Record Type", '=%1', 'L');
                                StyleWiseMachineLineRec.SetCurrentKey("Machine No");
                                StyleWiseMachineLineRec.Ascending(true);
                                if StyleWiseMachineLineRec.FindSet() then begin

                                    repeat
                                        //Insert or Modify Total
                                        FactoryAndLineTotRec.Reset();
                                        FactoryAndLineTotRec.SetRange(Factory, Rec."Factory Name");
                                        FactoryAndLineTotRec.SetFilter("Record Type", '=%1', 'T');
                                        if not FactoryAndLineTotRec.FindSet() then begin

                                            FactoryAndLineTotRec.Init();
                                            FactoryAndLineTotRec.Factory := Rec."Factory Name";
                                            FactoryAndLineTotRec."Machine type" := '';
                                            FactoryAndLineTotRec."Machine Description" := 'TOTAL';
                                            FactoryAndLineTotRec."Line No" := 9999;
                                            FactoryAndLineTotRec.Month := '';
                                            FactoryAndLineTotRec.Year := 0;
                                            FactoryAndLineTotRec."Record Type" := 'T';

                                            if D = 1 then
                                                FactoryAndLineTotRec."1 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 2 then
                                                FactoryAndLineTotRec."2 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 3 then
                                                FactoryAndLineTotRec."3 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 4 then
                                                FactoryAndLineTotRec."4 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 5 then
                                                FactoryAndLineTotRec."5 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 6 then
                                                FactoryAndLineTotRec."6 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 7 then
                                                FactoryAndLineTotRec."7 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 8 then
                                                FactoryAndLineTotRec."8 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 9 then
                                                FactoryAndLineTotRec."9 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 10 then
                                                FactoryAndLineTotRec."10 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 11 then
                                                FactoryAndLineTotRec."11 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 12 then
                                                FactoryAndLineTotRec."12 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 13 then
                                                FactoryAndLineTotRec."13 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 14 then
                                                FactoryAndLineTotRec."14 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 15 then
                                                FactoryAndLineTotRec."15 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 16 then
                                                FactoryAndLineTotRec."16 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 17 then
                                                FactoryAndLineTotRec."17 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 18 then
                                                FactoryAndLineTotRec."18 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 19 then
                                                FactoryAndLineTotRec."19 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 20 then
                                                FactoryAndLineTotRec."20 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 21 then
                                                FactoryAndLineTotRec."21 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 22 then
                                                FactoryAndLineTotRec."22 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 23 then
                                                FactoryAndLineTotRec."23 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 24 then
                                                FactoryAndLineTotRec."24 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 25 then
                                                FactoryAndLineTotRec."25 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 26 then
                                                FactoryAndLineTotRec."26 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 27 then
                                                FactoryAndLineTotRec."27 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 28 then
                                                FactoryAndLineTotRec."28 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 29 then
                                                FactoryAndLineTotRec."29 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 30 then
                                                FactoryAndLineTotRec."30 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 31 then
                                                FactoryAndLineTotRec."31 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            FactoryAndLineTotRec.Insert();

                                        end
                                        else begin
                                            if D = 1 then
                                                FactoryAndLineTotRec."1 New" := FactoryAndLineTotRec."1 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 2 then
                                                FactoryAndLineTotRec."2 New" := FactoryAndLineTotRec."2 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 3 then
                                                FactoryAndLineTotRec."3 New" := FactoryAndLineTotRec."3 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 4 then
                                                FactoryAndLineTotRec."4 New" := FactoryAndLineTotRec."4 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 5 then
                                                FactoryAndLineTotRec."5 New" := FactoryAndLineTotRec."5 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 6 then
                                                FactoryAndLineTotRec."6 New" := FactoryAndLineTotRec."6 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 7 then
                                                FactoryAndLineTotRec."7 New" := FactoryAndLineTotRec."7 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 8 then
                                                FactoryAndLineTotRec."8 New" := FactoryAndLineTotRec."8 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 9 then
                                                FactoryAndLineTotRec."9 New" := FactoryAndLineTotRec."9 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 10 then
                                                FactoryAndLineTotRec."10 New" := FactoryAndLineTotRec."10 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 11 then
                                                FactoryAndLineTotRec."11 New" := FactoryAndLineTotRec."11 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 12 then
                                                FactoryAndLineTotRec."12 New" := FactoryAndLineTotRec."12 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 13 then
                                                FactoryAndLineTotRec."13 New" := FactoryAndLineTotRec."13 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 14 then
                                                FactoryAndLineTotRec."14 New" := FactoryAndLineTotRec."14 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 15 then
                                                FactoryAndLineTotRec."15 New" := FactoryAndLineTotRec."15 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 16 then
                                                FactoryAndLineTotRec."16 New" := FactoryAndLineTotRec."16 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 17 then
                                                FactoryAndLineTotRec."17 New" := FactoryAndLineTotRec."17 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 18 then
                                                FactoryAndLineTotRec."18 New" := FactoryAndLineTotRec."18 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 19 then
                                                FactoryAndLineTotRec."19 New" := FactoryAndLineTotRec."19 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 20 then
                                                FactoryAndLineTotRec."20 New" := FactoryAndLineTotRec."20 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 21 then
                                                FactoryAndLineTotRec."21 New" := FactoryAndLineTotRec."21 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 22 then
                                                FactoryAndLineTotRec."22 New" := FactoryAndLineTotRec."22 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 23 then
                                                FactoryAndLineTotRec."23 New" := FactoryAndLineTotRec."23 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 24 then
                                                FactoryAndLineTotRec."24 New" := FactoryAndLineTotRec."24 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 25 then
                                                FactoryAndLineTotRec."25 New" := FactoryAndLineTotRec."25 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 26 then
                                                FactoryAndLineTotRec."26 New" := FactoryAndLineTotRec."26 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 27 then
                                                FactoryAndLineTotRec."27 New" := FactoryAndLineTotRec."27 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 28 then
                                                FactoryAndLineTotRec."28 New" := FactoryAndLineTotRec."28 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 29 then
                                                FactoryAndLineTotRec."29 New" := FactoryAndLineTotRec."29 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 30 then
                                                FactoryAndLineTotRec."30 New" := FactoryAndLineTotRec."30 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 31 then
                                                FactoryAndLineTotRec."31 New" := FactoryAndLineTotRec."31 New" + StyleWiseMachineLineRec."Machine Qty New";
                                            FactoryAndLineTotRec.Modify()
                                        end;

                                        FactoryAndLineRec.Reset();
                                        FactoryAndLineRec.SetRange("Machine type", StyleWiseMachineLineRec."Machine No");
                                        FactoryAndLineRec.SetRange(Factory, Rec."Factory Name");
                                        FactoryAndLineRec.SetRange(Month, MonthText);
                                        if not FactoryAndLineRec.FindSet() then begin

                                            LineNo += 1;
                                            FactoryAndLineRec.Init();
                                            FactoryAndLineRec.Factory := Rec."Factory Name";
                                            FactoryAndLineRec."Machine type" := StyleWiseMachineLineRec."Machine No";
                                            FactoryAndLineRec."Machine Description" := StyleWiseMachineLineRec."Machine Name";
                                            FactoryAndLineRec."Line No" := LineNo;
                                            FactoryAndLineRec.Month := MonthText;
                                            FactoryAndLineRec.Year := Y;
                                            FactoryAndLineRec."Record Type" := 'R';

                                            if D = 1 then
                                                FactoryAndLineRec."1 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 2 then
                                                FactoryAndLineRec."2 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 3 then
                                                FactoryAndLineRec."3 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 4 then
                                                FactoryAndLineRec."4 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 5 then
                                                FactoryAndLineRec."5 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 6 then
                                                FactoryAndLineRec."6 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 7 then
                                                FactoryAndLineRec."7 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 8 then
                                                FactoryAndLineRec."8 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 9 then
                                                FactoryAndLineRec."9 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 10 then
                                                FactoryAndLineRec."10 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 11 then
                                                FactoryAndLineRec."11 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 12 then
                                                FactoryAndLineRec."12 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 13 then
                                                FactoryAndLineRec."13 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 14 then
                                                FactoryAndLineRec."14 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 15 then
                                                FactoryAndLineRec."15 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 16 then
                                                FactoryAndLineRec."16 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 17 then
                                                FactoryAndLineRec."17 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 18 then
                                                FactoryAndLineRec."18 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 19 then
                                                FactoryAndLineRec."19 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 20 then
                                                FactoryAndLineRec."20 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 21 then
                                                FactoryAndLineRec."21 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 22 then
                                                FactoryAndLineRec."22 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 23 then
                                                FactoryAndLineRec."23 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 24 then
                                                FactoryAndLineRec."24 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 25 then
                                                FactoryAndLineRec."25 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 26 then
                                                FactoryAndLineRec."26 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 27 then
                                                FactoryAndLineRec."27 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 28 then
                                                FactoryAndLineRec."28 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 29 then
                                                FactoryAndLineRec."29 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 30 then
                                                FactoryAndLineRec."30 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 31 then
                                                FactoryAndLineRec."31 New" := StyleWiseMachineLineRec."Machine Qty New";
                                            FactoryAndLineRec.Insert();
                                        end
                                        else begin

                                            if (PreResourceNo = NavAppPlanProdLineRec."Resource No.") and (PreDate = D) then begin
                                                FactoryAndLine1Rec.Reset();
                                                FactoryAndLine1Rec.SetRange("Machine type", StyleWiseMachineLineRec."Machine No");
                                                FactoryAndLine1Rec.SetRange(Factory, Rec."Factory Name");
                                                FactoryAndLine1Rec.SetRange(Month, MonthText);
                                                if FactoryAndLine1Rec.FindSet() then begin

                                                    WorkCenterRec.Reset();
                                                    WorkCenterRec.SetRange("No.", NavAppPlanProdLineRec."Resource No.");
                                                    WorkCenterRec.FindSet();

                                                    StyleWiseMachineLine1Rec.Reset();
                                                    StyleWiseMachineLine1Rec.SetRange("Style No", PrevStyleNo);
                                                    StyleWiseMachineLine1Rec.SetRange(Factory, rec."Factory Code");
                                                    StyleWiseMachineLine1Rec.SetRange("Work Center Name", WorkCenterRec.Name);
                                                    StyleWiseMachineLine1Rec.SetRange("Machine No", StyleWiseMachineLineRec."Machine No");
                                                    StyleWiseMachineLine1Rec.SetFilter("Record Type", '=%1', 'L');
                                                    if StyleWiseMachineLine1Rec.FindSet() then
                                                        PreVal := StyleWiseMachineLine1Rec."Machine Qty New"
                                                    else
                                                        PreVal := 0;


                                                    if D = 1 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."1 New" := FactoryAndLineRec."1 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 2 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."2 New" := FactoryAndLineRec."2 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 3 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."3 New" := FactoryAndLineRec."3 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 4 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."4 New" := FactoryAndLineRec."4 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 5 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."5 New" := FactoryAndLineRec."5 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 6 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."6 New" := FactoryAndLineRec."6 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 7 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."7 New" := FactoryAndLineRec."7 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 8 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."8 New" := FactoryAndLineRec."8 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 9 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."9 New" := FactoryAndLineRec."9 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 10 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."10 New" := FactoryAndLineRec."10 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 11 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."11 New" := FactoryAndLineRec."11 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 12 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."12 New" := FactoryAndLineRec."12 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 13 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."13 New" := FactoryAndLineRec."13 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 14 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."14 New" := FactoryAndLineRec."14 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 15 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."15 New" := FactoryAndLineRec."15 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 16 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."16 New" := FactoryAndLineRec."16 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 17 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."17 New" := FactoryAndLineRec."17 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 18 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."18 New" := FactoryAndLineRec."18 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 19 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."19 New" := FactoryAndLineRec."19 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 20 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."20 New" := FactoryAndLineRec."20 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 21 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."21 New" := FactoryAndLineRec."21 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 22 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."22 New" := FactoryAndLineRec."22 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 23 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."23 New" := FactoryAndLineRec."23 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 24 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."24 New" := FactoryAndLineRec."24 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 25 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."25 New" := FactoryAndLineRec."25 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 26 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."26 New" := FactoryAndLineRec."26 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 27 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."27 New" := FactoryAndLineRec."27 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 28 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."28 New" := FactoryAndLineRec."28 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 29 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."29 New" := FactoryAndLineRec."29 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 30 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."30 New" := FactoryAndLineRec."30 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 31 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLineRec."31 New" := FactoryAndLineRec."31 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);

                                                    FactoryAndLineRec.Modify();
                                                end;
                                            end
                                            else begin

                                                if D = 1 then
                                                    FactoryAndLineRec."1 New" := FactoryAndLineRec."1 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 2 then
                                                    FactoryAndLineRec."2 New" := FactoryAndLineRec."2 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 3 then
                                                    FactoryAndLineRec."3 New" := FactoryAndLineRec."3 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 4 then
                                                    FactoryAndLineRec."4 New" := FactoryAndLineRec."4 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 5 then
                                                    FactoryAndLineRec."5 New" := FactoryAndLineRec."5 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 6 then
                                                    FactoryAndLineRec."6 New" := FactoryAndLineRec."6 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 7 then
                                                    FactoryAndLineRec."7 New" := FactoryAndLineRec."7 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 8 then
                                                    FactoryAndLineRec."8 New" := FactoryAndLineRec."8 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 9 then
                                                    FactoryAndLineRec."9 New" := FactoryAndLineRec."9 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 10 then
                                                    FactoryAndLineRec."10 New" := FactoryAndLineRec."10 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 11 then
                                                    FactoryAndLineRec."11 New" := FactoryAndLineRec."11 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 12 then
                                                    FactoryAndLineRec."12 New" := FactoryAndLineRec."12 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 13 then
                                                    FactoryAndLineRec."13 New" := FactoryAndLineRec."13 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 14 then
                                                    FactoryAndLineRec."14 New" := FactoryAndLineRec."14 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 15 then
                                                    FactoryAndLineRec."15 New" := FactoryAndLineRec."15 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 16 then
                                                    FactoryAndLineRec."16 New" := FactoryAndLineRec."16 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 17 then
                                                    FactoryAndLineRec."17 New" := FactoryAndLineRec."17 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 18 then
                                                    FactoryAndLineRec."18 New" := FactoryAndLineRec."18 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 19 then
                                                    FactoryAndLineRec."19 New" := FactoryAndLineRec."19 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 20 then
                                                    FactoryAndLineRec."20 New" := FactoryAndLineRec."20 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 21 then
                                                    FactoryAndLineRec."21 New" := FactoryAndLineRec."21 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 22 then
                                                    FactoryAndLineRec."22 New" := FactoryAndLineRec."22 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 23 then
                                                    FactoryAndLineRec."23 New" := FactoryAndLineRec."23 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 24 then
                                                    FactoryAndLineRec."24 New" := FactoryAndLineRec."24 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 25 then
                                                    FactoryAndLineRec."25 New" := FactoryAndLineRec."25 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 26 then
                                                    FactoryAndLineRec."26 New" := FactoryAndLineRec."26 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 27 then
                                                    FactoryAndLineRec."27 New" := FactoryAndLineRec."27 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 28 then
                                                    FactoryAndLineRec."28 New" := FactoryAndLineRec."28 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 29 then
                                                    FactoryAndLineRec."29 New" := FactoryAndLineRec."29 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 30 then
                                                    FactoryAndLineRec."30 New" := FactoryAndLineRec."30 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 31 then
                                                    FactoryAndLineRec."31 New" := FactoryAndLineRec."31 New" + StyleWiseMachineLineRec."Machine Qty New";

                                                FactoryAndLineRec.Modify();
                                            end;
                                        end;
                                    until StyleWiseMachineLineRec.Next() = 0;

                                    PreResourceNo := NavAppPlanProdLineRec."Resource No.";
                                    PreDate := D;
                                    PrevStyleNo := NavAppPlanProdLineRec."Style No.";
                                end;
                            until NavAppPlanProdLineRec.Next() = 0;
                        end;
                    end
                    else begin       ////////////////////////line wise
                        //Get all planning lines for the date period and line
                        NavAppPlanProdLineRec.Reset();
                        NavAppPlanProdLineRec.SetRange("Factory No.", Rec."Factory Code");
                        NavAppPlanProdLineRec.SetRange("Resource No.", rec."Resource No.");
                        NavAppPlanProdLineRec.SetRange(PlanDate, Rec."Start Date", Rec."End Date");
                        NavAppPlanProdLineRec.SetCurrentKey(PlanDate);
                        NavAppPlanProdLineRec.Ascending(True);
                        if NavAppPlanProdLineRec.FindSet() then begin

                            repeat
                                evaluate(Y, copystr(Format(NavAppPlanProdLineRec.PlanDate), 7, 2));
                                evaluate(M, copystr(Format(NavAppPlanProdLineRec.PlanDate), 4, 2));
                                evaluate(D, copystr(Format(NavAppPlanProdLineRec.PlanDate), 1, 2));

                                Y := Y + 2000;

                                If M = 1 then
                                    MonthText := 'January';
                                If M = 2 then
                                    MonthText := 'February';
                                If M = 3 then
                                    MonthText := 'March';
                                If M = 4 then
                                    MonthText := 'April';
                                If M = 5 then
                                    MonthText := 'May';
                                If M = 6 then
                                    MonthText := 'June';
                                If M = 7 then
                                    MonthText := 'July';
                                If M = 8 then
                                    MonthText := 'August';
                                If M = 9 then
                                    MonthText := 'September';
                                If M = 10 then
                                    MonthText := 'October';
                                If M = 11 then
                                    MonthText := 'November';
                                If M = 12 then
                                    MonthText := 'December';

                                //Get Style/line wise machine requirment
                                StyleWiseMachineLineRec.Reset();
                                StyleWiseMachineLineRec.SetRange("Style No", NavAppPlanProdLineRec."Style No.");
                                StyleWiseMachineLineRec.SetCurrentKey("Machine No");
                                StyleWiseMachineLineRec.SetFilter("Record Type", '=%1', 'L');
                                StyleWiseMachineLineRec.SetRange("Work Center Name", rec."Resource Name");
                                StyleWiseMachineLineRec.Ascending(true);
                                if StyleWiseMachineLineRec.FindSet() then begin
                                    repeat

                                        //Insert or Modify Total
                                        FactoryAndLine2TotaRec.Reset();
                                        FactoryAndLine2TotaRec.SetRange(Factory, Rec."Factory Name");
                                        FactoryAndLine2TotaRec.SetRange("Resourse No", rec."Resource No.");
                                        FactoryAndLine2TotaRec.SetFilter("Record Type", '=%1', 'T');
                                        if not FactoryAndLine2TotaRec.FindSet() then begin

                                            FactoryAndLine2TotaRec.Init();
                                            FactoryAndLine2TotaRec.Factory := Rec."Factory Name";
                                            FactoryAndLine2TotaRec."Machine type" := '';
                                            FactoryAndLine2TotaRec."Machine Description" := 'TOTAL';
                                            FactoryAndLine2TotaRec."Line No" := 9999;
                                            FactoryAndLine2TotaRec.Month := '';
                                            FactoryAndLine2TotaRec.Year := 0;
                                            FactoryAndLine2TotaRec."Line No" := LineNo;
                                            FactoryAndLine2TotaRec."Record Type" := 'T';
                                            FactoryAndLine2TotaRec."Resource Name" := rec."Resource Name";
                                            FactoryAndLine2TotaRec."Resourse No" := rec."Resource No.";

                                            if D = 1 then
                                                FactoryAndLine2TotaRec."1" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 2 then
                                                FactoryAndLine2TotaRec."2" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 3 then
                                                FactoryAndLine2TotaRec."3" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 4 then
                                                FactoryAndLine2TotaRec."4" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 5 then
                                                FactoryAndLine2TotaRec."5" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 6 then
                                                FactoryAndLine2TotaRec."6" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 7 then
                                                FactoryAndLine2TotaRec."7" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 8 then
                                                FactoryAndLine2TotaRec."8" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 9 then
                                                FactoryAndLine2TotaRec."9" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 10 then
                                                FactoryAndLine2TotaRec."10" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 11 then
                                                FactoryAndLine2TotaRec."11" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 12 then
                                                FactoryAndLine2TotaRec."12" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 13 then
                                                FactoryAndLine2TotaRec."13" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 14 then
                                                FactoryAndLine2TotaRec."14" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 15 then
                                                FactoryAndLine2TotaRec."15" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 16 then
                                                FactoryAndLine2TotaRec."16" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 17 then
                                                FactoryAndLine2TotaRec."17" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 18 then
                                                FactoryAndLine2TotaRec."18" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 19 then
                                                FactoryAndLine2TotaRec."19" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 20 then
                                                FactoryAndLine2TotaRec."20" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 21 then
                                                FactoryAndLine2TotaRec."21" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 22 then
                                                FactoryAndLine2TotaRec."22" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 23 then
                                                FactoryAndLine2TotaRec."23" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 24 then
                                                FactoryAndLine2TotaRec."24" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 25 then
                                                FactoryAndLine2TotaRec."25" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 26 then
                                                FactoryAndLine2TotaRec."26" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 27 then
                                                FactoryAndLine2TotaRec."27" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 28 then
                                                FactoryAndLine2TotaRec."28" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 29 then
                                                FactoryAndLine2TotaRec."29" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 30 then
                                                FactoryAndLine2TotaRec."30" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 31 then
                                                FactoryAndLine2TotaRec."31" := StyleWiseMachineLineRec."Machine Qty New";

                                            FactoryAndLine2TotaRec.Insert();
                                        end
                                        else begin
                                            if D = 1 then
                                                FactoryAndLine2TotaRec."1" := FactoryAndLine2TotaRec."1" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 2 then
                                                FactoryAndLine2TotaRec."2" := FactoryAndLine2TotaRec."2" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 3 then
                                                FactoryAndLine2TotaRec."3" := FactoryAndLine2TotaRec."3" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 4 then
                                                FactoryAndLine2TotaRec."4" := FactoryAndLine2TotaRec."4" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 5 then
                                                FactoryAndLine2TotaRec."5" := FactoryAndLine2TotaRec."5" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 6 then
                                                FactoryAndLine2TotaRec."6" := FactoryAndLine2TotaRec."6" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 7 then
                                                FactoryAndLine2TotaRec."7" := FactoryAndLine2TotaRec."7" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 8 then
                                                FactoryAndLine2TotaRec."8" := FactoryAndLine2TotaRec."8" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 9 then
                                                FactoryAndLine2TotaRec."9" := FactoryAndLine2TotaRec."9" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 10 then
                                                FactoryAndLine2TotaRec."10" := FactoryAndLine2TotaRec."10" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 11 then
                                                FactoryAndLine2TotaRec."11" := FactoryAndLine2TotaRec."11" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 12 then
                                                FactoryAndLine2TotaRec."12" := FactoryAndLine2TotaRec."12" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 13 then
                                                FactoryAndLine2TotaRec."13" := FactoryAndLine2TotaRec."13" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 14 then
                                                FactoryAndLine2TotaRec."14" := FactoryAndLine2TotaRec."14" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 15 then
                                                FactoryAndLine2TotaRec."15" := FactoryAndLine2TotaRec."15" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 16 then
                                                FactoryAndLine2TotaRec."16" := FactoryAndLine2TotaRec."16" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 17 then
                                                FactoryAndLine2TotaRec."17" := FactoryAndLine2TotaRec."17" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 18 then
                                                FactoryAndLine2TotaRec."18" := FactoryAndLine2TotaRec."18" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 19 then
                                                FactoryAndLine2TotaRec."19" := FactoryAndLine2TotaRec."19" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 20 then
                                                FactoryAndLine2TotaRec."20" := FactoryAndLine2TotaRec."20" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 21 then
                                                FactoryAndLine2TotaRec."21" := FactoryAndLine2TotaRec."21" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 22 then
                                                FactoryAndLine2TotaRec."22" := FactoryAndLine2TotaRec."22" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 23 then
                                                FactoryAndLine2TotaRec."23" := FactoryAndLine2TotaRec."23" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 24 then
                                                FactoryAndLine2TotaRec."24" := FactoryAndLine2TotaRec."24" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 25 then
                                                FactoryAndLine2TotaRec."25" := FactoryAndLine2TotaRec."25" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 26 then
                                                FactoryAndLine2TotaRec."26" := FactoryAndLine2TotaRec."26" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 27 then
                                                FactoryAndLine2TotaRec."27" := FactoryAndLine2TotaRec."27" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 28 then
                                                FactoryAndLine2TotaRec."28" := FactoryAndLine2TotaRec."28" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 29 then
                                                FactoryAndLine2TotaRec."29" := FactoryAndLine2TotaRec."29" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 30 then
                                                FactoryAndLine2TotaRec."30" := FactoryAndLine2TotaRec."30" + StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 31 then
                                                FactoryAndLine2TotaRec."31" := FactoryAndLine2TotaRec."31" + StyleWiseMachineLineRec."Machine Qty New";
                                            FactoryAndLine2TotaRec.Modify()
                                        end;

                                        FactoryAndLine2Rec.Reset();
                                        FactoryAndLine2Rec.SetRange("Machine type", StyleWiseMachineLineRec."Machine No");
                                        FactoryAndLine2Rec.SetRange(Factory, Rec."Factory Name");
                                        FactoryAndLine2Rec.SetRange("Resourse No", rec."Resource No.");
                                        FactoryAndLine2Rec.SetRange(Month, MonthText);
                                        if not FactoryAndLine2Rec.FindSet() then begin

                                            LineNo += 1;
                                            FactoryAndLine2Rec.Init();
                                            FactoryAndLine2Rec.Factory := Rec."Factory Name";
                                            FactoryAndLine2Rec."Machine type" := StyleWiseMachineLineRec."Machine No";
                                            FactoryAndLine2Rec."Machine Description" := StyleWiseMachineLineRec."Machine Name";
                                            FactoryAndLine2Rec."Line No" := LineNo;
                                            FactoryAndLine2Rec.Month := MonthText;
                                            FactoryAndLine2Rec."Record Type" := 'R';
                                            FactoryAndLine2Rec."Resource Name" := rec."Resource Name";
                                            FactoryAndLine2Rec."Resourse No" := rec."Resource No.";
                                            FactoryAndLine2Rec.Year := y;

                                            if D = 1 then
                                                FactoryAndLine2Rec."1" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 2 then
                                                FactoryAndLine2Rec."2" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 3 then
                                                FactoryAndLine2Rec."3" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 4 then
                                                FactoryAndLine2Rec."4" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 5 then
                                                FactoryAndLine2Rec."5" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 6 then
                                                FactoryAndLine2Rec."6" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 7 then
                                                FactoryAndLine2Rec."7" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 8 then
                                                FactoryAndLine2Rec."8" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 9 then
                                                FactoryAndLine2Rec."9" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 10 then
                                                FactoryAndLine2Rec."10" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 11 then
                                                FactoryAndLine2Rec."11" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 12 then
                                                FactoryAndLine2Rec."12" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 13 then
                                                FactoryAndLine2Rec."13" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 14 then
                                                FactoryAndLine2Rec."14" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 15 then
                                                FactoryAndLine2Rec."15" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 16 then
                                                FactoryAndLine2Rec."16" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 17 then
                                                FactoryAndLine2Rec."17" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 18 then
                                                FactoryAndLine2Rec."18" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 19 then
                                                FactoryAndLine2Rec."19" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 20 then
                                                FactoryAndLine2Rec."20" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 21 then
                                                FactoryAndLine2Rec."21" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 22 then
                                                FactoryAndLine2Rec."22" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 23 then
                                                FactoryAndLine2Rec."23" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 24 then
                                                FactoryAndLine2Rec."24" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 25 then
                                                FactoryAndLine2Rec."25" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 26 then
                                                FactoryAndLine2Rec."26" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 27 then
                                                FactoryAndLine2Rec."27" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 28 then
                                                FactoryAndLine2Rec."28" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 29 then
                                                FactoryAndLine2Rec."29" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 30 then
                                                FactoryAndLine2Rec."30" := StyleWiseMachineLineRec."Machine Qty New";
                                            if D = 31 then
                                                FactoryAndLine2Rec."31" := StyleWiseMachineLineRec."Machine Qty New";

                                            FactoryAndLine2Rec.Insert();
                                        end
                                        else begin
                                            if (PreResourceNo = NavAppPlanProdLineRec."Resource No.") and (PreDate = D) then begin
                                                FactoryAndLine2Rec.Reset();
                                                FactoryAndLine2Rec.SetRange("Machine type", StyleWiseMachineLineRec."Machine No");
                                                FactoryAndLine2Rec.SetRange(Factory, Rec."Factory Name");
                                                FactoryAndLine2Rec.SetRange("Resourse No", rec."Resource No.");
                                                FactoryAndLine2Rec.SetRange(Month, MonthText);
                                                if FactoryAndLine2Rec.FindSet() then begin

                                                    if D = 1 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."1 New" := FactoryAndLine2Rec."1 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 2 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."2 New" := FactoryAndLine2Rec."2 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 3 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."3 New" := FactoryAndLine2Rec."3 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 4 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."4 New" := FactoryAndLine2Rec."4 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 5 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."5 New" := FactoryAndLine2Rec."5 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 6 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."6 New" := FactoryAndLine2Rec."6 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 7 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."7 New" := FactoryAndLine2Rec."7 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 8 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."8 New" := FactoryAndLine2Rec."8 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 9 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."9 New" := FactoryAndLine2Rec."9 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 10 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."10 New" := FactoryAndLine2Rec."10 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 11 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."11 New" := FactoryAndLine2Rec."11 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 12 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."12 New" := FactoryAndLine2Rec."12 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 13 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."13 New" := FactoryAndLine2Rec."13 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 14 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."14 New" := FactoryAndLine2Rec."14 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 15 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."15 New" := FactoryAndLine2Rec."15 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 16 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."16 New" := FactoryAndLine2Rec."16 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 17 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."17 New" := FactoryAndLine2Rec."17 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 18 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."18 New" := FactoryAndLine2Rec."18 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 19 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."19 New" := FactoryAndLine2Rec."19 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 20 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."20 New" := FactoryAndLine2Rec."20 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 21 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."21 New" := FactoryAndLine2Rec."21 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 22 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."22 New" := FactoryAndLine2Rec."22 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 23 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."23 New" := FactoryAndLine2Rec."23 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 24 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."24 New" := FactoryAndLine2Rec."24 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 25 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."25 New" := FactoryAndLine2Rec."25 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 26 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."26 New" := FactoryAndLine2Rec."26 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 27 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."27 New" := FactoryAndLine2Rec."27 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 28 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."28 New" := FactoryAndLine2Rec."28 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 29 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."29 New" := FactoryAndLine2Rec."29 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 30 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."30 New" := FactoryAndLine2Rec."30 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);
                                                    if D = 31 then
                                                        if PreVal < StyleWiseMachineLineRec."Machine Qty New" then
                                                            FactoryAndLine2Rec."31 New" := FactoryAndLine2Rec."31 New" + (StyleWiseMachineLineRec."Machine Qty New" - PreVal);

                                                    FactoryAndLine2Rec.Modify();
                                                end;
                                            end
                                            else begin
                                                if D = 1 then
                                                    FactoryAndLine2Rec."1 New" := FactoryAndLine2Rec."1 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 2 then
                                                    FactoryAndLine2Rec."2 New" := FactoryAndLine2Rec."2 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 3 then
                                                    FactoryAndLine2Rec."3 New" := FactoryAndLine2Rec."3 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 4 then
                                                    FactoryAndLine2Rec."4 New" := FactoryAndLine2Rec."4 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 5 then
                                                    FactoryAndLine2Rec."5 New" := FactoryAndLine2Rec."5 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 6 then
                                                    FactoryAndLine2Rec."6 New" := FactoryAndLine2Rec."6 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 7 then
                                                    FactoryAndLine2Rec."7 New" := FactoryAndLine2Rec."7 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 8 then
                                                    FactoryAndLine2Rec."8 New" := FactoryAndLine2Rec."8 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 9 then
                                                    FactoryAndLine2Rec."9 New" := FactoryAndLine2Rec."9 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 10 then
                                                    FactoryAndLine2Rec."10 New" := FactoryAndLine2Rec."10 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 11 then
                                                    FactoryAndLine2Rec."11 New" := FactoryAndLine2Rec."11 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 12 then
                                                    FactoryAndLine2Rec."12 New" := FactoryAndLine2Rec."12 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 13 then
                                                    FactoryAndLine2Rec."13 New" := FactoryAndLine2Rec."13 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 14 then
                                                    FactoryAndLine2Rec."14 New" := FactoryAndLine2Rec."14 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 15 then
                                                    FactoryAndLine2Rec."15 New" := FactoryAndLine2Rec."15 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 16 then
                                                    FactoryAndLine2Rec."16 New" := FactoryAndLine2Rec."16 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 17 then
                                                    FactoryAndLine2Rec."17 New" := FactoryAndLine2Rec."17 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 18 then
                                                    FactoryAndLine2Rec."18 New" := FactoryAndLine2Rec."18 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 19 then
                                                    FactoryAndLine2Rec."19 New" := FactoryAndLine2Rec."19 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 20 then
                                                    FactoryAndLine2Rec."20 New" := FactoryAndLine2Rec."20 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 21 then
                                                    FactoryAndLine2Rec."21 New" := FactoryAndLine2Rec."21 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 22 then
                                                    FactoryAndLine2Rec."22 New" := FactoryAndLine2Rec."22 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 23 then
                                                    FactoryAndLine2Rec."23 New" := FactoryAndLine2Rec."23 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 24 then
                                                    FactoryAndLine2Rec."24 New" := FactoryAndLine2Rec."24 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 25 then
                                                    FactoryAndLine2Rec."25 New" := FactoryAndLine2Rec."25 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 26 then
                                                    FactoryAndLine2Rec."26 New" := FactoryAndLine2Rec."26 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 27 then
                                                    FactoryAndLine2Rec."27 New" := FactoryAndLine2Rec."27 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 28 then
                                                    FactoryAndLine2Rec."28 New" := FactoryAndLine2Rec."28 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 29 then
                                                    FactoryAndLine2Rec."29 New" := FactoryAndLine2Rec."29 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 30 then
                                                    FactoryAndLine2Rec."30 New" := FactoryAndLine2Rec."30 New" + StyleWiseMachineLineRec."Machine Qty New";
                                                if D = 31 then
                                                    FactoryAndLine2Rec."31 New" := FactoryAndLine2Rec."31 New" + StyleWiseMachineLineRec."Machine Qty New";

                                                FactoryAndLine2Rec.Modify();
                                            end;
                                        end;

                                        PreResourceNo := NavAppPlanProdLineRec."Resource No.";
                                        PreDate := D;
                                        PreVal := StyleWiseMachineLineRec."Machine Qty New";

                                    until StyleWiseMachineLineRec.Next() = 0;
                                end;
                            until NavAppPlanProdLineRec.Next() = 0;
                        end;
                    end;
                    Message('Completed');
                end;
            }
        }
    }


    trigger OnOpenPage()
    begin
        VisibleGB := false;
        VisibleGB2 := true;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        FactoryAndLineMachineLineRec: Record FactoryAndLineMachineLine;
        FactoryAndLineMachine2LineRec: Record FactoryAndLineMachine2Line;
    begin
        FactoryAndLineMachineLineRec.Reset();
        FactoryAndLineMachineLineRec.SetRange(Factory, Rec."Factory Name");
        if FactoryAndLineMachineLineRec.FindSet() then
            FactoryAndLineMachineLineRec.DeleteAll();

        FactoryAndLineMachine2LineRec.Reset();
        FactoryAndLineMachine2LineRec.SetRange(Factory, Rec."Factory Name");
        if FactoryAndLineMachine2LineRec.FindSet() then
            FactoryAndLineMachine2LineRec.DeleteAll();
    end;

    var
        VisibleGB: Boolean;
        VisibleGB2: Boolean;
}