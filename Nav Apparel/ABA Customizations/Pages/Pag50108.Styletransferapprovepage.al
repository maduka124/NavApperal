page 50108 "Style Transfer Approve Card"
{
    Caption = 'Style Transfer Approve';
    PageType = Card;
    SourceTable = "Style transfer Header";
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("From Prod. Order No."; Rec."From Prod. Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("From Style Name"; Rec."From Style Name")
                {
                    ApplicationArea = All;
                }
                field("To Prod. Order No."; Rec."To Prod. Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("To Style Name"; Rec."To Style Name")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lines; "Style Transfer Subform")
            {
                ApplicationArea = All;
                Enabled = rec."No." <> '';
                UpdatePropagation = Both;
                Editable = false;
                SubPageLink = "Document No." = field("No.");
            }
        }


    }
    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StyleRec: Record "Style Master";
                    ItemJRec: Record "Item Journal Line";
                    UserSetup: Record "User Setup";
                    StyleTLineRec: Record "Style Transfer Line";
                    Inx: Integer;
                    GenIssueLine: Record "General Issue Line";
                    ItemJnlMgt: Codeunit ItemJnlManagement;
                    PositiveFactoty: Code[20];
                    NegativeFactoty: Code[20];
                    PostNoGen: Code[20];
                    NosManagement: Codeunit NoSeriesManagement;
                    InventSetup: Record "Inventory Setup";
                    ItemJnalBatch: Record "Item Journal Batch";
                    ItemJnalRec: Record "Item Journal Line";
                begin
                    PostNoGen := '';
                    InventSetup.Get();
                    InventSetup.TestField("Posted Gen. Issue Nos.");

                    PostNoGen := NosManagement.GetNextNo(InventSetup."Posted Gen. Issue Nos.", Today, true);

                    StyleRec.Reset();
                    StyleRec.SetRange("No.", Rec."To Style No");
                    if StyleRec.FindSet() then begin
                        PositiveFactoty := StyleRec."Factory Code";
                    end;

                    StyleRec.Reset();
                    StyleRec.SetRange("No.", Rec."From Style No");
                    if StyleRec.FindSet() then begin
                        NegativeFactoty := StyleRec."Factory Code";
                    end;

                    UserSetup.Get(UserId);
                    if not UserSetup."Head of Department" then
                        Error('You do not have permission to perform this action');



                    UserSetup.Get(UserId);

                    ItemJRec.Reset();
                    ItemJRec.SetRange("Journal Template Name", 'ITEM');
                    ItemJRec.SetRange("Journal Batch Name", 'DEFAULT');
                    if ItemJRec.FindLast() then
                        Inx := ItemJRec."Line No.";

                    StyleTLineRec.Reset();
                    StyleTLineRec.SetRange("Document No.", Rec."No.");
                    StyleTLineRec.SetFilter("Required Quantity", '<>%1', 0);
                    if StyleTLineRec.FindSet() then begin
                        repeat

                            Inx += 10000;
                            ItemJRec.Init();
                            ItemJRec."Journal Template Name" := 'ITEM';
                            ItemJRec."Journal Batch Name" := 'DEFAULT';
                            ItemJRec."Line No." := Inx;
                            ItemJRec.Insert(true);
                            ItemJRec.Validate("Posting Date", rec."Document Date");
                            ItemJRec."Document No." := rec."No.";
                            ItemJRec."Location Code" := PositiveFactoty;
                            ItemJRec.Validate("Item No.", StyleTLineRec."Item Code");
                            ItemJRec."Main Category Name" := StyleTLineRec."Main Category Name";
                            ItemJRec."Line Approved" := true;
                            ItemJRec.Validate("Entry Type", ItemJRec."Entry Type"::"Positive Adjmt.");
                            ItemJRec.Validate(Quantity, StyleTLineRec."Required Quantity");
                            ItemJRec.Modify(true);

                            Inx += 10000;
                            ItemJRec.Init();
                            ItemJRec."Journal Template Name" := 'ITEM';
                            ItemJRec."Journal Batch Name" := 'DEFAULT';
                            ItemJRec."Line No." := Inx;
                            ItemJRec.Insert(true);
                            ItemJRec.Validate("Posting Date", rec."Document Date");
                            ItemJRec."Document No." := rec."No.";
                            ItemJRec."Location Code" := NegativeFactoty;
                            ItemJRec.Validate("Item No.", StyleTLineRec."Item Code");
                            ItemJRec."Main Category Name" := StyleTLineRec."Main Category Name";
                            ItemJRec."Line Approved" := true;
                            ItemJRec.Validate("Entry Type", ItemJRec."Entry Type"::"Negative Adjmt.");
                            ItemJRec.Validate(Quantity, StyleTLineRec."Required Quantity");
                            ItemJRec.Modify(true);

                        until StyleTLineRec.Next() = 0;
                        Commit();

                    end;

                    ItemJRec.Reset();
                    ItemJRec.SetRange("Journal Template Name", 'ITEM');
                    ItemJnlMgt.SetName('DEFAULT', ItemJRec);
                    ItemJRec.SetRange("Journal Batch Name", 'DEFAULT');
                    Page.RunModal(40, ItemJRec);


                    rec.Status := rec.Status::Approved;
                    rec.Modify();
                    Message('Document No %1 is approved', rec."No.");


                    CurrPage.Close();
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Head of Department" then
                        Error('You do not have permission to perform this action');

                    rec.Status := rec.Status::Open;
                    rec.Modify();
                    Message('Document No %1 is rejected', rec."No.");
                    CurrPage.Close();
                end;
            }
            //   action("Send for Approval")
            //   {
            //       ApplicationArea = All;
            //       Image = SendApprovalRequest;
            //       Promoted = true;
            //       PromotedCategory = Process;
            //       trigger OnAction()
            //       begin
            //           rec.Status := rec.Status::"Pending Approval";
            //           rec.Modify();
            //           Message('Approval request sent successfully');
            //       end;
            //   }
            //   action(Reopen)
            //   {
            //       ApplicationArea = All;
            //       Image = ReOpen;
            //       Promoted = true;
            //       PromotedCategory = Process;
            //       trigger OnAction()
            //       begin
            //           if Rec.Status = Rec.Status::Approved then
            //               Error('Document already approved');

            //           rec.Status := Rec.Status::Open;
            //           Rec.Modify();
            //       end;
            //   }
        }
    }

}
