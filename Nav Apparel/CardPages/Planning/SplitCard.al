page 50613 "Split Card"
{
    PageType = Card;
    Caption = 'Split';

    layout
    {
        area(Content)
        {
            grid("")
            {
                GridLayout = Rows;

                group(General)
                {
                    field(Qty; Qty)
                    {
                        ApplicationArea = All;
                        Caption = 'Split Qantity';

                        trigger OnValidate()
                        var

                        begin


                        end;
                    }
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Split)
            {
                ApplicationArea = All;
                Image = Split;
                Caption = 'Split';

                trigger OnAction()
                var
                    X: BigInteger;
                    y: Decimal;
                    z: Decimal;
                    QueueNo: BigInteger;
                    PlanningQueueRec: Record "Planning Queue";

                begin

                    if ((Qty <> 0) and (Qty < OrderQty)) then begin

                        //Get Max Lineno
                        PlanningQueueRec.Reset();

                        if PlanningQueueRec.FindLast() then
                            QueueNo := PlanningQueueRec."Queue No.";

                        PlanningQueueRec.Init();
                        PlanningQueueRec."Queue No." := QueueNo + 1;
                        PlanningQueueRec."Style No." := StyleNo;
                        PlanningQueueRec."Style Name" := StyleName;
                        PlanningQueueRec."PO No." := PoNo;
                        PlanningQueueRec."Lot No." := LotNo;
                        PlanningQueueRec.Qty := Qty;
                        PlanningQueueRec.SMV := 0;
                        PlanningQueueRec."TGTSEWFIN Date" := TGTSEWFINDate;
                        PlanningQueueRec."Learning Curve No." := LearningCurveNo;
                        PlanningQueueRec.SMV := SMV;
                        PlanningQueueRec.Carder := Carder;
                        PlanningQueueRec.Eff := Eff;
                        PlanningQueueRec.Target := Target;
                        PlanningQueueRec.Factory := Factory;
                        PlanningQueueRec.HoursPerDay := HoursPerDay;
                        PlanningQueueRec."Planned Date" := WorkDate();
                        PlanningQueueRec."User ID" := UserId;
                        PlanningQueueRec.Insert();

                        //modify existing record
                        PlanningQueueRec.Reset();
                        PlanningQueueRec.SetRange("Queue No.", ID);
                        PlanningQueueRec.FindSet();
                        PlanningQueueRec.ModifyAll(Qty, OrderQty - Qty);

                        Message('Completed');
                        CurrPage.Close();

                    end
                    else
                        Message('Invalid quantity.');
                end;
            }
        }
    }

    var
        OrderQty: BigInteger;
        Qty: BigInteger;
        QueueID: Text;
        ID: BigInteger;
        PoNo: Code[20];
        LotNo: Code[20];
        StyleNo: Code[20];
        StyleName: Text[50];
        LearningCurveNo: Integer;
        TGTSEWFINDate: Date;
        SMV: Decimal;
        Eff: Decimal;
        Carder: Integer;
        Target: BigInteger;
        Factory: Code[20];
        HoursPerDay: Integer;


    trigger OnOpenPage()
    var
        PlanningQueueRec: Record "Planning Queue";
    begin
        Evaluate(ID, QueueID);
        PlanningQueueRec.Reset();
        PlanningQueueRec.SetRange("Queue No.", ID);

        if PlanningQueueRec.FindSet() then begin

            OrderQty := PlanningQueueRec.Qty;
            StyleNo := PlanningQueueRec."Style No.";
            PoNo := PlanningQueueRec."PO No.";
            LotNo := PlanningQueueRec."Lot No.";
            StyleName := PlanningQueueRec."Style Name";
            LearningCurveNo := PlanningQueueRec."Learning Curve No.";
            TGTSEWFINDate := PlanningQueueRec."TGTSEWFIN Date";
            SMV := PlanningQueueRec.SMV;
            Eff := PlanningQueueRec.Eff;
            Carder := PlanningQueueRec.Carder;
            Target := PlanningQueueRec.Target;
            Factory := PlanningQueueRec.Factory;
            HoursPerDay := PlanningQueueRec.HoursPerDay;

        end;

    end;

    procedure PassParameters(QueueIDPara: Text);
    var

    begin
        QueueID := QueueIDPara;
    end;

}