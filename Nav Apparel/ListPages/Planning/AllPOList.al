
page 50489 "All PO List"
{
    PageType = Card;
    SourceTable = StyleMaster_StyleMasterPO_T;
    SourceTableView = sorting(Buyer, Style_No, PONo, ShipDate) where(PlannedStatus = filter(false), smv = filter(> 0));
    DeleteAllowed = false;
    InsertAllowed = false;
    Caption = 'Pending PO Plan';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(select; rec.select)
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                        T: Record StyleMaster_StyleMasterPO_T;
                    begin
                        Rec.Amount := 0;
                        CurrPage.Update();
                        T.Reset();
                        T.FindSet();
                        repeat
                            if T.Select = true then
                                Rec.Amount += T.Qty;
                        until T.Next() = 0;
                        CurrPage.Update();
                    end;
                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                //Done By Sachith on 27/03/23
                field(Brand; Rec.Brand)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Style_No; rec.Style_No)
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field(Lot_No; Rec.Lot_No)
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                    Editable = false;
                }

                field(PONo; Rec.PONo)
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                    Editable = false;
                }

                field("Order Qty"; Rec."Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Order Qty';
                }

                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Qty';
                }

                //Done By sachith on 27/03/23
                field("Sewing Out Qty"; Rec."Sewing Out Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Mode; Rec.Mode)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SMV; Rec.SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(BPCD; Rec.BPCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(ShipDate; Rec.ShipDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Production File Handover Date"; Rec."Production File Handover Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(UnitPrice; Rec.UnitPrice)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(ConfirmDate; Rec.ConfirmDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            //Done By Sachith on 27/03/23
            group(Total)
            {
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Qty';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            //Done By Sachith on 27/03/23
            action("Export To Excel")
            {
                ApplicationArea = all;
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Export To Excel';

                trigger OnAction()
                var
                begin
                    ExportData(Rec);
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        StyleMasterPORec: Record "Style Master PO";
        TempRec: Record StyleMaster_StyleMasterPO_T;
        PlanningQueueRec: Record "Planning Queue";
        WastageRec: Record Wastage;
        PlanningQueueNewRec: Record "Planning Queue";
        StyleMasterRec: Record "Style Master";
        StyleMasterPONewRec: Record "Style Master PO";
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
        NavAppSetupRec: Record "NavApp Setup";
        Waistage: Decimal;
        QtyWithWaistage: Decimal;
        QueueNo: Decimal;
        x: Decimal;
        Temp: Decimal;
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
            LoginSessionsRec.FindSet();
        end;

        if CloseAction = Action::LookupOK then begin

            NavAppSetupRec.Reset();
            NavAppSetupRec.FindSet();

            //Get Max Lineno
            PlanningQueueRec.Reset();
            if PlanningQueueRec.FindLast() then
                QueueNo := PlanningQueueRec."Queue No.";

            Waistage := 0;
            QtyWithWaistage := 0;

            TempRec.Reset();
            TempRec.SetRange(select, true);
            TempRec.SetFilter(PlannedStatus, '=%1', false);
            //TempRec.SetFilter(Status, '=%1', TempRec.Status::Confirm); //Nevil asked to remove this

            if TempRec.FindSet() then begin
                repeat
                    if TempRec.PlannedStatus = false then begin
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", TempRec.No);
                        StyleMasterPORec.SetRange("Lot No.", TempRec.Lot_No);
                        if not StyleMasterPORec.FindSet() then
                            Error('Cannot find PO details.');

                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                        if not StyleMasterRec.FindSet() then
                            Error('Cannot find Style details.');

                        // //Get the wastage from wastage table
                        // WastageRec.Reset();
                        // WastageRec.SetFilter("Start Qty", '<=%1', StyleMasterPORec.Qty);
                        // WastageRec.SetFilter("Finish Qty", '>=%1', StyleMasterPORec.Qty);

                        // if WastageRec.FindSet() then
                        //     Waistage := WastageRec.Percentage;

                        // QueueNo += 1;
                        // if StyleMasterPORec."Cut In Qty" <= (StyleMasterPORec.Qty + (StyleMasterPORec.Qty * Waistage) / 100) then begin
                        //     Temp := StyleMasterPORec.Qty - StyleMasterPORec.PlannedQty - StyleMasterPORec."Sawing Out Qty";
                        //     QtyWithWaistage := Temp + (Temp * Waistage) / 100;
                        //     QtyWithWaistage := Round(QtyWithWaistage, 1);
                        //     x := StyleMasterPORec.PlannedQty + StyleMasterPORec."Sawing Out Qty" + StyleMasterPORec.QueueQty + StyleMasterPORec.Waistage;
                        // end
                        // else begin
                        //     Waistage := 0;
                        //     Temp := StyleMasterPORec."Cut In Qty" - StyleMasterPORec.PlannedQty - StyleMasterPORec."Sawing Out Qty";
                        //     QtyWithWaistage := Temp;
                        //     QtyWithWaistage := Round(QtyWithWaistage, 1);
                        //     x := StyleMasterPORec.PlannedQty + StyleMasterPORec."Sawing Out Qty" + StyleMasterPORec.QueueQty + StyleMasterPORec.Waistage;
                        // end;

                        //if StyleMasterPORec.Qty > x then begin

                        //Insert new line to Queue
                        QueueNo += 1;
                        PlanningQueueNewRec.Init();
                        PlanningQueueNewRec."Queue No." := QueueNo;
                        PlanningQueueNewRec."Style No." := TempRec.No;
                        PlanningQueueNewRec."Style Name" := TempRec.Style_No;
                        PlanningQueueNewRec."PO No." := TempRec.PONo;
                        PlanningQueueNewRec."Lot No." := TempRec.Lot_No;
                        PlanningQueueNewRec.Qty := TempRec.Qty;
                        PlanningQueueNewRec.Waistage := TempRec.Waistage;
                        // PlanningQueueNewRec.Waistage := 0;  
                        PlanningQueueNewRec.SMV := TempRec.SMV;
                        PlanningQueueNewRec.Factory := Factory;
                        PlanningQueueNewRec."TGTSEWFIN Date" := StyleMasterPORec."Ship Date" - NavAppSetupRec."Sewing Finished";
                        PlanningQueueNewRec."Learning Curve No." := learningcurve;
                        PlanningQueueNewRec."Resource No" := '';
                        PlanningQueueNewRec.Front := StyleMasterRec.Front;
                        PlanningQueueNewRec.Back := StyleMasterRec.Back;
                        PlanningQueueNewRec."User ID" := UserId;
                        PlanningQueueNewRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        PlanningQueueNewRec."Created Date" := WorkDate();
                        PlanningQueueNewRec."Created User" := UserId;
                        PlanningQueueNewRec.Insert();

                        //Update Style Master PO
                        StyleMasterPONewRec.Reset();
                        StyleMasterPONewRec.SetRange("Style No.", StyleMasterPORec."Style No.");
                        StyleMasterPONewRec.SetRange("Lot No.", StyleMasterPORec."Lot No.");
                        if StyleMasterPONewRec.FindSet() then begin
                            StyleMasterPONewRec.PlannedStatus := true;
                            StyleMasterPONewRec.QueueQty := TempRec.Qty;
                            StyleMasterPONewRec.Waistage := TempRec.Waistage;
                            StyleMasterPONewRec.Modify();
                        end;
                        //end;
                    end;
                until TempRec.Next = 0;
            end;
        end;
    end;


    trigger OnOpenPage()
    var
        TempQuery: Query StyleMaster_StyleMasterPO_Q;
        TempRec: Record StyleMaster_StyleMasterPO_T;
        LoginRec: Page "Login Card";
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        LoginSessionsRec: Record LoginSessions;
        NavAppLineRec: Record "NavApp Planning Lines";
        ProcutionOutHeaderRec: Record ProductionOutHeader;
        WastageRec: Record Wastage;
        QtyWithWaistage: Decimal;
        x: Integer;
        Temp: Decimal;
        Waistage: Decimal;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

        //Delete old records
        TempRec.Reset();
        if TempRec.FindSet() then
            TempRec.DeleteAll();

        //Insert records from query 
        if TempQuery.Open() then begin
            while TempQuery.Read() do begin

                StyleMasterPORec.Reset();
                StyleMasterPORec.SetRange("Style No.", TempQuery.No);
                StyleMasterPORec.SetRange("Lot No.", TempQuery.Lot_No);
                if not StyleMasterPORec.FindSet() then
                    Error('Cannot find PO : %1.', TempQuery.PONo);

                //Get the wastage from wastage table
                Waistage := 0;
                WastageRec.Reset();
                WastageRec.SetFilter("Start Qty", '<=%1', StyleMasterPORec.Qty);
                WastageRec.SetFilter("Finish Qty", '>=%1', StyleMasterPORec.Qty);

                if WastageRec.FindSet() then
                    Waistage := WastageRec.Percentage;

                if StyleMasterPORec."Cut In Qty" > (StyleMasterPORec.Qty + (StyleMasterPORec.Qty * Waistage) / 100) then begin
                    Temp := StyleMasterPORec."Cut In Qty" - StyleMasterPORec."Sawing Out Qty" - StyleMasterPORec.QueueQty - StyleMasterPORec.PlannedQty;
                    QtyWithWaistage := Temp;  // + (Temp * Waistage) / 100;
                                              //QtyWithWaistage := Round(QtyWithWaistage, 1);
                                              //x := StyleMasterPORec.PlannedQty + StyleMasterPORec."Sawing Out Qty" + StyleMasterPORec.QueueQty + StyleMasterPORec.Waistage;
                end
                else begin
                    Temp := StyleMasterPORec.Qty - StyleMasterPORec."Sawing Out Qty" - StyleMasterPORec.QueueQty - StyleMasterPORec.PlannedQty;
                    QtyWithWaistage := Temp;
                    QtyWithWaistage := QtyWithWaistage + (StyleMasterPORec.Qty * Waistage) / 100;
                    QtyWithWaistage := Round(QtyWithWaistage, 1);
                    //x := StyleMasterPORec.PlannedQty + StyleMasterPORec."Sawing Out Qty" + StyleMasterPORec.QueueQty + StyleMasterPORec.Waistage;
                end;

                if (QtyWithWaistage > 0) then begin
                    Rec.Init();
                    Rec.BPCD := TempQuery.BPCD;
                    Rec.Buyer := TempQuery.Buyer_Name;
                    Rec.ConfirmDate := TempQuery.ConfirmDate;
                    Rec.Lot_No := TempQuery.Lot_No;
                    Rec.Mode := TempQuery.Mode;
                    Rec.No := TempQuery.No;
                    Rec.PlannedStatus := TempQuery.PlannedStatus;
                    Rec.PONo := TempQuery.PONo;
                    // Rec.Qty := TempQuery.Qty - TempQuery.PlannedQty - TempQuery.SawingOutQty;   
                    // Rec.Qty := TempQuery.Qty - TempQuery.SawingOutQty;  //Nevil asked to remove paln qty
                    Rec.Qty := QtyWithWaistage;
                    Rec."Order Qty" := StyleMasterPORec.Qty;
                    Rec.Waistage := (Temp * Waistage) / 100;
                    Rec.Select := TempQuery.Select;
                    Rec.ShipDate := TempQuery.ShipDate;
                    Rec.SID := TempQuery.SID;
                    Rec.SMV := TempQuery.SMV;
                    Rec.Status := TempQuery.Status;
                    Rec.Style_No := TempQuery.Style_No;
                    Rec.UnitPrice := TempQuery.UnitPrice;
                    Rec."Sewing Out Qty" := StyleMasterPORec."Sawing Out Qty";
                    Rec."Production File Handover Date" := TempQuery.Production_File_Handover_Date;

                    // Done By Sachith On 27/03/23
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", TempQuery.No);
                    if StyleMasterRec.FindSet() then
                        Rec.Brand := StyleMasterRec."Brand Name";

                    Rec.Insert();
                end;
            end;
            TempQuery.Close();
        end;
    end;


    var
        Factory: Code[20];
        learningcurve: integer;


    //Done By Sachith on 27/03/23
    procedure ExportData(var StyleMasterQuaryRec: Record StyleMaster_StyleMasterPO_T)
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Exellable: Label 'All PO List';
        ExcelFileName: Label 'All Po List';
    begin

        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(Buyer), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(Brand), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(Style_No), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(Lot_No), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(PONo), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption("Order Qty"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(Qty), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption("Sewing Out Qty"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(Mode), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(SMV), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(BPCD), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(ShipDate), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption("Production File Handover Date"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(Status), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(StyleMasterQuaryRec.FieldCaption(ConfirmDate), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);


        if StyleMasterQuaryRec.FindSet() then begin
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.Buyer, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.Brand, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.Style_No, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.Lot_No, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.PONo, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec."Order Qty", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.Qty, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec."Sewing Out Qty", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.Mode, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.SMV, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.BPCD, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.ShipDate, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec."Production File Handover Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(StyleMasterQuaryRec.ConfirmDate, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
            until StyleMasterQuaryRec.Next() = 0;
        end;

        TempExcelBuffer.CreateNewBook(ExcelFileName);
        TempExcelBuffer.WriteSheet(ExcelFileName, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();

    end;


    procedure PassParameters(FactoryPara: Code[20]; learningcurvePara: Integer);
    var
    begin
        Factory := FactoryPara;
        learningcurve := learningcurvePara;
    end;

}


