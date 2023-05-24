
page 51306 "Delete From Queue List"
{
    PageType = Card;
    SourceTable = "Planning Queue";
    InsertAllowed = false;
    //ModifyAllowed = false;
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

                field(Factory; rec.Factory)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                // field("Queue No."; rec."Queue No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Caption = 'Queue No';
                // }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
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
                }

                // field("ResourceName"; ResourceName)
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Caption = 'Line';
                // }

                // field("Start Date"; rec."Start Date")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                // field("Finish Date"; rec."Finish Date")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Delete From Queue")
            {
                ApplicationArea = all;
                Image = DeleteQtyToHandle;
                Caption = 'Delete From Queue';

                trigger OnAction()
                var
                    PlanningQueueRec: Record "Planning Queue";
                    PlanningQueue1Rec: Record "Planning Queue";
                    PlanningQueueNewRec: Record "Planning Queue";
                    StyleMasterPORec: Record "Style Master PO";
                    QTYVar: Decimal;
                begin

                    if (Dialog.CONFIRM('Do you want to delete?', true) = true) then begin

                        QTYVar := 0;
                        PlanningQueueRec.Reset();
                        PlanningQueueRec.SetFilter(Select, '=%1', true);
                        PlanningQueueRec.SetFilter("User ID", '=%1', rec."User ID");
                        if PlanningQueueRec.FindSet() then begin
                            repeat

                                PlanningQueue1Rec.Reset();
                                PlanningQueue1Rec.SetRange("Style No.", PlanningQueueRec."Style No.");
                                PlanningQueue1Rec.SetRange("Lot No.", PlanningQueueRec."Lot No.");
                                PlanningQueue1Rec.SetFilter("Queue No.", '<>%1', PlanningQueueRec."Queue No.");
                                PlanningQueue1Rec.SetFilter("User ID", '=%1', rec."User ID");
                                if not PlanningQueue1Rec.FindSet() then begin  //Last record of the queue

                                    //Update PO table
                                    StyleMasterPORec.Reset();
                                    StyleMasterPORec.SetRange("Style No.", PlanningQueueRec."Style No.");
                                    StyleMasterPORec.SetRange("Lot No.", PlanningQueueRec."Lot No.");
                                    if StyleMasterPORec.FindSet() then begin

                                        StyleMasterPORec.PlannedStatus := false;
                                        StyleMasterPORec.QueueQty := 0;
                                        StyleMasterPORec.Waistage := 0;
                                        StyleMasterPORec.Modify();
                                    end
                                    else
                                        Error('Cannot find PO : %1', PlanningQueueRec."PO No.");
                                end
                                else begin
                                    //Add qty to existing record      
                                    QTYVar := PlanningQueue1Rec.Qty + PlanningQueueRec.Qty;
                                    PlanningQueue1Rec.Qty := QTYVar;
                                    PlanningQueue1Rec.Modify();
                                end;

                                //Delete from Queue                                    
                                PlanningQueueRec.Delete();

                            until PlanningQueueRec.Next() = 0;
                            Message('Completed');
                        end
                        else
                            Error('No PO selected for deletion.');
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

        // rec.SetFilter(Factory, '=%1', FactoryCode);
        rec.SetFilter(rec."User ID", '=%1', UserId);
    end;


    // procedure PassParameters(FactoryPara: Code[20]);
    // var
    // begin
    //     FactoryCode := FactoryPara;
    // end;


    // trigger OnAfterGetRecord()
    // var
    //     WorkCenterRec: Record "Work Center";
    // begin
    //     WorkCenterRec.Reset();
    //     WorkCenterRec.SetRange("No.", rec."Resource No");

    //     if WorkCenterRec.FindSet() then
    //         ResourceName := WorkCenterRec.Name;
    // end;

    // var
    //     FactoryCode: Code[20];
    //ResourceName: text[200];
}


