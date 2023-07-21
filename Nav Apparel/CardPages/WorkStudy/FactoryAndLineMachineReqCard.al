page 51368 FactoryAndLineMachineReqCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = FactoryandlinemachineReqlist;
    Caption = 'Factory And Line Wise Machine Requirement';

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
                    FactoryAndLineRec: Record FactoryAndLineMachineLine;
                    FactoryAndLine2Rec: Record FactoryAndLineMachine2Line;
                    LineNo: Integer;
                    Y: Integer;
                    M: Integer;
                    D: Integer;
                    MonthText: Text[50];
                begin

                    if REc."Start Date" = 0D then
                        Error('Start Date cannot be empty');

                    if REc."End Date" = 0D then
                        Error('Start Date cannot be empty');

                    if Rec."End Date" < Rec."Start Date" then
                        Error('Invalid date range');

                    if VisibleGB = true then begin
                        if Rec."Resource Name" = '' then
                            Error('Resource Name cannot be blank');
                    end;

                    FactoryAndLineRec.Reset();
                    FactoryAndLineRec.SetRange(Factory, Rec."Factory Name");
                    if FactoryAndLineRec.FindSet() then
                        FactoryAndLineRec.DeleteAll();

                    FactoryAndLine2Rec.Reset();
                    FactoryAndLine2Rec.SetRange(Factory, Rec."Factory Name");
                    if FactoryAndLine2Rec.FindSet() then
                        FactoryAndLine2Rec.DeleteAll();

                    if Rec."Resource No." = '' then begin

                        NavAppPlanProdLineRec.Reset();
                        NavAppPlanProdLineRec.SetRange("Factory No.", Rec."Factory Code");
                        NavAppPlanProdLineRec.SetRange(PlanDate, Rec."Start Date", Rec."End Date");
                        NavAppPlanProdLineRec.SetCurrentKey("Style No.");
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


                                StyleWiseMachineLineRec.Reset();
                                StyleWiseMachineLineRec.SetRange("Style No", NavAppPlanProdLineRec."Style No.");
                                StyleWiseMachineLineRec.SetCurrentKey("Machine No");
                                StyleWiseMachineLineRec.Ascending(true);

                                if StyleWiseMachineLineRec.FindSet() then begin
                                    repeat

                                        FactoryAndLineRec.Reset();
                                        FactoryAndLineRec.SetRange("Machine type", StyleWiseMachineLineRec."Machine No");
                                        FactoryAndLineRec.SetRange(Factory, Rec."Factory Name");

                                        if not FactoryAndLineRec.FindSet() then begin

                                            LineNo += 1;
                                            FactoryAndLineRec.Init();
                                            FactoryAndLineRec.Factory := Rec."Factory Name";
                                            // FactoryAndLineRec.fa
                                            FactoryAndLineRec."Machine type" := StyleWiseMachineLineRec."Machine No";
                                            FactoryAndLineRec."Machine Description" := StyleWiseMachineLineRec."Machine Name";
                                            FactoryAndLineRec."Line No" := LineNo;
                                            FactoryAndLineRec.Month := MonthText;
                                            FactoryAndLineRec.Year := y;

                                            if D = 1 then
                                                FactoryAndLineRec."1" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 2 then
                                                FactoryAndLineRec."2" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 3 then
                                                FactoryAndLineRec."3" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 4 then
                                                FactoryAndLineRec."4" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 5 then
                                                FactoryAndLineRec."5" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 6 then
                                                FactoryAndLineRec."6" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 7 then
                                                FactoryAndLineRec."7" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 8 then
                                                FactoryAndLineRec."8" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 9 then
                                                FactoryAndLineRec."9" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 10 then
                                                FactoryAndLineRec."10" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 11 then
                                                FactoryAndLineRec."11" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 12 then
                                                FactoryAndLineRec."12" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 13 then
                                                FactoryAndLineRec."13" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 14 then
                                                FactoryAndLineRec."14" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 15 then
                                                FactoryAndLineRec."15" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 16 then
                                                FactoryAndLineRec."16" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 17 then
                                                FactoryAndLineRec."17" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 18 then
                                                FactoryAndLineRec."18" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 19 then
                                                FactoryAndLineRec."19" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 20 then
                                                FactoryAndLineRec."20" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 21 then
                                                FactoryAndLineRec."21" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 22 then
                                                FactoryAndLineRec."22" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 23 then
                                                FactoryAndLineRec."23" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 24 then
                                                FactoryAndLineRec."24" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 25 then
                                                FactoryAndLineRec."25" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 26 then
                                                FactoryAndLineRec."26" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 27 then
                                                FactoryAndLineRec."27" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 28 then
                                                FactoryAndLineRec."28" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 29 then
                                                FactoryAndLineRec."29" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 30 then
                                                FactoryAndLineRec."30" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 31 then
                                                FactoryAndLineRec."31" := StyleWiseMachineLineRec."Machine Qty";
                                            FactoryAndLineRec.Insert();

                                        end
                                        else begin
                                            if D = 1 then
                                                FactoryAndLineRec."1" := FactoryAndLineRec."1" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 2 then
                                                FactoryAndLineRec."2" := FactoryAndLineRec."2" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 3 then
                                                FactoryAndLineRec."3" := FactoryAndLineRec."3" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 4 then
                                                FactoryAndLineRec."4" := FactoryAndLineRec."4" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 5 then
                                                FactoryAndLineRec."5" := FactoryAndLineRec."5" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 6 then
                                                FactoryAndLineRec."6" := FactoryAndLineRec."6" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 7 then
                                                FactoryAndLineRec."7" := FactoryAndLineRec."7" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 8 then
                                                FactoryAndLineRec."8" := FactoryAndLineRec."8" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 9 then
                                                FactoryAndLineRec."9" := FactoryAndLineRec."9" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 10 then
                                                FactoryAndLineRec."10" := FactoryAndLineRec."10" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 11 then
                                                FactoryAndLineRec."11" := FactoryAndLineRec."11" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 12 then
                                                FactoryAndLineRec."12" := FactoryAndLineRec."12" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 13 then
                                                FactoryAndLineRec."13" := FactoryAndLineRec."13" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 14 then
                                                FactoryAndLineRec."14" := FactoryAndLineRec."14" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 15 then
                                                FactoryAndLineRec."15" := FactoryAndLineRec."15" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 16 then
                                                FactoryAndLineRec."16" := FactoryAndLineRec."16" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 17 then
                                                FactoryAndLineRec."17" := FactoryAndLineRec."17" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 18 then
                                                FactoryAndLineRec."18" := FactoryAndLineRec."18" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 19 then
                                                FactoryAndLineRec."19" := FactoryAndLineRec."19" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 20 then
                                                FactoryAndLineRec."20" := FactoryAndLineRec."20" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 21 then
                                                FactoryAndLineRec."21" := FactoryAndLineRec."21" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 22 then
                                                FactoryAndLineRec."22" := FactoryAndLineRec."22" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 23 then
                                                FactoryAndLineRec."23" := FactoryAndLineRec."23" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 24 then
                                                FactoryAndLineRec."24" := FactoryAndLineRec."24" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 25 then
                                                FactoryAndLineRec."25" := FactoryAndLineRec."25" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 26 then
                                                FactoryAndLineRec."26" := FactoryAndLineRec."26" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 27 then
                                                FactoryAndLineRec."27" := FactoryAndLineRec."27" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 28 then
                                                FactoryAndLineRec."28" := FactoryAndLineRec."28" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 29 then
                                                FactoryAndLineRec."29" := FactoryAndLineRec."29" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 30 then
                                                FactoryAndLineRec."30" := FactoryAndLineRec."30" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 31 then
                                                FactoryAndLineRec."31" := FactoryAndLineRec."31" + StyleWiseMachineLineRec."Machine Qty";
                                            FactoryAndLineRec.Modify()
                                        end;

                                    until StyleWiseMachineLineRec.Next() = 0;
                                end;
                            until NavAppPlanProdLineRec.Next() = 0;
                        end;

                    end
                    else begin
                        NavAppPlanProdLineRec.Reset();
                        NavAppPlanProdLineRec.SetRange("Factory No.", Rec."Factory Code");
                        NavAppPlanProdLineRec.SetRange("Resource No.", rec."Resource No.");
                        NavAppPlanProdLineRec.SetRange(PlanDate, Rec."Start Date", Rec."End Date");
                        NavAppPlanProdLineRec.SetCurrentKey("Style No.");
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


                                StyleWiseMachineLineRec.Reset();
                                StyleWiseMachineLineRec.SetRange("Style No", NavAppPlanProdLineRec."Style No.");
                                StyleWiseMachineLineRec.SetCurrentKey("Machine No");
                                StyleWiseMachineLineRec.Ascending(true);

                                if StyleWiseMachineLineRec.FindSet() then begin
                                    repeat

                                        FactoryAndLine2Rec.Reset();
                                        FactoryAndLine2Rec.SetRange("Machine type", StyleWiseMachineLineRec."Machine No");
                                        FactoryAndLineRec.SetRange(Factory, Rec."Factory Name");

                                        if not FactoryAndLine2Rec.FindSet() then begin

                                            LineNo += 1;
                                            FactoryAndLine2Rec.Init();
                                            FactoryAndLine2Rec.Factory := Rec."Factory Name";
                                            FactoryAndLine2Rec."Machine type" := StyleWiseMachineLineRec."Machine No";
                                            FactoryAndLine2Rec."Machine Description" := StyleWiseMachineLineRec."Machine Name";
                                            FactoryAndLine2Rec."Line No" := LineNo;
                                            FactoryAndLine2Rec.Month := MonthText;
                                            FactoryAndLine2Rec.Year := y;

                                            if D = 1 then
                                                FactoryAndLine2Rec."1" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 2 then
                                                FactoryAndLine2Rec."2" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 3 then
                                                FactoryAndLine2Rec."3" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 4 then
                                                FactoryAndLine2Rec."4" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 5 then
                                                FactoryAndLine2Rec."5" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 6 then
                                                FactoryAndLine2Rec."6" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 7 then
                                                FactoryAndLine2Rec."7" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 8 then
                                                FactoryAndLine2Rec."8" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 9 then
                                                FactoryAndLine2Rec."9" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 10 then
                                                FactoryAndLine2Rec."10" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 11 then
                                                FactoryAndLine2Rec."11" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 12 then
                                                FactoryAndLine2Rec."12" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 13 then
                                                FactoryAndLine2Rec."13" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 14 then
                                                FactoryAndLine2Rec."14" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 15 then
                                                FactoryAndLine2Rec."15" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 16 then
                                                FactoryAndLine2Rec."16" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 17 then
                                                FactoryAndLine2Rec."17" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 18 then
                                                FactoryAndLine2Rec."18" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 19 then
                                                FactoryAndLine2Rec."19" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 20 then
                                                FactoryAndLine2Rec."20" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 21 then
                                                FactoryAndLine2Rec."21" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 22 then
                                                FactoryAndLine2Rec."22" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 23 then
                                                FactoryAndLine2Rec."23" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 24 then
                                                FactoryAndLine2Rec."24" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 25 then
                                                FactoryAndLine2Rec."25" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 26 then
                                                FactoryAndLine2Rec."26" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 27 then
                                                FactoryAndLine2Rec."27" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 28 then
                                                FactoryAndLine2Rec."28" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 29 then
                                                FactoryAndLine2Rec."29" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 30 then
                                                FactoryAndLine2Rec."30" := StyleWiseMachineLineRec."Machine Qty";
                                            if D = 31 then
                                                FactoryAndLine2Rec."31" := StyleWiseMachineLineRec."Machine Qty";
                                            FactoryAndLine2Rec.Insert();

                                        end
                                        else begin
                                            if D = 1 then
                                                FactoryAndLine2Rec."1" := FactoryAndLine2Rec."1" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 2 then
                                                FactoryAndLine2Rec."2" := FactoryAndLine2Rec."2" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 3 then
                                                FactoryAndLine2Rec."3" := FactoryAndLine2Rec."3" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 4 then
                                                FactoryAndLine2Rec."4" := FactoryAndLine2Rec."4" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 5 then
                                                FactoryAndLine2Rec."5" := FactoryAndLine2Rec."5" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 6 then
                                                FactoryAndLine2Rec."6" := FactoryAndLine2Rec."6" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 7 then
                                                FactoryAndLine2Rec."7" := FactoryAndLine2Rec."7" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 8 then
                                                FactoryAndLine2Rec."8" := FactoryAndLine2Rec."8" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 9 then
                                                FactoryAndLine2Rec."9" := FactoryAndLine2Rec."9" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 10 then
                                                FactoryAndLine2Rec."10" := FactoryAndLine2Rec."10" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 11 then
                                                FactoryAndLine2Rec."11" := FactoryAndLine2Rec."11" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 12 then
                                                FactoryAndLine2Rec."12" := FactoryAndLine2Rec."12" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 13 then
                                                FactoryAndLine2Rec."13" := FactoryAndLine2Rec."13" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 14 then
                                                FactoryAndLine2Rec."14" := FactoryAndLine2Rec."14" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 15 then
                                                FactoryAndLine2Rec."15" := FactoryAndLine2Rec."15" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 16 then
                                                FactoryAndLine2Rec."16" := FactoryAndLine2Rec."16" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 17 then
                                                FactoryAndLine2Rec."17" := FactoryAndLine2Rec."17" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 18 then
                                                FactoryAndLine2Rec."18" := FactoryAndLine2Rec."18" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 19 then
                                                FactoryAndLine2Rec."19" := FactoryAndLine2Rec."19" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 20 then
                                                FactoryAndLine2Rec."20" := FactoryAndLine2Rec."20" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 21 then
                                                FactoryAndLine2Rec."21" := FactoryAndLine2Rec."21" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 22 then
                                                FactoryAndLine2Rec."22" := FactoryAndLine2Rec."22" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 23 then
                                                FactoryAndLine2Rec."23" := FactoryAndLine2Rec."23" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 24 then
                                                FactoryAndLine2Rec."24" := FactoryAndLine2Rec."24" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 25 then
                                                FactoryAndLine2Rec."25" := FactoryAndLine2Rec."25" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 26 then
                                                FactoryAndLine2Rec."26" := FactoryAndLine2Rec."26" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 27 then
                                                FactoryAndLine2Rec."27" := FactoryAndLine2Rec."27" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 28 then
                                                FactoryAndLine2Rec."28" := FactoryAndLine2Rec."28" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 29 then
                                                FactoryAndLine2Rec."29" := FactoryAndLine2Rec."29" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 30 then
                                                FactoryAndLine2Rec."30" := FactoryAndLine2Rec."30" + StyleWiseMachineLineRec."Machine Qty";
                                            if D = 31 then
                                                FactoryAndLine2Rec."31" := FactoryAndLine2Rec."31" + StyleWiseMachineLineRec."Machine Qty";
                                            FactoryAndLine2Rec.Modify()
                                        end;

                                    until StyleWiseMachineLineRec.Next() = 0;
                                end;
                            until NavAppPlanProdLineRec.Next() = 0;
                        end;
                    end;
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