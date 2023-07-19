page 50324 "NETRONICVSDevToolDemoAppPage"
{
    PageType = Card;
    Caption = ' ';
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Filters")
            {
                field("FactoryNo"; "FactoryNo")
                {
                    Caption = 'Factory Code';
                    TableRelation = Location.Code where("Sewing Unit" = filter(1));

                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.get("FactoryNo");
                        "FactoryName" := LocationRec.Name;

                        LoadData(true, true, true, true, true);
                        // SetconVSControlAddInSettings();
                    end;
                }

                field("StartDate"; "StartDate")
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if FactoryName = '' then
                            Error('Select a Factory.');

                        gdtconVSControlAddInStart := CREATEDATETIME(DMY2DATE(DATE2DMY(StartDate, 1), DATE2DMY(StartDate, 2), DATE2DMY(StartDate, 3)), 0T);
                        gdtconVSControlAddInEnd := CREATEDATETIME(DMY2DATE(DATE2DMY(FinishDate, 1), DATE2DMY(FinishDate, 2), DATE2DMY(FinishDate, 3)), 0T);
                        LoadData(true, false, false, false, false);
                        SetconVSControlAddInSettings();
                    end;
                }

                field("FinishDate"; "FinishDate")
                {
                    Caption = 'Finish Date';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if FactoryName = '' then
                            Error('Select a Factory.');

                        gdtconVSControlAddInStart := CREATEDATETIME(DMY2DATE(DATE2DMY(StartDate, 1), DATE2DMY(StartDate, 2), DATE2DMY(StartDate, 3)), 0T);
                        gdtconVSControlAddInEnd := CREATEDATETIME(DMY2DATE(DATE2DMY(FinishDate, 1), DATE2DMY(FinishDate, 2), DATE2DMY(FinishDate, 3)), 0T);
                        LoadData(true, false, false, false, false);
                        SetconVSControlAddInSettings();
                    end;
                }

                field("LearningCurveNo"; "LearningCurveNo")
                {
                    TableRelation = "Learning Curve"."No." where(Active = filter(1));
                    Caption = 'Learning Curve';
                    ApplicationArea = All;
                }
            }

            usercontrol(conVSControlAddIn; NetronicVSControlAddIn)
            {
                ApplicationArea = All;

                trigger OnRequestSettings(eventArgs: JsonObject)
                var
                    _settings: JsonObject;
                begin
                    // Message('OnRequestSettings!');
                    _settings.Add('LicenseKey', 'MTAzNDItMjQxNTMwLTE0ODI4Mi17InciOiIiLCJpZCI6IlZTQ0FJRXZhbCIsIm4iOiJORVRST05JQyIsInUiOiIiLCJlIjoyMzA4LCJ2IjoiNC4wIiwiZiI6WzEwMDFdLCJlZCI6IkJhc2UifQ==');
                    _settings.Add('Start', gdtconVSControlAddInStart);
                    _settings.Add('End', gdtconVSControlAddInEnd);
                    _settings.Add('WorkDate', gdtconVSControlAddInWorkdate);
                    _settings.Add('ViewType', gintconVSControlAddInViewType);
                    _settings.Add('TitleText', gtxtconVSControlAddInTitleText);
                    _settings.Add('TableWidth', gintconVSControlAddInTableViewWidth);
                    _settings.Add('TableViewWidth', gintconVSControlAddInTableViewWidth);
                    _settings.Add('EntitiesTitleText', gtxtconVSControlAddInEntitiesTitleText);
                    _settings.Add('EntitiesTableWidth', gintconVSControlAddInEntitiesTableWidth);
                    _settings.Add('EntitiesTableViewWidth', gintconVSControlAddInEntitiesTableViewWidth);
                    _settings.Add('EntitiesTableVisible', gbShowEntities);
                    _settings.Add('PM_DefaultAllocationAllowedBarDragModes', 16);
                    _settings.Add('PM_DefaultMinimumActivityRowHeight', '25');
                    _settings.Add('PM_DefaultAllocationMinimumRowHeight', '25');
                    _settings.Add('PM_DefaultMinimumResourceRowHeight', '25');
                    _settings.Add('PM_DefaultMinimumEntityRowHeight', '25');
                    _settings.Add('PM_TopRowMarginInTimeArea', 4);
                    _settings.Add('PM_BottomRowMarginInTimeArea', 4);
                    CurrPage.conVSControlAddIn.SetSettings(_settings);
                    gbAddInInitialized := TRUE;
                end;

                trigger OnControlAddInReady()
                var
                begin
                    //Message('OnControlAddInReady!');
                    //initialize();
                    //LoadData();
                end;

                trigger OnCollapseStateChanged(eventArgs: JsonObject)
                var
                    _jsonToken: JsonToken;
                    _objectType: Integer;
                    _objectID: Text;
                    _interactively: Boolean;
                    _newCollapseState: Integer;
                begin
                    if (eventArgs.Get('ObjectType', _jsonToken)) then
                        _objectType := _jsonToken.AsValue().AsInteger()
                    else
                        _objectType := 0;

                    if (eventArgs.Get('ObjectID', _jsonToken)) then
                        _objectID := _jsonToken.AsValue().AsText()
                    else
                        _objectID := '';

                    if (eventArgs.Get('Interactively', _jsonToken)) then
                        _interactively := _jsonToken.AsValue().AsBoolean()
                    else
                        _interactively := false;

                    if (eventArgs.Get('NewCollapseState', _jsonToken)) then
                        _newCollapseState := _jsonToken.AsValue().AsInteger()
                    else
                        _newCollapseState := 0;

                    // Message('Event OnCollapseStateChanged:\ObjectType: ' + Format(_objectType) + '\ObjectID: ' + _objectID +
                    //         '\Interactively: ' + Format(_interactively) + '\NewCollapseState: ' + Format(_newCollapseState));
                end;

                trigger OnCurveCollapseStateChanged(eventArgs: JsonObject)
                var
                    _jsonToken: JsonToken;
                    _objectType: Integer;
                    _objectID: Text;
                    _newCollapseState: Integer;
                begin
                    if (eventArgs.Get('ObjectType', _jsonToken)) then
                        _objectType := _jsonToken.AsValue().AsInteger()
                    else
                        _objectType := 0;

                    if (eventArgs.Get('ObjectID', _jsonToken)) then
                        _objectID := _jsonToken.AsValue().AsText()
                    else
                        _objectID := '';

                    if (eventArgs.Get('NewCollapseState', _jsonToken)) then
                        _newCollapseState := _jsonToken.AsValue().AsInteger()
                    else
                        _newCollapseState := 0;

                    // Message('Event OnCurveCollapseStateChanged:\ObjectType: ' + Format(_objectType) + '\ObjectID: ' + _objectID +
                    //         '\NewCollapseState: ' + Format(_newCollapseState));
                end;

                trigger OnDoubleClicked(eventArgs: JsonObject)
                var
                    _jsonToken: JsonToken;
                    _tempText: Text;
                    _tempJsonValue: JsonValue;
                    _objectType: Integer;
                    _objectID: Text;
                    _visualType: Integer;
                    _date: DateTime;
                    ResourceList: Page "Resource List part";
                    objectID: Text;
                    LineNo: BigInteger;
                    LineNo1: text;
                    Temp: text;
                    D: Integer;
                    M: Integer;
                    Y: Integer;
                    dtEnd: Date;
                    HrsPerDay: Integer;
                    ResourceNo: Code[20];
                    StartDate: Date;
                    FullQty: BigInteger;
                    QTY: Decimal;
                    PlanningLinesRec: Record "NavApp Planning Lines";
                    ProdPlanDetRec: Record "NavApp Prod Plans Details";
                    PlanningQueueRec: Record "Planning Queue";
                    QueueNo: BigInteger;
                    TempQty: BigInteger;
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                    LocationRec: Record Location;
                    StyleMasterPORec: Record "Style Master PO";
                    FactoryFinishTime: time;
                    NavAppCodeUnit3Rec: Codeunit NavAppCodeUnit3;
                begin
                    if (eventArgs.Get('ObjectType', _jsonToken)) then
                        _objectType := _jsonToken.AsValue().AsInteger()
                    else
                        _objectType := 0;

                    if (eventArgs.Get('ObjectID', _jsonToken)) then
                        _objectID := _jsonToken.AsValue().AsText()
                    else
                        _objectID := '';

                    if (eventArgs.Get('VisualType', _jsonToken)) then
                        _visualType := _jsonToken.AsValue().AsInteger()
                    else
                        _visualType := -1;

                    if (eventArgs.Get('Date', _jsonToken)) then begin
                        _jsonToken.AsValue().WriteTo(_tempText);
                        _tempJsonValue.SetValue(CopyStr(_tempText, 2, 19) + 'Z');
                        _date := _tempJsonValue.AsDateTime();
                    end;

                    // if Format(_objectType) = '5' then begin
                    //     objectID := _objectID.Substring(3);
                    //     Clear(ResourceList);
                    //     ResourceList.LookupMode(true);
                    //     ResourceList.PassParameters(objectID);
                    //     ResourceList.Run();
                    // end;

                    //Get Start and Finish Time
                    LocationRec.Reset();
                    LocationRec.SetRange(code, FactoryNo);
                    LocationRec.FindSet();

                    Temp := _objectID.Substring(_objectID.IndexOfAny('/') + 1, StrLen(_objectID) - _objectID.IndexOfAny('/'));
                    Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                    LineNo1 := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                    Evaluate(LineNo, LineNo1);
                    evaluate(Y, copystr(Format(_date), 7, 2));
                    evaluate(M, copystr(Format(_date), 4, 2));
                    evaluate(D, copystr(Format(_date), 1, 2));
                    Y := 2000 + Y;
                    dtEnd := DMY2DATE(D, M, Y);
                    HrsPerDay := 0;
                    QTY := 0;

                    //Get resource No, Start Date
                    PlanningLinesRec.Reset();
                    PlanningLinesRec.SetRange("Line No.", LineNo);
                    if PlanningLinesRec.FindSet() then begin
                        ResourceNo := PlanningLinesRec."Resource No.";
                        StartDate := PlanningLinesRec."Start Date";
                        FullQty := PlanningLinesRec.Qty;
                    end;

                    //get records within date range
                    ProdPlanDetRec.Reset();
                    ProdPlanDetRec.SetRange("Resource No.", ResourceNo);
                    ProdPlanDetRec.SetRange(PlanDate, StartDate, dtEnd);
                    ProdPlanDetRec.SetRange("Line No.", LineNo);
                    if ProdPlanDetRec.FindSet() then begin
                        repeat
                            QTY += ProdPlanDetRec.Qty;
                        until ProdPlanDetRec.Next() = 0;
                    end;

                    QTY := round(QTY, 1);
                    TempQty := PlanningLinesRec.Qty - QTY;

                    if QTY = 0 then
                        Error('You cannot cut at the start of line.');

                    if TempQty = 0 then
                        Error('You cannot cut at the end of line.');

                    if Confirm('Remaining Qty : ' + format(QTY) + '. Cut Qty : ' + Format(TempQty) + '. Do you want to Cut ?', true) then begin
                        //Get Max QueueNo
                        PlanningQueueRec.Reset();
                        if PlanningQueueRec.FindLast() then
                            QueueNo := PlanningQueueRec."Queue No.";

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());
                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            LoginSessionsRec.FindSet();
                        end;

                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtEnd, LocationRec."Start Time");

                        //Add remaining qty to the Queue
                        PlanningQueueRec.Init();
                        PlanningQueueRec."Queue No." := QueueNo + 1;
                        PlanningQueueRec."Style No." := PlanningLinesRec."Style No.";
                        PlanningQueueRec."Style Name" := PlanningLinesRec."Style Name";
                        PlanningQueueRec."PO No." := PlanningLinesRec."PO No.";
                        PlanningQueueRec."Lot No." := PlanningLinesRec."Lot No.";
                        PlanningQueueRec.Qty := TempQty;
                        PlanningQueueRec.SMV := PlanningLinesRec.SMV;
                        PlanningQueueRec.Carder := PlanningLinesRec.Carder;
                        PlanningQueueRec."TGTSEWFIN Date" := PlanningLinesRec."TGTSEWFIN Date";
                        PlanningQueueRec."Learning Curve No." := PlanningLinesRec."Learning Curve No.";
                        PlanningQueueRec.Eff := PlanningLinesRec.Eff;
                        PlanningQueueRec.HoursPerDay := PlanningLinesRec.HoursPerDay;
                        PlanningQueueRec.Front := PlanningLinesRec.Front;
                        PlanningQueueRec.Back := PlanningLinesRec.Back;
                        PlanningQueueRec.Waistage := 0;
                        PlanningQueueRec."User ID" := UserId;
                        PlanningQueueRec.Factory := PlanningLinesRec.Factory;
                        PlanningQueueRec.Target := PlanningLinesRec.Target;
                        PlanningQueueRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        PlanningQueueRec."Created Date" := WorkDate();
                        PlanningQueueRec."Created User" := UserId;
                        PlanningQueueRec.Insert();

                        //Modify Planning line
                        PlanningLinesRec.Reset();
                        PlanningLinesRec.SetRange("Line No.", LineNo);
                        PlanningLinesRec.FindSet();
                        PlanningLinesRec."End Date" := dtEnd;
                        PlanningLinesRec.Qty := QTY;
                        PlanningLinesRec."Finish Time" := FactoryFinishTime;
                        PlanningLinesRec.FinishDateTime := CREATEDATETIME(dtEnd, FactoryFinishTime);
                        PlanningLinesRec.Modify();

                        //Delete remaining line from the Prod Plan Det table
                        ProdPlanDetRec.Reset();
                        ProdPlanDetRec.SetRange("Resource No.", ResourceNo);
                        ProdPlanDetRec.SetRange("Line No.", LineNo);
                        ProdPlanDetRec.SetFilter("PlanDate", '>=%1', dtEnd + 1);
                        ProdPlanDetRec.DeleteAll();

                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", PlanningLinesRec."Style No.");
                        StyleMasterPORec.SetRange("Lot No.", PlanningLinesRec."Lot No.");
                        StyleMasterPORec.FindSet();

                        StyleMasterPORec.PlannedQty := StyleMasterPORec.PlannedQty - TempQty;
                        StyleMasterPORec.QueueQty := StyleMasterPORec.QueueQty + TempQty;
                        StyleMasterPORec.Modify();

                        LoadData(false, false, true, true, false);
                    end;

                end;

                trigger OnDrop(eventArgs: JsonObject)
                var
                    _jsonToken: JsonToken;
                    _tempText: Text;
                    _tempJsonValue: JsonValue;
                    _objectType: Integer;
                    _objectID: Text;
                    _newRowObjectType: Integer;
                    _newRowObjectID: Text;
                    _dragMode: Integer;
                    _newStart: DateTime;
                    _newEnd: DateTime;
                    pAllocations: JsonArray;
                    _allocEntries: JsonArray;
                    _allocEntry0: JsonObject;

                    JobPlaLineRec: Record "NavApp Planning Lines";
                    PlanningQueueeRec: Record "Planning Queue";
                    ResourceRec: Record "Work Center";
                    ResCapacityEntryRec: Record "Calendar Entry";
                    LocationRec: Record Location;
                    //NavAppSetupRec: Record "NavApp Setup";
                    LearningCurveRec: Record "Learning Curve";
                    ProdPlansDetails: Record "NavApp Prod Plans Details";
                    ProdHeaderRec: Record ProductionOutHeader;
                    StyleMasterPORec: Record "Style Master PO";
                    SHCalHolidayRec: Record "Shop Calendar Holiday";
                    SHCalWorkRec: Record "Shop Calendar Working Days";
                    ProdOutHeaderRec: Record ProductionOutHeader;
                    NavAppCodeUnit3Rec: Codeunit NavAppCodeUnit3;
                    dtStart: Date;
                    dtEnd: Date;
                    D: Integer;
                    M: Integer;
                    Y: Integer;
                    TImeStart: Time;
                    LineNo: BigInteger;
                    LEARNCURVENO: Integer;
                    LineNo1: text;
                    _objID: Text;
                    STYNo: Text;
                    STYNAME: Text;
                    PONo: Text;
                    LOTNo: Text;
                    Temp: Text;
                    ID: BigInteger;
                    ResourceNo: Code[20];
                    ResourceName: Text;
                    Eff: Decimal;
                    Carder: Integer;
                    SMV: Decimal;
                    Hours: Decimal;
                    TargetPerDay: BigInteger;
                    HoursPerDay: Decimal;
                    TargetPerHour: Decimal;
                    TempQty: Decimal;
                    TempQty1: Decimal;
                    TempDate: Date;
                    TempHours: Decimal;
                    i: Integer;
                    Rate: Decimal;
                    Found: Boolean;
                    Qty: BigInteger;
                    IsInserted: Boolean;
                    MaxLineNo: BigInteger;
                    xQty: Decimal;
                    DayForWeek: Record Date;
                    Day: Integer;
                    LCurveFinishDate: Date;
                    LCurveStartTime: Time;
                    LCurveFinishTime: Time;
                    LcurveTemp: Decimal;
                    Holiday: code[10];
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                    RowCount1: Integer;
                    N1: Integer;
                    StartTime2: time;
                    ArrayOfAllocations: Array[100] of BigInteger;
                    Prev_FinishedDateTime: DateTime;
                    Curr_StartDateTime: DateTime;
                    HoursGap: Decimal;
                    TempTIme: Time;
                    WorkCenCapacityEntryRec: Record "Calendar Entry";
                    dtNextMonth: date;
                    dtLastDate: date;
                    dtSt: Date;
                    dtEd: Date;
                    Count: Integer;
                    X: Integer;
                    XX: Integer;
                    HoursPerDay1: Decimal;
                    HoursPerDay2: Decimal;
                    JobPlaLine2Rec: Record "NavApp Planning Lines";
                    ddddddtttt: DateTime;
                    LcurveHoursPerday: Decimal;
                    LCurveStartTimePerDay: Time;
                    FactoryFinishTime: Time;
                begin
                    if (eventArgs.Get('ObjectType', _jsonToken)) then
                        _objectType := _jsonToken.AsValue().AsInteger()
                    else
                        _objectType := 0;

                    if (eventArgs.Get('ObjectID', _jsonToken)) then
                        _objectID := _jsonToken.AsValue().AsText()
                    else
                        _objectID := '';

                    if (eventArgs.Get('NewRowObjectType', _jsonToken)) then
                        _newRowObjectType := _jsonToken.AsValue().AsInteger()
                    else
                        _newRowObjectType := 0;

                    if (eventArgs.Get('NewRowObjectID', _jsonToken)) then
                        _newRowObjectID := _jsonToken.AsValue().AsText()
                    else
                        _newRowObjectID := '';

                    if (eventArgs.Get('DragMode', _jsonToken)) then
                        _dragMode := _jsonToken.AsValue().AsInteger()
                    else
                        _dragMode := 0;

                    if (eventArgs.Get('NewStart', _jsonToken)) then begin
                        _jsonToken.AsValue().WriteTo(_tempText);
                        _tempJsonValue.SetValue(CopyStr(_tempText, 2, 19) + 'Z');
                        _newStart := _tempJsonValue.AsDateTime();
                    end;
                    if (eventArgs.Get('NewEnd', _jsonToken)) then begin
                        _jsonToken.AsValue().WriteTo(_tempText);
                        _tempJsonValue.SetValue(CopyStr(_tempText, 2, 19) + 'Z');
                        _newEnd := _tempJsonValue.AsDateTime();
                    end;

                    //Get Start and Finish Time
                    LocationRec.Reset();
                    LocationRec.SetRange(code, FactoryNo);
                    LocationRec.FindSet();

                    ResourceNo := copystr(_newRowObjectID, 3, StrLen(_newRowObjectID) - 2);

                    if FactoryNo = '' then
                        Error('Invalid Factory');

                    if ResourceNo = '' then
                        Error('Invalid Line');

                    //------------------------------------------
                    //calculate start date and strt time
                    //Check whether a allocations starts between day start time and drop time. 
                    JobPlaLineRec.Reset();
                    JobPlaLineRec.SetRange("Resource No.", ResourceNo);
                    JobPlaLineRec.SetRange("StartDateTime", CreateDateTime(DT2Date(_newStart), LocationRec."Start Time"), _newStart);
                    if not JobPlaLineRec.FindSet() then begin
                        //Check whether a allocations finishes between day start time and drop time. 
                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetRange("Resource No.", ResourceNo);
                        JobPlaLineRec.SetRange(FinishDateTime, CreateDateTime(DT2Date(_newStart), LocationRec."Start Time"), _newStart);
                        if not JobPlaLineRec.FindSet() then
                            _newStart := CreateDateTime(DT2Date(_newStart), LocationRec."Start Time");
                    end;

                    evaluate(Y, copystr(Format(_newStart), 7, 2));
                    evaluate(M, copystr(Format(_newStart), 4, 2));
                    evaluate(D, copystr(Format(_newStart), 1, 2));
                    Y := 2000 + Y;
                    dtStart := DMY2DATE(D, M, Y);
                    TImeStart := DT2TIME(_newStart);

                    //Get last production updated header
                    ProdOutHeaderRec.Reset();
                    ProdOutHeaderRec.SetCurrentKey("Prod Date");
                    ProdOutHeaderRec.Ascending(false);
                    ProdOutHeaderRec.SetFilter("Prod Updated", '=%1', 1);
                    if ProdOutHeaderRec.FindFirst() then begin
                        if dtStart <= ProdOutHeaderRec."Prod Date" then begin
                            Message('Drag and drop date should be greater than the Production Updated Date.');
                            exit;
                        end;
                    end;

                    if _objectID.Contains('/') then begin    //Grag and drop existing allocation                        
                        STYNo := _objectID.Substring(1, _objectID.IndexOfAny('/') - 1);
                        Temp := _objectID.Substring(_objectID.IndexOfAny('/') + 1, StrLen(_objectID) - _objectID.IndexOfAny('/'));
                        LOTNo := Temp.Substring(1, Temp.IndexOfAny('/') - 1);
                        Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                        PONo := Temp.Substring(1, Temp.IndexOfAny('/') - 1);
                        Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                        LineNo1 := Temp;
                        Evaluate(LineNo, LineNo1);
                    end
                    else
                        _objID := _objectID;  //From Queue                  

                    if _dragMode = 0 then begin   //New PO From The Queue

                        if _objID <> '' then begin

                            //get styleno and pono
                            HoursPerDay := 0;
                            IsInserted := false;
                            Evaluate(ID, _objID);

                            //Get Resorce line details
                            ResourceRec.Reset();
                            ResourceRec.SetRange("No.", ResourceNo);
                            ResourceRec.FindSet();

                            Carder := ResourceRec.Carder;
                            eff := ResourceRec.PlanEff;
                            ResourceName := ResourceRec.Name;

                            //Get Style name
                            PlanningQueueeRec.Reset();
                            PlanningQueueeRec.SetRange("Queue No.", ID);
                            PlanningQueueeRec.FindSet();

                            //Get Max Lineno
                            ProdPlansDetails.Reset();
                            ProdPlansDetails.SetCurrentKey("Line No.");
                            if ProdPlansDetails.FindLast() then
                                LineNo := ProdPlansDetails."Line No.";

                            LineNo += 1;

                            if PlanningQueueeRec.Carder <> 0 then
                                Carder := PlanningQueueeRec.Carder;

                            if Carder = 0 then
                                Error('No of Carders for Line : %1 is zero. Cannot proceed.', ResourceRec.Name);

                            if PlanningQueueeRec.Eff <> 0 then
                                Eff := PlanningQueueeRec.Eff;

                            if Eff = 0 then
                                Error('Efficiency is zero. Cannot proceed.');

                            SMV := PlanningQueueeRec.SMV;
                            FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtStart, LocationRec."Start Time");

                            if SMV = 0 then
                                Error('SMV for Style : %1 is zero. Cannot proceed.', PlanningQueueeRec."Style Name");

                            //if start time earlier than parameter start time, set start time as parameter time
                            if ((LocationRec."Start Time" - TImeStart) > 0) then begin
                                TImeStart := LocationRec."Start Time";
                            end;

                            //if start time greater than parameter Finish time, set start time next day morning
                            if ((TImeStart - FactoryFinishTime) >= 0) then begin
                                TImeStart := LocationRec."Start Time";
                                dtStart := dtStart + 1;
                            end;

                            //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                            repeat
                                ResCapacityEntryRec.Reset();
                                ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                ResCapacityEntryRec.SETRANGE(Date, dtStart);
                                if ResCapacityEntryRec.FindSet() then begin
                                    repeat
                                        HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                    until ResCapacityEntryRec.Next() = 0;
                                end;

                                if HoursPerDay = 0 then begin
                                    //Validate the day (Holiday or Weekend)
                                    SHCalHolidayRec.Reset();
                                    SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                    SHCalHolidayRec.SETRANGE(Date, dtStart);

                                    if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                        DayForWeek.Get(DayForWeek."Period Type"::Date, dtStart);

                                        case DayForWeek."Period No." of
                                            1:
                                                Day := 0;
                                            2:
                                                Day := 1;
                                            3:
                                                Day := 2;
                                            4:
                                                Day := 3;
                                            5:
                                                Day := 4;
                                            6:
                                                Day := 5;
                                            7:
                                                Day := 6;
                                        end;

                                        SHCalWorkRec.Reset();
                                        SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                        SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                        if SHCalWorkRec.FindSet() then   //If not weekend
                                            Error('Calender for date : %1  Work center : %2 has not calculated', dtStart, ResourceRec.Name);
                                    end;
                                end;

                                if HoursPerDay = 0 then
                                    dtStart := dtStart + 1;

                            until HoursPerDay > 0;

                            JobPlaLineRec.Reset();
                            JobPlaLineRec.SetRange("Resource No.", ResourceNo);
                            JobPlaLineRec.SetFilter("StartDateTime", '<=%1', CreateDateTime(dtStart, TImeStart));
                            JobPlaLineRec.SetFilter("FinishDateTime", '>%1', CreateDateTime(dtStart, TImeStart));
                            if JobPlaLineRec.FindSet() then begin

                                dtStart := JobPlaLineRec."End Date";
                                TImeStart := JobPlaLineRec."Finish Time";
                                Prev_FinishedDateTime := JobPlaLineRec.FinishDateTime;
                                FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtStart, LocationRec."Start Time");

                                //if start time equal to the parameter Finish time, set start time next day morning
                                if ((TImeStart - FactoryFinishTime) = 0) then begin
                                    TImeStart := LocationRec."Start Time";
                                    dtStart := dtStart + 1;
                                end;

                                HoursPerDay := 0;

                                //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                repeat
                                    ResCapacityEntryRec.Reset();
                                    ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                    ResCapacityEntryRec.SETRANGE(Date, dtStart);
                                    if ResCapacityEntryRec.FindSet() then begin
                                        repeat
                                            HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                        until ResCapacityEntryRec.Next() = 0;
                                    end;

                                    if HoursPerDay = 0 then begin

                                        //Validate the day (Holiday or Weekend)
                                        SHCalHolidayRec.Reset();
                                        SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                        SHCalHolidayRec.SETRANGE(Date, dtStart);

                                        if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                            DayForWeek.Get(DayForWeek."Period Type"::Date, dtStart);

                                            case DayForWeek."Period No." of
                                                1:
                                                    Day := 0;
                                                2:
                                                    Day := 1;
                                                3:
                                                    Day := 2;
                                                4:
                                                    Day := 3;
                                                5:
                                                    Day := 4;
                                                6:
                                                    Day := 5;
                                                7:
                                                    Day := 6;
                                            end;

                                            SHCalWorkRec.Reset();
                                            SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                            SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                            if SHCalWorkRec.FindSet() then   //If not weekend
                                                Error('Calender for date : %1  Work center : %2 has not calculated', dtStart, ResourceRec.Name);
                                        end;
                                    end;

                                    if HoursPerDay = 0 then
                                        dtStart := dtStart + 1;

                                until HoursPerDay > 0;
                            end;

                            TargetPerDay := round(((60 / SMV) * Carder * HoursPerDay * Eff) / 100, 1, '>');
                            TargetPerHour := TargetPerDay / HoursPerDay;
                            TempDate := dtStart;

                            //Check learning curve                        
                            LCurveFinishDate := dtStart;
                            LCurveFinishTime := TImeStart;
                            LCurveStartTime := TImeStart;

                            if PlanningQueueeRec."Learning Curve No." <> 0 then begin
                                LearningCurveRec.Reset();
                                LearningCurveRec.SetRange("No.", PlanningQueueeRec."Learning Curve No.");
                                if LearningCurveRec.FindSet() then
                                    if LearningCurveRec.Type = LearningCurveRec.Type::Hourly then begin
                                        LcurveTemp := LearningCurveRec.Day1;
                                        repeat
                                            FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, LCurveFinishDate, LocationRec."Start Time");

                                            if ((FactoryFinishTime - LCurveStartTime) / 3600000 <= LcurveTemp) then begin
                                                LcurveTemp -= (FactoryFinishTime - LCurveStartTime) / 3600000;
                                                LCurveStartTime := LocationRec."Start Time";
                                                LCurveFinishDate += 1;

                                                //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                HoursPerDay := 0;
                                                repeat
                                                    ResCapacityEntryRec.Reset();
                                                    ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                    ResCapacityEntryRec.SETRANGE(Date, LCurveFinishDate);
                                                    if ResCapacityEntryRec.FindSet() then begin
                                                        repeat
                                                            HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                        until ResCapacityEntryRec.Next() = 0;
                                                    end;

                                                    if HoursPerDay = 0 then begin

                                                        //Validate the day (Holiday or Weekend)
                                                        SHCalHolidayRec.Reset();
                                                        SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                        SHCalHolidayRec.SETRANGE(Date, LCurveFinishDate);

                                                        if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                            DayForWeek.Get(DayForWeek."Period Type"::Date, LCurveFinishDate);

                                                            case DayForWeek."Period No." of
                                                                1:
                                                                    Day := 0;
                                                                2:
                                                                    Day := 1;
                                                                3:
                                                                    Day := 2;
                                                                4:
                                                                    Day := 3;
                                                                5:
                                                                    Day := 4;
                                                                6:
                                                                    Day := 5;
                                                                7:
                                                                    Day := 6;
                                                            end;

                                                            SHCalWorkRec.Reset();
                                                            SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                            SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                            if SHCalWorkRec.FindSet() then   //If not weekend
                                                                Error('Calender for date : %1  Work center : %2 has not calculated', LCurveFinishDate, ResourceRec.Name);
                                                        end;
                                                    end;

                                                    if HoursPerDay = 0 then
                                                        LCurveFinishDate := LCurveFinishDate + 1;

                                                until HoursPerDay > 0;
                                            end
                                            else begin
                                                LCurveStartTime := LCurveStartTime + 60 * 60 * 1000 * LcurveTemp;
                                                LcurveTemp -= LcurveTemp;
                                            end;
                                        until LcurveTemp <= 0;

                                        LCurveFinishTime := LCurveStartTime;
                                    end;
                            end;

                            repeat
                                //Get working hours for the day
                                HoursPerDay := 0;
                                Holiday := 'No';
                                TempHours := 0;
                                Rate := 0;
                                ResCapacityEntryRec.Reset();
                                ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                ResCapacityEntryRec.SETRANGE(Date, TempDate);
                                if ResCapacityEntryRec.FindSet() then begin
                                    repeat
                                        HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                    until ResCapacityEntryRec.Next() = 0;
                                end;

                                if HoursPerDay = 0 then begin

                                    //Validate the day (Holiday or Weekend)
                                    SHCalHolidayRec.Reset();
                                    SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                    SHCalHolidayRec.SETRANGE(Date, TempDate);

                                    if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                        DayForWeek.Get(DayForWeek."Period Type"::Date, TempDate);

                                        case DayForWeek."Period No." of
                                            1:
                                                Day := 0;
                                            2:
                                                Day := 1;
                                            3:
                                                Day := 2;
                                            4:
                                                Day := 3;
                                            5:
                                                Day := 4;
                                            6:
                                                Day := 5;
                                            7:
                                                Day := 6;
                                        end;

                                        SHCalWorkRec.Reset();
                                        SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                        SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                        if SHCalWorkRec.FindSet() then   //If not weekend
                                            Error('Calender for date : %1  Work center : %2 has not calculated', TempDate, ResourceRec.Name)
                                        else
                                            Holiday := 'Yes';
                                    end
                                    else
                                        Holiday := 'Yes';
                                end;

                                //No learning curve for holidays
                                if HoursPerDay > 0 then
                                    i += 1;

                                if (i = 1) and (HoursPerDay > 0) then begin
                                    //Calculate hours for the first day (substracti hours if delay start)
                                    HoursPerDay := HoursPerDay - (TImeStart - LocationRec."Start Time") / 3600000;
                                end;

                                if PlanningQueueeRec."Learning Curve No." <> 0 then begin
                                    //Aplly learning curve
                                    LearningCurveRec.Reset();
                                    LearningCurveRec.SetRange("No.", PlanningQueueeRec."Learning Curve No.");
                                    if LearningCurveRec.FindSet() then begin   //Efficiency wise
                                        if LearningCurveRec.Type = LearningCurveRec.Type::"Efficiency Wise" then begin
                                            case i of
                                                1:
                                                    Rate := LearningCurveRec.Day1;
                                                2:
                                                    Rate := LearningCurveRec.Day2;
                                                3:
                                                    Rate := LearningCurveRec.Day3;
                                                4:
                                                    Rate := LearningCurveRec.Day4;
                                                5:
                                                    Rate := LearningCurveRec.Day5;
                                                6:
                                                    Rate := LearningCurveRec.Day6;
                                                7:
                                                    Rate := LearningCurveRec.Day7;
                                                else
                                                    Rate := 100;
                                            end;

                                            if Rate = 0 then
                                                Rate := 100;

                                            if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < PlanningQueueeRec.Qty) then begin
                                                TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                            end
                                            else begin
                                                TempQty1 := PlanningQueueeRec.Qty - TempQty;
                                                TempQty := TempQty + TempQty1;
                                                TempHours := TempQty1 / TargetPerHour;
                                                xQty := TempQty1;

                                                // if (TempHours IN [0.0001 .. 0.99]) then
                                                //     TempHours := 1;

                                                //TempHours := round(TempHours, 1, '>');  
                                                TempHours := round(TempHours, 0.01);
                                            end;
                                        end
                                        else begin  //Hourly

                                            Rate := 100;
                                            LcurveHoursPerday := 0;
                                            LCurveStartTimePerDay := 0T;

                                            if LCurveFinishDate > TempDate then begin
                                                LcurveHoursPerday := HoursPerDay;   //Hourly target calculation purpose

                                                if LcurveHoursPerday = 0 then
                                                    LCurveStartTimePerDay := 0T
                                                else begin
                                                    if i = 1 then
                                                        LCurveStartTimePerDay := LCurveStartTime
                                                    else
                                                        LCurveStartTimePerDay := LocationRec."Start Time";
                                                end;

                                                HoursPerDay := 0;
                                            end
                                            else begin
                                                if LCurveFinishDate = TempDate then begin

                                                    if i = 1 then begin
                                                        if ((LCurveFinishTime - TImeStart) / 3600000) < 0 then begin

                                                            LcurveHoursPerday := (TImeStart - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                            if LcurveHoursPerday = 0 then
                                                                LCurveStartTimePerDay := 0T
                                                            else
                                                                LCurveStartTimePerDay := TImeStart;

                                                            HoursPerDay := HoursPerDay - (TImeStart - LCurveFinishTime) / 3600000;
                                                        end
                                                        else begin

                                                            LcurveHoursPerday := (LCurveFinishTime - TImeStart) / 3600000;   //Hourly target calculation purpose
                                                            if LcurveHoursPerday = 0 then
                                                                LCurveStartTimePerDay := 0T
                                                            else
                                                                LCurveStartTimePerDay := TImeStart;

                                                            HoursPerDay := HoursPerDay - (LCurveFinishTime - TImeStart) / 3600000;
                                                        end;
                                                    end
                                                    else begin

                                                        if ((LCurveFinishTime - LocationRec."Start Time") / 3600000) < 0 then begin

                                                            LcurveHoursPerday := (LocationRec."Start Time" - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                            if LcurveHoursPerday = 0 then
                                                                LCurveStartTimePerDay := 0T
                                                            else
                                                                LCurveStartTimePerDay := LocationRec."Start Time";

                                                            HoursPerDay := HoursPerDay - (LocationRec."Start Time" - LCurveFinishTime) / 3600000;
                                                        end
                                                        else begin

                                                            LcurveHoursPerday := (LCurveFinishTime - LocationRec."Start Time") / 3600000;   //Hourly target calculation purpose
                                                            if LcurveHoursPerday = 0 then
                                                                LCurveStartTimePerDay := 0T
                                                            else
                                                                LCurveStartTimePerDay := LocationRec."Start Time";

                                                            HoursPerDay := HoursPerDay - (LCurveFinishTime - LocationRec."Start Time") / 3600000;
                                                        end;
                                                    end;

                                                end;
                                            end;

                                            if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < PlanningQueueeRec.Qty) then begin
                                                TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                            end
                                            else begin
                                                TempQty1 := PlanningQueueeRec.Qty - TempQty;
                                                xQty := TempQty1;
                                                TempQty := TempQty + TempQty1;
                                                TempHours := TempQty1 / TargetPerHour;

                                                // if (TempHours IN [0.0001 .. 0.99]) then
                                                //     TempHours := 1;

                                                // TempHours := round(TempHours, 1, '>');
                                                TempHours := round(TempHours, 0.01);

                                            end;
                                        end;
                                    end;
                                end
                                else begin
                                    if (TempQty + round((TargetPerHour * HoursPerDay), 1)) < PlanningQueueeRec.Qty then begin
                                        TempQty += round((TargetPerHour * HoursPerDay), 1);
                                        xQty := round(TargetPerHour * HoursPerDay, 1);
                                    end
                                    else begin
                                        TempQty1 := PlanningQueueeRec.Qty - TempQty;
                                        TempQty := TempQty + TempQty1;
                                        TempHours := TempQty1 / TargetPerHour;
                                        xQty := TempQty1;

                                        // if (TempHours IN [0.0001 .. 0.99]) then
                                        //     TempHours := 1;

                                        // TempHours := round(TempHours, 1, '>');
                                        TempHours := round(TempHours, 0.01);
                                    end;
                                end;

                                xQty := Round(xQty, 1);

                                //Get Max Lineno
                                MaxLineNo := 0;
                                ProdPlansDetails.Reset();

                                if ProdPlansDetails.FindLast() then
                                    MaxLineNo := ProdPlansDetails."No.";

                                MaxLineNo += 1;
                                FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, TempDate, LocationRec."Start Time");

                                //insert to ProdPlansDetails
                                ProdPlansDetails.Init();
                                ProdPlansDetails."No." := MaxLineNo;
                                ProdPlansDetails.PlanDate := TempDate;
                                ProdPlansDetails."Style No." := PlanningQueueeRec."Style No.";
                                ProdPlansDetails."Style Name" := PlanningQueueeRec."Style Name";
                                ProdPlansDetails."PO No." := PlanningQueueeRec."PO No.";
                                ProdPlansDetails."lot No." := PlanningQueueeRec."lot No.";
                                ProdPlansDetails."Line No." := LineNo;
                                ProdPlansDetails."Resource No." := ResourceNo;
                                ProdPlansDetails.Carder := Carder;
                                ProdPlansDetails.Eff := Eff;
                                ProdPlansDetails.SMV := SMV;

                                if Holiday = 'NO' then begin
                                    if i = 1 then
                                        ProdPlansDetails."Start Time" := TImeStart
                                    else
                                        ProdPlansDetails."Start Time" := LocationRec."Start Time";

                                    if TempHours = 0 then
                                        ProdPlansDetails."Finish Time" := FactoryFinishTime
                                    else begin
                                        if i = 1 then
                                            ProdPlansDetails."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                        else
                                            ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                    end;
                                end;

                                ProdPlansDetails.Qty := xQty;
                                ProdPlansDetails.Target := TargetPerDay;

                                if Holiday = 'NO' then
                                    if TempHours > 0 then
                                        ProdPlansDetails.HoursPerDay := TempHours
                                    else
                                        ProdPlansDetails.HoursPerDay := HoursPerDay
                                else
                                    ProdPlansDetails.HoursPerDay := 0;

                                if Holiday = 'YES' then begin
                                    ProdPlansDetails."LCurve Hours Per Day" := 0;
                                    ProdPlansDetails."LCurve Start Time" := 0T;
                                    ProdPlansDetails."Learning Curve No." := 0;
                                end
                                else begin
                                    ProdPlansDetails."LCurve Hours Per Day" := LcurveHoursPerday;
                                    ProdPlansDetails."LCurve Start Time" := LCurveStartTimePerDay;

                                    if ProdPlansDetails."LCurve Hours Per Day" = 0 then
                                        ProdPlansDetails."Learning Curve No." := 0
                                    else
                                        ProdPlansDetails."Learning Curve No." := PlanningQueueeRec."Learning Curve No.";
                                end;

                                ProdPlansDetails.ProdUpd := 0;
                                ProdPlansDetails.ProdUpdQty := 0;
                                ProdPlansDetails."Created User" := UserId;
                                ProdPlansDetails."Created Date" := WorkDate();
                                ProdPlansDetails."Factory No." := FactoryNo;
                                ProdPlansDetails.Insert();

                                TempDate := TempDate + 1;

                            until (TempQty >= PlanningQueueeRec.Qty);

                            TempDate := TempDate - 1;

                            if TempHours = 0 then
                                TempDate := TempDate - 1;

                            //Check whether user logged in or not
                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if not LoginSessionsRec.FindSet() then begin  //not logged in
                                Clear(LoginRec);
                                LoginRec.LookupMode(true);
                                LoginRec.RunModal();

                                LoginSessionsRec.Reset();
                                LoginSessionsRec.SetRange(SessionID, SessionId());
                                LoginSessionsRec.FindSet();
                            end;

                            //Insert to the Planning line table
                            JobPlaLineRec.Init();
                            JobPlaLineRec."Style No." := PlanningQueueeRec."Style No.";
                            JobPlaLineRec."PO No." := PlanningQueueeRec."PO No.";
                            JobPlaLineRec."Lot No." := PlanningQueueeRec."Lot No.";
                            JobPlaLineRec."Line No." := LineNo;
                            JobPlaLineRec."Style Name" := PlanningQueueeRec."Style Name";
                            JobPlaLineRec."Description" := PlanningQueueeRec."Style Name";
                            JobPlaLineRec."Resource No." := ResourceNo;
                            JobPlaLineRec."Resource Name" := ResourceName;
                            JobPlaLineRec."Start Date" := dtStart;
                            JobPlaLineRec."End Date" := TempDate;
                            JobPlaLineRec."Start Time" := TImeStart;

                            if TempHours = 0 then
                                JobPlaLineRec."Finish Time" := FactoryFinishTime
                            else begin
                                if i = 1 then
                                    if (FactoryFinishTime < TImeStart + 60 * 60 * 1000 * TempHours) then
                                        JobPlaLineRec."Finish Time" := FactoryFinishTime
                                    else
                                        JobPlaLineRec."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                else
                                    JobPlaLineRec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                            end;

                            JobPlaLineRec.Carder := Carder;
                            JobPlaLineRec.Target := TargetPerDay;
                            JobPlaLineRec.Front := PlanningQueueeRec.Front;
                            JobPlaLineRec.Back := PlanningQueueeRec.Back;
                            JobPlaLineRec.HoursPerDay := HoursPerDay;
                            JobPlaLineRec."TGTSEWFIN Date" := PlanningQueueeRec."TGTSEWFIN Date";
                            JobPlaLineRec.Eff := Eff;
                            JobPlaLineRec."Learning Curve No." := PlanningQueueeRec."Learning Curve No.";
                            JobPlaLineRec.SMV := SMV;
                            JobPlaLineRec."Created User" := UserId;
                            JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                            JobPlaLineRec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLineRec."Finish Time");
                            JobPlaLineRec.Qty := PlanningQueueeRec.Qty;
                            JobPlaLineRec.Factory := FactoryNo;
                            JobPlaLineRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                            JobPlaLineRec."Created Date" := WorkDate();
                            JobPlaLineRec.Insert();

                            //Get previuos finish time;                           
                            //Prev_FinishedDateTime := 0DT;
                            TempTIme := JobPlaLineRec."Finish Time";
                            IsInserted := true;

                            //Update StyleMsterPO table
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Style No.", PlanningQueueeRec."Style No.");
                            StyleMasterPORec.SetRange("Lot No.", PlanningQueueeRec."Lot No.");
                            StyleMasterPORec.FindSet();

                            // if (StyleMasterPORec.PlannedQty + PlanningQueueeRec.Qty) < 0 then
                            //     Error('Planned Qty is minus. Cannot proceed. PO No :  %1', StyleMasterPORec."PO No.");

                            StyleMasterPORec.PlannedQty := StyleMasterPORec.PlannedQty + PlanningQueueeRec.Qty;
                            StyleMasterPORec.QueueQty := StyleMasterPORec.QueueQty - PlanningQueueeRec.Qty;
                            StyleMasterPORec.Modify();


                            ///////////////////Check whether new allocation conflicts other allocation  
                            TempHours := 0;

                            JobPlaLineRec.Reset();
                            JobPlaLineRec.SetRange("Resource No.", ResourceNo);
                            JobPlaLineRec.SetRange("StartDateTime", CreateDateTime(dtStart, JobPlaLineRec."Start Time"), CreateDateTime(TempDate, JobPlaLineRec."Finish Time"));
                            JobPlaLineRec.SetCurrentKey(StartDateTime);
                            JobPlaLineRec.Ascending(true);
                            JobPlaLineRec.SetFilter("Line No.", '<>%1', LineNo);
                            if JobPlaLineRec.FindSet() then begin         //conflicts yes, then get all allocations for the line

                                JobPlaLineRec.Reset();
                                JobPlaLineRec.SetRange("Resource No.", ResourceNo);
                                JobPlaLineRec.SetFilter("StartDateTime", '>=%1', CreateDateTime(dtStart, JobPlaLineRec."Start Time"));
                                JobPlaLineRec.SetCurrentKey(StartDateTime);
                                JobPlaLineRec.Ascending(true);
                                JobPlaLineRec.SetFilter("Line No.", '<>%1', LineNo);
                                if JobPlaLineRec.FindSet() then begin

                                    HoursPerDay := 0;
                                    i := 0;
                                    N1 := 0;
                                    TempQty := 0;
                                    RowCount1 := JobPlaLineRec.Count;
                                    StartTime2 := JobPlaLineRec."Start Time";

                                    if RowCount1 > 0 then begin

                                        //Clear all Array data
                                        for N1 := 1 To 100 do begin
                                            ArrayOfAllocations[N1] := 0;
                                        end;

                                        N1 := 0;
                                        //Assign all line no of the work center line
                                        repeat
                                            N1 += 1;
                                            ArrayOfAllocations[N1] := JobPlaLineRec."Line No.";
                                        until JobPlaLineRec.Next() = 0;

                                        N1 := 0;
                                        for N1 := 1 To RowCount1 do begin

                                            HoursGap := 0;
                                            JobPlaLineRec.Reset();
                                            JobPlaLineRec.SetRange("Resource No.", ResourceNo);
                                            JobPlaLineRec.SetFilter("Line No.", '=%1', ArrayOfAllocations[N1]);
                                            if JobPlaLineRec.FindSet() then begin

                                                i := 0;
                                                Qty := JobPlaLineRec.Qty;
                                                LineNo := JobPlaLineRec."Line No.";
                                                SMV := JobPlaLineRec.SMV;

                                                if JobPlaLineRec.Carder <> 0 then
                                                    Carder := JobPlaLineRec.Carder;

                                                if JobPlaLineRec.Eff <> 0 then
                                                    Eff := JobPlaLineRec.Eff;

                                                ResourceRec.Reset();
                                                ResourceRec.SetRange("No.", ResourceNo);
                                                ResourceRec.FindSet();

                                                dtStart := TempDate;
                                                TImeStart := TempTIme;
                                                Curr_StartDateTime := JobPlaLineRec.StartDateTime;

                                                //Calculate hourly gap between prevous and current allocation
                                                if Prev_FinishedDateTime <> 0DT then begin
                                                    if DT2DATE(Prev_FinishedDateTime) = DT2DATE(Curr_StartDateTime) then begin
                                                        HoursGap := Curr_StartDateTime - Prev_FinishedDateTime;
                                                        HoursGap := HoursGap / 3600000;

                                                        if (HoursGap IN [0.0001 .. 0.99]) then
                                                            HoursGap := 1;

                                                        HoursGap := round(HoursGap, 1, '>');
                                                    end
                                                    else begin

                                                        XX := (DT2DATE(Curr_StartDateTime) - DT2DATE(Prev_FinishedDateTime) + 1);
                                                        HoursPerDay2 := 0;

                                                        for X := 1 To XX do begin
                                                            HoursPerDay1 := 0;
                                                            ResCapacityEntryRec.Reset();
                                                            ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                            ResCapacityEntryRec.SETRANGE(Date, DT2DATE(Prev_FinishedDateTime) + (X - 1));

                                                            if ResCapacityEntryRec.FindSet() then begin
                                                                repeat
                                                                    HoursPerDay1 += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                                until ResCapacityEntryRec.Next() = 0;
                                                            end;

                                                            if HoursPerDay1 > 0 then begin
                                                                FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, DT2DATE(Prev_FinishedDateTime) + (X - 1), LocationRec."Start Time");

                                                                if X = 1 then  //First Date
                                                                    HoursGap := CREATEDATETIME(DT2DATE(Prev_FinishedDateTime), FactoryFinishTime) - Prev_FinishedDateTime
                                                                else
                                                                    if X = XX then  //Last date
                                                                        HoursGap := HoursGap + (Curr_StartDateTime - CREATEDATETIME(DT2DATE(Curr_StartDateTime), LocationRec."start Time"))
                                                                    else
                                                                        HoursPerDay2 := HoursPerDay2 + HoursPerDay1;
                                                            end;
                                                        end;

                                                        HoursGap := HoursGap / 3600000;

                                                        if (HoursGap IN [0.0001 .. 0.99]) then
                                                            HoursGap := 1;

                                                        HoursGap := round(HoursGap, 1, '>');
                                                        HoursGap := HoursGap + HoursPerDay2;
                                                    end;
                                                end;

                                                //Based on Hourly Gap, calculate start Date/time of current allocation 
                                                if HoursGap > 0 then begin

                                                    ddddddtttt := CREATEDATETIME(dtStart, TImeStart);
                                                    FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtStart, LocationRec."Start Time");

                                                    if (CREATEDATETIME(dtStart, FactoryFinishTime) <= (ddddddtttt + (60 * 60 * 1000 * HoursGap))) then begin

                                                        HoursGap := HoursGap - (FactoryFinishTime - TImeStart) / 3600000;
                                                        TImeStart := LocationRec."Start Time";
                                                        dtStart := dtStart + 1;

                                                        if HoursGap > 0 then begin
                                                            repeat

                                                                //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                                repeat
                                                                    HoursPerDay := 0;
                                                                    WorkCenCapacityEntryRec.Reset();
                                                                    WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                                    WorkCenCapacityEntryRec.SETRANGE(Date, dtStart);
                                                                    if WorkCenCapacityEntryRec.FindSet() then begin
                                                                        repeat
                                                                            HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                                        until WorkCenCapacityEntryRec.Next() = 0;
                                                                    end
                                                                    else begin
                                                                        Count := 0;
                                                                        dtNextMonth := CalcDate('<+1M>', dtStart);
                                                                        dtSt := CalcDate('<-CM>', dtNextMonth);
                                                                        dtEd := CalcDate('<+CM>', dtNextMonth);

                                                                        WorkCenCapacityEntryRec.Reset();
                                                                        WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                                        WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                                                        if WorkCenCapacityEntryRec.FindSet() then
                                                                            Count += WorkCenCapacityEntryRec.Count;

                                                                        if Count < 14 then
                                                                            Error('Calender is not setup for the Line : %1', ResourceName);
                                                                    end;

                                                                    if HoursPerDay = 0 then
                                                                        dtStart := dtStart + 1;
                                                                until HoursPerDay > 0;

                                                                if (HoursPerDay > HoursGap) then begin
                                                                    TImeStart := TImeStart + (60 * 60 * 1000 * HoursGap);
                                                                    HoursGap := 0;
                                                                end
                                                                else begin
                                                                    HoursGap := HoursGap - HoursPerDay;
                                                                    dtStart := dtStart + 1;
                                                                end;

                                                            until HoursGap = 0;
                                                        end
                                                    end
                                                    else begin
                                                        TImeStart := TImeStart + (60 * 60 * 1000 * HoursGap);
                                                        HoursGap := 0;
                                                    end;

                                                    TempDate := dtStart;
                                                end;

                                                HoursPerDay := 0;
                                                FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtStart, LocationRec."Start Time");

                                                //if start time greater than parameter Finish time, set start time next day morning
                                                if ((TImeStart - FactoryFinishTime) >= 0) then begin
                                                    TImeStart := LocationRec."Start Time";
                                                    dtStart := dtStart + 1;
                                                    TempDate := dtStart;
                                                end;

                                                //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                repeat
                                                    WorkCenCapacityEntryRec.Reset();
                                                    WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                    WorkCenCapacityEntryRec.SETRANGE(Date, dtStart);
                                                    if WorkCenCapacityEntryRec.FindSet() then begin
                                                        repeat
                                                            HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                        until WorkCenCapacityEntryRec.Next() = 0;
                                                    end
                                                    else begin
                                                        Count := 0;
                                                        dtNextMonth := CalcDate('<+1M>', dtStart);
                                                        dtSt := CalcDate('<-CM>', dtNextMonth);
                                                        dtEd := CalcDate('<+CM>', dtNextMonth);

                                                        WorkCenCapacityEntryRec.Reset();
                                                        WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                        WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);
                                                        if WorkCenCapacityEntryRec.FindSet() then
                                                            Count += WorkCenCapacityEntryRec.Count;

                                                        if Count < 14 then
                                                            Error('Calender is not setup for the Line : %1', ResourceName);
                                                    end;

                                                    if HoursPerDay = 0 then
                                                        dtStart := dtStart + 1;

                                                until HoursPerDay > 0;

                                                TargetPerDay := round(((60 / SMV) * Carder * HoursPerDay * Eff) / 100, 1);
                                                TargetPerHour := round(TargetPerDay / HoursPerDay, 1);
                                                TempQty := 0;

                                                //Delete old lines
                                                ProdPlansDetails.Reset();
                                                ProdPlansDetails.SetRange("Line No.", LineNo);
                                                ProdPlansDetails.SetFilter(ProdUpd, '=%1', 0);
                                                if ProdPlansDetails.FindSet() then
                                                    ProdPlansDetails.DeleteAll();

                                                //Check learning curve                        
                                                LCurveFinishDate := TempDate;
                                                LCurveFinishTime := TImeStart;
                                                LCurveStartTime := TImeStart;

                                                if JobPlaLineRec."Learning Curve No." <> 0 then begin
                                                    LearningCurveRec.Reset();
                                                    LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                                    if LearningCurveRec.FindSet() then begin

                                                        if LearningCurveRec.Type = LearningCurveRec.Type::Hourly then begin
                                                            LcurveTemp := LearningCurveRec.Day1;

                                                            repeat
                                                                FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, LCurveFinishDate, LocationRec."Start Time");

                                                                if ((FactoryFinishTime - LCurveStartTime) / 3600000 <= LcurveTemp) then begin
                                                                    LcurveTemp -= (FactoryFinishTime - LCurveStartTime) / 3600000;
                                                                    LCurveStartTime := LocationRec."Start Time";
                                                                    LCurveFinishDate += 1;

                                                                    //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                                    HoursPerDay := 0;
                                                                    repeat
                                                                        ResCapacityEntryRec.Reset();
                                                                        ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                                        ResCapacityEntryRec.SETRANGE(Date, LCurveFinishDate);
                                                                        if ResCapacityEntryRec.FindSet() then begin
                                                                            repeat
                                                                                HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                                            until ResCapacityEntryRec.Next() = 0;
                                                                        end;

                                                                        if HoursPerDay = 0 then begin

                                                                            //Validate the day (Holiday or Weekend)
                                                                            SHCalHolidayRec.Reset();
                                                                            SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                                            SHCalHolidayRec.SETRANGE(Date, LCurveFinishDate);
                                                                            if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                                                DayForWeek.Get(DayForWeek."Period Type"::Date, LCurveFinishDate);

                                                                                case DayForWeek."Period No." of
                                                                                    1:
                                                                                        Day := 0;
                                                                                    2:
                                                                                        Day := 1;
                                                                                    3:
                                                                                        Day := 2;
                                                                                    4:
                                                                                        Day := 3;
                                                                                    5:
                                                                                        Day := 4;
                                                                                    6:
                                                                                        Day := 5;
                                                                                    7:
                                                                                        Day := 6;
                                                                                end;

                                                                                SHCalWorkRec.Reset();
                                                                                SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                                                SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                                                if SHCalWorkRec.FindSet() then   //If not weekend
                                                                                    Error('Calender for date : %1  Work center : %2 has not calculated', LCurveFinishDate, ResourceRec.Name);
                                                                            end;
                                                                        end;

                                                                        if HoursPerDay = 0 then
                                                                            LCurveFinishDate := LCurveFinishDate + 1;

                                                                    until HoursPerDay > 0;
                                                                end
                                                                else begin
                                                                    LCurveStartTime := LCurveStartTime + 60 * 60 * 1000 * LcurveTemp;
                                                                    LcurveTemp -= LcurveTemp;
                                                                end;
                                                            until LcurveTemp <= 0;

                                                            LCurveFinishTime := LCurveStartTime;
                                                        end;
                                                    end;
                                                end;

                                                repeat
                                                    //Get working hours for the day
                                                    HoursPerDay := 0;
                                                    Holiday := 'NO';
                                                    TempHours := 0;
                                                    Rate := 0;
                                                    WorkCenCapacityEntryRec.Reset();
                                                    WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                    WorkCenCapacityEntryRec.SETRANGE(Date, TempDate);
                                                    if WorkCenCapacityEntryRec.FindSet() then begin
                                                        repeat
                                                            HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                        until WorkCenCapacityEntryRec.Next() = 0;
                                                    end
                                                    else begin
                                                        Count := 0;
                                                        dtNextMonth := CalcDate('<+1M>', TempDate);
                                                        dtSt := CalcDate('<-CM>', dtNextMonth);
                                                        dtEd := CalcDate('<+CM>', dtNextMonth);

                                                        WorkCenCapacityEntryRec.Reset();
                                                        WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                        WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                                        if WorkCenCapacityEntryRec.FindSet() then
                                                            Count += WorkCenCapacityEntryRec.Count;

                                                        if Count < 14 then
                                                            Error('Calender is not setup for the Line : %1', ResourceName);
                                                    end;

                                                    ResourceRec.Reset();
                                                    ResourceRec.SetRange("No.", ResourceNo);
                                                    ResourceRec.FindSet();

                                                    if HoursPerDay = 0 then begin

                                                        //Validate the day (Holiday or Weekend)
                                                        SHCalHolidayRec.Reset();
                                                        SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                        SHCalHolidayRec.SETRANGE(Date, TempDate);
                                                        if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                            DayForWeek.Get(DayForWeek."Period Type"::Date, TempDate);

                                                            case DayForWeek."Period No." of
                                                                1:
                                                                    Day := 0;
                                                                2:
                                                                    Day := 1;
                                                                3:
                                                                    Day := 2;
                                                                4:
                                                                    Day := 3;
                                                                5:
                                                                    Day := 4;
                                                                6:
                                                                    Day := 5;
                                                                7:
                                                                    Day := 6;
                                                            end;

                                                            SHCalWorkRec.Reset();
                                                            SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                            SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                            if SHCalWorkRec.FindSet() then   //If not weekend
                                                                Error('Calender for date : %1  Work center : %2 has not calculated', TempDate, ResourceRec.Name)
                                                            else
                                                                Holiday := 'Yes';
                                                        end
                                                        else
                                                            Holiday := 'Yes';
                                                    end;

                                                    //No learning curve for holidays
                                                    if HoursPerDay > 0 then
                                                        i += 1;

                                                    if (i = 1) and (HoursPerDay > 0) then begin
                                                        //Calculate hours for the first day (substracti hours if delay start)
                                                        HoursPerDay := HoursPerDay - (TImeStart - LocationRec."Start Time") / 3600000;
                                                    end;

                                                    if JobPlaLineRec."Learning Curve No." <> 0 then begin

                                                        //Aplly learning curve
                                                        LearningCurveRec.Reset();
                                                        LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                                        if LearningCurveRec.FindSet() then begin
                                                            if LearningCurveRec.Type = LearningCurveRec.Type::"Efficiency Wise" then begin  //Efficiency wise
                                                                case i of
                                                                    1:
                                                                        Rate := LearningCurveRec.Day1;
                                                                    2:
                                                                        Rate := LearningCurveRec.Day2;
                                                                    3:
                                                                        Rate := LearningCurveRec.Day3;
                                                                    4:
                                                                        Rate := LearningCurveRec.Day4;
                                                                    5:
                                                                        Rate := LearningCurveRec.Day5;
                                                                    6:
                                                                        Rate := LearningCurveRec.Day6;
                                                                    7:
                                                                        Rate := LearningCurveRec.Day7;
                                                                    else
                                                                        Rate := 100;
                                                                end;

                                                                if Rate = 0 then
                                                                    Rate := 100;

                                                                if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < Qty) then begin
                                                                    TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                                    xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                                end
                                                                else begin
                                                                    TempQty1 := Qty - TempQty;
                                                                    TempQty := TempQty + TempQty1;
                                                                    TempHours := TempQty1 / TargetPerHour;
                                                                    xQty := TempQty1;

                                                                    // if (TempHours IN [0.0001 .. 0.99]) then
                                                                    //     TempHours := 1;

                                                                    // TempHours := round(TempHours, 1, '>');
                                                                    TempHours := round(TempHours, 0.01);
                                                                end;
                                                            end
                                                            else begin  //Hourly

                                                                Rate := 100;
                                                                LcurveHoursPerday := 0;
                                                                LCurveStartTimePerDay := 0T;

                                                                if LCurveFinishDate > TempDate then begin
                                                                    LcurveHoursPerday := HoursPerDay;   //Hourly target calculation purpose

                                                                    if LcurveHoursPerday = 0 then
                                                                        LCurveStartTimePerDay := 0T
                                                                    else begin
                                                                        if i = 1 then
                                                                            LCurveStartTimePerDay := LCurveStartTime
                                                                        else
                                                                            LCurveStartTimePerDay := LocationRec."Start Time";
                                                                    end;

                                                                    HoursPerDay := 0;
                                                                end
                                                                else begin
                                                                    if LCurveFinishDate = TempDate then begin

                                                                        if i = 1 then begin
                                                                            if ((LCurveFinishTime - TImeStart) / 3600000) < 0 then begin

                                                                                LcurveHoursPerday := (TImeStart - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                                                if LcurveHoursPerday = 0 then
                                                                                    LCurveStartTimePerDay := 0T
                                                                                else
                                                                                    LCurveStartTimePerDay := TImeStart;

                                                                                HoursPerDay := HoursPerDay - (TImeStart - LCurveFinishTime) / 3600000;
                                                                            end
                                                                            else begin

                                                                                LcurveHoursPerday := (LCurveFinishTime - TImeStart) / 3600000;   //Hourly target calculation purpose
                                                                                if LcurveHoursPerday = 0 then
                                                                                    LCurveStartTimePerDay := 0T
                                                                                else
                                                                                    LCurveStartTimePerDay := TImeStart;

                                                                                HoursPerDay := HoursPerDay - (LCurveFinishTime - TImeStart) / 3600000;
                                                                            end;
                                                                        end
                                                                        else begin
                                                                            if ((LCurveFinishTime - LocationRec."Start Time") / 3600000) < 0 then begin

                                                                                LcurveHoursPerday := (LocationRec."Start Time" - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                                                if LcurveHoursPerday = 0 then
                                                                                    LCurveStartTimePerDay := 0T
                                                                                else
                                                                                    LCurveStartTimePerDay := LocationRec."Start Time";

                                                                                HoursPerDay := HoursPerDay - (LocationRec."Start Time" - LCurveFinishTime) / 3600000;
                                                                            end
                                                                            else begin
                                                                                LcurveHoursPerday := (LCurveFinishTime - LocationRec."Start Time") / 3600000;   //Hourly target calculation purpose
                                                                                if LcurveHoursPerday = 0 then
                                                                                    LCurveStartTimePerDay := 0T
                                                                                else
                                                                                    LCurveStartTimePerDay := LocationRec."Start Time";

                                                                                HoursPerDay := HoursPerDay - (LCurveFinishTime - LocationRec."Start Time") / 3600000;
                                                                            end;
                                                                        end;
                                                                    end;
                                                                end;

                                                                if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < Qty) then begin
                                                                    TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                                    xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                                end
                                                                else begin
                                                                    TempQty1 := Qty - TempQty;
                                                                    xQty := TempQty1;
                                                                    TempQty := TempQty + TempQty1;
                                                                    TempHours := TempQty1 / TargetPerHour;

                                                                    // if (TempHours IN [0.0001 .. 0.99]) then
                                                                    //     TempHours := 1;

                                                                    // TempHours := round(TempHours, 1, '>');
                                                                    TempHours := round(TempHours, 0.01);
                                                                end;
                                                            end;
                                                        end;
                                                    end
                                                    else begin

                                                        if (TempQty + (TargetPerHour * HoursPerDay)) < Qty then begin
                                                            TempQty += (TargetPerHour * HoursPerDay);
                                                            xQty := TargetPerHour * HoursPerDay;
                                                        end
                                                        else begin
                                                            TempQty1 := Qty - TempQty;
                                                            TempQty := TempQty + TempQty1;
                                                            TempHours := TempQty1 / TargetPerHour;
                                                            xQty := TempQty1;

                                                            // if (TempHours IN [0.0001 .. 0.99]) then
                                                            //     TempHours := 1;

                                                            // TempHours := round(TempHours, 1, '>');
                                                            TempHours := round(TempHours, 0.01);
                                                        end;
                                                    end;

                                                    //Get Max Lineno
                                                    MaxLineNo := 0;
                                                    ProdPlansDetails.Reset();
                                                    if ProdPlansDetails.FindLast() then
                                                        MaxLineNo := ProdPlansDetails."No.";

                                                    MaxLineNo += 1;
                                                    FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, TempDate, LocationRec."Start Time");

                                                    //insert to ProdPlansDetails
                                                    ProdPlansDetails.Init();
                                                    ProdPlansDetails."No." := MaxLineNo;
                                                    ProdPlansDetails.PlanDate := TempDate;
                                                    ProdPlansDetails."Style No." := JobPlaLineRec."Style No.";
                                                    ProdPlansDetails."Style Name" := JobPlaLineRec."Style Name";
                                                    ProdPlansDetails."PO No." := JobPlaLineRec."PO No.";
                                                    ProdPlansDetails."Lot No." := JobPlaLineRec."Lot No.";
                                                    ProdPlansDetails."Line No." := LineNo;
                                                    ProdPlansDetails."Resource No." := ResourceNo;
                                                    ProdPlansDetails.Carder := Carder;
                                                    ProdPlansDetails.Eff := Eff;
                                                    ProdPlansDetails.SMV := JobPlaLineRec.SMV;

                                                    if Holiday = 'NO' then begin
                                                        if i = 1 then
                                                            ProdPlansDetails."Start Time" := TImeStart
                                                        else
                                                            ProdPlansDetails."Start Time" := LocationRec."Start Time";

                                                        if TempHours = 0 then
                                                            ProdPlansDetails."Finish Time" := FactoryFinishTime
                                                        else begin
                                                            if i = 1 then
                                                                if (FactoryFinishTime < TImeStart + 60 * 60 * 1000 * TempHours) then
                                                                    ProdPlansDetails."Finish Time" := FactoryFinishTime
                                                                else
                                                                    ProdPlansDetails."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                                            else
                                                                ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                                        end;
                                                    end;

                                                    ProdPlansDetails.Qty := xQty;
                                                    ProdPlansDetails.Target := TargetPerDay;
                                                    // ProdPlansDetails.HoursPerDay := HoursPerDay;

                                                    if Holiday = 'NO' then
                                                        if TempHours > 0 then
                                                            ProdPlansDetails.HoursPerDay := TempHours
                                                        else
                                                            ProdPlansDetails.HoursPerDay := HoursPerDay
                                                    else
                                                        ProdPlansDetails.HoursPerDay := 0;

                                                    if Holiday = 'YES' then begin
                                                        ProdPlansDetails."LCurve Hours Per Day" := 0;
                                                        ProdPlansDetails."LCurve Start Time" := 0T;
                                                        ProdPlansDetails."Learning Curve No." := 0;
                                                    end
                                                    else begin
                                                        ProdPlansDetails."LCurve Hours Per Day" := LcurveHoursPerday;
                                                        ProdPlansDetails."LCurve Start Time" := LCurveStartTimePerDay;

                                                        if ProdPlansDetails."LCurve Hours Per Day" = 0 then
                                                            ProdPlansDetails."Learning Curve No." := 0
                                                        else
                                                            ProdPlansDetails."Learning Curve No." := JobPlaLineRec."Learning Curve No.";
                                                    end;

                                                    ProdPlansDetails.ProdUpd := 0;
                                                    ProdPlansDetails.ProdUpdQty := 0;
                                                    ProdPlansDetails."Created User" := UserId;
                                                    ProdPlansDetails."Created Date" := WorkDate();
                                                    ProdPlansDetails."Factory No." := JobPlaLineRec.Factory;
                                                    ProdPlansDetails.Insert();

                                                    TempDate := TempDate + 1;

                                                until (TempQty >= Qty);

                                                TempDate := TempDate - 1;

                                                if TempHours = 0 then
                                                    TempDate := TempDate - 1;

                                                //modift the line
                                                JobPlaLine2Rec.Reset();
                                                JobPlaLine2Rec.SetRange("Line No.", LineNo);
                                                JobPlaLine2Rec.FindSet();

                                                JobPlaLine2Rec."Start Date" := dtStart;
                                                JobPlaLine2Rec."End Date" := TempDate;
                                                JobPlaLine2Rec."Start Time" := TImeStart;

                                                if TempHours = 0 then
                                                    JobPlaLine2Rec."Finish Time" := FactoryFinishTime
                                                else begin
                                                    if i = 1 then
                                                        if (FactoryFinishTime < TImeStart + 60 * 60 * 1000 * TempHours) then
                                                            JobPlaLine2Rec."Finish Time" := FactoryFinishTime
                                                        else
                                                            JobPlaLine2Rec."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                                    else
                                                        JobPlaLine2Rec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                                end;

                                                JobPlaLine2Rec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                                                JobPlaLine2Rec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLine2Rec."Finish Time");
                                                JobPlaLine2Rec.Qty := Qty;

                                                Prev_FinishedDateTime := JobPlaLineRec.FinishDateTime;
                                                JobPlaLine2Rec.Modify();

                                                TempTIme := JobPlaLine2Rec."Finish Time";

                                                //delete allocation if remaining qty is 0 or less than 0
                                                JobPlaLine2Rec.Reset();
                                                JobPlaLine2Rec.SetRange("Line No.", LineNo);

                                                if JobPlaLine2Rec.FindSet() then begin
                                                    if JobPlaLine2Rec.Qty <= 0 then
                                                        JobPlaLine2Rec.DeleteAll();
                                                end;
                                            end;

                                            StartTime2 := JobPlaLine2Rec."Start Time";
                                            LineNo := JobPlaLineRec."Line No.";
                                        end;
                                    end;
                                end;
                            end;

                            if IsInserted = true then begin
                                // Delete from the Queue
                                PlanningQueueeRec.Reset();
                                PlanningQueueeRec.SetRange("Queue No.", ID);
                                PlanningQueueeRec.DeleteAll();
                            end;

                            //LoadDataFromQ();
                            LoadData(false, false, true, true, false);
                        end;
                    end
                    else begin   //Drag and drop existing allocation

                        HoursPerDay := 0;
                        //ResourceNo := copystr(_newRowObjectID, 3, StrLen(_newRowObjectID) - 2);

                        // //Check whether pending sawing out quantity is there for the allocation
                        // ProdHeaderRec.Reset();
                        // ProdHeaderRec.SetFilter("Prod Updated", '=%1', 0);
                        // ProdHeaderRec.SetRange("out Style No.", STYNo);
                        // ProdHeaderRec.SetRange("out Lot No.", lotNo);
                        // ProdHeaderRec.SetRange("OUT PO No", PONo);
                        // ProdHeaderRec.SetRange("Ref Line No.", LineNo);
                        // ProdHeaderRec.SetRange("Resource No.", ResourceNo);
                        // ProdHeaderRec.SetFilter(Type, '=%1', ProdHeaderRec.Type::Saw);

                        // if ProdHeaderRec.FindSet() then
                        //     Error('Prodcution update for allocation : %1 has not processed yet for the date : %2. Cannot change the allocation.', _objectID, ProdHeaderRec."Prod Date");


                        //Get Resorce line details
                        ResourceRec.Reset();
                        ResourceRec.SetRange("No.", ResourceNo);
                        ResourceRec.FindSet();

                        Carder := ResourceRec.Carder;
                        eff := ResourceRec.PlanEff;
                        ResourceName := ResourceRec.Name;

                        //Get Carder and eff is exsted in planning lines
                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetCurrentKey("Line No.");
                        JobPlaLineRec.SetRange("Line No.", LineNo);
                        JobPlaLineRec.FindSet();

                        if JobPlaLineRec.Carder <> 0 then
                            Carder := JobPlaLineRec.Carder;

                        if Carder = 0 then
                            Error('Number of Carders is zero for Line : %1 . Cannot proceed.', ResourceName);

                        if JobPlaLineRec.Eff <> 0 then
                            Eff := JobPlaLineRec.Eff;

                        if Eff = 0 then
                            Error('Efficiency is zero. Cannot proceed.');

                        SMV := JobPlaLineRec.SMV;
                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtStart, LocationRec."Start Time");

                        if SMV = 0 then
                            Error('SMV for Style : %1 is zero. Cannot proceed.', JobPlaLineRec."Style Name");

                        //if start time earlier than parameter start time, set start time as parameter time                      
                        if ((LocationRec."Start Time" - TImeStart) > 0) then begin
                            TImeStart := LocationRec."Start Time";
                        end;

                        //if start time greater than parameter Finish time, set start time next day morning
                        if ((TImeStart - FactoryFinishTime) >= 0) then begin
                            TImeStart := LocationRec."Start Time";
                            dtStart := dtStart + 1;
                        end;

                        HoursPerDay := 0;
                        //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                        repeat
                            ResCapacityEntryRec.Reset();
                            ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                            ResCapacityEntryRec.SETRANGE(Date, dtStart);
                            if ResCapacityEntryRec.FindSet() then begin
                                repeat
                                    HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                until ResCapacityEntryRec.Next() = 0;
                            end;

                            if HoursPerDay = 0 then begin
                                //Validate the day (Holiday or Weekend)
                                SHCalHolidayRec.Reset();
                                SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                SHCalHolidayRec.SETRANGE(Date, dtStart);
                                if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                    DayForWeek.Get(DayForWeek."Period Type"::Date, dtStart);

                                    case DayForWeek."Period No." of
                                        1:
                                            Day := 0;
                                        2:
                                            Day := 1;
                                        3:
                                            Day := 2;
                                        4:
                                            Day := 3;
                                        5:
                                            Day := 4;
                                        6:
                                            Day := 5;
                                        7:
                                            Day := 6;
                                    end;

                                    SHCalWorkRec.Reset();
                                    SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                    SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                    if SHCalWorkRec.FindSet() then   //If not weekend
                                        Error('Calender for date : %1  Work center : %2 has not calculated', dtStart, ResourceRec.Name);
                                end;
                            end;

                            if HoursPerDay = 0 then
                                dtStart := dtStart + 1;

                        until HoursPerDay > 0;

                        // Check whether resource line is occupied in the date                             
                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetRange("Resource No.", ResourceNo);
                        JobPlaLineRec.SetFilter("StartDateTime", '<=%1', CreateDateTime(dtStart, TImeStart));
                        JobPlaLineRec.SetFilter("FinishDateTime", '>%1', CreateDateTime(dtStart, TImeStart));
                        JobPlaLineRec.SetFilter("Line No.", '<>%1', LineNo);
                        if JobPlaLineRec.FindSet() then begin

                            //Found := true;
                            dtStart := JobPlaLineRec."End Date";
                            TImeStart := JobPlaLineRec."Finish Time";
                            HoursPerDay := 0;
                            FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtStart, LocationRec."Start Time");

                            //if start time equal to the parameter Finish time, set start time next day morning
                            if ((TImeStart - FactoryFinishTime) = 0) then begin
                                TImeStart := LocationRec."Start Time";
                                dtStart := dtStart + 1;
                            end;

                            //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                            repeat
                                ResCapacityEntryRec.Reset();
                                ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                ResCapacityEntryRec.SETRANGE(Date, dtStart);
                                if ResCapacityEntryRec.FindSet() then begin
                                    repeat
                                        HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                    until ResCapacityEntryRec.Next() = 0;
                                end;

                                if HoursPerDay = 0 then begin

                                    //Validate the day (Holiday or Weekend)
                                    SHCalHolidayRec.Reset();
                                    SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                    SHCalHolidayRec.SETRANGE(Date, dtStart);

                                    if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                        DayForWeek.Get(DayForWeek."Period Type"::Date, dtStart);

                                        case DayForWeek."Period No." of
                                            1:
                                                Day := 0;
                                            2:
                                                Day := 1;
                                            3:
                                                Day := 2;
                                            4:
                                                Day := 3;
                                            5:
                                                Day := 4;
                                            6:
                                                Day := 5;
                                            7:
                                                Day := 6;
                                        end;

                                        SHCalWorkRec.Reset();
                                        SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                        SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                        if SHCalWorkRec.FindSet() then   //If not weekend
                                            Error('Calender for date : %1  Work center : %2 has not calculated', dtStart, ResourceRec.Name);
                                    end;
                                end;

                                if HoursPerDay = 0 then
                                    dtStart := dtStart + 1;

                            until HoursPerDay > 0;
                        end;

                        //Get Existing line details
                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetCurrentKey("Line No.");
                        JobPlaLineRec.SetRange("Line No.", LineNo);
                        JobPlaLineRec.FindSet();

                        // TargetPerDay := round(((60 / JobPlaLineRec.SMV) * Carder * HoursPerDay * Eff) / 100, 1);
                        // TargetPerHour := TargetPerDay / HoursPerDay;

                        TargetPerHour := round(((60 / JobPlaLineRec.SMV) * Carder * Eff) / 100, 1);
                        TargetPerDay := round(TargetPerHour * HoursPerDay, 1);

                        // TargetPerHour := round(TargetPerDay / HoursPerDay, 1, '>');
                        TempDate := dtStart;

                        //Delete old lines
                        ProdPlansDetails.Reset();
                        ProdPlansDetails.SetRange("Line No.", LineNo);
                        ProdPlansDetails.SetFilter(ProdUpd, '=%1', 0);
                        if ProdPlansDetails.FindSet() then
                            ProdPlansDetails.DeleteAll();

                        //Check learning curve                        
                        LCurveFinishDate := dtStart;
                        LCurveFinishTime := TImeStart;
                        LCurveStartTime := TImeStart;

                        if JobPlaLineRec."Learning Curve No." <> 0 then begin
                            LearningCurveRec.Reset();
                            LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                            if LearningCurveRec.FindSet() then begin

                                if LearningCurveRec.Type = LearningCurveRec.Type::Hourly then begin
                                    LcurveTemp := LearningCurveRec.Day1;

                                    repeat
                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, LCurveFinishDate, LocationRec."Start Time");

                                        if ((FactoryFinishTime - LCurveStartTime) / 3600000 <= LcurveTemp) then begin
                                            LcurveTemp -= (FactoryFinishTime - LCurveStartTime) / 3600000;
                                            LCurveStartTime := LocationRec."Start Time";
                                            LCurveFinishDate += 1;

                                            //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                            HoursPerDay := 0;
                                            repeat

                                                ResCapacityEntryRec.Reset();
                                                ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                ResCapacityEntryRec.SETRANGE(Date, LCurveFinishDate);
                                                if ResCapacityEntryRec.FindSet() then begin
                                                    repeat
                                                        HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                    until ResCapacityEntryRec.Next() = 0;
                                                end;

                                                if HoursPerDay = 0 then begin

                                                    //Validate the day (Holiday or Weekend)
                                                    SHCalHolidayRec.Reset();
                                                    SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                    SHCalHolidayRec.SETRANGE(Date, LCurveFinishDate);
                                                    if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                        DayForWeek.Get(DayForWeek."Period Type"::Date, LCurveFinishDate);

                                                        case DayForWeek."Period No." of
                                                            1:
                                                                Day := 0;
                                                            2:
                                                                Day := 1;
                                                            3:
                                                                Day := 2;
                                                            4:
                                                                Day := 3;
                                                            5:
                                                                Day := 4;
                                                            6:
                                                                Day := 5;
                                                            7:
                                                                Day := 6;
                                                        end;

                                                        SHCalWorkRec.Reset();
                                                        SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                        SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                        if SHCalWorkRec.FindSet() then   //If not weekend
                                                            Error('Calender for date : %1  Work center : %2 has not calculated', LCurveFinishDate, ResourceRec.Name);
                                                    end;
                                                end;

                                                if HoursPerDay = 0 then
                                                    LCurveFinishDate := LCurveFinishDate + 1;

                                            until HoursPerDay > 0;
                                        end
                                        else begin
                                            LCurveStartTime := LCurveStartTime + 60 * 60 * 1000 * LcurveTemp;
                                            LcurveTemp -= LcurveTemp;
                                        end;
                                    until LcurveTemp <= 0;

                                    LCurveFinishTime := LCurveStartTime;
                                end;
                            end;
                        end;

                        repeat

                            //Get working hours for the day
                            HoursPerDay := 0;
                            Holiday := 'No';
                            TempHours := 0;
                            Rate := 0;
                            ResCapacityEntryRec.Reset();
                            ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                            ResCapacityEntryRec.SETRANGE(Date, TempDate);
                            if ResCapacityEntryRec.FindSet() then begin
                                repeat
                                    HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                until ResCapacityEntryRec.Next() = 0;
                            end;

                            if HoursPerDay = 0 then begin

                                //Validate the day (Holiday or Weekend)
                                SHCalHolidayRec.Reset();
                                SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                SHCalHolidayRec.SETRANGE(Date, TempDate);

                                if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                    DayForWeek.Get(DayForWeek."Period Type"::Date, TempDate);

                                    case DayForWeek."Period No." of
                                        1:
                                            Day := 0;
                                        2:
                                            Day := 1;
                                        3:
                                            Day := 2;
                                        4:
                                            Day := 3;
                                        5:
                                            Day := 4;
                                        6:
                                            Day := 5;
                                        7:
                                            Day := 6;
                                    end;

                                    SHCalWorkRec.Reset();
                                    SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                    SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                    if SHCalWorkRec.FindSet() then   //If not weekend
                                        Error('Calender for date : %1  Work center : %2 has not calculated', TempDate, ResourceRec.Name)
                                    else
                                        Holiday := 'Yes';
                                end
                                else
                                    Holiday := 'Yes';
                            end;

                            //No learning curve for holidays
                            if HoursPerDay > 0 then
                                i += 1;

                            if (i = 1) and (HoursPerDay > 0) then begin
                                //Calculate hours for the first day (substracti hours if delay start)
                                HoursPerDay := HoursPerDay - (TImeStart - LocationRec."Start Time") / 3600000;
                            end;

                            if JobPlaLineRec."Learning Curve No." <> 0 then begin

                                //Aplly learning curve
                                LearningCurveRec.Reset();
                                LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                if LearningCurveRec.FindSet() then begin   //Efficiency wise

                                    if LearningCurveRec.Type = LearningCurveRec.Type::"Efficiency Wise" then begin
                                        case i of
                                            1:
                                                Rate := LearningCurveRec.Day1;
                                            2:
                                                Rate := LearningCurveRec.Day2;
                                            3:
                                                Rate := LearningCurveRec.Day3;
                                            4:
                                                Rate := LearningCurveRec.Day4;
                                            5:
                                                Rate := LearningCurveRec.Day5;
                                            6:
                                                Rate := LearningCurveRec.Day6;
                                            7:
                                                Rate := LearningCurveRec.Day7;
                                            else
                                                Rate := 100;
                                        end;

                                        if Rate = 0 then
                                            Rate := 100;

                                        if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < JobPlaLineRec.Qty) then begin
                                            TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                            xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                        end
                                        else begin
                                            TempQty1 := JobPlaLineRec.Qty - TempQty;
                                            TempQty := TempQty + TempQty1;
                                            TempHours := TempQty1 / TargetPerHour;
                                            xQty := TempQty1;

                                            // if (TempHours IN [0.0001 .. 0.99]) then
                                            //     TempHours := 1;

                                            // TempHours := round(TempHours, 1, '>');
                                            TempHours := round(TempHours, 0.01);

                                        end;
                                    end
                                    else begin  //Hourly

                                        Rate := 100;
                                        LcurveHoursPerday := 0;
                                        LCurveStartTimePerDay := 0T;

                                        if LCurveFinishDate > TempDate then begin
                                            LcurveHoursPerday := HoursPerDay;   //Hourly target calculation purpose

                                            if LcurveHoursPerday = 0 then
                                                LCurveStartTimePerDay := 0T
                                            else begin
                                                if i = 1 then
                                                    LCurveStartTimePerDay := LCurveStartTime
                                                else
                                                    LCurveStartTimePerDay := LocationRec."Start Time";
                                            end;
                                            HoursPerDay := 0;
                                        end
                                        else begin
                                            if LCurveFinishDate = TempDate then begin
                                                if i = 1 then begin
                                                    if ((LCurveFinishTime - TImeStart) / 3600000) < 0 then begin

                                                        LcurveHoursPerday := (TImeStart - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                        if LcurveHoursPerday = 0 then
                                                            LCurveStartTimePerDay := 0T
                                                        else
                                                            LCurveStartTimePerDay := TImeStart;

                                                        HoursPerDay := HoursPerDay - (TImeStart - LCurveFinishTime) / 3600000;
                                                    end
                                                    else begin

                                                        LcurveHoursPerday := (LCurveFinishTime - TImeStart) / 3600000;   //Hourly target calculation purpose
                                                        if LcurveHoursPerday = 0 then
                                                            LCurveStartTimePerDay := 0T
                                                        else
                                                            LCurveStartTimePerDay := TImeStart;

                                                        HoursPerDay := HoursPerDay - (LCurveFinishTime - TImeStart) / 3600000;
                                                    end;
                                                end
                                                else begin
                                                    if ((LCurveFinishTime - LocationRec."Start Time") / 3600000) < 0 then begin

                                                        LcurveHoursPerday := (LocationRec."Start Time" - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                        if LcurveHoursPerday = 0 then
                                                            LCurveStartTimePerDay := 0T
                                                        else
                                                            LCurveStartTimePerDay := LocationRec."Start Time";

                                                        HoursPerDay := HoursPerDay - (LocationRec."Start Time" - LCurveFinishTime) / 3600000;
                                                    end
                                                    else begin

                                                        LcurveHoursPerday := (LCurveFinishTime - LocationRec."Start Time") / 3600000;   //Hourly target calculation purpose
                                                        if LcurveHoursPerday = 0 then
                                                            LCurveStartTimePerDay := 0T
                                                        else
                                                            LCurveStartTimePerDay := LocationRec."Start Time";

                                                        HoursPerDay := HoursPerDay - (LCurveFinishTime - LocationRec."Start Time") / 3600000;
                                                    end;
                                                end;
                                            end;
                                        end;

                                        if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < JobPlaLineRec.Qty) then begin
                                            TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                            xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                        end
                                        else begin
                                            TempQty1 := JobPlaLineRec.Qty - TempQty;
                                            xQty := TempQty1;
                                            TempQty := TempQty + TempQty1;
                                            TempHours := TempQty1 / TargetPerHour;

                                            // if (TempHours IN [0.0001 .. 0.99]) then
                                            //     TempHours := 1;

                                            // TempHours := round(TempHours, 1, '>');
                                            TempHours := round(TempHours, 0.01);
                                        end;
                                    end;
                                end;
                            end
                            else begin
                                if (TempQty + round((TargetPerHour * HoursPerDay), 1)) < JobPlaLineRec.Qty then begin
                                    TempQty += round((TargetPerHour * HoursPerDay), 1);
                                    xQty := round(TargetPerHour * HoursPerDay, 1);
                                end
                                else begin
                                    TempQty1 := JobPlaLineRec.Qty - TempQty;
                                    TempQty := TempQty + TempQty1;
                                    TempHours := TempQty1 / TargetPerHour;
                                    xQty := TempQty1;

                                    // if (TempHours IN [0.0001 .. 0.99]) then
                                    //     TempHours := 1;

                                    // TempHours := round(TempHours, 1, '>');
                                    TempHours := round(TempHours, 0.01);
                                end;
                            end;

                            xQty := Round(xQty, 1);

                            //Get Max Lineno
                            MaxLineNo := 0;
                            ProdPlansDetails.Reset();
                            if ProdPlansDetails.FindLast() then
                                MaxLineNo := ProdPlansDetails."No.";

                            MaxLineNo += 1;
                            FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, TempDate, LocationRec."Start Time");

                            //insert to ProdPlansDetails
                            ProdPlansDetails.Init();
                            ProdPlansDetails."No." := MaxLineNo;
                            ProdPlansDetails.PlanDate := TempDate;
                            ProdPlansDetails."Style No." := JobPlaLineRec."Style No.";
                            ProdPlansDetails."Style Name" := JobPlaLineRec."Style Name";
                            ProdPlansDetails."PO No." := JobPlaLineRec."PO No.";
                            ProdPlansDetails."lot No." := JobPlaLineRec."lot No.";
                            ProdPlansDetails."Line No." := LineNo;
                            ProdPlansDetails."Resource No." := ResourceNo;
                            ProdPlansDetails.Carder := Carder;
                            ProdPlansDetails.Eff := Eff;
                            // ProdPlansDetails."Learning Curve No." := JobPlaLineRec."Learning Curve No.";
                            ProdPlansDetails.SMV := JobPlaLineRec.SMV;

                            if Holiday = 'NO' then begin
                                if i = 1 then
                                    ProdPlansDetails."Start Time" := TImeStart
                                else
                                    ProdPlansDetails."Start Time" := LocationRec."Start Time";

                                if TempHours = 0 then
                                    ProdPlansDetails."Finish Time" := FactoryFinishTime
                                else begin
                                    if i = 1 then
                                        ProdPlansDetails."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                    else
                                        ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                end;
                            end;

                            ProdPlansDetails.Qty := xQty;
                            ProdPlansDetails.Target := TargetPerDay;

                            if Holiday = 'NO' then
                                if TempHours > 0 then
                                    ProdPlansDetails.HoursPerDay := TempHours
                                else
                                    ProdPlansDetails.HoursPerDay := HoursPerDay
                            else
                                ProdPlansDetails.HoursPerDay := 0;

                            if Holiday = 'YES' then begin
                                ProdPlansDetails."LCurve Hours Per Day" := 0;
                                ProdPlansDetails."LCurve Start Time" := 0T;
                                ProdPlansDetails."Learning Curve No." := 0;
                            end
                            else begin
                                ProdPlansDetails."LCurve Hours Per Day" := LcurveHoursPerday;
                                ProdPlansDetails."LCurve Start Time" := LCurveStartTimePerDay;

                                if ProdPlansDetails."LCurve Hours Per Day" = 0 then
                                    ProdPlansDetails."Learning Curve No." := 0
                                else
                                    ProdPlansDetails."Learning Curve No." := JobPlaLineRec."Learning Curve No.";
                            end;

                            ProdPlansDetails.ProdUpd := 0;
                            ProdPlansDetails.ProdUpdQty := 0;
                            ProdPlansDetails."Created User" := UserId;
                            ProdPlansDetails."Created Date" := WorkDate();
                            ProdPlansDetails."Factory No." := FactoryNo;
                            ProdPlansDetails.Insert();

                            TempDate := TempDate + 1;

                        until (TempQty >= JobPlaLineRec.Qty);

                        TempDate := TempDate - 1;

                        if TempHours = 0 then
                            TempDate := TempDate - 1;

                        //Insert to the Planning line table
                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetRange("Line No.", LineNo);
                        JobPlaLineRec.FindSet();
                        JobPlaLineRec."Resource No." := ResourceNo;
                        JobPlaLineRec."Resource Name" := ResourceName;
                        JobPlaLineRec."Start Date" := dtStart;
                        JobPlaLineRec."End Date" := TempDate;
                        JobPlaLineRec."Start Time" := TImeStart;

                        if TempHours = 0 then
                            JobPlaLineRec."Finish Time" := FactoryFinishTime
                        else begin
                            if i = 1 then
                                if (FactoryFinishTime < TImeStart + 60 * 60 * 1000 * TempHours) then
                                    JobPlaLineRec."Finish Time" := FactoryFinishTime
                                else
                                    JobPlaLineRec."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                            else
                                JobPlaLineRec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                        end;

                        // if TempHours = 0 then
                        //     JobPlaLineRec."Finish Time" := LocationRec."Finish Time"
                        // else
                        //     JobPlaLineRec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;

                        JobPlaLineRec."Created User" := UserId;
                        JobPlaLineRec."Created Date" := WorkDate();
                        JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                        JobPlaLineRec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLineRec."Finish Time");
                        JobPlaLineRec.Modify();
                        IsInserted := true;
                        TempTIme := JobPlaLineRec."Finish Time";
                        Prev_FinishedDateTime := JobPlaLineRec.FinishDateTime;


                        // ///////////////////Check whether new allocation conflicts other allocation  
                        TempHours := 0;

                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetRange("Resource No.", ResourceNo);
                        JobPlaLineRec.SetFilter("StartDateTime", '>=%1', CreateDateTime(dtStart, JobPlaLineRec."Start Time"));
                        JobPlaLineRec.SetCurrentKey(StartDateTime);
                        JobPlaLineRec.Ascending(true);
                        JobPlaLineRec.SetFilter("Line No.", '<>%1', LineNo);
                        if JobPlaLineRec.FindSet() then begin

                            HoursPerDay := 0;
                            i := 0;
                            N1 := 0;
                            TempQty := 0;
                            RowCount1 := JobPlaLineRec.Count;
                            StartTime2 := JobPlaLineRec."Start Time";

                            if RowCount1 > 0 then begin

                                //Clear all Array data
                                for N1 := 1 To 100 do begin
                                    ArrayOfAllocations[N1] := 0;
                                end;

                                N1 := 0;
                                //Assign all line no of the work center line
                                repeat
                                    N1 += 1;
                                    ArrayOfAllocations[N1] := JobPlaLineRec."Line No.";
                                until JobPlaLineRec.Next() = 0;

                                N1 := 0;
                                for N1 := 1 To RowCount1 do begin

                                    HoursGap := 0;
                                    TempHours := 0;
                                    JobPlaLineRec.Reset();
                                    JobPlaLineRec.SetRange("Resource No.", ResourceNo);
                                    JobPlaLineRec.SetFilter("Line No.", '=%1', ArrayOfAllocations[N1]);
                                    if JobPlaLineRec.FindSet() then begin

                                        i := 0;
                                        Qty := JobPlaLineRec.Qty;
                                        LineNo := JobPlaLineRec."Line No.";
                                        SMV := JobPlaLineRec.SMV;

                                        if JobPlaLineRec.Carder <> 0 then
                                            Carder := JobPlaLineRec.Carder;

                                        if JobPlaLineRec.Eff <> 0 then
                                            Eff := JobPlaLineRec.Eff;

                                        dtStart := TempDate;
                                        TImeStart := TempTIme;
                                        Curr_StartDateTime := JobPlaLineRec.StartDateTime;

                                        //Calculate hourly gap between prevous and current allocation
                                        if Prev_FinishedDateTime <> 0DT then begin
                                            if DT2DATE(Prev_FinishedDateTime) = DT2DATE(Curr_StartDateTime) then
                                                HoursGap := 0
                                            else begin

                                                XX := (DT2DATE(Curr_StartDateTime) - DT2DATE(Prev_FinishedDateTime) + 1);
                                                HoursPerDay2 := 0;

                                                for X := 1 To XX do begin
                                                    HoursPerDay1 := 0;
                                                    ResCapacityEntryRec.Reset();
                                                    ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                    ResCapacityEntryRec.SETRANGE(Date, DT2DATE(Prev_FinishedDateTime) + (X - 1));

                                                    if ResCapacityEntryRec.FindSet() then begin
                                                        repeat
                                                            HoursPerDay1 += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                        until ResCapacityEntryRec.Next() = 0;
                                                    end;

                                                    FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, DT2DATE(Prev_FinishedDateTime) + (X - 1), LocationRec."Start Time");

                                                    if HoursPerDay1 > 0 then begin
                                                        if X = 1 then  //First Date
                                                            HoursGap := CREATEDATETIME(DT2DATE(Prev_FinishedDateTime), FactoryFinishTime) - Prev_FinishedDateTime
                                                        else
                                                            if X = XX then  //Last date
                                                                HoursGap := HoursGap + (Curr_StartDateTime - CREATEDATETIME(DT2DATE(Curr_StartDateTime), LocationRec."start Time"))
                                                            else
                                                                HoursPerDay2 := HoursPerDay2 + HoursPerDay1;
                                                    end;
                                                end;

                                                HoursGap := HoursGap / 3600000;

                                                if (HoursGap IN [0.0001 .. 0.99]) then
                                                    HoursGap := 1;

                                                HoursGap := round(HoursGap, 1, '>');
                                                HoursGap := HoursGap + HoursPerDay2;
                                            end;
                                        end;

                                        if HoursGap < 30 then
                                            HoursGap := 0;

                                        //Based on Hourly Gap, calculate start Date/time of current allocation 
                                        if HoursGap > 0 then begin

                                            ddddddtttt := CREATEDATETIME(dtStart, TImeStart);
                                            FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtStart, LocationRec."Start Time");

                                            if (CREATEDATETIME(dtStart, FactoryFinishTime) <= (ddddddtttt + (60 * 60 * 1000 * HoursGap))) then begin

                                                HoursGap := HoursGap - (FactoryFinishTime - TImeStart) / 3600000;
                                                TImeStart := LocationRec."Start Time";
                                                dtStart := dtStart + 1;

                                                if HoursGap > 0 then begin
                                                    repeat

                                                        //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                        repeat
                                                            HoursPerDay := 0;
                                                            WorkCenCapacityEntryRec.Reset();
                                                            WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                            WorkCenCapacityEntryRec.SETRANGE(Date, dtStart);
                                                            if WorkCenCapacityEntryRec.FindSet() then begin
                                                                repeat
                                                                    HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                                until WorkCenCapacityEntryRec.Next() = 0;
                                                            end
                                                            else begin
                                                                Count := 0;
                                                                dtNextMonth := CalcDate('<+1M>', dtStart);
                                                                dtSt := CalcDate('<-CM>', dtNextMonth);
                                                                dtEd := CalcDate('<+CM>', dtNextMonth);

                                                                WorkCenCapacityEntryRec.Reset();
                                                                WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                                WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                                                if WorkCenCapacityEntryRec.FindSet() then
                                                                    Count += WorkCenCapacityEntryRec.Count;

                                                                if Count < 14 then
                                                                    Error('Calender is not setup for the Line : %1', ResourceName);
                                                            end;

                                                            if HoursPerDay = 0 then
                                                                dtStart := dtStart + 1;

                                                        until HoursPerDay > 0;

                                                        if (HoursPerDay > HoursGap) then begin
                                                            TImeStart := TImeStart + (60 * 60 * 1000 * HoursGap);
                                                            HoursGap := 0;
                                                        end
                                                        else begin
                                                            HoursGap := HoursGap - HoursPerDay;
                                                            dtStart := dtStart + 1;
                                                        end;

                                                    until HoursGap = 0;
                                                end
                                            end
                                            else begin
                                                TImeStart := TImeStart + (60 * 60 * 1000 * HoursGap);
                                                HoursGap := 0;
                                            end;

                                            TempDate := dtStart;
                                        end;

                                        HoursPerDay := 0;
                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtStart, LocationRec."Start Time");

                                        //if start time greater than parameter Finish time, set start time next day morning
                                        if ((TImeStart - FactoryFinishTime) >= 0) then begin
                                            TImeStart := LocationRec."Start Time";
                                            dtStart := dtStart + 1;
                                            TempDate := dtStart;
                                        end;

                                        //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                        repeat

                                            WorkCenCapacityEntryRec.Reset();
                                            WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                            WorkCenCapacityEntryRec.SETRANGE(Date, dtStart);
                                            if WorkCenCapacityEntryRec.FindSet() then begin
                                                repeat
                                                    HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                until WorkCenCapacityEntryRec.Next() = 0;
                                            end
                                            else begin
                                                Count := 0;
                                                dtNextMonth := CalcDate('<+1M>', dtStart);
                                                dtSt := CalcDate('<-CM>', dtNextMonth);
                                                dtEd := CalcDate('<+CM>', dtNextMonth);

                                                WorkCenCapacityEntryRec.Reset();
                                                WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                                if WorkCenCapacityEntryRec.FindSet() then
                                                    Count += WorkCenCapacityEntryRec.Count;

                                                if Count < 14 then
                                                    Error('Calender is not setup for the Line : %1', ResourceName);
                                            end;

                                            if HoursPerDay = 0 then
                                                dtStart := dtStart + 1;

                                        until HoursPerDay > 0;

                                        TargetPerDay := round(((60 / SMV) * Carder * HoursPerDay * Eff) / 100, 1);
                                        TargetPerHour := round(TargetPerDay / HoursPerDay, 1);
                                        TempQty := 0;

                                        //Delete old lines
                                        ProdPlansDetails.Reset();
                                        ProdPlansDetails.SetRange("Line No.", LineNo);
                                        ProdPlansDetails.SetFilter(ProdUpd, '=%1', 0);
                                        if ProdPlansDetails.FindSet() then
                                            ProdPlansDetails.DeleteAll();

                                        //Check learning curve                        
                                        LCurveFinishDate := TempDate;
                                        LCurveFinishTime := TImeStart;
                                        LCurveStartTime := TImeStart;

                                        if JobPlaLineRec."Learning Curve No." <> 0 then begin
                                            LearningCurveRec.Reset();
                                            LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                            if LearningCurveRec.FindSet() then begin

                                                if LearningCurveRec.Type = LearningCurveRec.Type::Hourly then begin
                                                    LcurveTemp := LearningCurveRec.Day1;

                                                    repeat
                                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, LCurveFinishDate, LocationRec."Start Time");

                                                        if ((FactoryFinishTime - LCurveStartTime) / 3600000 <= LcurveTemp) then begin
                                                            LcurveTemp -= (FactoryFinishTime - LCurveStartTime) / 3600000;
                                                            LCurveStartTime := LocationRec."Start Time";
                                                            LCurveFinishDate += 1;

                                                            //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                            HoursPerDay := 0;
                                                            repeat
                                                                ResCapacityEntryRec.Reset();
                                                                ResCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                                ResCapacityEntryRec.SETRANGE(Date, LCurveFinishDate);
                                                                if ResCapacityEntryRec.FindSet() then begin
                                                                    repeat
                                                                        HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                                    until ResCapacityEntryRec.Next() = 0;
                                                                end;

                                                                if HoursPerDay = 0 then begin

                                                                    //Validate the day (Holiday or Weekend)
                                                                    SHCalHolidayRec.Reset();
                                                                    SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                                    SHCalHolidayRec.SETRANGE(Date, LCurveFinishDate);
                                                                    if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                                        DayForWeek.Get(DayForWeek."Period Type"::Date, LCurveFinishDate);

                                                                        case DayForWeek."Period No." of
                                                                            1:
                                                                                Day := 0;
                                                                            2:
                                                                                Day := 1;
                                                                            3:
                                                                                Day := 2;
                                                                            4:
                                                                                Day := 3;
                                                                            5:
                                                                                Day := 4;
                                                                            6:
                                                                                Day := 5;
                                                                            7:
                                                                                Day := 6;
                                                                        end;

                                                                        SHCalWorkRec.Reset();
                                                                        SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                                        SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                                        if SHCalWorkRec.FindSet() then   //If not weekend
                                                                            Error('Calender for date : %1  Work center : %2 has not calculated', LCurveFinishDate, ResourceRec.Name);
                                                                    end;
                                                                end;

                                                                if HoursPerDay = 0 then
                                                                    LCurveFinishDate := LCurveFinishDate + 1;

                                                            until HoursPerDay > 0;
                                                        end
                                                        else begin
                                                            LCurveStartTime := LCurveStartTime + 60 * 60 * 1000 * LcurveTemp;
                                                            LcurveTemp -= LcurveTemp;
                                                        end;
                                                    until LcurveTemp <= 0;

                                                    LCurveFinishTime := LCurveStartTime;
                                                end;
                                            end;
                                        end;

                                        repeat
                                            ResourceRec.Reset();
                                            ResourceRec.SetRange("No.", ResourceNo);
                                            ResourceRec.FindSet();

                                            //Get working hours for the day
                                            HoursPerDay := 0;
                                            Rate := 0;
                                            TempHours := 0;
                                            Holiday := 'No';

                                            WorkCenCapacityEntryRec.Reset();
                                            WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                            WorkCenCapacityEntryRec.SETRANGE(Date, TempDate);
                                            if WorkCenCapacityEntryRec.FindSet() then begin
                                                repeat
                                                    HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                until WorkCenCapacityEntryRec.Next() = 0;
                                            end
                                            else begin
                                                Count := 0;
                                                dtNextMonth := CalcDate('<+1M>', TempDate);
                                                dtSt := CalcDate('<-CM>', dtNextMonth);
                                                dtEd := CalcDate('<+CM>', dtNextMonth);

                                                WorkCenCapacityEntryRec.Reset();
                                                WorkCenCapacityEntryRec.SETRANGE("No.", ResourceNo);
                                                WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                                if WorkCenCapacityEntryRec.FindSet() then
                                                    Count += WorkCenCapacityEntryRec.Count;

                                                if Count < 14 then
                                                    Error('Calender is not setup for the Line : %1', ResourceName);
                                            end;

                                            if HoursPerDay = 0 then begin

                                                //Validate the day (Holiday or Weekend)
                                                SHCalHolidayRec.Reset();
                                                SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                SHCalHolidayRec.SETRANGE(Date, TempDate);
                                                if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                    DayForWeek.Get(DayForWeek."Period Type"::Date, TempDate);

                                                    case DayForWeek."Period No." of
                                                        1:
                                                            Day := 0;
                                                        2:
                                                            Day := 1;
                                                        3:
                                                            Day := 2;
                                                        4:
                                                            Day := 3;
                                                        5:
                                                            Day := 4;
                                                        6:
                                                            Day := 5;
                                                        7:
                                                            Day := 6;
                                                    end;

                                                    SHCalWorkRec.Reset();
                                                    SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                    SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                    if SHCalWorkRec.FindSet() then   //If not weekend
                                                        Error('Calender for date : %1  Work center : %2 has not calculated', TempDate, ResourceRec.Name)
                                                    else
                                                        Holiday := 'Yes';
                                                end
                                                else
                                                    Holiday := 'Yes';
                                            end;

                                            //No learning curve for holidays
                                            if HoursPerDay > 0 then
                                                i += 1;

                                            if (i = 1) and (HoursPerDay > 0) then begin
                                                //Calculate hours for the first day (substracti hours if delay start)
                                                HoursPerDay := HoursPerDay - (TImeStart - LocationRec."Start Time") / 3600000;
                                            end;

                                            if JobPlaLineRec."Learning Curve No." <> 0 then begin

                                                //Aplly learning curve
                                                LearningCurveRec.Reset();
                                                LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                                if LearningCurveRec.FindSet() then begin

                                                    if LearningCurveRec.Type = LearningCurveRec.Type::"Efficiency Wise" then begin  //Efficiency wise
                                                        case i of
                                                            1:
                                                                Rate := LearningCurveRec.Day1;
                                                            2:
                                                                Rate := LearningCurveRec.Day2;
                                                            3:
                                                                Rate := LearningCurveRec.Day3;
                                                            4:
                                                                Rate := LearningCurveRec.Day4;
                                                            5:
                                                                Rate := LearningCurveRec.Day5;
                                                            6:
                                                                Rate := LearningCurveRec.Day6;
                                                            7:
                                                                Rate := LearningCurveRec.Day7;
                                                            else
                                                                Rate := 100;
                                                        end;

                                                        if Rate = 0 then
                                                            Rate := 100;

                                                        if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < Qty) then begin
                                                            TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                            xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                        end
                                                        else begin
                                                            TempQty1 := Qty - TempQty;
                                                            TempQty := TempQty + TempQty1;
                                                            TempHours := TempQty1 / TargetPerHour;
                                                            xQty := TempQty1;

                                                            // if (TempHours IN [0.0001 .. 0.99]) then
                                                            //     TempHours := 1;

                                                            // TempHours := round(TempHours, 1, '>');
                                                            TempHours := round(TempHours, 0.01);
                                                        end;
                                                    end
                                                    else begin  //Hourly

                                                        Rate := 100;
                                                        LcurveHoursPerday := 0;
                                                        LCurveStartTimePerDay := 0T;

                                                        if LCurveFinishDate > TempDate then begin
                                                            LcurveHoursPerday := HoursPerDay;   //Hourly target calculation purpose

                                                            if LcurveHoursPerday = 0 then
                                                                LCurveStartTimePerDay := 0T
                                                            else begin
                                                                if i = 1 then
                                                                    LCurveStartTimePerDay := LCurveStartTime
                                                                else
                                                                    LCurveStartTimePerDay := LocationRec."Start Time";
                                                            end;

                                                            HoursPerDay := 0;
                                                        end
                                                        else begin
                                                            if LCurveFinishDate = TempDate then begin

                                                                if i = 1 then begin
                                                                    if ((LCurveFinishTime - TImeStart) / 3600000) < 0 then begin

                                                                        LcurveHoursPerday := (TImeStart - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                                        if LcurveHoursPerday = 0 then
                                                                            LCurveStartTimePerDay := 0T
                                                                        else
                                                                            LCurveStartTimePerDay := TImeStart;

                                                                        HoursPerDay := HoursPerDay - (TImeStart - LCurveFinishTime) / 3600000;
                                                                    end
                                                                    else begin

                                                                        LcurveHoursPerday := (LCurveFinishTime - TImeStart) / 3600000;   //Hourly target calculation purpose
                                                                        if LcurveHoursPerday = 0 then
                                                                            LCurveStartTimePerDay := 0T
                                                                        else
                                                                            LCurveStartTimePerDay := TImeStart;

                                                                        HoursPerDay := HoursPerDay - (LCurveFinishTime - TImeStart) / 3600000;
                                                                    end;
                                                                end
                                                                else begin
                                                                    if ((LCurveFinishTime - LocationRec."Start Time") / 3600000) < 0 then begin

                                                                        LcurveHoursPerday := (LocationRec."Start Time" - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                                        if LcurveHoursPerday = 0 then
                                                                            LCurveStartTimePerDay := 0T
                                                                        else
                                                                            LCurveStartTimePerDay := LocationRec."Start Time";

                                                                        HoursPerDay := HoursPerDay - (LocationRec."Start Time" - LCurveFinishTime) / 3600000;
                                                                    end
                                                                    else begin
                                                                        LcurveHoursPerday := (LCurveFinishTime - LocationRec."Start Time") / 3600000;   //Hourly target calculation purpose
                                                                        if LcurveHoursPerday = 0 then
                                                                            LCurveStartTimePerDay := 0T
                                                                        else
                                                                            LCurveStartTimePerDay := LocationRec."Start Time";

                                                                        HoursPerDay := HoursPerDay - (LCurveFinishTime - LocationRec."Start Time") / 3600000;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;

                                                        if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < Qty) then begin
                                                            TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                            xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                        end
                                                        else begin
                                                            TempQty1 := Qty - TempQty;
                                                            xQty := TempQty1;
                                                            TempQty := TempQty + TempQty1;
                                                            TempHours := TempQty1 / TargetPerHour;

                                                            // if (TempHours IN [0.0001 .. 0.99]) then
                                                            //     TempHours := 1;

                                                            // TempHours := round(TempHours, 1, '>');
                                                            TempHours := round(TempHours, 0.01);
                                                        end;
                                                    end;
                                                end;
                                            end
                                            else begin
                                                if (TempQty + (TargetPerHour * HoursPerDay)) < Qty then begin
                                                    TempQty += (TargetPerHour * HoursPerDay);
                                                    xQty := TargetPerHour * HoursPerDay;
                                                end
                                                else begin
                                                    TempQty1 := Qty - TempQty;
                                                    TempQty := TempQty + TempQty1;
                                                    TempHours := TempQty1 / TargetPerHour;
                                                    xQty := TempQty1;

                                                    // if (TempHours IN [0.0001 .. 0.99]) then
                                                    //     TempHours := 1;

                                                    // TempHours := round(TempHours, 1, '>');
                                                    TempHours := round(TempHours, 0.01);
                                                end;
                                            end;

                                            //Get Max Lineno
                                            MaxLineNo := 0;
                                            ProdPlansDetails.Reset();

                                            if ProdPlansDetails.FindLast() then
                                                MaxLineNo := ProdPlansDetails."No.";

                                            MaxLineNo += 1;
                                            FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, TempDate, LocationRec."Start Time");

                                            //insert to ProdPlansDetails
                                            ProdPlansDetails.Init();
                                            ProdPlansDetails."No." := MaxLineNo;
                                            ProdPlansDetails.PlanDate := TempDate;
                                            ProdPlansDetails."Style No." := JobPlaLineRec."Style No.";
                                            ProdPlansDetails."Style Name" := JobPlaLineRec."Style Name";
                                            ProdPlansDetails."PO No." := JobPlaLineRec."PO No.";
                                            ProdPlansDetails."Lot No." := JobPlaLineRec."Lot No.";
                                            ProdPlansDetails."Line No." := LineNo;
                                            ProdPlansDetails."Resource No." := ResourceNo;
                                            ProdPlansDetails.Carder := Carder;
                                            ProdPlansDetails.Eff := Eff;
                                            //ProdPlansDetails."Learning Curve No." := JobPlaLineRec."Learning Curve No.";
                                            ProdPlansDetails.SMV := JobPlaLineRec.SMV;

                                            if Holiday = 'NO' then begin
                                                if i = 1 then
                                                    ProdPlansDetails."Start Time" := TImeStart
                                                else
                                                    ProdPlansDetails."Start Time" := LocationRec."Start Time";

                                                if TempHours = 0 then
                                                    ProdPlansDetails."Finish Time" := FactoryFinishTime
                                                else begin
                                                    if i = 1 then
                                                        if (FactoryFinishTime < TImeStart + 60 * 60 * 1000 * TempHours) then
                                                            ProdPlansDetails."Finish Time" := FactoryFinishTime
                                                        else
                                                            ProdPlansDetails."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                                    else
                                                        ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                                end;
                                            end;

                                            ProdPlansDetails.Qty := xQty;
                                            ProdPlansDetails.Target := TargetPerDay;
                                            // ProdPlansDetails.HoursPerDay := HoursPerDay;

                                            if Holiday = 'NO' then
                                                if TempHours > 0 then
                                                    ProdPlansDetails.HoursPerDay := TempHours
                                                else
                                                    ProdPlansDetails.HoursPerDay := HoursPerDay
                                            else
                                                ProdPlansDetails.HoursPerDay := 0;

                                            if Holiday = 'YES' then begin
                                                ProdPlansDetails."LCurve Hours Per Day" := 0;
                                                ProdPlansDetails."LCurve Start Time" := 0T;
                                                ProdPlansDetails."Learning Curve No." := 0;
                                            end
                                            else begin
                                                ProdPlansDetails."LCurve Hours Per Day" := LcurveHoursPerday;
                                                ProdPlansDetails."LCurve Start Time" := LCurveStartTimePerDay;

                                                if ProdPlansDetails."LCurve Hours Per Day" = 0 then
                                                    ProdPlansDetails."Learning Curve No." := 0
                                                else
                                                    ProdPlansDetails."Learning Curve No." := JobPlaLineRec."Learning Curve No.";
                                            end;

                                            ProdPlansDetails.ProdUpd := 0;
                                            ProdPlansDetails.ProdUpdQty := 0;
                                            ProdPlansDetails."Created User" := UserId;
                                            ProdPlansDetails."Created Date" := WorkDate();
                                            ProdPlansDetails."Factory No." := JobPlaLineRec.Factory;
                                            ProdPlansDetails.Insert();

                                            TempDate := TempDate + 1;

                                        until (TempQty >= Qty);

                                        TempDate := TempDate - 1;

                                        if TempHours = 0 then
                                            TempDate := TempDate - 1;

                                        //modift the line
                                        JobPlaLine2Rec.Reset();
                                        JobPlaLine2Rec.SetRange("Line No.", LineNo);
                                        JobPlaLine2Rec.FindSet();

                                        JobPlaLine2Rec."Start Date" := dtStart;
                                        JobPlaLine2Rec."End Date" := TempDate;
                                        JobPlaLine2Rec."Start Time" := TImeStart;

                                        if TempHours = 0 then
                                            JobPlaLine2Rec."Finish Time" := FactoryFinishTime
                                        else begin
                                            if i = 1 then
                                                if (FactoryFinishTime < TImeStart + 60 * 60 * 1000 * TempHours) then
                                                    JobPlaLine2Rec."Finish Time" := FactoryFinishTime
                                                else
                                                    JobPlaLine2Rec."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                            else
                                                JobPlaLine2Rec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                        end;

                                        JobPlaLine2Rec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                                        JobPlaLine2Rec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLine2Rec."Finish Time");
                                        JobPlaLine2Rec.Qty := Qty;
                                        //JobPlaLine2Rec.Factory := FactoryNo;

                                        Prev_FinishedDateTime := JobPlaLine2Rec.FinishDateTime;
                                        // Prev_FinishedDateTime := JobPlaLineRec.FinishDateTime;
                                        JobPlaLine2Rec.Modify();

                                        TempTIme := JobPlaLine2Rec."Finish Time";

                                        //delete allocation if remaining qty is 0 or less than 0
                                        JobPlaLine2Rec.Reset();
                                        JobPlaLine2Rec.SetRange("Line No.", LineNo);

                                        if JobPlaLine2Rec.FindSet() then begin
                                            if JobPlaLine2Rec.Qty <= 0 then
                                                JobPlaLine2Rec.DeleteAll();
                                        end;

                                    end;

                                    StartTime2 := JobPlaLine2Rec."Start Time";
                                    LineNo := JobPlaLineRec."Line No.";
                                end;
                            end;
                        end;
                        //end;

                        LoadData(false, false, true, true, false);

                    end;
                end;


                trigger OnSelectionChanged(eventArgs: JsonObject)
                var
                    _jsonToken: JsonToken;
                    _objectType: Integer;
                    _objectID: Text;
                    _visualType: Integer;
                begin
                    if (eventArgs.Get('ObjectType', _jsonToken)) then
                        _objectType := _jsonToken.AsValue().AsInteger()
                    else
                        _objectType := 0;

                    if (eventArgs.Get('ObjectID', _jsonToken)) then
                        _objectID := _jsonToken.AsValue().AsText()
                    else
                        _objectID := '';

                    if (eventArgs.Get('VisualType', _jsonToken)) then
                        _visualType := _jsonToken.AsValue().AsInteger()
                    else
                        _visualType := -1;

                    // Message('Event OnSelectionChanged:\ObjectType: ' + Format(_objectType) + '\ObjectID: ' + _objectID +
                    //         '\VisualType: ' + Format(_visualType));
                end;

                trigger OnContextMenuItemClicked(eventArgs: JsonObject)
                var
                    _jsonToken: JsonToken;
                    _tempText: Text;
                    _tempJsonValue: JsonValue;
                    _contextMenuID: Text;
                    _objectType: Integer;
                    _objectID: Text;
                    _contextMenuItemCode: Text;
                    _visualType: Integer;
                    _date: DateTime;

                    //JobPlaLineRec: Record "Job Planning Line";
                    SplitMoreCard: Page "Split More Card";
                    SplitCard: Page "Split Card";
                    PlanningQueueRec: Record "Planning Queue";
                    PlanningQueueNewRec: Record "Planning Queue";
                    PlanningLinesRec: Record "NavApp Planning Lines";
                    ProdPlanDetRec: Record "NavApp Prod Plans Details";
                    StyleMasterPORec: Record "Style Master PO";
                    StyleMasterRec: Record "Style Master";
                    ResCapacityEntryRec: Record "Calendar Entry";
                    LocationRec: Record Location;
                    PlanTargetList: Page "Plan Target List part";
                    PlanHistoryList: Page "Plan History List part";
                    PlanTargetVsAchList: Page "Plan Target Vs Acheive";
                    AccessoriesStatusReportNew: Report AccessoriesStatusReportNew;
                    WIPReport: Report WIPReport;
                    SizeColorWiseQtyBrReport: Report SizeColourwiseQuantity;
                    TnAStyleMerchanReport: Report TnAStyleMerchandizing;
                    ProPicFactBoxPlan: Page "Property Picture FactBox Plan";
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                    ProdHeaderRec: Record ProductionOutHeader;
                    DeleteFromQueueListPage: Page "Delete From Queue List";
                    PlanHistoryListPage: Page "Plan Lines - Search List";
                    NavAppCodeUnit3Rec: Codeunit NavAppCodeUnit3;
                    STY: Code[20];
                    PO: Code[20];
                    LOT: Code[20];
                    ID: BigInteger;
                    QTY: Decimal;
                    STYNO: Text;
                    PONO: Text;
                    LOTNO: Text;
                    LineNo: BigInteger;
                    LineNo1: text;
                    Temp: text;
                    dtEnd: Date;
                    HrsPerDay: Integer;
                    D: Integer;
                    M: Integer;
                    Y: Integer;
                    ResourceNo: Code[20];
                    StartDate: Date;
                    FullQty: BigInteger;
                    QueueNo: BigInteger;
                    TempQty: BigInteger;
                    FactoryFinishTime: Time;
                begin
                    if (eventArgs.Get('ContextMenuID', _jsonToken)) then
                        _contextMenuID := _jsonToken.AsValue().AsText()
                    else
                        _contextMenuID := '';

                    if (eventArgs.Get('ContextMenuItemCode', _jsonToken)) then
                        _contextMenuItemCode := _jsonToken.AsValue().AsText()
                    else
                        _contextMenuItemCode := '';

                    if (eventArgs.Get('ObjectType', _jsonToken)) then
                        _objectType := _jsonToken.AsValue().AsInteger()
                    else
                        _objectType := 0;

                    if (eventArgs.Get('ObjectID', _jsonToken)) then
                        _objectID := _jsonToken.AsValue().AsText()
                    else
                        _objectID := '';

                    if (eventArgs.Get('VisualType', _jsonToken)) then
                        _visualType := _jsonToken.AsValue().AsInteger()
                    else
                        _visualType := -1;

                    if (eventArgs.Get('Date', _jsonToken)) then begin
                        _jsonToken.AsValue().WriteTo(_tempText);
                        _tempJsonValue.SetValue(CopyStr(_tempText, 2, 19) + 'Z');
                        _date := _tempJsonValue.AsDateTime();
                    end;

                    //Get Start and Finish Time
                    LocationRec.Reset();
                    LocationRec.SetRange(code, FactoryNo);
                    LocationRec.FindSet();

                    if _contextMenuID = 'CM_Entity' then begin

                        if _contextMenuItemCode = 'E_02' then begin   //Split

                            SplitCard.LookupMode(true);
                            SplitCard.PassParameters(_objectID);
                            SplitCard.RunModal();
                            LoadData(false, false, false, true, false);
                            SetconVSControlAddInSettings();

                        end;

                        if _contextMenuItemCode = 'E_03' then begin   //Split more

                            //Clear(ResourceList);
                            SplitMoreCard.LookupMode(true);
                            SplitMoreCard.PassParameters(_objectID);
                            SplitMoreCard.RunModal();
                            LoadData(false, false, false, true, false);
                            SetconVSControlAddInSettings();

                            // gcodconVSControlAddIn.LoadEntities(ldnEntitiesJSON);
                            // // CurrPage.conVSControlAddIn.RemoveEntities(ldnEntitiesJSON);
                            // CurrPage.conVSControlAddIn.AddEntities(ldnEntitiesJSON);
                            // CurrPage.conVSControlAddIn.Render();

                        end;

                        if _contextMenuItemCode = 'E_04' then begin   //Delete

                            if (Dialog.CONFIRM('Do you want to delete?', true) = true) then begin

                                Evaluate(ID, _objectID);
                                PlanningQueueRec.Reset();
                                PlanningQueueRec.SetRange("Queue No.", ID);
                                PlanningQueueRec.FindSet();

                                STY := PlanningQueueRec."Style No.";
                                PO := PlanningQueueRec."PO No.";
                                LOT := PlanningQueueRec."Lot No.";
                                QTY := PlanningQueueRec.Qty;

                                PlanningQueueRec.Reset();
                                PlanningQueueRec.SetRange("Style No.", STY);
                                PlanningQueueRec.SetRange("Lot No.", LOT);
                                PlanningQueueRec.FindSet();

                                if PlanningQueueRec.Count = 1 then begin  //Last record of the queue

                                    //Update PO table
                                    StyleMasterPORec.Reset();
                                    StyleMasterPORec.SetRange("Style No.", STY);
                                    StyleMasterPORec.SetRange("Lot No.", LOT);
                                    StyleMasterPORec.SetRange("PO No.", PO);
                                    if StyleMasterPORec.FindSet() then begin

                                        StyleMasterPORec.PlannedStatus := false;
                                        StyleMasterPORec.QueueQty := 0;
                                        StyleMasterPORec.Waistage := 0;
                                        StyleMasterPORec.Modify();
                                    end;

                                    //Delete from Queue
                                    PlanningQueueRec.Reset();
                                    PlanningQueueRec.SetRange("Queue No.", ID);
                                    if PlanningQueueRec.FindSet() then
                                        PlanningQueueRec.Delete();

                                end
                                else begin   //Many records in the queue
                                    repeat
                                        if PlanningQueueRec."Queue No." <> ID then begin
                                            //Add qty to existing record
                                            PlanningQueueNewRec.Reset();
                                            PlanningQueueNewRec.SetRange("Queue No.", PlanningQueueRec."Queue No.");
                                            PlanningQueueNewRec.FindSet();
                                            PlanningQueueNewRec.ModifyAll(Qty, (QTY + PlanningQueueRec.Qty));

                                            //Delete old record from Queue
                                            PlanningQueueNewRec.Reset();
                                            PlanningQueueNewRec.SetRange("Queue No.", ID);
                                            if PlanningQueueRec.FindSet() then
                                                PlanningQueueNewRec.DeleteAll();
                                            break;
                                        end
                                    until PlanningQueueRec.Next() = 0;
                                end;

                                LoadData(false, false, false, true, false);
                                SetconVSControlAddInSettings();
                            end;
                        end;

                        if _contextMenuItemCode = 'E_01' then begin   //Properties
                            Evaluate(ID, _objectID);
                            PlanningQueueRec.Reset();
                            PlanningQueueRec.SetRange("Queue No.", ID);
                            PlanningQueueRec.FindSet();
                            Page.RunModal(50340, PlanningQueueRec);
                        end;

                        if _contextMenuItemCode = 'E_06' then begin   //Accessories Status  
                            Evaluate(ID, _objectID);
                            PlanningQueueRec.Reset();
                            PlanningQueueRec.SetRange("Queue No.", ID);
                            PlanningQueueRec.FindSet();

                            STY := PlanningQueueRec."Style No.";
                            AccessoriesStatusReportNew.PassParameters(STY);
                            AccessoriesStatusReportNew.RunModal();
                        end;

                        if _contextMenuItemCode = 'E_07' then begin   //WIP  
                            Evaluate(ID, _objectID);
                            PlanningQueueRec.Reset();
                            PlanningQueueRec.SetRange("Queue No.", ID);
                            PlanningQueueRec.FindSet();

                            STY := PlanningQueueRec."Style No.";
                            WIPReport.PassParameters(STY);
                            WIPReport.RunModal();
                        end;

                        if _contextMenuItemCode = 'E_05' then begin   //Delete From Queue  
                            if FactoryNo = '' then
                                Error('Select a factory');

                            Clear(DeleteFromQueueListPage);
                            DeleteFromQueueListPage.LookupMode(true);
                            DeleteFromQueueListPage.RunModal();
                            LoadData(false, false, false, true, false);
                            SetconVSControlAddInSettings();
                        end;

                        if _contextMenuItemCode = 'E_08' then begin   //Size Color wise report  
                            Evaluate(ID, _objectID);
                            PlanningQueueRec.Reset();
                            PlanningQueueRec.SetRange("Queue No.", ID);
                            if PlanningQueueRec.FindSet() then begin
                                STY := PlanningQueueRec."Style No.";

                                StyleMasterRec.Reset();
                                StyleMasterRec.SetRange("No.", STY);
                                if StyleMasterRec.FindSet() then begin
                                    SizeColorWiseQtyBrReport.PassParameters(StyleMasterRec."Buyer No.", STY);
                                    SizeColorWiseQtyBrReport.RunModal();
                                end;
                            end;
                        end;
                    end;

                    if _contextMenuID = 'CM_Allocation' then begin

                        if _contextMenuItemCode = 'Al_01' then begin   //Properties

                            STYNo := _objectID.Substring(1, _objectID.IndexOfAny('/') - 1);
                            Temp := _objectID.Substring(_objectID.IndexOfAny('/') + 1, StrLen(_objectID) - _objectID.IndexOfAny('/'));
                            lotNo := Temp.Substring(1, Temp.IndexOfAny('/') - 1);
                            Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            PONo := Temp.Substring(1, Temp.IndexOfAny('/') - 1);
                            Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            LineNo1 := Temp;
                            Evaluate(LineNo, LineNo1);

                            PlanningLinesRec.Reset();
                            PlanningLinesRec.SetRange("Line No.", LineNo);
                            PlanningLinesRec.FindSet();
                            Page.RunModal(50343, PlanningLinesRec);
                            LoadData(false, false, true, true, false);

                        end;

                        if _contextMenuItemCode = 'Al_02' then begin   //Cut

                            Temp := _objectID.Substring(_objectID.IndexOfAny('/') + 1, StrLen(_objectID) - _objectID.IndexOfAny('/'));
                            Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            LineNo1 := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            Evaluate(LineNo, LineNo1);
                            evaluate(Y, copystr(Format(_date), 7, 2));
                            evaluate(M, copystr(Format(_date), 4, 2));
                            evaluate(D, copystr(Format(_date), 1, 2));
                            Y := 2000 + Y;
                            dtEnd := DMY2DATE(D, M, Y);
                            HrsPerDay := 0;

                            //Get resource No, Start Date
                            PlanningLinesRec.Reset();
                            PlanningLinesRec.SetRange("Line No.", LineNo);
                            if PlanningLinesRec.FindSet() then begin
                                ResourceNo := PlanningLinesRec."Resource No.";
                                StartDate := PlanningLinesRec."Start Date";
                                FullQty := PlanningLinesRec.Qty;
                            end;

                            //Check for not prod. updated sewing out enties
                            //Check whether pending sawing out quantity is there for the allocation
                            // ProdHeaderRec.Reset();
                            // ProdHeaderRec.SetFilter("Prod Updated", '=%1', 0);
                            // ProdHeaderRec.SetRange("out Style No.", PlanningLinesRec."Style No.");
                            // ProdHeaderRec.SetRange("out Lot No.", PlanningLinesRec."Lot No.");
                            // ProdHeaderRec.SetRange("OUT PO No", PlanningLinesRec."PO No.");
                            // ProdHeaderRec.SetFilter("Prod Date", '>=%1', dtEnd);
                            // ProdHeaderRec.SetRange("Ref Line No.", LineNo);
                            // ProdHeaderRec.SetRange("Resource No.", ResourceNo);
                            // ProdHeaderRec.SetFilter(Type, '=%1', ProdHeaderRec.Type::Saw);

                            // if ProdHeaderRec.FindSet() then
                            //     Error('Prodcution update for allocation : %1 has not processed yet for the date : %2. Cannot change the allocation.', _objectID, ProdHeaderRec."Prod Date");


                            QTY := 0;
                            //get records within date range
                            ProdPlanDetRec.Reset();
                            ProdPlanDetRec.SetRange("Resource No.", ResourceNo);
                            ProdPlanDetRec.SetRange(PlanDate, StartDate, dtEnd);
                            ProdPlanDetRec.SetRange("Line No.", LineNo);
                            if ProdPlanDetRec.FindSet() then begin
                                repeat
                                    QTY += ProdPlanDetRec.Qty;
                                until ProdPlanDetRec.Next() = 0;
                            end;

                            QTY := round(QTY, 1);

                            if QTY = 0 then
                                Error('You cannot cut at the start of line.');

                            //Get Max QueueNo
                            PlanningQueueRec.Reset();
                            if PlanningQueueRec.FindLast() then
                                QueueNo := PlanningQueueRec."Queue No.";

                            TempQty := PlanningLinesRec.Qty - QTY;

                            if TempQty = 0 then
                                Error('You cannot cut at the end of line.');

                            //Check whether user logged in or not
                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if not LoginSessionsRec.FindSet() then begin  //not logged in
                                Clear(LoginRec);
                                LoginRec.LookupMode(true);
                                LoginRec.RunModal();

                                LoginSessionsRec.Reset();
                                LoginSessionsRec.SetRange(SessionID, SessionId());
                                LoginSessionsRec.FindSet();
                            end;

                            //Add remaining qty to the Queue
                            PlanningQueueRec.Init();
                            PlanningQueueRec."Queue No." := QueueNo + 1;
                            PlanningQueueRec."Style No." := PlanningLinesRec."Style No.";
                            PlanningQueueRec."Style Name" := PlanningLinesRec."Style Name";
                            PlanningQueueRec."PO No." := PlanningLinesRec."PO No.";
                            PlanningQueueRec."Lot No." := PlanningLinesRec."Lot No.";
                            PlanningQueueRec.Qty := PlanningLinesRec.Qty - QTY;
                            PlanningQueueRec.SMV := PlanningLinesRec.SMV;
                            PlanningQueueRec.Carder := PlanningLinesRec.Carder;
                            PlanningQueueRec."TGTSEWFIN Date" := PlanningLinesRec."TGTSEWFIN Date";
                            PlanningQueueRec."Learning Curve No." := PlanningLinesRec."Learning Curve No.";
                            PlanningQueueRec.Eff := PlanningLinesRec.Eff;
                            PlanningQueueRec.HoursPerDay := PlanningLinesRec.HoursPerDay;
                            PlanningQueueRec.Front := PlanningLinesRec.Front;
                            PlanningQueueRec.Back := PlanningLinesRec.Back;
                            PlanningQueueRec.Waistage := 0;
                            PlanningQueueRec."User ID" := UserId;
                            PlanningQueueRec.Factory := PlanningLinesRec.Factory;
                            PlanningQueueRec.Target := PlanningLinesRec.Target;
                            PlanningQueueRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                            PlanningQueueRec."Created Date" := WorkDate();
                            PlanningQueueRec."Created User" := UserId;
                            PlanningQueueRec.Insert();

                            FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(ResourceNo, dtEnd, LocationRec."Start Time");

                            //Modify Planning line
                            PlanningLinesRec.Reset();
                            PlanningLinesRec.SetRange("Line No.", LineNo);
                            PlanningLinesRec.FindSet();
                            PlanningLinesRec."End Date" := dtEnd;
                            PlanningLinesRec.Qty := QTY;
                            PlanningLinesRec."Finish Time" := FactoryFinishTime;
                            PlanningLinesRec.FinishDateTime := CREATEDATETIME(dtEnd, FactoryFinishTime);
                            PlanningLinesRec.Modify();

                            //Delete remaining line from the Prod Plan Det table
                            ProdPlanDetRec.Reset();
                            ProdPlanDetRec.SetRange("Resource No.", ResourceNo);
                            ProdPlanDetRec.SetRange("Line No.", LineNo);
                            ProdPlanDetRec.SetFilter("PlanDate", '>=%1', dtEnd + 1);
                            ProdPlanDetRec.DeleteAll();

                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Style No.", PlanningLinesRec."Style No.");
                            StyleMasterPORec.SetRange("Lot No.", PlanningLinesRec."Lot No.");
                            StyleMasterPORec.FindSet();

                            // if (StyleMasterPORec.PlannedQty - TempQty) < 0 then
                            //     Error('Planned Qty is minus. Cannot proceed. PO No :  %1', StyleMasterPORec."PO No.");


                            StyleMasterPORec.PlannedQty := StyleMasterPORec.PlannedQty - TempQty;
                            StyleMasterPORec.QueueQty := StyleMasterPORec.QueueQty + TempQty;
                            StyleMasterPORec.Modify();

                            LoadData(false, false, true, true, false);

                        end;

                        if _contextMenuItemCode = 'Al_03' then begin   //Return to Queue

                            Temp := _objectID.Substring(_objectID.IndexOfAny('/') + 1, StrLen(_objectID) - _objectID.IndexOfAny('/'));
                            Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            LineNo1 := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            Evaluate(LineNo, LineNo1);

                            //Get resource No, Start Date
                            PlanningLinesRec.Reset();
                            PlanningLinesRec.SetRange("Line No.", LineNo);
                            if PlanningLinesRec.FindSet() then begin
                                QTY := PlanningLinesRec.Qty;
                                ResourceNo := PlanningLinesRec."Resource No.";
                            end;


                            // //Check for not prod. updated sewing out enties
                            // //Check whether pending sawing out quantity is there for the allocation
                            // ProdHeaderRec.Reset();
                            // ProdHeaderRec.SetFilter("Prod Updated", '=%1', 0);
                            // ProdHeaderRec.SetRange("out Style No.", PlanningLinesRec."Style No.");
                            // ProdHeaderRec.SetRange("out Lot No.", PlanningLinesRec."Lot No.");
                            // ProdHeaderRec.SetRange("OUT PO No", PlanningLinesRec."PO No.");
                            // ProdHeaderRec.SetRange("Ref Line No.", LineNo);
                            // ProdHeaderRec.SetRange("Resource No.", ResourceNo);
                            // ProdHeaderRec.SetFilter(Type, '=%1', ProdHeaderRec.Type::Saw);

                            // if ProdHeaderRec.FindSet() then
                            //     Error('Prodcution update for allocation : %1 has not processed yet for the date : %2. Cannot change the allocation.', _objectID, ProdHeaderRec."Prod Date");

                            // QTY := 0;
                            // //get remaining qty
                            // ProdPlanDetRec.Reset();
                            // ProdPlanDetRec.SetRange("Resource No.", ResourceNo);
                            // ProdPlanDetRec.SetFilter(ProdUpd, '=%1', 0);
                            // ProdPlanDetRec.SetRange("Line No.", LineNo);


                            // if ProdPlanDetRec.FindSet() then begin
                            //     repeat
                            //         QTY += ProdPlanDetRec.Qty;
                            //     until ProdPlanDetRec.Next() = 0;
                            // end;

                            // QTY := Round(QTY, 1);

                            //Check whether user logged in or not
                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());

                            if not LoginSessionsRec.FindSet() then begin  //not logged in
                                Clear(LoginRec);
                                LoginRec.LookupMode(true);
                                LoginRec.RunModal();

                                LoginSessionsRec.Reset();
                                LoginSessionsRec.SetRange(SessionID, SessionId());
                                LoginSessionsRec.FindSet();
                            end;

                            //Get Max QueueNo
                            PlanningQueueRec.Reset();
                            if PlanningQueueRec.FindLast() then
                                QueueNo := PlanningQueueRec."Queue No.";

                            if QTY > 0 then begin
                                //Add remaining qty to the Queue
                                PlanningQueueRec.Init();
                                PlanningQueueRec."Queue No." := QueueNo + 1;
                                PlanningQueueRec."Style No." := PlanningLinesRec."Style No.";
                                PlanningQueueRec."Style Name" := PlanningLinesRec."Style Name";
                                PlanningQueueRec."PO No." := PlanningLinesRec."PO No.";
                                PlanningQueueRec."Lot No." := PlanningLinesRec."Lot No.";
                                PlanningQueueRec.Qty := QTY;
                                PlanningQueueRec.SMV := PlanningLinesRec.SMV;
                                PlanningQueueRec.Carder := PlanningLinesRec.Carder;
                                PlanningQueueRec."TGTSEWFIN Date" := PlanningLinesRec."TGTSEWFIN Date";
                                PlanningQueueRec."Learning Curve No." := PlanningLinesRec."Learning Curve No.";
                                PlanningQueueRec.Eff := PlanningLinesRec.Eff;
                                PlanningQueueRec.HoursPerDay := PlanningLinesRec.HoursPerDay;
                                PlanningQueueRec.Front := PlanningLinesRec.Front;
                                PlanningQueueRec.Back := PlanningLinesRec.Back;
                                PlanningQueueRec.Waistage := 0;
                                PlanningQueueRec.Factory := PlanningLinesRec.Factory;
                                PlanningQueueRec."User ID" := UserId;
                                PlanningQueueRec.Target := PlanningLinesRec.Target;
                                PlanningQueueRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                PlanningQueueRec."Created Date" := WorkDate();
                                PlanningQueueRec."Created User" := UserId;
                                PlanningQueueRec.Insert();
                            end;

                            //Update StyleMsterPO table
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Style No.", PlanningLinesRec."Style No.");
                            StyleMasterPORec.SetRange("Lot No.", PlanningLinesRec."Lot No.");
                            if StyleMasterPORec.FindSet() then begin
                                StyleMasterPORec.PlannedQty := StyleMasterPORec.PlannedQty - QTY;
                                StyleMasterPORec.QueueQty := StyleMasterPORec.QueueQty + QTY;
                                StyleMasterPORec.Modify();
                            end
                            else
                                Error('Cannot find PO : %1 in Style PO Details.', PlanningLinesRec."PO No.");

                            // if (StyleMasterPORec.PlannedQty - QTY) < 0 then
                            //     Error('Planned Qty is minus. Cannot proceed. PO No :  %1', StyleMasterPORec."PO No.");

                            //Delete Planning line
                            PlanningLinesRec.Reset();
                            PlanningLinesRec.SetRange("Line No.", LineNo);
                            if PlanningLinesRec.FindSet() then
                                PlanningLinesRec.Delete();

                            //Delete remaining line from the Prod Plan Det table
                            ProdPlanDetRec.Reset();
                            ProdPlanDetRec.SetRange("Resource No.", ResourceNo);
                            ProdPlanDetRec.SetRange("Line No.", LineNo);
                            ProdPlanDetRec.SetRange(ProdUpd, 0);
                            if ProdPlanDetRec.FindSet() then
                                ProdPlanDetRec.DeleteAll();

                            LoadData(false, false, true, true, false);

                        end;

                        if _contextMenuItemCode = 'Al_04' then begin   //Plan Targets

                            Temp := _objectID.Substring(_objectID.IndexOfAny('/') + 1, StrLen(_objectID) - _objectID.IndexOfAny('/'));
                            Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            LineNo1 := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            Clear(PlanTargetList);
                            PlanTargetList.LookupMode(true);
                            PlanTargetList.PassParameters(LineNo1);
                            PlanTargetList.RunModal();

                        end;

                        if _contextMenuItemCode = 'Al_05' then begin   //Plan History

                            STYNo := _objectID.Substring(1, _objectID.IndexOfAny('/') - 1);
                            Clear(PlanHistoryList);
                            PlanHistoryList.LookupMode(true);
                            PlanHistoryList.PassParameters(STYNo);
                            PlanHistoryList.RunModal();

                        end;

                        if _contextMenuItemCode = 'Al_06' then begin   //Target Vs Achieve

                            Temp := _objectID.Substring(_objectID.IndexOfAny('/') + 1, StrLen(_objectID) - _objectID.IndexOfAny('/'));
                            Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            LineNo1 := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            Evaluate(LineNo, LineNo1);
                            // PlanningLinesRec.Reset();
                            // PlanningLinesRec.SetRange("Line No.", LineNo);
                            // PlanningLinesRec.FindSet();
                            // ResourceNo := PlanningLinesRec."Resource No.";

                            Clear(PlanTargetVsAchList);
                            PlanTargetVsAchList.LookupMode(true);
                            //PlanTargetVsAchList.PassParameters(ResourceNo);
                            PlanTargetVsAchList.PassParameters(format(LineNo));
                            PlanTargetVsAchList.RunModal();

                        end;

                        if _contextMenuItemCode = 'Al_11' then begin   //Accessories Status  
                            AccessoriesStatusReportNew.PassParameters(_objectID.Substring(1, _objectID.IndexOfAny('/') - 1));
                            AccessoriesStatusReportNew.RunModal();
                        end;
                        //Mihiranga 2023/02/23
                        if _contextMenuItemCode = 'Al_12' then begin   //WIP  
                            WIPReport.PassParameters(_objectID.Substring(1, _objectID.IndexOfAny('/') - 1));
                            WIPReport.RunModal();
                        end;

                        if _contextMenuItemCode = 'Al_13' then begin   //Size Color wise report  
                            StyleMasterRec.Reset();
                            StyleMasterRec.SetRange("No.", _objectID.Substring(1, _objectID.IndexOfAny('/') - 1));
                            if StyleMasterRec.FindSet() then begin
                                SizeColorWiseQtyBrReport.PassParameters(StyleMasterRec."Buyer No.", _objectID.Substring(1, _objectID.IndexOfAny('/') - 1));
                                SizeColorWiseQtyBrReport.RunModal();
                            end;
                        end;

                        if _contextMenuItemCode = 'Al_8' then begin   //picture

                            // Temp := _objectID.Substring(_objectID.IndexOfAny('/') + 1, StrLen(_objectID) - _objectID.IndexOfAny('/'));
                            // Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            // LineNo1 := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));

                            // Clear(ProPicFactBoxPlan);
                            // ProPicFactBoxPlan.LookupMode(true);
                            // ProPicFactBoxPlan.PassParameters(LineNo1);
                            // ProPicFactBoxPlan.RunModal();

                            Temp := _objectID.Substring(_objectID.IndexOfAny('/') + 1, StrLen(_objectID) - _objectID.IndexOfAny('/'));
                            Temp := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            LineNo1 := Temp.Substring(Temp.IndexOfAny('/') + 1, StrLen(Temp) - Temp.IndexOfAny('/'));
                            Evaluate(LineNo, LineNo1);
                            Clear(ProPicFactBoxPlan);
                            ProPicFactBoxPlan.LookupMode(true);
                            ProPicFactBoxPlan.PassParameters(LineNo);
                            ProPicFactBoxPlan.RunModal();

                        end;

                        if _contextMenuItemCode = 'Al_9' then begin   //Time and Action Plan
                            TnAStyleMerchanReport.PassParameters(_objectID.Substring(1, _objectID.IndexOfAny('/') - 1));
                            TnAStyleMerchanReport.RunModal();
                        end;

                        if _contextMenuItemCode = 'Al_10' then begin   //Search By Style/Return To Queue
                            if FactoryNo = '' then
                                Error('Select a factory');

                            Clear(PlanHistoryListPage);
                            PlanHistoryListPage.LookupMode(true);
                            PlanHistoryListPage.PassParameters(FactoryNo);
                            PlanHistoryListPage.RunModal();

                            LoadData(false, false, true, true, false);
                        end;

                        //LoadData();
                        SetconVSControlAddInSettings();
                    end;
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                action("Pending PO Plan")
                {
                    ToolTip = 'Pending PO Plan';
                    Image = SelectMore;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        AllPOListPage: Page "All PO List";
                    begin
                        if FactoryNo = '' then
                            Error('Select a factory');

                        Clear(AllPOListPage);
                        AllPOListPage.LookupMode(true);
                        AllPOListPage.PassParameters(FactoryNo, LearningCurveNo);
                        AllPOListPage.RunModal();
                        LoadData(false, false, false, true, false);
                        SetconVSControlAddInSettings();
                    end;
                }

                action("Delete From Queue")
                {
                    ToolTip = 'Delete From Queue';
                    Image = TaskList;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        DeleteFromQueueListPage: Page "Delete From Queue List";
                    begin
                        if FactoryNo = '' then
                            Error('Select a factory');

                        Clear(DeleteFromQueueListPage);
                        DeleteFromQueueListPage.LookupMode(true);
                        //  DeleteFromQueueListPage.PassParameters(FactoryNo);
                        DeleteFromQueueListPage.RunModal();
                        LoadData(false, false, false, true, false);
                        SetconVSControlAddInSettings();
                    end;
                }

                // action("Return To Queue")
                // {
                //     ToolTip = 'Return To Queue';
                //     Image = TaskList;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     var
                //         ReturnToQueueListPage: Page "Return To Queue List";
                //     begin
                //         if FactoryNo = '' then
                //             Error('Select a factory');

                //         Clear(ReturnToQueueListPage);
                //         ReturnToQueueListPage.LookupMode(true);
                //         ReturnToQueueListPage.PassParameters(FactoryNo);
                //         ReturnToQueueListPage.RunModal();
                //         LoadData();
                //         SetconVSControlAddInSettings();
                //     end;
                // }

                action("Show/Hide Plannnig Queue")
                {
                    ToolTip = 'Show/Hide Plannnig Queue';
                    Image = ShowList;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        _settings: JsonObject;
                    begin
                        gbShowEntities := NOT gbShowEntities;
                        _settings.Add('EntitiesTableVisible', gbShowEntities);
                        CurrPage.conVSControlAddIn.SetSettings(_settings);
                    end;
                }

                action("Search By Style/Return To Queue")
                {
                    Image = Find;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PlanHistoryListPage: Page "Plan Lines - Search List";
                        FactoryNoVar: code[20];
                        userRec: Record "User Setup";
                    begin

                        userRec.Reset();
                        userRec.SetRange("User ID", UserId);

                        if userRec.FindSet() then
                            FactoryNoVar := userRec."Factory Code";

                        if FactoryNoVar = '' then
                            Error('Factory not setup for the User.');

                        Clear(PlanHistoryListPage);
                        PlanHistoryListPage.LookupMode(true);
                        PlanHistoryListPage.PassParameters(FactoryNoVar);
                        PlanHistoryListPage.RunModal();
                        LoadData(false, false, true, true, false);
                        SetconVSControlAddInSettings();
                    end;
                }

                action("Production Update")
                {
                    ToolTip = 'Production Update';
                    Image = Production;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        _options: JsonObject;
                        ProdUpdateCard: Page "Prod Update Card";
                    begin
                        if (Dialog.CONFIRM('Do you want to upload sewing out details? After uploading sewing out, you cannot undo the process.', true) = true) then begin

                            ProdUpdateCard.LookupMode(true);
                            ProdUpdateCard.PassParameters(FactoryNo);
                            ProdUpdateCard.RunModal();
                            LoadData(false, false, true, false, false);
                        end;
                    end;
                }

                // action(Reload)
                // {
                //     Image = RefreshLines;
                //     ApplicationArea = All;

                //     trigger OnAction()

                //     begin
                //         LoadData();
                //     end;
                // }

                // action("Generate Queue")
                // {
                //     ToolTip = 'Generate Queue';
                //     Image = TaskList;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     begin
                //         GenerateQueue();
                //         LoadData();
                //         SetconVSControlAddInSettings();
                //     end;
                // }

                action("Save as PDF")
                {
                    ToolTip = 'Saves the complete chart as PDF file';
                    Image = SendAsPDF;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        _options: JsonObject;
                    begin
                        CurrPage.conVSControlAddIn.SaveAsPDF('VSCAI_SavedChart', _options);
                    end;
                }
            }
        }
    }

    trigger OnInit()
    var
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
    begin

        //Filter Criteria - Dates
        StartDate := CALCDATE('-1D', Today());
        FinishDate := CALCDATE('+1M', Today());

        //Session Settings
        gbAddInInitialized := FALSE;
        gbAddInReady := FALSE;
        gbShowWorkfreePeriods := TRUE;
        gbShowEntities := true;

        //conVSControlAddIn Settings
        gdtconVSControlAddInStart := CREATEDATETIME(DMY2DATE(DATE2DMY(StartDate, 1), DATE2DMY(StartDate, 2), DATE2DMY(StartDate, 3)), 0T);
        gdtconVSControlAddInEnd := CREATEDATETIME(DMY2DATE(DATE2DMY(FinishDate, 1), DATE2DMY(FinishDate, 2), DATE2DMY(FinishDate, 3)), 0T);
        gdtconVSControlAddInWorkdate := CREATEDATETIME(WORKDATE(Today()), 0T);
        gintconVSControlAddInViewType := goptViewType::ResourceView;
        gtxtconVSControlAddInTitleText := 'Lines';
        gintconVSControlAddInTableWidth := 120;
        gintconVSControlAddInTableViewWidth := 120;
        gtxtconVSControlAddInEntitiesTitleText := 'PO Queue';
        gintconVSControlAddInEntitiesTableWidth := 250;
        gintconVSControlAddInEntitiesTableViewWidth := 250;

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            LoginSessionsRec.Reset();
            LoginSessionsRec.SetRange(SessionID, SessionId());
            LoginSessionsRec.FindSet();
        end;

    end;

    var
        gRetVal: Boolean;
        gbAddInInitialized: Boolean;
        gbAddInReady: Boolean;
        gcodconVSControlAddIn: Codeunit 50325;
        gtxtconVSControlAddInTitleText: Text[50];
        gintconVSControlAddInTableWidth: Integer;
        gintconVSControlAddInTableViewWidth: Integer;
        gdtconVSControlAddInStart: DateTime;
        gdtconVSControlAddInEnd: DateTime;
        gbShowWorkfreePeriods: Boolean;
        gbShowEntities: Boolean;
        gtxtconVSControlAddInEntitiesTitleText: Text[50];
        gintconVSControlAddInEntitiesTableWidth: Integer;
        gintconVSControlAddInEntitiesTableViewWidth: Integer;
        gintconVSControlAddInViewType: Integer;
        goptViewType: Option ActivityView,ResourceView;
        gdtconVSControlAddInWorkdate: DateTime;
        gSavedAllocation: JsonObject;
        gCompletionID: Text;


        "FactoryNo": Code[20];
        "FactoryName": Text[50];
        "StyleNo": Code[20];
        "StyleName": Text[50];
        "Lot": text[50];
        "Po": text[50];
        "StartDate": Date;
        "FinishDate": Date;
        "LearningCurveNo": Integer;
        AllPo: Boolean;
        LcurveType: code[20];
        navappsetup: Record "NavApp Setup";

    local procedure SetconVSControlAddInSettings()
    var
        _settings: JsonObject;
        i: Integer;
    begin
        IF (gbAddInInitialized) THEN BEGIN
            _settings.Add('Start', gdtconVSControlAddInStart);
            _settings.Add('End', gdtconVSControlAddInEnd);
            _settings.Add('WorkDate', gdtconVSControlAddInWorkdate);
            _settings.Add('ViewType', gintconVSControlAddInViewType);
            _settings.Add('TitleText', gtxtconVSControlAddInTitleText);
            _settings.Add('TableWidth', gintconVSControlAddInTableWidth);
            _settings.Add('TableViewWidth', gintconVSControlAddInTableViewWidth);
            _settings.Add('EntitiesTitleText', gtxtconVSControlAddInEntitiesTitleText);
            _settings.Add('EntitiesTableWidth', gintconVSControlAddInEntitiesTableWidth);
            _settings.Add('EntitiesTableViewWidth', gintconVSControlAddInEntitiesTableViewWidth);
            _settings.Add('EntitiesTableVisible', gbShowEntities);
            _settings.Add('NonworkingTimeVisible', gbShowWorkfreePeriods);
            _settings.Add('PM_DefaultAllocationAllowedBarDragModes', 16);
            _settings.Add('PM_DefaultMinimumActivityRowHeight', '25');
            _settings.Add('PM_DefaultAllocationMinimumRowHeight', '25');
            _settings.Add('PM_DefaultMinimumResourceRowHeight', '25');
            _settings.Add('PM_DefaultMinimumEntityRowHeight', '25');
            _settings.Add('PM_TopRowMarginInTimeArea', 4);
            _settings.Add('PM_BottomRowMarginInTimeArea', 4);


            CurrPage.conVSControlAddIn.SetSettings(_settings);
        END;
    end;

    local procedure LoadData(blnCal: Boolean; blnRes: Boolean; blnAllo: Boolean; blnQue: Boolean; blnMenu: Boolean)
    var
        ldnResourcesJSON: JsonArray;
        ldnCalendarsJSON: JsonArray;
        ldnActivitiesJSON: JsonArray;
        ldnAllocationsJSON: JsonArray;
        ldnEntitiesJSON: JsonArray;
        ldnCurvesJSON: JsonArray;
        ldnContextMenusJSON: JsonArray;
        tempJsonToken: JsonToken;
    begin
        gbAddInReady := true;
        IF (gbAddInReady) THEN BEGIN

            CASE gintconVSControlAddInViewType OF
                goptViewType::ActivityView:
                    BEGIN
                        //ldnActivities := ldnActivities.List();
                        gcodconVSControlAddIn.LoadActivities(ldnActivitiesJSON, DT2DATE(gdtconVSControlAddInStart), DT2DATE(gdtconVSControlAddInEnd));
                        //ldnContextMenus := ldnContextMenus.List();
                        gcodconVSControlAddIn.LoadContextMenus(ldnContextMenusJSON);
                        CurrPage.conVSControlAddIn.RemoveAll();
                        CurrPage.conVSControlAddIn.AddContextMenus(ldnContextMenusJSON);
                        CurrPage.conVSControlAddIn.AddActivities(ldnActivitiesJSON);
                        CurrPage.conVSControlAddIn.Render();
                    END;

                goptViewType::ResourceView:
                    BEGIN

                        gcodconVSControlAddIn.LoadCalendars(FactoryNo, ldnCalendarsJSON, DT2DATE(gdtconVSControlAddInStart), DT2DATE(gdtconVSControlAddInEnd));
                        gcodconVSControlAddIn.LoadResources(ldnResourcesJSON, ldnCurvesJSON, DT2DATE(gdtconVSControlAddInStart), DT2DATE(gdtconVSControlAddInEnd), FactoryNo);
                        gcodconVSControlAddIn.LoadAllocations(ldnActivitiesJSON, ldnAllocationsJSON, DT2DATE(gdtconVSControlAddInStart), DT2DATE(gdtconVSControlAddInEnd));
                        gcodconVSControlAddIn.LoadEntities(ldnEntitiesJSON);
                        gcodconVSControlAddIn.LoadContextMenus(ldnContextMenusJSON);

                        // if blnCal then begin
                        //     gcodconVSControlAddIn.LoadCalendars(FactoryNo, ldnCalendarsJSON, DT2DATE(gdtconVSControlAddInStart), DT2DATE(gdtconVSControlAddInEnd));
                        //     CurrPage.conVSControlAddIn.RemoveCalendars(ldnCalendarsJSON);
                        //     CurrPage.conVSControlAddIn.AddCalendars(ldnCalendarsJSON);
                        // end;

                        // if blnRes then begin
                        //     gcodconVSControlAddIn.LoadResources(ldnResourcesJSON, ldnCurvesJSON, DT2DATE(gdtconVSControlAddInStart), DT2DATE(gdtconVSControlAddInEnd), FactoryNo);
                        //     CurrPage.conVSControlAddIn.RemoveResources(ldnResourcesJSON);
                        //     CurrPage.conVSControlAddIn.AddResources(ldnResourcesJSON);
                        // end;

                        // if blnAllo then begin
                        //     gcodconVSControlAddIn.LoadAllocations(ldnActivitiesJSON, ldnAllocationsJSON, DT2DATE(gdtconVSControlAddInStart), DT2DATE(gdtconVSControlAddInEnd));
                        //     CurrPage.conVSControlAddIn.RemoveAllocations(ldnAllocationsJSON);
                        //     CurrPage.conVSControlAddIn.AddAllocations(ldnAllocationsJSON);
                        // end;

                        // if blnQue then begin
                        //     gcodconVSControlAddIn.LoadEntities(ldnEntitiesJSON);
                        //     CurrPage.conVSControlAddIn.RemoveEntities(ldnEntitiesJSON);
                        //     CurrPage.conVSControlAddIn.AddEntities(ldnEntitiesJSON);
                        // end;

                        // if blnMenu then begin
                        //     gcodconVSControlAddIn.LoadContextMenus(ldnContextMenusJSON);
                        //     CurrPage.conVSControlAddIn.RemoveContextMenus(ldnContextMenusJSON);
                        //     CurrPage.conVSControlAddIn.AddContextMenus(ldnContextMenusJSON);
                        // end;

                        // CurrPage.conVSControlAddIn.Render();


                        CurrPage.conVSControlAddIn.RemoveAll();
                        CurrPage.conVSControlAddIn.AddContextMenus(ldnContextMenusJSON);
                        CurrPage.conVSControlAddIn.AddCalendars(ldnCalendarsJSON);
                        // CurrPage.conVSControlAddIn.AddCurves(ldnCurvesJSON);
                        CurrPage.conVSControlAddIn.AddResources(ldnResourcesJSON);
                        // CurrPage.conVSControlAddIn.AddActivities(ldnActivitiesJSON);
                        CurrPage.conVSControlAddIn.AddAllocations(ldnAllocationsJSON);
                        CurrPage.conVSControlAddIn.AddEntities(ldnEntitiesJSON);

                        CurrPage.conVSControlAddIn.Render();

                        //ldnAllocationsJSON.Get(0, tempJsonToken);
                        // gSavedAllocation := tempJsonToken.AsObject();
                        // gSavedAllocation.Get('ID', tempJsonToken);
                        //Message(tempJsonToken.AsValue().AsText());

                    END;
            END;
        END;
    end;

    local procedure LoadDataFromQ()
    var
        ldnResourcesJSON: JsonArray;
        ldnCalendarsJSON: JsonArray;
        ldnActivitiesJSON: JsonArray;
        ldnAllocationsJSON: JsonArray;
        ldnEntitiesJSON: JsonArray;
        ldnCurvesJSON: JsonArray;
        ldnContextMenusJSON: JsonArray;
        tempJsonToken: JsonToken;
    begin
        gbAddInReady := true;
        IF (gbAddInReady) THEN BEGIN

            CASE gintconVSControlAddInViewType OF

                goptViewType::ResourceView:
                    BEGIN

                        gcodconVSControlAddIn.LoadAllocations(ldnActivitiesJSON, ldnAllocationsJSON, DT2DATE(gdtconVSControlAddInStart), DT2DATE(gdtconVSControlAddInEnd));
                        gcodconVSControlAddIn.LoadEntities(ldnEntitiesJSON);

                        // CurrPage.conVSControlAddIn.RemoveAllOfType(2);
                        // CurrPage.conVSControlAddIn.RemoveAllOfType(13);

                        CurrPage.conVSControlAddIn.AddAllocations(ldnAllocationsJSON);
                        CurrPage.conVSControlAddIn.AddEntities(ldnEntitiesJSON);
                        CurrPage.conVSControlAddIn.Render();


                    END;
            END;
        END;
    end;


    local procedure ScrollToActivity()
    var
        _jsonArray: JsonArray;
    begin
        if (gbAddInReady) then begin
            CurrPage.conVSControlAddIn.ScrollToObject(1, 'Act_SIL_SO000001_10000', 0, false);

            _jsonArray.Add('Act_SIL_SO000001_10000');
            CurrPage.conVSControlAddIn.SelectObjects(1, _jsonArray, 1);
        end;
    end;

    local procedure ScrollToResource()
    begin
        if (gbAddInReady) then begin
            CurrPage.conVSControlAddIn.ScrollToObject(5, 'R0010', 0, false);
        end;
    end;

    local procedure ScrollToAllocation()
    begin
        if (gbAddInReady) then begin
            CurrPage.conVSControlAddIn.ScrollToObject(2, 'SOA_16', 0, false);
        end;
    end;

    local procedure ScrollToEntity()
    begin
        if (gbAddInReady) then begin
            CurrPage.conVSControlAddIn.ScrollToObject(13, 'BA_Job_E_Task_2', 0, false);
        end;
    end;

    local procedure ScrollToDate()
    begin
        if (gbAddInReady) then begin
            CurrPage.conVSControlAddIn.ScrollToDate(CREATEDATETIME(WORKDATE(), 000000T));
        end;
    end;

    // local procedure SetView(pViewType: Integer)
    // begin
    //     CASE pViewType OF
    //         goptViewType::ActivityView:
    //             BEGIN
    //                 gintconVSControlAddInViewType := pViewType;
    //                 gtxtconVSControlAddInTitleText := 'Activity View';
    //                 SetconVSControlAddInSettings();
    //                 LoadData(false, false, false, false, false);
    //             END;

    //         goptViewType::ResourceView:
    //             BEGIN
    //                 gintconVSControlAddInViewType := pViewType;
    //                 gtxtconVSControlAddInTitleText := 'Resource View';
    //                 SetconVSControlAddInSettings();
    //                 LoadData(false, false, false, true, false);
    //             END;
    //     END;
    // end;

    // local procedure GenerateQueue()
    // var
    //     WastageRec: Record Wastage;
    //     PlanningQueueRec: Record "Planning Queue";
    //     PlanningQueueNewRec: Record "Planning Queue";
    //     StyleMasterPORec: Record "Style Master PO";
    //     StyleMasterRec: Record "Style Master";
    //     StyleMasterPONewRec: Record "Style Master PO";
    //     CostPlanParaLineRec: Record CostingPlanningParaLine;
    //     LoginSessionsRec: Record LoginSessions;
    //     LoginRec: Page "Login Card";
    //     Waistage: Decimal;
    //     QtyWithWaistage: Decimal;
    //     QueueNo: Decimal;
    //     x: Decimal;
    //     Temp: Decimal;
    //     Status: Integer;
    // begin
    //     if StyleNo = '' then
    //         Error('Select a Style to proceed.');

    //     if (AllPo = false) and (Lot = '') then
    //         Error('Please select POs.');

    //     //Get Max Lineno
    //     PlanningQueueRec.Reset();

    //     if PlanningQueueRec.FindLast() then
    //         QueueNo := PlanningQueueRec."Queue No.";

    //     Waistage := 0;
    //     QtyWithWaistage := 0;

    //     StyleMasterRec.Reset();
    //     StyleMasterRec.SetRange("No.", StyleNo);
    //     StyleMasterRec.FindSet();

    //     if StyleMasterRec.SMV = 0 then
    //         Error('SMV is zero for Style : %1. Cannot proceed.', StyleName);


    //     StyleMasterPORec.Reset();
    //     StyleMasterPORec.SetRange("Style No.", StyleNo);

    //     if AllPo = false then
    //         StyleMasterPORec.SetRange("Lot No.", "Lot");

    //     if StyleMasterPORec.FindSet() then begin

    //         //Get the wastage from wastage table
    //         WastageRec.Reset();
    //         WastageRec.SetFilter("Start Qty", '<=%1', StyleMasterPORec.Qty);
    //         WastageRec.SetFilter("Finish Qty", '>=%1', StyleMasterPORec.Qty);

    //         if WastageRec.FindSet() then
    //             Waistage := WastageRec.Percentage;

    //         repeat

    //             if StyleMasterPORec.PlannedStatus = false then begin

    //                 QueueNo += 1;
    //                 Temp := StyleMasterPORec.Qty - StyleMasterPORec.PlannedQty - StyleMasterPORec."Sawing Out Qty";
    //                 QtyWithWaistage := Temp + (Temp * Waistage) / 100;
    //                 QtyWithWaistage := Round(QtyWithWaistage, 1);
    //                 x := StyleMasterPORec.PlannedQty + StyleMasterPORec."Sawing Out Qty" + StyleMasterPORec.QueueQty + StyleMasterPORec.Waistage;

    //                 if StyleMasterPORec.Qty > x then begin

    //                     //Check whether user logged in or not
    //                     LoginSessionsRec.Reset();
    //                     LoginSessionsRec.SetRange(SessionID, SessionId());

    //                     if not LoginSessionsRec.FindSet() then begin  //not logged in
    //                         Clear(LoginRec);
    //                         LoginRec.LookupMode(true);
    //                         LoginRec.RunModal();

    //                         LoginSessionsRec.Reset();
    //                         LoginSessionsRec.SetRange(SessionID, SessionId());
    //                         LoginSessionsRec.FindSet();
    //                     end;

    //                     //Get plan efficiency                          
    //                     CostPlanParaLineRec.Reset();
    //                     CostPlanParaLineRec.SetFilter("From SMV", '<=%1', StyleMasterRec.SMV);
    //                     CostPlanParaLineRec.SetFilter("To SMV", '>=%1', StyleMasterRec.SMV);
    //                     CostPlanParaLineRec.SetFilter("From Qty", '<=%1', StyleMasterRec."Order Qty");
    //                     CostPlanParaLineRec.SetFilter("To Qty", '>=%1', StyleMasterRec."Order Qty");

    //                     //Insert new line to Queue
    //                     PlanningQueueNewRec.Init();
    //                     PlanningQueueNewRec."Queue No." := QueueNo;
    //                     PlanningQueueNewRec."Style No." := StyleMasterPORec."Style No.";
    //                     PlanningQueueNewRec."Style Name" := StyleName;
    //                     PlanningQueueNewRec."PO No." := StyleMasterPORec."PO No.";
    //                     PlanningQueueNewRec."Lot No." := StyleMasterPORec."Lot No.";
    //                     PlanningQueueNewRec.Qty := QtyWithWaistage;
    //                     PlanningQueueNewRec.Waistage := (Temp * Waistage) / 100;
    //                     PlanningQueueNewRec.SMV := StyleMasterRec.SMV;
    //                     PlanningQueueNewRec.Factory := FactoryNo;
    //                     PlanningQueueNewRec."TGTSEWFIN Date" := StyleMasterPORec."Ship Date";
    //                     PlanningQueueNewRec."Learning Curve No." := LearningCurveNo;
    //                     PlanningQueueNewRec."Resource No" := '';
    //                     PlanningQueueNewRec.Front := StyleMasterRec.Front;
    //                     PlanningQueueNewRec.Back := StyleMasterRec.Back;
    //                     PlanningQueueNewRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
    //                     PlanningQueueNewRec."Created Date" := WorkDate();
    //                     PlanningQueueNewRec."Created User" := UserId;

    //                     if CostPlanParaLineRec.FindSet() then
    //                         PlanningQueueNewRec.Eff := CostPlanParaLineRec."Planning Eff%";

    //                     PlanningQueueNewRec.Insert();


    //                     //Update Style Master PO
    //                     StyleMasterPONewRec.Reset();
    //                     StyleMasterPONewRec.SetRange("Style No.", StyleMasterPORec."Style No.");
    //                     StyleMasterPONewRec.SetRange("Lot No.", StyleMasterPORec."Lot No.");
    //                     StyleMasterPONewRec.FindSet();
    //                     StyleMasterPONewRec.PlannedStatus := true;
    //                     StyleMasterPONewRec.QueueQty := QtyWithWaistage;
    //                     StyleMasterPONewRec.Waistage := (Temp * Waistage) / 100;
    //                     StyleMasterPONewRec.Modify();

    //                     Status := 1;
    //                 end;
    //             end;

    //         until StyleMasterPORec.Next = 0;

    //         if Status = 0 then
    //             Error('Nothing to queue.');
    //     end
    //     else
    //         Error('Cannot find PO details for the Style : %1', StyleName);
    // end;

}

