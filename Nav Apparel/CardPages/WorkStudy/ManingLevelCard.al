page 50475 "Maning Level Card"
{
    PageType = Card;
    SourceTable = "Maning Level";
    Caption = 'Maning Level';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Maning No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        NewBRRec: Record "New Breakdown";
                        StyeleMasRec: Record "Style Master";
                        StyleName: text[50];
                        NewBR: Record "New Breakdown";
                        ManingLevelsLineRec: Record "Maning Levels Line";
                        NewBrOpLineRec: Record "New Breakdown Op Line2";
                        NewBRNo: Code[20];
                        LineNo: Integer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;


                        StyeleMasRec.Reset();
                        if StyeleMasRec.Findset() then begin
                            repeat
                                NewBRRec.Reset();
                                NewBRRec.SetRange("Style No.", StyeleMasRec."No.");
                                if NewBRRec.Findset() then
                                    StyeleMasRec.Mark(true);
                            until StyeleMasRec.Next() = 0;

                            StyeleMasRec.MARKEDONLY(TRUE);
                        end;

                        if Page.RunModal(51185, StyeleMasRec) = Action::LookupOK then begin

                            rec."Style No." := StyeleMasRec."No.";
                            rec."Style Name" := StyeleMasRec."Style No.";

                            //Delete old records
                            ManingLevelsLineRec.Reset();
                            ManingLevelsLineRec.SetRange("No.", rec."No.");
                            ManingLevelsLineRec.DeleteAll();

                            NewBR.Reset();
                            NewBR.SetRange("Style No.", StyeleMasRec."No.");
                            if NewBR.FindSet() then begin
                                rec."Total SMV" := NewBR."Total SMV";
                                rec."Sewing SMV" := NewBR.Machine;
                                rec."Manual SMV" := NewBR.Manual;
                            end
                            else
                                Error('No Breakdown for the Style : %1', StyeleMasRec."Style No.");


                            //Load Line Items
                            NewBrRec.Reset();
                            NewBrRec.SetRange("Style No.", StyeleMasRec."No.");

                            if NewBrRec.FindSet() then begin

                                NewBRNo := NewBrRec."No.";

                                NewBrOpLineRec.Reset();
                                NewBrOpLineRec.SetRange("No.", NewBRNo);
                                NewBrOpLineRec.SetCurrentKey("GPart Position", "Line Position");
                                NewBrOpLineRec.Ascending(true);
                                NewBrOpLineRec.SetFilter(LineType, '=%1', 'L');

                                if NewBrOpLineRec.FindSet() then begin

                                    //Get max line no
                                    LineNo := 0;
                                    ManingLevelsLineRec.Reset();
                                    ManingLevelsLineRec.SetRange("No.", rec."No.");

                                    if ManingLevelsLineRec.FindLast() then
                                        LineNo := ManingLevelsLineRec."Line No.";

                                    repeat

                                        LineNo += 1;
                                        ManingLevelsLineRec.Init();
                                        ManingLevelsLineRec."No." := rec."No.";
                                        ManingLevelsLineRec."Line No." := LineNo;
                                        ManingLevelsLineRec.Code := NewBrOpLineRec.Code;
                                        ManingLevelsLineRec.Description := NewBrOpLineRec.Description;
                                        ManingLevelsLineRec."Machine No." := NewBrOpLineRec."Machine No.";
                                        ManingLevelsLineRec."Machine Name" := NewBrOpLineRec."Machine Name";
                                        ManingLevelsLineRec."Department No." := NewBrOpLineRec."Department No.";
                                        ManingLevelsLineRec."Department Name" := NewBrOpLineRec."Department Name";
                                        ManingLevelsLineRec.RefGPartName := NewBrOpLineRec.RefGPartName;

                                        if NewBrOpLineRec.MachineType = 'Machine' then
                                            ManingLevelsLineRec."SMV Machine" := NewBrOpLineRec.SMV;

                                        if NewBrOpLineRec.MachineType = 'Helper' then
                                            ManingLevelsLineRec."SMV Manual" := NewBrOpLineRec.SMV;

                                        ManingLevelsLineRec."Target Per Hour" := NewBrOpLineRec."Target Per Hour";
                                        ManingLevelsLineRec."Created User" := UserId;
                                        ManingLevelsLineRec.Insert();

                                    until NewBrOpLineRec.Next = 0;

                                end;
                            end;

                        end;

                    end;

                    // trigger OnValidate()
                    // var
                    //     StyleMasterRec: Record "Style Master";
                    //     NewBR: Record "New Breakdown";
                    //     ManingLevelsLineRec: Record "Maning Levels Line";
                    //     NewBrOpLineRec: Record "New Breakdown Op Line2";
                    //     NewBrRec: Record "New Breakdown";
                    //     NewBRNo: Code[20];
                    //     LineNo: Integer;
                    //     LoginSessionsRec: Record LoginSessions;
                    //     LoginRec: Page "Login Card";
                    // begin


                    //     //Delete old records
                    //     ManingLevelsLineRec.Reset();
                    //     ManingLevelsLineRec.SetRange("No.", rec."No.");
                    //     ManingLevelsLineRec.DeleteAll();

                    //     StyleMasterRec.Reset();
                    //     StyleMasterRec.SetRange("Style No.", rec."Style Name");
                    //     if StyleMasterRec.FindSet() then
                    //         rec."Style No." := StyleMasterRec."No.";

                    //     NewBR.Reset();
                    //     NewBR.SetRange("Style No.", StyleMasterRec."No.");
                    //     if NewBR.FindSet() then begin
                    //         rec."Total SMV" := NewBR."Total SMV";
                    //         rec."Sewing SMV" := NewBR.Machine;
                    //         rec."Manual SMV" := NewBR.Manual;
                    //     end
                    //     else
                    //         Error('No Breakdown for the Style : %1', StyleMasterRec."Style No.");


                    //     //Load Line Items
                    //     NewBrRec.Reset();
                    //     NewBrRec.SetRange("Style No.", StyleMasterRec."No.");

                    //     if NewBrRec.FindSet() then begin

                    //         NewBRNo := NewBrRec."No.";

                    //         NewBrOpLineRec.Reset();
                    //         NewBrOpLineRec.SetRange("No.", NewBRNo);
                    //         NewBrOpLineRec.SetCurrentKey("Garment Part Name", "Line Position");
                    //         NewBrOpLineRec.Ascending(true);
                    //         NewBrOpLineRec.SetFilter(LineType, '=%1', 'L');

                    //         if NewBrOpLineRec.FindSet() then begin

                    //             //Get max line no
                    //             LineNo := 0;
                    //             ManingLevelsLineRec.Reset();
                    //             ManingLevelsLineRec.SetRange("No.", rec."No.");

                    //             if ManingLevelsLineRec.FindLast() then
                    //                 LineNo := ManingLevelsLineRec."Line No.";

                    //             repeat

                    //                 LineNo += 1;
                    //                 ManingLevelsLineRec.Init();
                    //                 ManingLevelsLineRec."No." := rec."No.";
                    //                 ManingLevelsLineRec."Line No." := LineNo;
                    //                 ManingLevelsLineRec.Code := NewBrOpLineRec.Code;
                    //                 ManingLevelsLineRec.Description := NewBrOpLineRec.Description;
                    //                 ManingLevelsLineRec."Machine No." := NewBrOpLineRec."Machine No.";
                    //                 ManingLevelsLineRec."Machine Name" := NewBrOpLineRec."Machine Name";
                    //                 ManingLevelsLineRec."Department No." := NewBrOpLineRec."Department No.";
                    //                 ManingLevelsLineRec."Department Name" := NewBrOpLineRec."Department Name";
                    //                 ManingLevelsLineRec.RefGPartName := NewBrOpLineRec.RefGPartName;

                    //                 if NewBrOpLineRec.MachineType = 'Machine' then
                    //                     ManingLevelsLineRec."SMV Machine" := NewBrOpLineRec.SMV;

                    //                 if NewBrOpLineRec.MachineType = 'Helper' then
                    //                     ManingLevelsLineRec."SMV Manual" := NewBrOpLineRec.SMV;

                    //                 ManingLevelsLineRec."Target Per Hour" := NewBrOpLineRec."Target Per Hour";
                    //                 ManingLevelsLineRec."Created User" := UserId;
                    //                 ManingLevelsLineRec.Insert();

                    //             until NewBrOpLineRec.Next = 0;

                    //         end;
                    //     end;
                    // end;
                }

                field("Work Center Name"; rec."Work Center Name")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        WorkCenterRec: Record "Work Center";
                        NavAppPlanLineRec: Record "NavApp Planning Lines";
                    begin
                        WorkCenterRec.Reset();
                        WorkCenterRec.SetRange(Name, rec."Work Center Name");
                        IF WorkCenterRec.FindSet() THEN
                            rec."Line No." := WorkCenterRec."No.";

                        //Get Eff and no of machines                     
                        NavAppPlanLineRec.Reset();
                        NavAppPlanLineRec.SetRange("Style No.", rec."Style No.");
                        NavAppPlanLineRec.SetRange("Resource No.", rec."Line No.");

                        if NavAppPlanLineRec.FindLast() then begin
                            rec.Eff := NavAppPlanLineRec.Eff;
                            rec.Val := NavAppPlanLineRec.Carder;
                            Cal_Values();
                        end;
                    end;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal_Values();
                    end;
                }

                field("Sewing SMV"; rec."Sewing SMV")
                {
                    ApplicationArea = All;
                }

                field("Manual SMV"; rec."Manual SMV")
                {
                    ApplicationArea = All;
                }

                field("Total SMV"; rec."Total SMV")
                {
                    ApplicationArea = All;
                }

                field(Val; rec.Val)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Cal_Values();
                    end;
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Expected Eff %';

                    trigger OnValidate()
                    var
                    begin
                        Cal_Values();
                    end;
                }

            }

            group("Planned Lines")
            {
                part("Maning Levels Listpart1"; "Maning Levels Listpart1")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = field("Style No.");
                }
            }

            group("Maning Levels")
            {
                part("Maning Levels Listpart"; "Maning Levels Listpart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = field("No.");
                }
            }

            group("Hourly Figures")
            {
                field(BPT; rec.BPT)
                {
                    ApplicationArea = All;
                }

                field("Mac Operator"; rec."Mac Operator")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Operators';
                }

                field("% Of Target "; Rec."% Of Target ")
                {
                    ApplicationArea = All;
                    Caption = '100% Target';
                }

                field("Expected Target"; rec."Expected Target")
                {
                    ApplicationArea = All;
                }
            }


            group("Total")
            {
                grid("Sewing Dept")
                {
                    GridLayout = Rows;
                    group("Machine operator")
                    {
                        field(MOTheo; rec.MOTheo)
                        {
                            ApplicationArea = All;
                            Caption = 'Theoretical';
                            Editable = false;
                        }

                        field(MOAct; rec.MOAct)
                        {
                            ApplicationArea = All;
                            Caption = 'Actual';
                            Editable = false;
                        }

                        field(MODiff; rec.MODiff)
                        {
                            ApplicationArea = All;
                            Caption = 'Difference';
                            Editable = false;
                        }

                        field(MOBil; rec.MOBil)
                        {
                            ApplicationArea = All;
                            Caption = 'BL%';
                            Editable = false;
                        }
                    }

                    group("Helper")
                    {
                        field(HPTheo; rec.HPTheo)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field(HPAct; rec.HPAct)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field(HPODiff; rec.HPODiff)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                        field(HPBil; rec.HPBil)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                    }
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(Calculate)
    //         {
    //             ApplicationArea = All;
    //             Image = Calculate;

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Manning Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    procedure Cal_Values()
    var
        ManingLevelsLineRec: Record "Maning Levels Line";
        TheoMOTotal: Decimal;
        TheoHPTotal: Decimal;
        ActMOTotal: Decimal;
        ActHPTotal: Decimal;
    begin

        //Calculate BPT and 100% of target
        if rec.Type = rec.Type::"Based on Machine Operator" then begin

            if rec.Val <> 0 then
                rec.BPT := rec."Sewing SMV" / rec.Val
            else
                rec.BPT := 0;

            if rec.BPT <> 0 then
                rec."% Of Target " := 60 / rec.BPT
            else
                rec."% Of Target " := 0;

            if rec.BPT <> 0 then
                rec."Expected Target" := ((60 / rec.BPT) * rec.Eff) / 100
            else
                rec."Expected Target" := 0;

        end
        else begin

            if rec.Val <> 0 then
                rec.BPT := (60 / rec.Val) / 100 * rec.Eff
            else
                rec.BPT := 0;

            rec."% Of Target " := rec.Val;
            rec."Expected Target" := (rec.Val * rec.Eff) / 100;

        end;

        CurrPage.Update();

        //Calculate Line values
        ManingLevelsLineRec.Reset();
        ManingLevelsLineRec.SetRange("No.", rec."No.");

        if ManingLevelsLineRec.FindSet() then begin
            repeat

                //Calculate ""Theo MO" / "Theo HP"
                if rec.BPT <> 0 then begin
                    ManingLevelsLineRec."Theo MO" := ManingLevelsLineRec."SMV Machine" / rec.BPT;
                    TheoMOTotal += ManingLevelsLineRec."SMV Machine" / rec.BPT;
                    ManingLevelsLineRec."Theo HP" := ManingLevelsLineRec."SMV Manual" / rec.BPT;
                    TheoHPTotal += ManingLevelsLineRec."SMV Manual" / rec.BPT
                end
                else begin
                    ManingLevelsLineRec."Theo MO" := 0;
                    ManingLevelsLineRec."Theo HP" := 0;
                end;

                ManingLevelsLineRec.Modify();

            until ManingLevelsLineRec.Next() = 0;
        end;


        if rec.Type = rec.Type::"Based on Machine Operator" then
            rec."Mac Operator" := TheoMOTotal
        else
            rec."Mac Operator" := TheoMOTotal;


        CurrPage.Update();

        //Sewing dept vvalues
        rec.MOTheo := TheoMOTotal;
        rec.HPTheo := TheoHPTotal;

        //Calculate Actual values
        ManingLevelsLineRec.Reset();
        ManingLevelsLineRec.SetRange("No.", rec."No.");

        if ManingLevelsLineRec.FindSet() then begin
            repeat
                ActMOTotal += ManingLevelsLineRec."Act MO";
                ActHPTotal += ManingLevelsLineRec."Act HP";
            until ManingLevelsLineRec.Next() = 0;
        end;

        rec.MOAct := ActMOTotal;
        rec.HPAct := ActHPTotal;
        rec.MODiff := ActMOTotal - TheoMOTotal;
        rec.HPODiff := ActHPTotal - TheoHPTotal;

        if TheoMOTotal <> 0 then
            rec.MOBil := ((ActMOTotal - TheoMOTotal) / TheoMOTotal) / 100
        else
            rec.MOBil := 0;

        if TheoHPTotal <> 0 then
            rec.HPBil := ((ActHPTotal - TheoHPTotal) / TheoHPTotal) / 100
        else
            rec.HPBil := 0;

        CurrPage.Update();
    end;


    trigger OnDeleteRecord(): Boolean
    var
        ManingLevelsLineRec: Record "Maning Levels Line";
    begin
        ManingLevelsLineRec.Reset();
        ManingLevelsLineRec.SetRange("No.", rec."No.");
        ManingLevelsLineRec.DeleteAll();
    end;

}