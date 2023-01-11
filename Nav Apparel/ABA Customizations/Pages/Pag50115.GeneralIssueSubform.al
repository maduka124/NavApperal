page 50115 "General Issue Subform"
{
    ApplicationArea = Suite;
    UsageCategory = Lists;
    Caption = 'General Issue Subform';
    PageType = ListPart;
    SourceTable = "General Issue Line";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Main Category"; Rec."Main Category")
                {
                    ApplicationArea = All;
                }
                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;

                    //Added by Maduka on 9/1/2023
                    trigger OnValidate()
                    var
                        ItemLedgerRec: Record "Item Ledger Entry";
                    begin
                        ItemLedgerRec.Reset();
                        ItemLedgerRec.SetRange("Item No.", Rec."Item Code");
                        if Rec."Location Code" <> '' then
                            ItemLedgerRec.SetRange("Location Code", Rec."Location Code");

                        if ItemLedgerRec.FindSet() then begin
                            repeat
                                Rec."Quantity In Stock" += ItemLedgerRec."Remaining Quantity";
                            until ItemLedgerRec.Next() = 0;
                        end;
                    end;
                }

                //Added by Maduka on 9/1/2023
                field("Quantity In Stock"; Rec."Quantity In Stock")
                {
                    ApplicationArea = All;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }

                //Added by Maduka on 11/1/2023
                // field(Select; Rec.Select)
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }


    // actions
    // {
    //     area(Processing)
    //     {
    //         //Added by Maduka on 11/1/2023
    //         action("Create PO")
    //         {
    //             Image = CreateDocument;
    //             ApplicationArea = All;
    //             Caption = 'Create PO';

    //             trigger OnAction()
    //             var
    //                 PurchaseHeader: Record "Purchase Header";
    //                 PurchaseLine: Record "Purchase Line";
    //                 NavAppSetupRec: Record "NavApp Setup";
    //                 NoSeriesManagementCode: Codeunit NoSeriesManagement;
    //                 PoNo: Code[20];
    //                 GeneralIssueLine: Record "General Issue Line";
    //                 LineNo: Integer;
    //                 ItemRec: Record Item;
    //             begin
    //                 NavAppSetupRec.Reset();
    //                 NavAppSetupRec.FindSet();

    //                 //Check whether user logged in or not
    //                 LoginSessionsRec.Reset();
    //                 LoginSessionsRec.SetRange(SessionID, SessionId());

    //                 if not LoginSessionsRec.FindSet() then begin  //not logged in
    //                     Clear(LoginRec);
    //                     LoginRec.LookupMode(true);
    //                     LoginRec.RunModal();

    //                     LoginSessionsRec.Reset();
    //                     LoginSessionsRec.SetRange(SessionID, SessionId());
    //                     LoginSessionsRec.FindSet();
    //                 end;

    //                 LineNo := 0;
    //                 GeneralIssueLine.Reset();
    //                 GeneralIssueLine.SetRange("Document No.", rec."Document No.");
    //                 GeneralIssueLine.SetFilter(Select, '=%1', true);
    //                 if not GeneralIssueLine.FindSet() then
    //                     Error('Please select items to include in the purchase order.');


    //                 PoNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."CP PO Nos.", Today(), true);
    //                 PurchaseHeader.Init();
    //                 PurchaseHeader."No." := PoNo;
    //                 PurchaseHeader."Buy-from Vendor No." := NavAppSetupRec."Wash PO Vendor";
    //                 PurchaseHeader.Validate("Buy-from Vendor No.");
    //                 //PurchaseHeader.Validate("Buy-from Address", PurchaseHeader."Buy-from Address");
    //                 //PurchaseHeader."Buy-from Vendor Name" := 'CoolWood Technologies';
    //                 PurchaseHeader."Order Date" := WorkDate();
    //                 PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
    //                 PurchaseHeader."Document Date" := WorkDate();
    //                 PurchaseHeader."Posting Date" := WorkDate();
    //                 PurchaseHeader.receive := true;
    //                 PurchaseHeader.EntryType := PurchaseHeader.EntryType::"Central Purchasing";
    //                 PurchaseHeader."Secondary UserID" := LoginSessionsRec."Secondary UserID";
    //                 PurchaseHeader.Insert();

    //                 GeneralIssueLine.Reset();
    //                 GeneralIssueLine.SetRange("Document No.", rec."Document No.");
    //                 GeneralIssueLine.SetFilter(Select, '=%1', true);
    //                 if GeneralIssueLine.FindSet() then begin

    //                     repeat

    //                         LineNo += 1;
    //                         //Insert Purchse Line
    //                         PurchaseLine.Init();
    //                         PurchaseLine."Document Type" := PurchaseHeader."Document Type"::Order;
    //                         PurchaseLine."Document No." := PoNo;
    //                         PurchaseLine.Type := PurchaseLine.Type::Item;
    //                         PurchaseLine."VAT Bus. Posting Group" := 'ZERO';
    //                         PurchaseLine."VAT Prod. Posting Group" := 'ZERO';
    //                         PurchaseLine.Validate("No.", rec."Item Code");
    //                         PurchaseLine."Line No." := LineNo;

    //                         ItemRec.Reset();
    //                         ItemRec.SetRange("No.", rec."Item Code");
    //                         if ItemRec.FindSet() then begin
    //                             PurchaseLine."Buy-from Vendor No." := ItemRec."Vendor No.";
    //                             PurchaseLine.Validate("Buy-from Vendor No.");
    //                         end;

    //                         PurchaseLine.Validate(Quantity, rec.Quantity - rec."Quantity In Stock");
    //                         purchaseline.Validate("Location Code", rec."Location Code");
    //                         // PurchaseLine."Quantity Received" := "Req Qty BW QC Pass";
    //                         // PurchaseLine."Qty. to Invoice" := "Req Qty BW QC Pass";
    //                         PurchaseLine.Insert();

    //                     until GeneralIssueLine.Next() = 0;

    //                 end;

    //                 Message('Purchase order : %1 generated.', PoNo);

    //             end;
    //         }
    //     }
    // }

    var

        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
}
