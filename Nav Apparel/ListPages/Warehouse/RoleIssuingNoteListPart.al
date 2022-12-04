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
                field("Location Name"; rec."Location Name")
                {
                    ApplicationArea = All;
                    Visible = false;

                    // trigger OnValidate()
                    // var
                    //     LocationRec: Record Location;
                    //     Location: Code[20];
                    //     RoleIssNoteHeadRec: Record RoleIssuingNoteHeader;
                    //     PurchRecLineRec: Record "Purch. Rcpt. Line";
                    // begin
                    //     RoleIssNoteHeadRec.Reset();
                    //     RoleIssNoteHeadRec.SetRange("RoleIssuNo.", "RoleIssuNo.");
                    //     if RoleIssNoteHeadRec.FindSet() then
                    //         "Item No" := RoleIssNoteHeadRec."Item No";

                    //     LocationRec.Reset();
                    //     LocationRec.SetRange(name, "Location Name");
                    //     if LocationRec.FindSet() then
                    //         "Location No" := LocationRec.code;

                    //     "Role Filter User ID" := UserId;
                    //     CurrPage.Update();
                    //     Generate_Role_Details();
                    //     CurrPage.Update();
                    // end;
                }

                field("Role ID"; rec."Role ID")
                {
                    ApplicationArea = All;
                    Caption = 'Roll ID';

                    // trigger OnValidate()
                    // var
                    //     ItemLedgerEnRec: Record "Item Ledger Entry";
                    //     FabricProceLineRec: Record FabricProceLine;
                    // begin

                    //     ItemLedgerEnRec.Reset();
                    //     ItemLedgerEnRec.SetRange("Item No.", "Item No");
                    //     ItemLedgerEnRec.SetRange("Location Code", "Location No");
                    //     ItemLedgerEnRec.SetRange("Lot No.", "Role ID");

                    //     if ItemLedgerEnRec.FindSet() then begin
                    //         "Supplier Batch No." := ItemLedgerEnRec."Supplier Batch No.";
                    //         // Shade := ItemLedgerEnRec.Shade;
                    //         // "Shade No" := ItemLedgerEnRec."Shade No";
                    //         "Length Tag" := ItemLedgerEnRec."Length Tag";
                    //         "Length Act" := ItemLedgerEnRec."Length Act";
                    //         "Width Tag" := ItemLedgerEnRec."Width Tag";
                    //         "Width Act" := ItemLedgerEnRec."Width Act";
                    //     end;

                    //     //Get shade
                    //     FabricProceLineRec.Reset();
                    //     FabricProceLineRec.SetRange("Item No", "Item No");
                    //     FabricProceLineRec.SetRange("Roll No", "Role ID");

                    //     if FabricProceLineRec.FindSet() then begin
                    //         Shade := FabricProceLineRec.Shade;
                    //         "Shade No" := FabricProceLineRec."Shade No";
                    //     end;

                    // end;
                }

                field("Supplier Batch No."; rec."Supplier Batch No.")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier Batch No';
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
                }

                field("Length Act"; rec."Length Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Length';
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
                }

                field("Width Act"; rec."Width Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Width';
                }

                field(Selected; rec.Selected)
                {
                    ApplicationArea = All;

                    trigger onvalidate()
                    var
                        RoleIssueRec: Record RoleIssuingNoteHeader;
                        RoleIssueLineRec: Record RoleIssuingNoteLine;
                        Qty: Decimal;
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