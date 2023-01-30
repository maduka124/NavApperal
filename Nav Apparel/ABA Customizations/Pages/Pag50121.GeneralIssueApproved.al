page 50121 "Approved General Issue List"
{
    ApplicationArea = All;
    Caption = 'General Issue List - Approved';
    PageType = List;
    SourceTable = "General Issue Header";
    UsageCategory = Lists;
    //CardPageId = 50114;
    Editable = false;
    SourceTableView = where(Status = filter(Approved), "Fully Posted" = filter(false));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created UserID"; Rec."Created UserID")
                {
                    ApplicationArea = All;
                }
                field("Approved UserID"; Rec."Approved UserID")
                {
                    ApplicationArea = All;
                }
                field("Issued UserID"; rec."Issued UserID")
                {
                    ApplicationArea = All;
                }
                field("Issued Date/Time"; rec."Issued Date/Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Creation)
        {
            action("Issue General Items")
            {
                ApplicationArea = All;
                Image = IssueFinanceCharge;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ItemJnalRec: Record "Item Journal Line";
                    GenIssueLine: Record "General Issue Line";
                    ItemJnlMgt: Codeunit ItemJnlManagement;
                    UserSetup: Record "User Setup";
                    ItemJnalBatch: Record "Item Journal Batch";
                    InventSetup: Record "Inventory Setup";
                    NosManagement: Codeunit NoSeriesManagement;
                    PostNoGen: Code[20];
                    Inx: Integer;
                begin
                    if not Confirm('Do you want to issue the Items?', false) then
                        exit;

                    PostNoGen := '';
                    Rec.TestField(Status, Rec.Status::Approved);
                    UserSetup.Get(UserId);

                    InventSetup.Get();
                    InventSetup.TestField("Posted Gen. Issue Nos.");

                    PostNoGen := NosManagement.GetNextNo(InventSetup."Posted Gen. Issue Nos.", Today, true);

                    ItemJnalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                    ItemJnalRec.Reset();
                    ItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnalRec.SetRange("Gen. Issue Doc. No.", rec."No.");
                    if ItemJnalRec.FindSet() then begin
                        Commit();
                        ItemJnalRec.Reset();
                        ItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
                        ItemJnlMgt.SetName(rec."Journal Batch Name", ItemJnalRec);
                        ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        ItemJnalRec.SetRange("Gen. Issue Doc. No.", rec."No.");
                        Page.RunModal(40, ItemJnalRec);
                    end
                    else begin
                        ItemJnalRec.LockTable();
                        Clear(ItemJnalRec);
                        ItemJnalRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                        ItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
                        ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        if ItemJnalRec.FindLast() then
                            Inx := ItemJnalRec."Line No.";

                        Clear(ItemJnalRec);

                        GenIssueLine.Reset();
                        GenIssueLine.SetRange("Document No.", rec."No.");
                        if GenIssueLine.FindFirst() then begin
                            repeat
                                Inx += 10000;
                                ItemJnalRec.Init();
                                ItemJnalRec."Journal Template Name" := rec."Journal Template Name";
                                ItemJnalRec."Journal Batch Name" := rec."Journal Batch Name";
                                ItemJnalRec."Line No." := Inx;
                                ItemJnalRec.Insert(true);
                                ItemJnalRec.Validate("Posting Date", rec."Document Date");
                                ItemJnalRec."Document No." := rec."No.";
                                //ItemJnalRec."Document No." := NosManagement.GetNextNo(ItemJnalBatch."No. Series", Today, true);
                                ItemJnalRec.Validate("Item No.", GenIssueLine."Item Code");
                                ItemJnalRec."Main Category Name" := GenIssueLine."Main Category Name";
                                ItemJnalRec."Line Approved" := true;
                                ItemJnalRec.Validate("Location Code", GenIssueLine."Location Code");
                                ItemJnalRec.Validate("Entry Type", ItemJnalRec."Entry Type"::"Negative Adjmt.");
                                ItemJnalRec.Validate(Quantity, GenIssueLine.Quantity);
                                ItemJnalRec."Gen. Issue Doc. No." := rec."No.";
                                ItemJnalRec."Posted Gen. Issue Doc. No." := PostNoGen;
                                ItemJnalRec."Requsting Department Name" := UserSetup."Requsting Department Name";
                                ItemJnalRec.Modify();
                            until GenIssueLine.Next() = 0;
                            Commit();

                            ItemJnalRec.Reset();
                            ItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
                            ItemJnlMgt.SetName(rec."Journal Batch Name", ItemJnalRec);
                            ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            ItemJnalRec.SetRange("Gen. Issue Doc. No.", rec."No.");
                            Page.RunModal(40, ItemJnalRec);
                        end;
                    end;
                end;
            }
        }

    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created UserID", UserId);
    end;
}
