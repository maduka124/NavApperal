page 50338 "Split More Card"
{
    PageType = Card;
    Caption = 'Split More';

    layout
    {
        area(Content)
        {
            grid("")
            {
                GridLayout = Rows;

                group(General)
                {
                    field(OrderQty; OrderQty)
                    {
                        ApplicationArea = All;
                        Caption = 'Order Qantity';
                        Editable = false;
                    }

                    field(EqualQty; EqualQty)
                    {
                        ApplicationArea = All;
                        Caption = 'Equal Qantity';

                        trigger OnValidate()
                        var

                        begin
                            if EqualQty = true then begin
                                Quantity := false;
                            end;
                        end;
                    }

                    field(Quantity; Quantity)
                    {
                        ApplicationArea = All;
                        Caption = 'Qantity';

                        trigger OnValidate()
                        var

                        begin
                            if Quantity = true then
                                EqualQty := false;
                        end;
                    }

                    field(Qty; Qty)
                    {
                        ApplicationArea = All;
                        Caption = ' ';
                    }

                    field(NoofLines; NoofLines)
                    {
                        ApplicationArea = All;
                        Caption = 'No of Lines';
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
                    ID: BigInteger;
                    QueueNo: BigInteger;
                    PlanningQueueRec: Record "Planning Queue";

                begin

                    if format(EqualQty) = 'Yes' then begin

                        if Format(NoofLines) <> '0' then begin
                            x := Round(OrderQty / NoofLines, 2);
                            y := x;

                            //Get Max Lineno
                            PlanningQueueRec.Reset();

                            if PlanningQueueRec.FindLast() then
                                QueueNo := PlanningQueueRec."Queue No.";

                            WHILE y <= OrderQty DO BEGIN

                                QueueNo += 1;
                                PlanningQueueRec.Init();
                                PlanningQueueRec."Queue No." := QueueNo;
                                PlanningQueueRec."Style No." := StyleNo;
                                PlanningQueueRec."Style Name" := StyleName;
                                PlanningQueueRec."PO No." := PoNo;
                                PlanningQueueRec."Lot No." := LotNo;
                                PlanningQueueRec.Qty := x;
                                PlanningQueueRec."TGTSEWFIN Date" := TGTSEWFINDate;
                                PlanningQueueRec."Learning Curve No." := LearningCurveNo;
                                PlanningQueueRec.SMV := SMV;
                                PlanningQueueRec.Carder := Carder;
                                PlanningQueueRec.Eff := Eff;
                                PlanningQueueRec.Target := Target;
                                PlanningQueueRec.Factory := Factory;
                                PlanningQueueRec.HoursPerDay := HoursPerDay;
                                PlanningQueueRec."Planned Date" := WorkDate();
                                PlanningQueueRec.Insert();

                                z := (y + x);
                                if (z > OrderQty) then begin
                                    x := OrderQty - y;
                                    y := y + x;

                                    if x = 0 then
                                        break;
                                end
                                else
                                    y := y + x;
                            end;

                            //Delete old queue id
                            PlanningQueueRec.Reset();
                            Evaluate(id, QueueID);
                            PlanningQueueRec.SetRange("Queue No.", ID);
                            PlanningQueueRec.DeleteAll();

                            Message('Completed');
                            CurrPage.Close();

                        end
                        else
                            Message('Enter no of lines.');
                    end
                    else
                        if format(Quantity) = 'Yes' then begin

                            if Format(Qty) <> '0' then begin

                                if Format(NoofLines) <> '0' then begin

                                    x := Qty * NoofLines;
                                    if x <= OrderQty then begin

                                        //Get Max Lineno
                                        PlanningQueueRec.Reset();

                                        if PlanningQueueRec.FindLast() then
                                            QueueNo := PlanningQueueRec."Queue No.";

                                        FOR z := 1 TO NoofLines DO begin

                                            QueueNo += 1;
                                            PlanningQueueRec.Init();
                                            PlanningQueueRec."Queue No." := QueueNo;
                                            PlanningQueueRec."Style No." := StyleNo;
                                            PlanningQueueRec."Style Name" := StyleName;
                                            PlanningQueueRec."PO No." := PoNo;
                                            PlanningQueueRec."Lot No." := LotNo;
                                            PlanningQueueRec.Qty := Qty;
                                            PlanningQueueRec."TGTSEWFIN Date" := TGTSEWFINDate;
                                            PlanningQueueRec."Learning Curve No." := LearningCurveNo;
                                            PlanningQueueRec.SMV := SMV;
                                            PlanningQueueRec.Carder := Carder;
                                            PlanningQueueRec.Eff := Eff;
                                            PlanningQueueRec.Target := Target;
                                            PlanningQueueRec.Factory := Factory;
                                            PlanningQueueRec.HoursPerDay := HoursPerDay;
                                            PlanningQueueRec."Planned Date" := WorkDate();
                                            PlanningQueueRec.Insert();

                                        end;

                                        //balance qty
                                        if (OrderQty - x) > 0 then begin

                                            Evaluate(id, QueueID);
                                            PlanningQueueRec.Reset();
                                            PlanningQueueRec.SetRange("Queue No.", ID);
                                            PlanningQueueRec.FindSet();
                                            PlanningQueueRec.ModifyAll(qty, OrderQty - x);

                                        end
                                        else
                                            if (OrderQty - x) = 0 then begin

                                                Evaluate(id, QueueID);
                                                PlanningQueueRec.Reset();
                                                PlanningQueueRec.SetRange("Queue No.", ID);
                                                PlanningQueueRec.DeleteAll();

                                            end;

                                        Message('Completed');
                                        CurrPage.Close();

                                    end
                                    else
                                        Message('Incorrect values. Cannot split.');
                                end
                                else
                                    Message('Enter no of lines.');
                            end
                            else
                                Message('Enter quantity.');
                        end
                        else
                            Message('Select an option to continue.');
                end;
            }
        }
    }

    var

        OrderQty: BigInteger;
        EqualQty: Boolean;
        Quantity: Boolean;
        Qty: BigInteger;
        NoofLines: Integer;
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