codeunit 50325 "NETRONICVSDevToolboxDemo Code"
{
    trigger OnRun()
    begin
    end;

    var
        gCurveType: Option Capacity,"Qty. on Order (Job)","Qty. Quoted (Job)","Qty. on Service Order","Qty. Sum All";

    procedure createJsonObject(): JsonObject
    var
        _json: JsonObject;
    begin
        EXIT(_json);
    end;

    procedure createJsonArray(): JsonArray
    var
        _json: JsonArray;
    begin
        EXIT(_json);
    end;


    procedure LoadResources(pResources: JsonArray; pCurves: JsonArray; pStart: Date; pEnd: Date; FactoryNo: Code[20])
    var
        ldnResource: JsonObject;
        //lrecResourceGroup: Record 152;
        lrecResource: Record "Work Center";
        ldnCurve: JsonObject;
        tempResourceToken: JsonToken;
        tempCurveToken: JsonToken;

        SpHoliday: JsonObject;
        SpHolidayEntry: JsonObject;
        tempEntities: JsonArray;
    begin
        //Add a 'No Group' Resource for Resources without a Resource Group
        // ldnResource.Add('ID', 'RG0_NoGroup');
        // ldnResource.Add('PM_TableColor', 'lightblue');
        // ldnResource.Add('PM_TableTextColor', 'black');
        // ldnResource.Add('AddIn_TableText', 'No Group');
        // ldnResource.Add('AddIn_TooltipText', 'Resourcegroup for<br>resources without a group.');
        // ldnResource.Add('AddIn_ContextMenuID', 'CM_ResourceGroup');
        // pResources.Add(ldnResource);

        //Load Resource Groups (Table 152)
        // lrecResourceGroup.SETCURRENTKEY(lrecResourceGroup."No.");
        // lrecResourceGroup.SETRANGE(lrecResourceGroup."No.");
        // IF lrecResourceGroup.FIND('-') THEN
        //     REPEAT
        //         ldnResource := createJsonObject();
        //         ldnResource.Add('ID', 'RG1_' + lrecResourceGroup."No.");
        //         ldnResource.Add('PM_TableColor', 'darkgray');
        //         ldnResource.Add('AddIn_TableText', lrecResourceGroup.Name + ' (' + lrecResourceGroup."No." + ')');
        //         ldnResource.Add('AddIn_TooltipText', 'Resourcegroup<br>Name: ' + FORMAT(lrecResourceGroup.Name) + '<br>No.: ' + FORMAT(lrecResourceGroup."No."));
        //         ldnResource.Add('AddIn_ContextMenuID', 'CM_ResourceGroup');
        //         pResources.Add(ldnResource);
        //     UNTIL lrecResourceGroup.NEXT = 0;


        //Load Resources 
        lrecResource.SETCURRENTKEY(lrecResource.Name);
        lrecResource.SETRANGE(lrecResource.Name);
        lrecResource.SetFilter("Planning Line", '=%1', true);

        if FactoryNo <> '' then
            lrecResource.SETRANGE(lrecResource."Factory No.", FactoryNo);

        IF lrecResource.FIND('-') THEN
            REPEAT

                // SpHoliday := createJsonObject();
                // SpHolidayEntry := createJsonObject();
                // tempEntities := createJsonArray();

                // SpHoliday.Add('ID', 'SP' + lrecResource."No.");
                // SpHolidayEntry.Add('Start', '20/01/2022');
                // SpHolidayEntry.Add('End', '21/01/2022');
                // SpHolidayEntry.Add('Color', 'red');
                // tempEntities.Add(SpHolidayEntry);
                // SpHoliday.Add('Entries', tempEntities);
                // pResources.Add('PM_PeriodHighlighterID', 'SP' + lrecResource."No.");



                ldnResource := createJsonObject();
                ldnResource.Add('ID', 'R_' + lrecResource."No.");
                ldnResource.Add('PM_TableColor', 'lightgray');
                ldnResource.Add('AddIn_TableText', lrecResource.Name);
                ldnResource.Add('PM_TableTextColor', 'darkblue');
                //ldnResource.Add('AddIn_TableText', lrecResource.Name + ' (' + lrecResource."No." + ')');
                ldnResource.Add('AddIn_TooltipText', 'Resource<br>Name: ' + FORMAT(lrecResource.Name) + '<br>No.: ' + FORMAT(lrecResource."No."));
                ldnResource.Add('AddIn_ContextMenuID', 'CM_Resource');
                //ldnResource.Add('PM_MinimumRowHeight', '19');


                // IF (lrecResource."Resource Group No." = '') THEN BEGIN
                //     ldnResource.Add('ParentID', 'RG0_NoGroup');
                // END
                // ELSE BEGIN
                //     ldnResource.Add('ParentID', 'RG1_' + lrecResource."Resource Group No.");
                // END;

                ldnResource.Add('CalendarID', 'CalRes_' + lrecResource."No.");

                // //Get Curves
                // ldnResource.Get('ID', tempResourceToken);
                // ldnCurve := createJsonObject();
                // ldnCurve.Add('ID', 'ResCapCurve_' + tempResourceToken.AsValue().AsText());
                // GetResourceCurve(lrecResource, ldnCurve, gCurveType::Capacity, pStart, pEnd);
                // ldnCurve.Get('ID', tempCurveToken);
                // ldnResource.Add('CapacityCurveID', tempCurveToken.AsValue().AsText());
                // pCurves.Add(ldnCurve);

                // ldnCurve := createJsonObject();
                // ldnCurve.Add('ID', 'ResLoadCurveService_' + tempResourceToken.AsValue().AsText());
                // GetResourceCurve(lrecResource, ldnCurve, gCurveType::"Qty. Sum All", pStart, pEnd);
                // ldnCurve.Get('ID', tempCurveToken);
                // ldnResource.Add('LoadCurveID', tempCurveToken.AsValue().AsText());
                // pCurves.Add(ldnCurve);

                pResources.Add(ldnResource);
            UNTIL lrecResource.NEXT = 0;
    end;

    procedure LoadCalendars(FactoryNo: code[20]; pCalendars: JsonArray; pStart: Date; pEnd: Date)
    var
        ldnCalendar: JsonObject;
        ldnCalendarEntry: JsonObject;
        WorkCenterRec: Record "Work Center";
        lrecDate: Record 2000000007;
        LocationRec: Record Location;
        tempEntities: JsonArray;
        ResCapacityEntryRec: Record "Calendar Entry";
    begin

        //Get Start and Finish Time
        LocationRec.Reset();
        LocationRec.SetRange(code, FactoryNo);
        LocationRec.FindSet();

        //Create Calendars by Resource Capacity 
        WorkCenterRec.SETCURRENTKEY(WorkCenterRec.Name);
        //WorkCenterRec.SETRANGE(WorkCenterRec.Name);
        WorkCenterRec.SetFilter("Planning Line", '=%1', true);
        WorkCenterRec.SETRANGE("Factory No.", FactoryNo);

        IF WorkCenterRec.FIND('-') THEN
            REPEAT
                tempEntities := createJsonArray();
                ldnCalendar := createJsonObject();
                ldnCalendar.Add('ID', 'CalRes_' + WorkCenterRec."No.");
                lrecDate.SETRANGE(lrecDate."Period Type", lrecDate."Period Type"::Date);
                lrecDate.SETRANGE(lrecDate."Period Start", pStart, pEnd);

                IF lrecDate.FINDSET THEN
                    REPEAT

                        WorkCenterRec.SETRANGE("Date Filter", lrecDate."Period Start", lrecDate."Period Start");
                        ldnCalendarEntry := createJsonObject();
                        ldnCalendarEntry.Add('Start', CREATEDATETIME(lrecDate."Period Start", LocationRec."Start Time"));
                        ldnCalendarEntry.Add('End', CREATEDATETIME(lrecDate."Period Start", LocationRec."Finish Time"));

                        ResCapacityEntryRec.Reset();
                        ResCapacityEntryRec.SETRANGE("No.", WorkCenterRec."No.");
                        ResCapacityEntryRec.SETRANGE(Date, lrecDate."Period Start");

                        if ResCapacityEntryRec.FindSet() then
                            ldnCalendarEntry.Add('TimeType', 1)       //Working Day                
                        else
                            ldnCalendarEntry.Add('TimeType', 0);     //Non Working day

                        tempEntities.Add(ldnCalendarEntry);

                    UNTIL lrecDate.NEXT = 0;

                ldnCalendar.Add('Entries', tempEntities);
                pCalendars.Add(ldnCalendar);

            UNTIL WorkCenterRec.NEXT = 0;
    end;

    // procedure GetResourceCurve(pResource: Record "Work Center"; pCurve: JsonObject; pCurveType: Option; pStart: Date; pEnd: Date)
    // var
    //     ldnCurvePointEntry: JsonObject;
    //     lrecResource: Record "Work Center";
    //     lrecDate: Record 2000000007;
    //     tempCurvePointEntries: JsonArray;
    // begin
    //     lrecDate.SETRANGE(lrecDate."Period Type", lrecDate."Period Type"::Date);
    //     lrecDate.SETRANGE(lrecDate."Period Start", pStart, pEnd);
    //     IF lrecDate.FINDSET THEN
    //         REPEAT
    //             pResource.SETRANGE("Date Filter", lrecDate."Period Start", lrecDate."Period Start");
    //             ldnCurvePointEntry := createJsonObject();
    //             ldnCurvePointEntry.Add('PointInTime', CREATEDATETIME(lrecDate."Period Start", 000000T));
    //             CASE pCurveType OF
    //                 gCurveType::Capacity:
    //                     BEGIN
    //                         pResource.CALCFIELDS(pResource.Capacity);
    //                         ldnCurvePointEntry.Add('Value', pResource.Capacity);
    //                     END;
    //                 gCurveType::"Qty. on Order (Job)":
    //                     BEGIN
    //                         pResource.CALCFIELDS(pResource."Qty. on Order (Job)");
    //                         ldnCurvePointEntry.Add('Value', pResource."Qty. on Order (Job)");
    //                     END;
    //                 gCurveType::"Qty. Quoted (Job)":
    //                     BEGIN
    //                         pResource.CALCFIELDS(pResource."Qty. Quoted (Job)");
    //                         ldnCurvePointEntry.Add('Value', pResource."Qty. Quoted (Job)");
    //                     END;
    //                 gCurveType::"Qty. on Service Order":
    //                     BEGIN
    //                         pResource.CALCFIELDS(pResource."Qty. on Service Order");
    //                         ldnCurvePointEntry.Add('Value', pResource."Qty. on Service Order");
    //                     END;
    //                 gCurveType::"Qty. Sum All":
    //                     BEGIN
    //                         pResource.CALCFIELDS(pResource."Qty. on Order (Job)", pResource."Qty. Quoted (Job)", pResource."Qty. on Service Order");
    //                         ldnCurvePointEntry.Add('Value', pResource."Qty. on Order (Job)" + pResource."Qty. Quoted (Job)" + pResource."Qty. on Service Order");
    //                     END;
    //             END;
    //             tempCurvePointEntries.Add(ldnCurvePointEntry);
    //         UNTIL lrecDate.NEXT = 0;
    //     pCurve.Add('CurvePointEntries', tempCurvePointEntries);
    // end;

    procedure LoadActivities(pActivities: JsonArray;
                pStart: Date;
                pEnd: Date)
    var
        ldnActivity: JsonObject;
        lrecServiceHeader: Record 5900;
        lrecServiceItemLine: Record 5901;
    begin
        //Create Activities from Service Headers (Table 5900) and Service Item Lines (Table 5901)
        ldnActivity.Add('ID', 'Act_Service_Header');
        ldnActivity.Add('AddIn_TableText', 'Service Orders');
        pActivities.Add(ldnActivity);

        lrecServiceHeader.SETCURRENTKEY(lrecServiceHeader."Document Type", lrecServiceHeader."No.");
        lrecServiceHeader.SETRANGE(lrecServiceHeader."Document Type", lrecServiceHeader."Document Type"::Order);
        IF lrecServiceHeader.FIND('-') THEN
            REPEAT
                ldnActivity := createJsonObject();
                ldnActivity.Add('ID', 'Act_SH_' + FORMAT(lrecServiceHeader."No."));
                ldnActivity.Add('ParentID', 'Act_Service_Header');
                ldnActivity.Add('Start', CREATEDATETIME(lrecServiceHeader."Due Date", 120000T));
                ldnActivity.Add('PM_BarShape', 2);
                ldnActivity.Add('AddIn_TableText', FORMAT(lrecServiceHeader."No.") + ' (' + FORMAT(lrecServiceHeader."Due Date") + ')');
                ldnActivity.Add('PM_Color', '#e69500');
                ldnActivity.Add('AddIn_BarText', FORMAT(lrecServiceHeader."No."));
                ldnActivity.Add('AddIn_TooltipText', 'Service Header' +
                  '<br>Document Type: ' + FORMAT(lrecServiceHeader."Document Type") +
                  '<br>No.: ' + FORMAT(lrecServiceHeader."No.") +
                  '<br>Due Date: ' + FORMAT(lrecServiceHeader."Due Date"));
                ldnActivity.Add('AddIn_ContextMenuID', 'CM_Activity');
                ldnActivity.Add('PM_CollapseState', 1);
                pActivities.Add(ldnActivity);

                lrecServiceItemLine.SETCURRENTKEY(lrecServiceItemLine."Document Type", lrecServiceItemLine."Document No.", lrecServiceItemLine."Line No.");
                lrecServiceItemLine.SETRANGE(lrecServiceItemLine."Document Type", lrecServiceItemLine."Document Type"::Order);
                lrecServiceItemLine.SETRANGE(lrecServiceItemLine."Document No.", lrecServiceHeader."No.");
                IF lrecServiceItemLine.FIND('-') THEN
                    REPEAT
                        ldnActivity := createJsonObject();
                        ldnActivity.Add('ID', 'Act_SIL_' + FORMAT(lrecServiceHeader."No.") + '_' + FORMAT(lrecServiceItemLine."Line No."));
                        ldnActivity.Add('ParentID', 'Act_SH_' + FORMAT(lrecServiceHeader."No."));
                        ldnActivity.Add('Start', CREATEDATETIME(lrecServiceItemLine."Starting Date", lrecServiceItemLine."Starting Time"));
                        ldnActivity.Add('End', CREATEDATETIME(lrecServiceItemLine."Finishing Date", lrecServiceItemLine."Finishing Time"));
                        ldnActivity.Add('AddIn_TableText', FORMAT(lrecServiceItemLine."Line No.") + ' (' + FORMAT(lrecServiceItemLine.Description) + ')');
                        ldnActivity.Add('PM_Color', '#e69500');
                        ldnActivity.Add('AddIn_BarText', FORMAT(lrecServiceItemLine."Line No."));
                        ldnActivity.Add('AddIn_TooltipText', 'Service Header' +
                          '<br>Document Type: ' + FORMAT(lrecServiceHeader."Document Type") +
                          '<br>No.: ' + FORMAT(lrecServiceHeader."No.") +
                          '<br>Line No.: ' + FORMAT(lrecServiceItemLine."Line No."));
                        ldnActivity.Add('AddIn_ContextMenuID', 'CM_Activity');
                        pActivities.Add(ldnActivity);
                    UNTIL lrecServiceItemLine.NEXT = 0;
            UNTIL lrecServiceHeader.NEXT = 0;
    end;

    procedure LoadAllocations(pActivities: JsonArray; pAllocations: JsonArray; pStart: Date; pEnd: Date)
    var
        ldnActivity: JsonObject;
        ldnAllocation: JsonObject;
        lrecSOAllocation: Record 5950;
        lrecJobPlanningLine: Record "NavApp Planning Lines";
        NavAppSetupRec: Record "NavApp Setup";
        StyleMasPoRec: Record "Style Master PO";
        StyleMasRec: Record "Style Master";
        tempEntry: JsonObject;
        tempEntries: JsonArray;
        tempText: Text;
        Brand: Text[200];
        ShiDate: Date;
    // dStart: Date;
    // dEnd: Date;
    begin
        // //Create Allocations from Service Order Allocations (Table 5950)
        // lrecSOAllocation.SETCURRENTKEY(lrecSOAllocation."Allocation Date", lrecSOAllocation.Status);
        // lrecSOAllocation.SETRANGE(lrecSOAllocation.Status, lrecSOAllocation.Status::Active);
        // lrecSOAllocation.SETRANGE(lrecSOAllocation."Allocation Date", pStart, pEnd);
        // IF lrecSOAllocation.FIND('-') THEN
        //     REPEAT
        //         IF (lrecSOAllocation."Resource No." <> '') THEN BEGIN
        //             IF ((lrecSOAllocation."Starting Time" <> 0T) AND (lrecSOAllocation."Finishing Time" <> 0T)) THEN BEGIN
        //                 ldnAllocation := createJsonObject();
        //                 ldnAllocation.Add('ID', 'SOA_' + FORMAT(lrecSOAllocation."Entry No."));
        //                 ldnAllocation.Add('ActivityID', 'Act_SOA_' + FORMAT(lrecSOAllocation."Entry No."));
        //                 ldnAllocation.Add('ResourceID', 'R_' + lrecSOAllocation."Resource No.");
        //                 tempEntries := createJsonArray();
        //                 tempEntry := createJsonObject();
        //                 tempEntry.Add('Start', CREATEDATETIME(lrecSOAllocation."Allocation Date", lrecSOAllocation."Starting Time"));
        //                 tempEntry.Add('End', CREATEDATETIME(lrecSOAllocation."Allocation Date", lrecSOAllocation."Finishing Time"));
        //                 tempEntry.Add('PM_Color', '#e69500');
        //                 tempEntries.Add(tempEntry);
        //                 ldnAllocation.Add('Entries', tempEntries);
        //                 ldnAllocation.Add('AddIn_BarText', 'Document No.: ' + lrecSOAllocation."Document No.");
        //                 ldnAllocation.Add('AddIn_TooltipText', 'Service Order Allocation:<br>Entry No.: ' + FORMAT(lrecSOAllocation."Entry No.") + '<br>Document No.: ' + FORMAT(lrecSOAllocation."Document No."));
        //                 ldnAllocation.Add('AddIn_ContextMenuID', 'CM_Allocation');
        //                 pAllocations.Add(ldnAllocation);
        //             END;
        //         END
        //         ELSE BEGIN
        //             IF (lrecSOAllocation."Resource Group No." <> '') THEN BEGIN
        //                 IF ((lrecSOAllocation."Starting Time" <> 0T) AND (lrecSOAllocation."Finishing Time" <> 0T)) THEN BEGIN
        //                     ldnAllocation := createJsonObject();
        //                     ldnAllocation.Add('ID', 'SOA_' + FORMAT(lrecSOAllocation."Entry No."));
        //                     ldnAllocation.Add('ActivityID', 'Act_SOA_' + FORMAT(lrecSOAllocation."Entry No."));
        //                     ldnAllocation.Add('ResourceID', 'RG1_' + lrecSOAllocation."Resource Group No.");
        //                     tempEntries := createJsonArray();
        //                     tempEntry := createJsonObject();
        //                     tempEntry.Add('Start', CREATEDATETIME(lrecSOAllocation."Allocation Date", lrecSOAllocation."Starting Time"));
        //                     tempEntry.Add('End', CREATEDATETIME(lrecSOAllocation."Allocation Date", lrecSOAllocation."Finishing Time"));
        //                     tempEntry.Add('PM_Color', 'yellow');
        //                     tempEntries.Add(tempEntry);
        //                     ldnAllocation.Add('Entries', tempEntries);
        //                     ldnAllocation.Add('AddIn_BarText', 'Document No.: ' + lrecSOAllocation."Document No.");
        //                     ldnAllocation.Add('AddIn_TooltipText', 'Service Order Allocation:<br>Entry No.: ' + FORMAT(lrecSOAllocation."Entry No.") + '<br>Document No.: ' + FORMAT(lrecSOAllocation."Document No."));
        //                     ldnAllocation.Add('AddIn_ContextMenuID', 'CM_Allocation');
        //                     pAllocations.Add(ldnAllocation);
        //                 END;
        //             END
        //         END;
        //     UNTIL lrecSOAllocation.NEXT = 0;



        //Create Allocations from Job Planning Lines (Table 50342)

        //lrecJobPlanningLine.SETRANGE(lrecJobPlanningLine.Type, lrecJobPlanningLine.Type::Resource);
        //Evaluate(dStart, format(pStart));
        //Evaluate(dEnd, format(pEnd));

        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();
        pStart := pStart - 30;

        lrecJobPlanningLine.SETCURRENTKEY(lrecJobPlanningLine."Start Date");
        lrecJobPlanningLine.SetRange(lrecJobPlanningLine."Start Date", pStart, pEnd);

        IF lrecJobPlanningLine.FIND('-') THEN
            REPEAT

                StyleMasPoRec.Reset();
                StyleMasPoRec.SetRange("Style No.", lrecJobPlanningLine."Style No.");
                StyleMasPoRec.SetRange("PO No.", lrecJobPlanningLine."PO No.");
                if StyleMasPoRec.FindSet() then
                    ShiDate := StyleMasPoRec."Ship Date";

                StyleMasRec.Reset();
                StyleMasRec.SetRange("No.", lrecJobPlanningLine."Style No.");
                if StyleMasRec.FindSet() then begin
                    Brand := StyleMasRec."Brand Name";
                end
                else begin
                    Brand := '';
                end;


                //tempText := 'JPL_' + FORMAT(lrecJobPlanningLine."Job No.") + '_' + FORMAT(lrecJobPlanningLine."Job Task No.") + '_' + FORMAT(lrecJobPlanningLine."Line No.");
                tempText := lrecJobPlanningLine."Style No." + '/' + lrecJobPlanningLine."Lot No." + '/' + lrecJobPlanningLine."PO No." + '/' + FORMAT(lrecJobPlanningLine."Line No.");
                ldnAllocation := createJsonObject();
                ldnAllocation.Add('ID', tempText);
                ldnAllocation.Add('ResourceID', 'R_' + lrecJobPlanningLine."Resource No.");
                tempEntries := createJsonArray();
                tempEntry := createJsonObject();
                tempEntry.Add('Start', CREATEDATETIME(lrecJobPlanningLine."Start Date", lrecJobPlanningLine."Start Time"));
                tempEntry.Add('End', CREATEDATETIME(lrecJobPlanningLine."End Date", lrecJobPlanningLine."Finish Time"));

                if lrecJobPlanningLine."End Date" > lrecJobPlanningLine."TGTSEWFIN Date" then
                    tempEntry.Add('PM_Color', '#e11f1f')
                else begin
                    if lrecJobPlanningLine."Start Date" < StyleMasPoRec.BPCD then
                        tempEntry.Add('PM_Color', '#09479b')
                    else
                        tempEntry.Add('PM_Color', '#28e554');
                end;

                tempEntries.Add(tempEntry);
                ldnAllocation.Add('Entries', tempEntries);
                ldnAllocation.Add('AddIn_BarText', lrecJobPlanningLine."Style Name" + '/' + lrecJobPlanningLine."Lot No." + '/' + lrecJobPlanningLine."PO No." + '/' + FORMAT(lrecJobPlanningLine."Line No."));
                //ldnAllocation.Add('AddIn_BarText', FORMAT(lrecJobPlanningLine."Line No."));
                ldnAllocation.Add('AddIn_TooltipText', 'Buyer : ' + FORMAT(StyleMasRec."Buyer Name") +
                  '<br>Brand : ' + FORMAT(Brand) +
                  '<br>Style : ' + FORMAT(lrecJobPlanningLine."Style Name") +
                  '<br>PO No : ' + FORMAT(lrecJobPlanningLine."PO No.") +
                  '<br>Order Qty : ' + FORMAT(StyleMasPoRec.Qty) +
                  '<br>Plan Qty : ' + FORMAT(lrecJobPlanningLine.Qty) +
                  '<br>SMV : ' + FORMAT(lrecJobPlanningLine.SMV) +
                  '<br>MC : ' + FORMAT(lrecJobPlanningLine.Carder) +
                  '<br>Plan Eff% : ' + FORMAT(lrecJobPlanningLine.Eff) +
                  '<br>Learning Curve : ' + FORMAT(lrecJobPlanningLine."Learning Curve No.") +
                  '<br>BPCD : ' + FORMAT(StyleMasPoRec.BPCD) +
                  '<br>Start D/T : ' + FORMAT(CREATEDATETIME(lrecJobPlanningLine."Start Date", lrecJobPlanningLine."Start Time")) +
                  '<br>Finish D/T : ' + FORMAT(CREATEDATETIME(lrecJobPlanningLine."End Date", lrecJobPlanningLine."Finish Time")) +
                  '<br>Ship Date : ' + FORMAT(CreateDateTime(ShiDate, 0T)));
                //   '<br>StartDateTime  : ' + FORMAT(lrecJobPlanningLine.StartDateTime) +
                //   '<br>FinishtDateTime : ' + FORMAT(lrecJobPlanningLine.FinishDateTime));
                ldnAllocation.Add('AddIn_ContextMenuID', 'CM_Allocation');

                ldnAllocation.Add('PM_BarHeight', '15');
                //ldnAllocation.Add('PM_MinimumRowHeight', '19');
                // ldnAllocation.Add('PM_TopRowMarginInTimeArea', '2');
                // ldnAllocation.Add('PM_BottomRowMarginInTimeArea', '2');
                pAllocations.Add(ldnAllocation);

            UNTIL lrecJobPlanningLine.NEXT = 0;

        //'<br>Line No : ' + FORMAT(lrecJobPlanningLine."Line No.") +
    end;

    procedure LoadEntities(pEntities: JsonArray)
    var
        // i: Integer;
        // j: Integer;
        // lchLetter: Char;
        ldnEntity: JsonObject;
        tempEntityToken: JsonToken;
        TempString: Text;
        PlanningQueueRec: Record "Planning Queue";
        StyleMasRec: Record "Style Master";
        Brand: text[200];
    begin

        PlanningQueueRec.Reset();
        PlanningQueueRec.SetRange("User ID", UserId);

        if PlanningQueueRec.FindSet() then begin
            repeat

                StyleMasRec.Reset();
                StyleMasRec.SetRange("No.", PlanningQueueRec."Style No.");
                if StyleMasRec.FindSet() then
                    Brand := StyleMasRec."Brand Name"
                else
                    Brand := '';

                TempString := PlanningQueueRec."Style Name" + '-' + PlanningQueueRec."Lot No." + '-' + PlanningQueueRec."PO No." + '-' + format(PlanningQueueRec."TGTSEWFIN Date") + '-' + format(PlanningQueueRec.Qty);
                ldnEntity := createJsonObject();
                ldnEntity.Add('ID', PlanningQueueRec."Queue No.");
                ldnEntity.Add('PM_TableColor', '#2672ab');
                ldnEntity.Add('PM_TableTextColor', 'white');
                //ldnEntity.Add('PM_MinimumRowHeight', '19');
                ldnEntity.Add('AddIn_TableText', TempString);
                ldnEntity.Get('ID', tempEntityToken);
                ldnEntity.Add('AddIn_ContextMenuID', 'CM_Entity');
                ldnEntity.Add('AddIn_TooltipText', 'Brand : ' + FORMAT(Brand) + '<br>' + 'Style : ' + FORMAT(PlanningQueueRec."Style Name") + '<br>' + 'LOT : ' + FORMAT(PlanningQueueRec."Lot No.") + '<br>' + 'PO : ' + FORMAT(PlanningQueueRec."PO No.") + '<br>' + 'Ship Date : ' + FORMAT(PlanningQueueRec."TGTSEWFIN Date") + '<br>' + 'Qty : ' + FORMAT(PlanningQueueRec.Qty - Round(PlanningQueueRec.Waistage, 1)) + '<br>' + 'Qty With Waistage : ' + FORMAT(PlanningQueueRec.Qty));
                pEntities.Add(ldnEntity);

            until PlanningQueueRec.Next() = 0;
        end;

        // FOR i := 65 TO 70 DO BEGIN
        //     lchLetter := i;
        //     ldnEntity := createJsonObject();
        //     ldnEntity.Add('ID', 'BA_Job_' + FORMAT(lchLetter));
        //     ldnEntity.Get('ID', tempEntityToken);
        //     ldnEntity.Add('PM_TableColor', 'darkgreen');
        //     ldnEntity.Add('PM_TableTextColor', 'white');
        //     ldnEntity.Add('AddIn_TooltipText', 'Backlog job:<br>' + FORMAT(tempEntityToken.AsValue().AsText()));
        //     ldnEntity.Add('AddIn_TableText', 'Job ' + FORMAT(lchLetter));
        //     IF (i = 66) THEN
        //         ldnEntity.Add('PM_CollapseState', 1);
        //     pEntities.Add(ldnEntity);
        //     FOR j := 1 TO 3 DO BEGIN
        //         ldnEntity := createJsonObject();
        //         ldnEntity.Add('ID', 'BA_Job_' + FORMAT(lchLetter) + '_Task_' + FORMAT(j));
        //         ldnEntity.Add('PM_TableColor', 'seagreen');
        //         ldnEntity.Add('PM_TableTextColor', 'white');
        //         ldnEntity.Add('AddIn_TableText', 'Task ' + FORMAT(j));
        //         ldnEntity.Get('ID', tempEntityToken);
        //         ldnEntity.Add('AddIn_TooltipText', 'Backlog task:<br>' + FORMAT(tempEntityToken.AsValue().AsText()));
        //         ldnEntity.Add('ParentID', 'BA_Job_' + FORMAT(lchLetter));
        //         ldnEntity.Add('AddIn_ContextMenuID', 'CM_Entity');
        //         pEntities.Add(ldnEntity);
        //     END
        // END
    end;

    procedure LoadContextMenus(pContextMenus: JsonArray)
    var
        ldnContextMenu: JsonObject;
        ldnContextMenuItem: JsonObject;
        tempEntries: JsonArray;
    begin
        //ldnContextMenu.Add('ID', 'CM_ResourceGroup');

        // ldnContextMenuItem.Add('Text', 'ResourceGroup CM-Entry 01');
        // ldnContextMenuItem.Add('Code', 'RG_01');
        // ldnContextMenuItem.Add('SortCode', 'a');
        // tempEntries.Add(ldnContextMenuItem);

        // ldnContextMenuItem := createJsonObject();
        // ldnContextMenuItem.Add('Text', 'ResourceGroup CM-Entry 02');
        // ldnContextMenuItem.Add('Code', 'RG_02');
        // ldnContextMenuItem.Add('SortCode', 'b');
        // tempEntries.Add(ldnContextMenuItem);

        // ldnContextMenu.Add('Items', tempEntries);
        // pContextMenus.Add(ldnContextMenu);

        // ldnContextMenu := createJsonObject();
        // ldnContextMenu.Add('ID', 'CM_Resource');
        // tempEntries := createJsonArray();
        // ldnContextMenuItem := createJsonObject();
        // ldnContextMenuItem.Add('Text', 'Resource CM-Entry 01');
        // ldnContextMenuItem.Add('Code', 'R_01');
        // ldnContextMenuItem.Add('SortCode', 'a');
        // tempEntries.Add(ldnContextMenuItem);

        // ldnContextMenuItem := createJsonObject();
        // ldnContextMenuItem.Add('Text', 'Resource CM-Entry 02');
        // ldnContextMenuItem.Add('Code', 'R_02');
        // ldnContextMenuItem.Add('SortCode', 'b');
        // tempEntries.Add(ldnContextMenuItem);

        // ldnContextMenu.Add('Items', tempEntries);
        // pContextMenus.Add(ldnContextMenu);

        // ldnContextMenu := createJsonObject();
        // ldnContextMenu.Add('ID', 'CM_Activity');
        // tempEntries := createJsonArray();
        // ldnContextMenuItem := createJsonObject();
        // ldnContextMenuItem.Add('Text', 'Activity CM-Entry 01');
        // ldnContextMenuItem.Add('Code', 'A_01');
        // ldnContextMenuItem.Add('SortCode', 'a');
        // tempEntries.Add(ldnContextMenuItem);
        // ldnContextMenuItem := createJsonObject();
        // ldnContextMenuItem.Add('Text', 'Activity CM-Entry 02');
        // ldnContextMenuItem.Add('Code', 'A_02');
        // ldnContextMenuItem.Add('SortCode', 'b');
        // tempEntries.Add(ldnContextMenuItem);
        // ldnContextMenu.Add('Items', tempEntries);
        // pContextMenus.Add(ldnContextMenu);


        //Allocation
        ldnContextMenu := createJsonObject();
        ldnContextMenu.Add('ID', 'CM_Allocation');
        tempEntries := createJsonArray();
        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Properties');
        ldnContextMenuItem.Add('Code', 'Al_01');
        ldnContextMenuItem.Add('SortCode', 'a');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Cut');
        ldnContextMenuItem.Add('Code', 'Al_02');
        ldnContextMenuItem.Add('SortCode', 'b');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Return to Queue');
        ldnContextMenuItem.Add('Code', 'Al_03');
        ldnContextMenuItem.Add('SortCode', 'c');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Plan Target');
        ldnContextMenuItem.Add('Code', 'Al_04');
        ldnContextMenuItem.Add('SortCode', 'd');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Plan History');
        ldnContextMenuItem.Add('Code', 'Al_05');
        ldnContextMenuItem.Add('SortCode', 'e');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Planned Vs Achieved');
        ldnContextMenuItem.Add('Code', 'Al_06');
        ldnContextMenuItem.Add('SortCode', 'f');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Plan MC Req.');
        ldnContextMenuItem.Add('Code', 'Al_07');
        ldnContextMenuItem.Add('SortCode', 'g');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Accessories Status');
        ldnContextMenuItem.Add('Code', 'Al_08');
        ldnContextMenuItem.Add('SortCode', 'h');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'W.I.P.');
        ldnContextMenuItem.Add('Code', 'Al_09');
        ldnContextMenuItem.Add('SortCode', 'j');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Garment Picture');
        ldnContextMenuItem.Add('Code', 'Al_10');
        ldnContextMenuItem.Add('SortCode', 'k');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Time and Action Plan');
        ldnContextMenuItem.Add('Code', 'Al_11');
        ldnContextMenuItem.Add('SortCode', 'l');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Search By Style/Return To Queue');
        ldnContextMenuItem.Add('Code', 'Al_12');
        ldnContextMenuItem.Add('SortCode', 'm');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenu.Add('Items', tempEntries);
        pContextMenus.Add(ldnContextMenu);


        //Queue Menu
        ldnContextMenu := createJsonObject();
        ldnContextMenu.Add('ID', 'CM_Entity');
        tempEntries := createJsonArray();

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Split');
        ldnContextMenuItem.Add('Code', 'E_01');
        ldnContextMenuItem.Add('SortCode', 'a');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Split more');
        ldnContextMenuItem.Add('Code', 'E_02');
        ldnContextMenuItem.Add('SortCode', 'b');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Delete');
        ldnContextMenuItem.Add('Code', 'E_03');
        ldnContextMenuItem.Add('SortCode', 'c');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Properties');
        ldnContextMenuItem.Add('Code', 'E_04');
        ldnContextMenuItem.Add('SortCode', 'd');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Accessories Status');
        ldnContextMenuItem.Add('Code', 'E_05');
        ldnContextMenuItem.Add('SortCode', 'e');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'WIP');
        ldnContextMenuItem.Add('Code', 'E_06');
        ldnContextMenuItem.Add('SortCode', 'f');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Delete From Queue');
        ldnContextMenuItem.Add('Code', 'E_07');
        ldnContextMenuItem.Add('SortCode', 'h');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenuItem := createJsonObject();
        ldnContextMenuItem.Add('Text', 'Size/Color Wise Qty Breakdown Report');
        ldnContextMenuItem.Add('Code', 'E_08');
        ldnContextMenuItem.Add('SortCode', 'i');
        tempEntries.Add(ldnContextMenuItem);

        ldnContextMenu.Add('Items', tempEntries);
        pContextMenus.Add(ldnContextMenu);

    end;



}

