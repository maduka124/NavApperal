page 50489 "All PO List"
{
    PageType = Card;
    SourceTable = StyleMaster_StyleMasterPO_T;
    SourceTableView = where(PlannedStatus = filter(false), Status = filter(Confirm), smv = filter(> 0));
    DeleteAllowed = false;
    InsertAllowed = false;

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

                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update();
                    end;
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Style_No; Style_No)
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field(Lot_No; Lot_No)
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                    Editable = false;
                }

                field(PONo; PONo)
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                    Editable = false;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Mode; Mode)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(BPCD; BPCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(ShipDate; ShipDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SID; SID)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(UnitPrice; UnitPrice)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(ConfirmDate; ConfirmDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
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

        TempRec.Reset();
        TempRec.SetRange(select, true);
        TempRec.SetFilter(PlannedStatus, '=%1', false);
        TempRec.SetFilter(Status, '=%1', TempRec.Status::Confirm);

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
            until TempRec.Next = 0;
        end;

        //end;
    end;


    trigger OnOpenPage()
    var
        TempQuery: Query StyleMaster_StyleMasterPO_Q;
        TempRec: Record StyleMaster_StyleMasterPO_T;
    begin

        //Delete old records
        TempRec.Reset();
        if TempRec.FindSet() then
            TempRec.DeleteAll();

        //Insert records from query 
        if TempQuery.Open() then begin
            while TempQuery.Read() do begin

                Rec.Init();
                Rec.BPCD := TempQuery.BPCD;
                Rec.Buyer := TempQuery.Buyer_Name;
                Rec.ConfirmDate := TempQuery.ConfirmDate;
                Rec.Lot_No := TempQuery.Lot_No;
                Rec.Mode := TempQuery.Mode;
                Rec.No := TempQuery.No;
                Rec.PlannedStatus := TempQuery.PlannedStatus;
                Rec.PONo := TempQuery.PONo;
                Rec.Qty := TempQuery.Qty;
                Rec.Select := TempQuery.Select;
                Rec.ShipDate := TempQuery.ShipDate;
                Rec.SID := TempQuery.SID;
                Rec.SMV := TempQuery.SMV;
                Rec.Status := TempQuery.Status;
                Rec.Style_No := TempQuery.Style_No;
                Rec.UnitPrice := TempQuery.UnitPrice;
                Rec.Insert();

            end;
            TempQuery.Close();
        end;
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
