page 51332 POCompleteListPart
{
    PageType = ListPart;
    SourceTable = "Style Master PO";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("PO Complete"; rec."PO Complete")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                        NavAppPlanLineRec: Record "NavApp Planning Lines";
                        PlanningQueueeRec: Record "Planning Queue";
                        ProdPlansDetails: Record "NavApp Prod Plans Details";
                        StyleMasterPORec: Record "Style Master PO";
                    begin
                        if rec."PO Complete" = true then begin
                            if (Dialog.CONFIRM('Do you want to delete this PO from Planning Board and Queue ?', true) = true) then begin

                                NavAppPlanLineRec.Reset();
                                NavAppPlanLineRec.SetRange("Style No.", rec."Style No.");
                                NavAppPlanLineRec.SetRange("Lot No.", rec."Lot No.");
                                if NavAppPlanLineRec.FindSet() then
                                    NavAppPlanLineRec.DeleteAll();

                                ProdPlansDetails.Reset();
                                ProdPlansDetails.SetRange("Style No.", rec."Style No.");
                                ProdPlansDetails.SetRange("Lot No.", rec."Lot No.");
                                ProdPlansDetails.SetFilter(ProdUpd, '=%1', 0);
                                if ProdPlansDetails.FindSet() then
                                    ProdPlansDetails.DeleteAll();

                                PlanningQueueeRec.Reset();
                                PlanningQueueeRec.SetRange("Style No.", rec."Style No.");
                                PlanningQueueeRec.SetRange("Lot No.", rec."Lot No.");
                                if PlanningQueueeRec.FindSet() then
                                    PlanningQueueeRec.DeleteAll();

                                //Update Style Master po table
                                rec.PlannedQty := 0;
                                rec.QueueQty := 0;
                                rec.PlannedStatus := false;
                                rec.Modify();

                                Message('Completed');
                            end
                            else begin
                                rec."PO Complete" := false;
                                rec.Modify();
                            end;
                        end;
                    end;
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Caption = 'Lot No';
                    Editable = false;
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                    Editable = false;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Mode; rec.Mode)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(BPCD; rec.BPCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SID; rec.SID)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Unit Price"; rec."Unit Price")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Confirm Date"; rec."Confirm Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(PlannedQty; rec.PlannedQty)
                {
                    ApplicationArea = All;
                    Caption = 'Planned Qty';
                    Editable = false;
                }

                field(QueueQty; rec.QueueQty)
                {
                    ApplicationArea = All;
                    Caption = 'Queue Qty';
                    Editable = false;
                }

                field("Cut In Qty"; Rec."Cut In Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Cut Out Qty"; rec."Cut Out Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sawing In Qty"; Rec."Sawing In Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sawing Out Qty"; Rec."Sawing Out Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Wash In Qty"; Rec."Wash In Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Wash Out Qty"; Rec."Wash Out Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Poly Bag"; Rec."Poly Bag")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shipped Qty"; Rec."Shipped Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(PlannedStatus; rec.PlannedStatus)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        Tot: BigInteger;
    begin
        //Update Po Total         
        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
        StyleMasterPORec.FindSet();

        repeat
            Tot += StyleMasterPORec.Qty;
        until StyleMasterPORec.Next() = 0;

        StyleMasterRec.Reset();
        StyleMasterRec.SetRange("No.", rec."Style No.");
        if StyleMasterRec.FindSet() then begin
            StyleMasterRec."PO Total" := Tot;
            StyleMasterRec.Modify();
        end;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        NavappPlanLineRec: Record "NavApp Planning Lines";
        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
    begin
        Error('You are not authorized to delete this PO.');
    end;

}