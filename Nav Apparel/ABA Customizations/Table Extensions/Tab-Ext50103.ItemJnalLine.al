// tableextension 50103 ItemJnalLine extends "Item Journal Line"
// {
//     fields
//     {
//         field(50100; "Quantity Approved"; Boolean)
//         {
//             Caption = 'Quantity Approved';
//             DataClassification = ToBeClassified;
//         }
//         field(50101; "Qty. Approved UserID"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50102; "Qty. Approved Date/Time"; DateTime)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50103; "Transfer Order Created"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         // field(50104; "Style Name"; text[50])
//         // {
//         //     DataClassification = ToBeClassified;
//         // }

//         // field(50105; "Style No."; Code[20])
//         // {
//         //     DataClassification = ToBeClassified;
//         //     TableRelation = "Style Master"."No.";
//         // }

//         field(50106; PO; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             //TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
//             //ValidateTableRelation = false;
//         }
//         field(50107; "Daily Consumption Doc. No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50108; "Posted Daily Output"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50109; "Style Transfer Doc. No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Style transfer Header" where(Status = filter(Approved));

//             trigger OnValidate()
//             var
//                 StyleTransHed: Record "Style transfer Header";
//             begin
//                 if "Style Transfer Doc. No." <> '' then
//                     StyleTransHed.Get("Style Transfer Doc. No.");

//                 if Rec."Order No." <> StyleTransHed."To Prod. Order No." then
//                     Error('Transfer to production order no must be equal to %1', "Order No.");
//             end;
//         }
//         field(50110; "Line Approved"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//             trigger OnValidate()
//             begin
//                 "Line Approved UserID" := UserId;
//                 "Line Approved DateTime" := CurrentDateTime;
//             end;
//         }
//         field(50111; "Line Approved UserID"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50112; "Line Approved DateTime"; DateTime)
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50113; "Main Category Name"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Main Category"."Main Category Name" where("General Issuing" = const(true));
//             ValidateTableRelation = false;
//         }
//         field(50114; "Requsting Department Name"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Department."Department Name";
//             ValidateTableRelation = false;
//         }
//         field(50115; "ABA Item No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Item where("Main Category Name" = field("Main Category Name"), Blocked = filter(false));
//             trigger OnValidate()
//             begin
//                 //if "ABA Item No." <> '' then
//                 Validate("Item No.", "ABA Item No.");
//             end;
//         }
//         field(50116; "Original Daily Requirement"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50117; "Gen. Issue Doc. No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         modify(Quantity)
//         {
//             trigger OnBeforeValidate()
//             var
//                 ItemJnalTemplate: Record "Item Journal Template";
//             begin
//                 ItemJnalTemplate.Get("Journal Template Name");
//                 if ItemJnalTemplate.Type = ItemJnalTemplate.Type::Consumption then
//                     if "Quantity Approved" then
//                         Error('Line already approved. You can not change the Quantity.');
//             end;

//             trigger OnAfterValidate()
//             var
//                 ItemJnalTemplate: Record "Item Journal Template";
//                 ProdOrdComp: Record "Prod. Order Component";
//             begin
//                 if ProdOrdComp.Get(ProdOrdComp.Status::Released, "Order No.", "Order Line No.", "Prod. Order Comp. Line No.") then begin
//                     ItemJnalTemplate.Get("Journal Template Name");
//                     if ItemJnalTemplate.Type = ItemJnalTemplate.Type::Consumption then
//                         "Posted Daily Output" := Quantity / ProdOrdComp."Quantity per";
//                 end;

//             end;
//         }
//         modify("Item No.")
//         {
//             trigger OnAfterValidate()
//             var
//                 ItemJnalBatch: Record "Item Journal Batch";
//                 InventSetup: Record "Inventory Setup";
//                 UserSetup: Record "User Setup";

//             begin
//                 if "Journal Template Name" <> '' then begin
//                     InventSetup.Get();
//                     if InventSetup."Gen. Issue Template" = "Journal Template Name" then begin
//                         //rec.TestField("Entry Type", Rec."Entry Type"::"Negative Adjmt.");
//                         ItemJnalBatch.Get("Journal Template Name", "Journal Batch Name");
//                         UserSetup.Get(UserId);
//                         if UserSetup."Global Dimension Code" <> ItemJnalBatch."Shortcut Dimension 1 Code" then
//                             Error('You do not have permission to use this batch');
//                         Rec.Validate("Gen. Prod. Posting Group", ItemJnalBatch."gen. Prod. Posting Group");
//                         if ItemJnalBatch."Location Code" <> '' then
//                             Rec.Validate("Location Code", ItemJnalBatch."Location Code");
//                         if ItemJnalBatch."Shortcut Dimension 1 Code" <> '' then
//                             Rec.Validate("Shortcut Dimension 1 Code", ItemJnalBatch."Shortcut Dimension 1 Code");
//                     end;
//                 end;
//             end;
//         }
//         modify("Entry Type")
//         {
//             trigger OnAfterValidate()
//             var
//                 InventSetup: Record "Inventory Setup";
//             begin
//                 // if "Journal Template Name" <> '' then begin
//                 //     InventSetup.Get();
//                 //     if InventSetup."Gen. Issue Template" = "Journal Template Name" then
//                 //         rec.TestField("Entry Type", Rec."Entry Type"::"Negative Adjmt.");
//                 // end;
//             end;
//         }
//     }
// }
