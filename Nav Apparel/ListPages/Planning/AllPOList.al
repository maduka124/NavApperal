
page 50489 "All PO List"
{
    PageType = Card;
    SourceTable = StyleMaster_StyleMasterPO_TNew;
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
                        T: Record StyleMaster_StyleMasterPO_TNew;
                    begin
                        //Check the user is planning user or not
                        if PlanningUser = false then
                            Error('You are not authorized to perform this task.');

                        Total := 0;
                        CurrPage.Update();
                        T.Reset();
                        T.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
                        T.FindSet();
                        repeat
                            if T.Select = true then
                                Total += T.Qty;
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
                    Caption = 'Prod File H/o';
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
            group(Filter)
            {
                grid("")
                {
                    GridLayout = Columns;

                    field(Buyer1; Buyer1)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer';

                        trigger OnValidate()
                        var
                        begin
                            UnCheckAll(1, Buyer1);
                        end;
                    }

                    field(BuyerBrand; BuyerBrand)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer/Brand';

                        trigger OnValidate()
                        var
                        begin
                            UnCheckAll(2, BuyerBrand);
                        end;
                    }

                    field(BuyerBrandStyle; BuyerBrandStyle)
                    {
                        ApplicationArea = All;
                        Caption = 'Buyer/Brand/Style';

                        trigger OnValidate()
                        var
                        begin
                            UnCheckAll(3, BuyerBrandStyle);
                        end;
                    }

                    // field(Brand1; Brand1)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Brand';

                    //     trigger OnValidate()
                    //     var
                    //     begin
                    //         UnCheckAll(4, Brand1);
                    //     end;
                    // }

                    // field(BrandStyle; BrandStyle)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Brand/Style';

                    //     trigger OnValidate()
                    //     var
                    //     begin
                    //         UnCheckAll(5, BrandStyle);
                    //     end;
                    // }

                    // field(Style1; Style1)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Style';

                    //     trigger OnValidate()
                    //     var
                    //     begin
                    //         UnCheckAll(6, Style1);
                    //     end;
                    // }

                    field(Total; Total)
                    {
                        ApplicationArea = All;
                        Caption = 'Total';
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Select All")
            {
                Caption = 'Select All';
                Image = SelectMore;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ReqRec: Record StyleMaster_StyleMasterPO_TNew;
                begin
                    //Check the user is planning user or not
                    if PlanningUser = false then
                        Error('You are not authorized to perform this task.');

                    //Check selection
                    if (Buyer1 = false) and (BuyerBrand = false) and (BuyerBrandStyle = false) and (BrandStyle = false) and (Style1 = false) and (Brand1 = false) then
                        Error('Select at least one filter');

                    //Delsect All
                    ReqRec.Reset();
                    ReqRec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
                    if ReqRec.FindSet() then
                        ReqRec.ModifyAll(Select, false);

                    ReqRec.Reset();
                    ReqRec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");

                    //Filter for the selected fields combination
                    if Buyer1 then
                        ReqRec.SetRange(Buyer, rec.Buyer);

                    if BuyerBrand then begin
                        ReqRec.SetRange(Buyer, rec.Buyer);
                        ReqRec.SetRange(Brand, rec.Brand);
                    end;

                    if BuyerBrandStyle then begin
                        ReqRec.SetRange(Buyer, rec.Buyer);
                        ReqRec.SetRange(Brand, rec.Brand);
                        ReqRec.SetRange(Style_No, rec.Style_No);
                    end;

                    if BrandStyle then begin
                        ReqRec.SetRange(Brand, rec.Brand);
                        ReqRec.SetRange(Style_No, rec.Style_No);
                    end;

                    if Style1 then begin
                        ReqRec.SetRange(Style_No, rec.Style_No);
                    end;

                    if Brand1 then begin
                        ReqRec.SetRange(Brand, rec.Brand);
                    end;

                    //Update select field
                    if ReqRec.FindSet() then
                        ReqRec.ModifyAll(Select, true);

                    //Calculate selected record total                   
                    Total := 0;
                    ReqRec.Reset();
                    ReqRec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
                    ReqRec.FindSet();
                    repeat
                        if ReqRec.Select = true then
                            Total += ReqRec.Qty;
                    until ReqRec.Next() = 0;

                    //CurrPage.Update();
                end;
            }

            action("De-Select All")
            {
                Caption = 'De-Select All';
                Image = RemoveLine;
                ApplicationArea = All;

                trigger OnAction()
                var
                    ReqRec: Record StyleMaster_StyleMasterPO_TNew;
                begin
                    ReqRec.Reset();
                    ReqRec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
                    if ReqRec.FindSet() then
                        ReqRec.ModifyAll(Select, false);

                    Total := 0;
                    CurrPage.Update();
                end;
            }

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
        TempRec: Record StyleMaster_StyleMasterPO_TNew;
        PlanningQueueRec: Record "Planning Queue";
        WastageRec: Record Wastage;
        PlanningQueueNewRec: Record "Planning Queue";
        StyleMasterRec: Record "Style Master";
        StyleMasterPONewRec: Record "Style Master PO";
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
            if PlanningUser = true then begin
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
                TempRec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
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
    end;


    trigger OnOpenPage()
    var
        TempQuery: Query StyleMaster_StyleMasterPO_Q;
        TempRec: Record StyleMaster_StyleMasterPO_TNew;
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        NavAppLineRec: Record "NavApp Planning Lines";
        ProcutionOutHeaderRec: Record ProductionOutHeader;
        WastageRec: Record Wastage;
        UserSetupRec: Record "User Setup";
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
        end;

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if not UserSetupRec.FindSet() then
            Error('Cannot find user setup details')
        else begin
            if UserSetupRec.UserRole = 'PLANNING USER' then
                PlanningUser := true
            else
                PlanningUser := false;
        end;

        //Delete old records
        TempRec.Reset();
        TempRec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
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
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";

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

        rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
    end;


    //Done By Sachith on 27/03/23
    procedure ExportData(var StyleMasterQuaryRec: Record StyleMaster_StyleMasterPO_TNew)
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Exellable: Label 'All PO List';
        ExcelFileName: Label 'All Po List';
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());
        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;

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

        StyleMasterQuaryRec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
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


    procedure UnCheckAll(Number: Integer; Status: Boolean)
    var
    begin
        case Number of
            1:
                begin
                    Buyer1 := Status;
                    BuyerBrand := false;
                    BuyerBrandStyle := false;
                    Brand1 := false;
                    BrandStyle := false;
                    Style1 := false;
                end;
            2:
                begin
                    Buyer1 := false;
                    BuyerBrand := Status;
                    BuyerBrandStyle := false;
                    Brand1 := false;
                    BrandStyle := false;
                    Style1 := false;
                end;
            3:
                begin
                    Buyer1 := false;
                    BuyerBrand := false;
                    BuyerBrandStyle := Status;
                    Brand1 := false;
                    BrandStyle := false;
                    Style1 := false;
                end;
            4:
                begin
                    Buyer1 := false;
                    BuyerBrand := false;
                    BuyerBrandStyle := false;
                    Brand1 := Status;
                    BrandStyle := false;
                    Style1 := false;
                end;
            5:
                begin
                    Buyer1 := false;
                    BuyerBrand := false;
                    BuyerBrandStyle := false;
                    Brand1 := false;
                    BrandStyle := Status;
                    Style1 := false;
                end;
            6:
                begin
                    Buyer1 := false;
                    BuyerBrand := false;
                    BuyerBrandStyle := false;
                    Brand1 := false;
                    BrandStyle := false;
                    Style1 := Status;
                end;
        end;
    end;


    var
        PlanningUser: Boolean;
        Factory: Code[20];
        learningcurve: integer;
        Buyer1: Boolean;
        Brand1: Boolean;
        Style1: Boolean;
        BuyerBrand: Boolean;
        BuyerBrandStyle: Boolean;
        BrandStyle: Boolean;
        Total: BigInteger;
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
}