page 50840 "Plan Lines - Search List"
{
    PageType = list;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Style No.", "Lot No.", "Line No.") order(ascending);
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Caption = 'Planned History - Search';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                }

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Line';
                }

                field(StartDateTime; rec.StartDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date/Time';
                }

                field(FinishDateTime; rec.FinishDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Finish Date/Time';
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                    Caption = 'No of Machines';
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Efficiency';
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                }

                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
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
                ApplicationArea = All;
                Image = Return;

                trigger OnAction();
                var
                    QTY: Decimal;
                    ProdPlanDetRec: Record "NavApp Prod Plans Details";
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                    PlanningQueueRec: Record "Planning Queue";
                    QueueNo: BigInteger;
                    StyleMasterPORec: Record "Style Master PO";
                    PlanningLinesRec: Record "NavApp Planning Lines";
                begin

                    if rec."Style Name" = '' then
                        Error('Select planning line to process');

                    if Confirm('Do you want to return this planning line to the queue?', true) then begin

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

                        QTY := 0;
                        //get remaining qty
                        ProdPlanDetRec.Reset();
                        ProdPlanDetRec.SetRange("Resource No.", rec."Resource No.");
                        ProdPlanDetRec.SetFilter(ProdUpd, '=0');
                        ProdPlanDetRec.SetRange("Line No.", rec."Line No.");

                        if ProdPlanDetRec.FindSet() then begin
                            repeat
                                QTY += ProdPlanDetRec.Qty;
                            until ProdPlanDetRec.Next() = 0;
                        end;

                        QTY := Round(QTY, 1);

                        //Get Max QueueNo
                        PlanningQueueRec.Reset();

                        if PlanningQueueRec.FindLast() then
                            QueueNo := PlanningQueueRec."Queue No.";

                        //Add remaining qty to the Queue
                        PlanningQueueRec.Init();
                        PlanningQueueRec."Queue No." := QueueNo + 1;
                        PlanningQueueRec."Style No." := rec."Style No.";
                        PlanningQueueRec."Style Name" := rec."Style Name";
                        PlanningQueueRec."PO No." := rec."PO No.";
                        PlanningQueueRec."Lot No." := rec."Lot No.";
                        PlanningQueueRec.Qty := QTY;
                        PlanningQueueRec.SMV := rec.SMV;
                        PlanningQueueRec.Carder := rec.Carder;
                        PlanningQueueRec."TGTSEWFIN Date" := rec."TGTSEWFIN Date";
                        PlanningQueueRec."Learning Curve No." := rec."Learning Curve No.";
                        PlanningQueueRec.Eff := rec.Eff;
                        PlanningQueueRec.HoursPerDay := rec.HoursPerDay;
                        PlanningQueueRec.Front := rec.Front;
                        PlanningQueueRec.Back := rec.Back;
                        PlanningQueueRec.Waistage := 0;
                        PlanningQueueRec.Factory := rec.Factory;
                        PlanningQueueRec."User ID" := UserId;
                        PlanningQueueRec.Target := rec.Target;
                        PlanningQueueRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        PlanningQueueRec."Created Date" := WorkDate();
                        PlanningQueueRec."Created User" := UserId;
                        PlanningQueueRec.Insert();


                        //Update StyleMsterPO table
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
                        StyleMasterPORec.SetRange("Lot No.", rec."Lot No.");
                        StyleMasterPORec.FindSet();
                        StyleMasterPORec.PlannedQty := StyleMasterPORec.PlannedQty - QTY;
                        StyleMasterPORec.QueueQty := StyleMasterPORec.QueueQty + QTY;
                        StyleMasterPORec.Modify();


                        //Delete Planning line
                        PlanningLinesRec.Reset();
                        PlanningLinesRec.SetRange("Line No.", rec."Line No.");
                        if PlanningLinesRec.FindSet() then
                            PlanningLinesRec.Delete();

                        //Delete remaining line from the Prod Plan Det table
                        ProdPlanDetRec.Reset();
                        ProdPlanDetRec.SetRange("Resource No.", rec."Resource No.");
                        ProdPlanDetRec.SetRange("Line No.", rec."Line No.");
                        ProdPlanDetRec.SetRange(ProdUpd, 0);
                        if ProdPlanDetRec.FindSet() then
                            ProdPlanDetRec.DeleteAll();

                        Message('Completed');
                    end;

                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
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

    end;
}