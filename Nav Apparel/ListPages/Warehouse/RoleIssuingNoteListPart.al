page 50638 "Roll Issuing Note ListPart"
{
    PageType = ListPart;
    SourceTable = RoleIssuingNoteLine;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Location Name"; "Location Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                        RoleIssNoteHeadRec: Record RoleIssuingNoteHeader;
                    begin

                        LocationRec.Reset();
                        LocationRec.SetRange(Name, "Location Name");
                        if LocationRec.FindSet() then
                            "Location No" := LocationRec.Code;

                        RoleIssNoteHeadRec.Reset();
                        RoleIssNoteHeadRec.SetRange("RoleIssuNo.", "RoleIssuNo.");
                        if RoleIssNoteHeadRec.FindSet() then
                            "Item No" := RoleIssNoteHeadRec."Item No";

                        CurrPage.Update();
                        Generate_Role_Details();
                        CurrPage.Update();

                    end;
                }

                field("Role ID"; "Role ID")
                {
                    ApplicationArea = All;
                    Caption = 'Roll ID';

                    trigger OnValidate()
                    var
                        ItemLedgerEnRec: Record "Item Ledger Entry";
                        FabricProceLineRec: Record FabricProceLine;
                    begin

                        ItemLedgerEnRec.Reset();
                        ItemLedgerEnRec.SetRange("Item No.", "Item No");
                        ItemLedgerEnRec.SetRange("Location Code", "Location No");
                        ItemLedgerEnRec.SetRange("Lot No.", "Role ID");

                        if ItemLedgerEnRec.FindSet() then begin
                            "Supplier Batch No." := ItemLedgerEnRec."Supplier Batch No.";
                            // Shade := ItemLedgerEnRec.Shade;
                            // "Shade No" := ItemLedgerEnRec."Shade No";
                            "Length Tag" := ItemLedgerEnRec."Length Tag";
                            "Length Act" := ItemLedgerEnRec."Length Act";
                            "Width Tag" := ItemLedgerEnRec."Width Tag";
                            "Width Act" := ItemLedgerEnRec."Width Act";
                        end;

                        //Get shade
                        FabricProceLineRec.Reset();
                        FabricProceLineRec.SetRange("Item No", "Item No");
                        FabricProceLineRec.SetRange("Roll No", "Role ID");

                        if FabricProceLineRec.FindSet() then begin
                            Shade := FabricProceLineRec.Shade;
                            "Shade No" := FabricProceLineRec."Shade No";
                        end;

                    end;
                }

                field(InvoiceNo; InvoiceNo)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice No';
                }

                field("Supplier Batch No."; "Supplier Batch No.")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier Batch No';
                }

                // field("Shade No"; "Shade No")
                // {
                //     ApplicationArea = All;
                // }

                field(Shade; Shade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Length Tag"; "Length Tag")
                {
                    ApplicationArea = All;
                    Caption = 'Tag Length';
                }

                field("Length Act"; "Length Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Length';
                }

                field("Length Allocated"; "Length Allocated")
                {
                    ApplicationArea = All;
                    Caption = 'Allocated Length';
                }

                field("Width Tag"; "Width Tag")
                {
                    ApplicationArea = All;
                    Caption = 'Tag Width';
                }

                field("Width Act"; "Width Act")
                {
                    ApplicationArea = All;
                    Caption = 'Act Width';
                }

                field(Selected; Selected)
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
                        RoleIssueLineRec.SetRange("RoleIssuNo.", "RoleIssuNo.");

                        if RoleIssueLineRec.FindSet() then begin
                            repeat
                                if RoleIssueLineRec.Selected = true then
                                    Qty := Qty + RoleIssueLineRec."Length Allocated";
                            until RoleIssueLineRec.Next() = 0;
                        end;

                        RoleIssueRec.Reset();
                        RoleIssueRec.SetRange("RoleIssuNo.", "RoleIssuNo.");

                        if RoleIssueRec.FindSet() then begin
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
        RoleIssuingNoteHeaderRec.SetRange("RoleIssuNo.", "RoleIssuNo.");
        RoleIssuingNoteHeaderRec.FindSet();
        GRNNo := RoleIssuingNoteHeaderRec."GRN No";

        //Delete old records
        RoleIDDetailsRec.Reset();
        RoleIDDetailsRec.SetRange("Location No", "Location No");
        RoleIDDetailsRec.SetRange("Item No", "Item No");
        //if RoleIDDetailsRec.FindSet() then
        RoleIDDetailsRec.DeleteAll();


        //Get Max entry no
        RoleIDDetailsRec.Reset();
        if RoleIDDetailsRec.FindLast() then
            EntryNo1 := RoleIDDetailsRec."EntryNo.";


        ItemLedEnRec.Reset();
        ItemLedEnRec.SetCurrentKey("Lot No.");
        ItemLedEnRec.Ascending := true;
        ItemLedEnRec.SetRange("Location Code", "Location No");
        ItemLedEnRec.SetRange("Item No.", "Item No");
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
                    RoleIDDetailsRec.Qty := ItemLedEnRec.Quantity;
                    RoleIDDetailsRec.Insert();

                end
                else begin

                    RoleIDDetailsRec.Reset();
                    RoleIDDetailsRec.SetRange("Item No", ItemLedEnRec."Item No.");
                    RoleIDDetailsRec.SetRange("Location No", ItemLedEnRec."Location Code");
                    RoleIDDetailsRec.SetRange("Role ID", ItemLedEnRec."Lot No.");
                    RoleIDDetailsRec.FindSet();
                    RoleIDDetailsRec.Qty := RoleIDDetailsRec.Qty + ItemLedEnRec.Quantity;
                    RoleIDDetailsRec.Modify();

                end;

                LotNo1 := ItemLedEnRec."Lot No.";

            until ItemLedEnRec.Next() = 0;

        end;

    end;
}