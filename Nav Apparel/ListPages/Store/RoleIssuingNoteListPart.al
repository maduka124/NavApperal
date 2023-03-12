page 50638 "Roll Issuing Note ListPart"
{
    PageType = ListPart;
    SourceTable = RoleIssuingNoteLine;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Role ID"; rec."Role ID")
                {
                    ApplicationArea = All;
                    Caption = 'Roll ID';
                    Editable = false;
                }

                field("Supplier Batch No."; rec."Supplier Batch No.")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier Batch No';
                    Editable = false;
                }

                field(Shade; rec.Shade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PTTN GRP"; rec."PTTN GRP")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Length Tag"; rec."Length Tag")
                {
                    ApplicationArea = All;
                    Caption = 'Tag Length';
                    Editable = false;
                }

                field("Length Act"; rec."Length Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Length';
                    Editable = false;
                }

                field("Length Allocated"; rec."Length Allocated")
                {
                    ApplicationArea = All;
                    Caption = 'Allocated Length';
                }

                field("Width Tag"; rec."Width Tag")
                {
                    ApplicationArea = All;
                    Caption = 'Tag Width';
                    Editable = false;
                }

                field("Width Act"; rec."Width Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Width';
                    Editable = false;
                }

                field("Selected Seq"; rec."Selected Seq")
                {
                    ApplicationArea = All;
                    Caption = 'Selected Seq';
                    Editable = false;
                }

                field(Selected; rec.Selected)
                {
                    ApplicationArea = All;

                    trigger onvalidate()
                    var
                        RoleIssueRec: Record RoleIssuingNoteHeader;
                        RoleIssueLineRec: Record RoleIssuingNoteLine;
                        Qty: Decimal;
                        MaxNo: Integer;
                    begin

                        CurrPage.Update();
                        RoleIssueLineRec.Reset();
                        RoleIssueLineRec.SetRange("RoleIssuNo.", rec."RoleIssuNo.");

                        if RoleIssueLineRec.FindSet() then begin
                            repeat
                                if RoleIssueLineRec.Selected = true then
                                    Qty := Qty + RoleIssueLineRec."Length Allocated";
                            until RoleIssueLineRec.Next() = 0;
                        end;

                        RoleIssueRec.Reset();
                        RoleIssueRec.SetRange("RoleIssuNo.", rec."RoleIssuNo.");

                        if RoleIssueRec.FindSet() then begin
                            if RoleIssueRec."Required Length" < Qty then
                                Error('Selected length is over than the required length.')
                            else
                                RoleIssueRec.ModifyAll("Selected Qty", Qty);
                        end;

                        //Update selected seq
                        RoleIssueLineRec.Reset();
                        RoleIssueLineRec.SetCurrentKey("Selected Seq");
                        RoleIssueLineRec.Ascending(true);
                        RoleIssueLineRec.SetRange("RoleIssuNo.", rec."RoleIssuNo.");

                        if RoleIssueLineRec.FindLast() then
                            MaxNo := RoleIssueLineRec."Selected Seq" + 1
                        else
                            MaxNo := 1;

                        if rec.Selected = false then
                            rec."Selected Seq" := 0
                        else
                            rec."Selected Seq" := MaxNo;

                        CurrPage.Update();
                    end;
                }
            }
        }
    }


    procedure Generate_Role_Details()
    var
        ItemLedEnRec: Record "Item Ledger Entry";
        RoleIDDetailsRec: Record RoleIDDetails;
        FabricProceLineRec: Record FabricProceLine;
        RoleIssuingNoteHeaderRec: Record RoleIssuingNoteHeader;
        EntryNo1: BigInteger;
        LotNo1: Code[20];
        ItemRec: Record item;
        LocRec: Record Location;
        GRNNo: Code[20];
    begin

        RoleIssuingNoteHeaderRec.Reset();
        RoleIssuingNoteHeaderRec.SetRange("RoleIssuNo.", rec."RoleIssuNo.");
        RoleIssuingNoteHeaderRec.FindSet();
        GRNNo := RoleIssuingNoteHeaderRec."GRN No";

        //Delete old records
        RoleIDDetailsRec.Reset();
        RoleIDDetailsRec.SetRange("Role ID Filter User", rec."Role Filter User ID");
        // RoleIDDetailsRec.SetRange("Location No", "Location No");
        // RoleIDDetailsRec.SetRange("Item No", "Item No");
        if RoleIDDetailsRec.FindSet() then
            RoleIDDetailsRec.DeleteAll();


        //Get Max entry no
        RoleIDDetailsRec.Reset();
        if RoleIDDetailsRec.FindLast() then
            EntryNo1 := RoleIDDetailsRec."EntryNo.";


        ItemLedEnRec.Reset();
        ItemLedEnRec.SetCurrentKey("Lot No.");
        ItemLedEnRec.Ascending := true;
        ItemLedEnRec.SetRange("Location Code", rec."Location No");
        ItemLedEnRec.SetRange("Item No.", rec."Item No");
        ItemLedEnRec.SetRange("Document No.", GRNNo);

        if ItemLedEnRec.FindSet() then begin

            repeat

                if (LotNo1 <> ItemLedEnRec."Lot No.") then begin

                    EntryNo1 += 1;
                    RoleIDDetailsRec.Init();
                    RoleIDDetailsRec."EntryNo." := EntryNo1;
                    RoleIDDetailsRec."Item No" := ItemLedEnRec."Item No.";

                    ItemRec.Reset();
                    ItemRec.Get(ItemLedEnRec."Item No.");

                    //Get shade
                    FabricProceLineRec.Reset();
                    FabricProceLineRec.SetRange("Item No", ItemLedEnRec."Item No.");
                    FabricProceLineRec.SetRange("Roll No", ItemLedEnRec."Lot No.");

                    if FabricProceLineRec.FindSet() then begin
                        RoleIDDetailsRec."Shade" := FabricProceLineRec.Shade;
                        RoleIDDetailsRec."Shade No" := FabricProceLineRec."Shade No";
                    end;


                    RoleIDDetailsRec."Item Name" := ItemRec.Description;
                    RoleIDDetailsRec."Length Act" := ItemLedEnRec."Length Act";
                    RoleIDDetailsRec."Length Tag" := ItemLedEnRec."Length Tag";
                    RoleIDDetailsRec."Length Allocated" := ItemLedEnRec."Length Act";
                    RoleIDDetailsRec."Width Act" := ItemLedEnRec."Width Act";
                    RoleIDDetailsRec."Width Tag" := ItemLedEnRec."Width Tag";
                    RoleIDDetailsRec.InvoiceNo := ItemLedEnRec.InvoiceNo;
                    RoleIDDetailsRec."Location No" := ItemLedEnRec."Location Code";

                    LocRec.Reset();
                    LocRec.Get(ItemLedEnRec."Location Code");

                    RoleIDDetailsRec."Location Name" := LocRec.Name;
                    RoleIDDetailsRec."Role ID" := ItemLedEnRec."Lot No.";
                    RoleIDDetailsRec."Supplier Batch No." := ItemLedEnRec."Supplier Batch No.";
                    RoleIDDetailsRec."Role ID Filter User" := UserId;
                    RoleIDDetailsRec.Qty := ItemLedEnRec.Quantity;
                    RoleIDDetailsRec.Insert();

                end
                else begin

                    RoleIDDetailsRec.Reset();
                    RoleIDDetailsRec.SetRange("Item No", ItemLedEnRec."Item No.");
                    RoleIDDetailsRec.SetRange("Location No", ItemLedEnRec."Location Code");
                    RoleIDDetailsRec.SetRange("Role ID", ItemLedEnRec."Lot No.");
                    RoleIDDetailsRec."Role ID Filter User" := UserId;
                    if RoleIDDetailsRec.FindSet() then begin
                        RoleIDDetailsRec.Qty := RoleIDDetailsRec.Qty + ItemLedEnRec.Quantity;
                        RoleIDDetailsRec.Modify();
                    end;

                end;

                LotNo1 := ItemLedEnRec."Lot No.";

            until ItemLedEnRec.Next() = 0;

        end;

    end;
}