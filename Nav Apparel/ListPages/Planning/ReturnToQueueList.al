
page 51307 "Return To Queue List"
{
    PageType = Card;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Resource Name", StartDateTime);
    InsertAllowed = false;
    DeleteAllowed = false;

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

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Planned Qty';
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
                                ProdHeaderRec.Reset();
                                ProdHeaderRec.SetFilter("Prod Updated", '=%1', 0);
                                ProdHeaderRec.SetRange("out Style No.", PlanningLinesRec."Style No.");
                                ProdHeaderRec.SetRange("out Lot No.", PlanningLinesRec."Lot No.");
                                ProdHeaderRec.SetRange("OUT PO No", PlanningLinesRec."PO No.");
                                ProdHeaderRec.SetRange("Ref Line No.", PlanningLinesRec."Line No.");
                                ProdHeaderRec.SetRange("Resource No.", PlanningLinesRec."Resource No.");
                                ProdHeaderRec.SetFilter(Type, '=%1', ProdHeaderRec.Type::Saw);

                                if ProdHeaderRec.FindSet() then
                                    Error('Sewing Production Output has entered but not processed yet for the date : %1 and Line : %2 . Cannot change the allocation.', ProdHeaderRec."Prod Date", PlanningLinesRec."Resource No.");

                                QTY := 0;
                                //get remaining qty
                                ProdPlanDetRec.Reset();
                                ProdPlanDetRec.SetRange("Resource No.", PlanningLinesRec."Resource No.");
                                ProdPlanDetRec.SetFilter(ProdUpd, '=0');
                                ProdPlanDetRec.SetRange("Line No.", PlanningLinesRec."Line No.");

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


                                //Update StyleMsterPO table
                                StyleMasterPORec.Reset();
                                StyleMasterPORec.SetRange("Style No.", PlanningLinesRec."Style No.");
                                StyleMasterPORec.SetRange("Lot No.", PlanningLinesRec."Lot No.");
                                StyleMasterPORec.FindSet();
                                StyleMasterPORec.PlannedQty := StyleMasterPORec.PlannedQty - QTY;
                                StyleMasterPORec.QueueQty := StyleMasterPORec.QueueQty + QTY;
                                StyleMasterPORec.Modify();

                                //Delete remaining line from the Prod Plan Det table
                                ProdPlanDetRec.Reset();
                                ProdPlanDetRec.SetRange("Resource No.", PlanningLinesRec."Resource No.");
                                ProdPlanDetRec.SetRange("Line No.", PlanningLinesRec."Line No.");
                                ProdPlanDetRec.SetRange(ProdUpd, 0);
                                if ProdPlanDetRec.FindSet() then
                                    ProdPlanDetRec.DeleteAll();

                                //Delete Planning line                            
                                PlanningLinesRec.Delete();

                            until PlanningLinesRec.Next() = 0;

                            Message('Completed');
                        end;
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

        rec.SetFilter(Factory, '=%1', FactoryCode);
    end;


    procedure PassParameters(FactoryPara: Code[20]);
    var
    begin
        FactoryCode := FactoryPara;
    end;

    var
        FactoryCode: Code[20];
}


