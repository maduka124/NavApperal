page 50489 "All PO List"
{
    PageType = Card;
    SourceTable = "Style Master PO";
    SourceTableView = where(PlannedStatus = filter(false), Status = filter(Confirm));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(select; select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }

                field(Mode; Mode)
                {
                    ApplicationArea = All;
                }

                field(BPCD; BPCD)
                {
                    ApplicationArea = All;
                }

                field("Ship Date"; "Ship Date")
                {
                    ApplicationArea = All;
                }

                field(SID; SID)
                {
                    ApplicationArea = All;
                }

                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field("Confirm Date"; "Confirm Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;

    var
        StyleMasterPORec: Record "Style Master PO";
        PlanningQueueRec: Record "Planning Queue";
        WastageRec: Record Wastage;
        PlanningQueueNewRec: Record "Planning Queue";
        StyleMasterRec: Record "Style Master";
        StyleMasterPONewRec: Record "Style Master PO";
        Waistage: Decimal;
        QtyWithWaistage: Decimal;
        QueueNo: Decimal;
        x: Decimal;
        Temp: Decimal;

    begin

        //if CloseAction = Action::OK then begin

        //Get Max Lineno
        PlanningQueueRec.Reset();

        if PlanningQueueRec.FindLast() then
            QueueNo := PlanningQueueRec."Queue No.";

        Waistage := 0;
        QtyWithWaistage := 0;

        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange(select, true);
        StyleMasterPORec.SetFilter(PlannedStatus, '=%1', false);
        StyleMasterPORec.SetFilter(Status, '=%1', StyleMasterPORec.Status::Confirm);

        if StyleMasterPORec.FindSet() then begin

            repeat

                if StyleMasterPORec.PlannedStatus = false then begin

                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                    StyleMasterRec.FindSet();

                    //Get the wastage from wastage table
                    WastageRec.Reset();
                    WastageRec.SetFilter("Start Qty", '<=%1', StyleMasterPORec.Qty);
                    WastageRec.SetFilter("Finish Qty", '>=%1', StyleMasterPORec.Qty);

                    if WastageRec.FindSet() then
                        Waistage := WastageRec.Percentage;

                    QueueNo += 1;
                    Temp := StyleMasterPORec.Qty - StyleMasterPORec.PlannedQty - StyleMasterPORec.OutputQty;
                    QtyWithWaistage := Temp + (Temp * Waistage) / 100;
                    QtyWithWaistage := Round(QtyWithWaistage, 1);
                    x := StyleMasterPORec.PlannedQty + StyleMasterPORec.OutputQty + StyleMasterPORec.QueueQty + StyleMasterPORec.Waistage;

                    if StyleMasterPORec.Qty > x then begin

                        //Insert new line to Queue
                        PlanningQueueNewRec.Init();
                        PlanningQueueNewRec."Queue No." := QueueNo;
                        PlanningQueueNewRec."Style No." := StyleMasterPORec."Style No.";
                        PlanningQueueNewRec."Style Name" := StyleMasterRec."Style No.";
                        PlanningQueueNewRec."PO No." := StyleMasterPORec."PO No.";
                        PlanningQueueNewRec."Lot No." := StyleMasterPORec."Lot No.";
                        PlanningQueueNewRec.Qty := QtyWithWaistage;
                        PlanningQueueNewRec.Waistage := (Temp * Waistage) / 100;
                        PlanningQueueNewRec.SMV := StyleMasterRec.SMV;
                        PlanningQueueNewRec.Factory := Factory;
                        PlanningQueueNewRec."TGTSEWFIN Date" := StyleMasterPORec."Ship Date";
                        PlanningQueueNewRec."Learning Curve No." := learningcurve;
                        PlanningQueueNewRec."Resource No" := '';
                        PlanningQueueNewRec.Front := StyleMasterRec.Front;
                        PlanningQueueNewRec.Back := StyleMasterRec.Back;
                        PlanningQueueNewRec.Insert();


                        //Update Style Master PO
                        StyleMasterPONewRec.Reset();
                        StyleMasterPONewRec.SetRange("Style No.", StyleMasterPORec."Style No.");
                        StyleMasterPONewRec.SetRange("Lot No.", StyleMasterPORec."Lot No.");
                        StyleMasterPONewRec.FindSet();
                        StyleMasterPONewRec.PlannedStatus := true;
                        StyleMasterPONewRec.QueueQty := QtyWithWaistage;
                        StyleMasterPONewRec.Waistage := (Temp * Waistage) / 100;
                        StyleMasterPONewRec.Modify();

                    end;
                end;
            until StyleMasterPORec.Next = 0;
        end;

        //end;
    end;


    var
        Factory: Code[20];
        learningcurve: integer;

    procedure PassParameters(FactoryPara: Code[20]; learningcurvePara: Integer);
    var
    begin
        Factory := FactoryPara;
        learningcurve := learningcurvePara;
    end;

}
