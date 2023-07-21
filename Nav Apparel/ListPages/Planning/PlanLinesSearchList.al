page 50840 "Plan Lines - Search List"
{
    PageType = list;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Resource Name", StartDateTime);
    DeleteAllowed = false;
    InsertAllowed = false;
    Caption = 'Search By Style/Return To Queue';

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
                }

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Line';
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
                }

                field(OrderQty; OrderQty)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Order Qty';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Planned Qty';
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'MC';
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Planned EFF%';
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Learning Curve';
                }

                field(BPCD; BPCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("StartDateTime"; rec.StartDateTime)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(FinishDateTime; rec.FinishDateTime)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(ShipDate; ShipDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Ship Date';
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Return To Queue")
            {
                ApplicationArea = all;
                Image = Return;
                Caption = 'Return To Queue';

                trigger OnAction()
                var
                    PlanningLinesRec: Record "NavApp Planning Lines";
                    ProdPlanDetRec: Record "NavApp Prod Plans Details";
                    PlanningQueueRec: Record "Planning Queue";
                    StyleMasterPORec: Record "Style Master PO";
                    QTY: Decimal;
                    ProdHeaderRec: Record ProductionOutHeader;
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                    QueueNo: BigInteger;
                begin
                    //Check the user is planning user or not
                    if PlanningUser = false then
                        Error('You are not authorized to perform this task.');

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

                    if (Dialog.CONFIRM('Do you want to Return all the selected POs to the Queue?', true) = true) then begin

                        PlanningLinesRec.Reset();
                        PlanningLinesRec.SetFilter(Select, '=%1', true);
                        PlanningLinesRec.SetRange(Factory, FactoryCode);
                        if PlanningLinesRec.FindSet() then begin
                            repeat

                                //Check for not prod. updated sewing out enties
                                //Check whether pending sawing out quantity is there for the allocation
                                // ProdHeaderRec.Reset();
                                // ProdHeaderRec.SetFilter("Prod Updated", '=%1', 0);
                                // ProdHeaderRec.SetRange("out Style No.", PlanningLinesRec."Style No.");
                                // ProdHeaderRec.SetRange("out Lot No.", PlanningLinesRec."Lot No.");
                                // ProdHeaderRec.SetRange("OUT PO No", PlanningLinesRec."PO No.");
                                // ProdHeaderRec.SetRange("Ref Line No.", PlanningLinesRec."Line No.");
                                // ProdHeaderRec.SetRange("Resource No.", PlanningLinesRec."Resource No.");
                                // ProdHeaderRec.SetFilter(Type, '=%1', ProdHeaderRec.Type::Saw);

                                // if ProdHeaderRec.FindSet() then
                                //     Error('Sewing Production Output has entered but not processed yet for the date : %1 and Line : %2 . Cannot change the allocation.', ProdHeaderRec."Prod Date", PlanningLinesRec."Resource No.");

                                // QTY := 0;
                                // //get remaining qty
                                // ProdPlanDetRec.Reset();
                                // ProdPlanDetRec.SetRange("Resource No.", PlanningLinesRec."Resource No.");
                                // ProdPlanDetRec.SetFilter(ProdUpd, '=%1', 0);
                                // ProdPlanDetRec.SetRange("Line No.", PlanningLinesRec."Line No.");

                                // if ProdPlanDetRec.FindSet() then begin
                                //     repeat
                                //         QTY += ProdPlanDetRec.Qty;
                                //     until ProdPlanDetRec.Next() = 0;
                                // end;

                                // QTY := Round(QTY, 1);
                                QTY := PlanningLinesRec.Qty;

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


                                //Delete remaining line from the Prod Plan Det table
                                ProdPlanDetRec.Reset();
                                //ProdPlanDetRec.SetRange("Resource No.", PlanningLinesRec."Resource No.");
                                ProdPlanDetRec.SetRange("Line No.", PlanningLinesRec."Line No.");
                                ProdPlanDetRec.SetFilter(ProdUpd, '=%1', 0);
                                if ProdPlanDetRec.FindSet() then
                                    ProdPlanDetRec.DeleteAll();
                            // else
                            //     Error('No records deleted.');

                            until PlanningLinesRec.Next() = 0;

                            //Delete Planning lines
                            PlanningLinesRec.Reset();
                            PlanningLinesRec.SetFilter(Select, '=%1', true);
                            PlanningLinesRec.SetRange(Factory, FactoryCode);
                            if PlanningLinesRec.FindSet() then
                                PlanningLinesRec.DeleteAll();

                            Message('Completed');
                        end
                        else
                            Error('No records selected for the Factory : %1', FactoryCode);
                    end;
                end;
            }

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

    procedure ExportData(varNavAppPlanRec: Record "NavApp Planning Lines")
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Exellable: Label 'Plan History List';
        ExcelFileName: Label 'Plan History List';
    begin

        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption("Style Name"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption("PO No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption("Resource Name"), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption(StartDateTime), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption(FinishDateTime), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption(Qty), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption(SMV), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption(Carder), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption(Eff), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption(HoursPerDay), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption("Learning Curve No."), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(varNavAppPlanRec.FieldCaption(ProdUpdDays), false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);

        if varNavAppPlanRec.FindSet() then begin
            repeat
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn(varNavAppPlanRec."Style Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(varNavAppPlanRec."PO No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(varNavAppPlanRec."Resource Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(varNavAppPlanRec.StartDateTime, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(varNavAppPlanRec.FinishDateTime, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(varNavAppPlanRec.Qty, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(varNavAppPlanRec.SMV, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(varNavAppPlanRec.Carder, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(varNavAppPlanRec.Eff, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(varNavAppPlanRec.HoursPerDay, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                TempExcelBuffer.AddColumn(varNavAppPlanRec."Learning Curve No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(varNavAppPlanRec.ProdUpdDays, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            until varNavAppPlanRec.Next() = 0;
        end;

        TempExcelBuffer.CreateNewBook(ExcelFileName);
        TempExcelBuffer.WriteSheet(ExcelFileName, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();

    end;


    procedure PassParameters(FactoryPara: Code[20]);
    var
    begin
        FactoryCode := FactoryPara;
    end;


    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserSetupRec: Record "User Setup";
    begin
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
        //rec.SetFilter(Factory, '=%1', FactoryCode);
    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        NavAppPlanningRec: Record "NavApp Planning Lines";
    begin
        NavAppPlanningRec.Reset();
        NavAppPlanningRec.SetRange(Factory, FactoryCode);
        if NavAppPlanningRec.FindSet() then
            NavAppPlanningRec.ModifyAll(Select, false);
    end;


    trigger OnAfterGetRecord()
    var
        StyeMastePORec: Record "Style Master PO";
        StyeMasteRec: Record "Style Master";
        NavAppSetupRec: Record "NavApp Setup";
    begin
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        StyeMasteRec.Reset();
        StyeMasteRec.SetRange("No.", rec."Style No.");
        if StyeMasteRec.FindSet() then
            Buyer := StyeMasteRec."Buyer Name"
        else
            Buyer := '';

        StyeMastePORec.Reset();
        StyeMastePORec.SetRange("Style No.", rec."Style No.");
        StyeMastePORec.SetRange("Lot No.", rec."Lot No.");
        if StyeMastePORec.FindSet() then begin
            OrderQty := StyeMastePORec.Qty;
            BPCD := StyeMastePORec.BPCD;
            ShipDate := StyeMastePORec."Ship Date";
            //rec."TGTSEWFIN Date" := ShipDate - NavAppSetupRec."Sewing Finished"
        end
        else begin
            BPCD := 0D;
            OrderQty := 0;
            ShipDate := 0D;
        end;
    end;


    var
        FactoryCode: Code[20];
        Buyer: Text[500];
        OrderQty: BigInteger;
        BPCD: Date;
        ShipDate: Date;
        PlanningUser: Boolean;
}