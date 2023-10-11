page 51428 POWashAllocatedCard
{
    Caption = 'PO Allocated To Wash';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = WashingMaster;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Wash Allocated Colors")
            {
                part(POWashAllocated; POWashAllocated)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = "Line No" = field("Line No");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Return To Pending")
            {
                ApplicationArea = all;
                Image = ReturnOrder;
                trigger OnAction()
                var
                    AllocatedPORec: Record AllocatedPoWash;
                    PendingAllocationWashRec: Record PendingAllocationWash;
                begin

                    PendingAllocationWashRec.Reset();
                    PendingAllocationWashRec.SetRange("Style No", Rec."Style No");
                    PendingAllocationWashRec.SetRange("PO No", Rec."PO No");
                    PendingAllocationWashRec.SetRange(Lot, Rec.Lot);

                    if PendingAllocationWashRec.FindSet() then begin

                        AllocatedPORec.Reset();
                        AllocatedPORec.SetRange("Seq No", PendingAllocationWashRec."Seq No");

                        if AllocatedPORec.FindSet() then begin
                            repeat
                                if AllocatedPORec."Color Code" = Rec."Color Code" then begin
                                    AllocatedPORec."Wash Type" := '';
                                    AllocatedPORec."Washing Plant" := '';
                                    AllocatedPORec.Recipe := '';
                                    AllocatedPORec."Wash Allocated Color" := false;

                                    AllocatedPORec.Modify(true);

                                end;
                            until AllocatedPORec.Next() = 0;
                        end;

                        PendingAllocationWashRec."Wash Allocated" := false;
                        PendingAllocationWashRec.Modify(true);
                    end;

                    Rec.Delete(true);
                    CurrPage.Close();
                end;
            }
        }
    }
}