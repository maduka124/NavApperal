page 50978 "Create User Card"
{
    PageType = Card;
    SourceTable = LoginDetails;
    Caption = 'User Creation';
    //AutoSplitKey = true;
    // Permissions = tabledata "Purch. Rcpt. Line" = rmID;
    // Permissions = tabledata "Purch. Rcpt. Line"  = rmID;
    Permissions = tabledata "Purchase Line" = rmID;

    layout
    {
        area(Content)
        {
            group(General)
            {
                // field("No."; rec."No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                field(contractNo; contractNo)
                {
                    ApplicationArea = All;
                }

                field("Secondary UserID"; rec."UserID Secondary")
                {
                    ApplicationArea = All;
                    Caption = 'Secondary User ID';

                    trigger OnValidate()
                    var
                        LoginDetailsRec: Record LoginDetails;
                    begin
                        LoginDetailsRec.Reset();
                        LoginDetailsRec.SetRange("UserID Secondary", rec."UserID Secondary");

                        if LoginDetailsRec.FindSet() then
                            Error('Secondary User ID already exists.');
                    end;
                }

                field("User Name"; rec."User Name")
                {
                    ApplicationArea = All;
                    Caption = 'Full Name';
                }

                field(Pw; rec.Pw)
                {
                    ApplicationArea = All;
                    Caption = 'Password';
                }

                field(Password; Password)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    Caption = 'Re Enter Password';

                    trigger OnValidate()
                    var
                    begin
                        if rec.pw <> Password then
                            Error('Password mismatch.');
                    end;
                }

                field(Active; rec.Active)
                {
                    ApplicationArea = All;
                    Caption = 'Active Status';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("remove navapp plan/Prod")
            {
                ApplicationArea = All;
                Image = AddAction;

                trigger OnAction()
                var
                    NavApp: Record "NavApp Planning Lines";
                    NavAppprod: Record "NavApp Prod Plans Details";
                begin
                    NavApp.Reset();
                    NavApp.SetRange("Style No.", '02367');
                    if NavApp.FindSet() then
                        NavApp.Delete();

                    NavAppprod.Reset();
                    NavAppprod.SetRange("Style No.", '02367');
                    if NavAppprod.FindSet() then
                        NavAppprod.DeleteAll();

                    Message('Completed');
                end;
            }

            // action("remove contarct/style")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ContractLCStyle: Record "Contract/LCStyle";
            //     begin
            //         ContractLCStyle.Reset();
            //         ContractLCStyle.SetRange("No.", contractNo);
            //         if ContractLCStyle.FindSet() then
            //             ContractLCStyle.DeleteAll();

            //         Message('Completed');
            //     end;
            // }


            // action("delete daily sewing")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ProductionOutHeader: Record ProductionOutHeader;
            //     begin
            //         ProductionOutHeader.Reset();
            //         ProductionOutHeader.SetFilter(Type, '=%1', ProductionOutHeader.Type::Saw);
            //         ProductionOutHeader.SetRange("No.", 139);
            //         if ProductionOutHeader.FindSet() then
            //             ProductionOutHeader.DeleteAll();

            //         Message('Completed');
            //     end;
            // }


            // action("Update Prod Status")
            // {
            //     ApplicationArea = All;
            //     Image = AddAction;

            //     trigger OnAction()
            //     var
            //         ProductionOutHeader: Record ProductionOutHeader;
            //     begin
            //         ProductionOutHeader.Reset();
            //         ProductionOutHeader.SetRange("No.", 175);
            //         if ProductionOutHeader.FindSet() then
            //             ProductionOutHeader.ModifyAll("Prod Updated", 1);

            //         Message('Completed');
            //     end;
            // }

            // actions


            // action("remove Export Reference No")
            // {
            //     ApplicationArea = All;
            //     Image = RemoveLine;


            //     trigger OnAction()
            //     var
            //         SalesInvRec: Record "Sales Invoice Header";
            //     begin
            //         SalesInvRec.Reset();
            //         SalesInvRec.FindSet();
            //         repeat
            //             SalesInvRec."Export Ref No." := '';
            //             SalesInvRec.Modify();
            //         until SalesInvRec.Next() = 0;
            //         Message('Completed');
            //     end;
            // }

            //Done By Sachithon 20/04/23
            // action("Update Colors")
            // {
            //     ApplicationArea = all;

            //     trigger OnAction()
            //     var
            //         PurchRcptLine: Record "Purch. Rcpt. Line";
            //         ItemRec: Record Item;
            //     begin

            //         PurchRcptLine.Reset();
            //         if PurchRcptLine.FindSet() then begin
            //             repeat
            //                 if PurchRcptLine."Color No." = '' then begin

            //                     // ItemRec.Reset();
            //                     // if ItemRec.FindSet() then begin
            //                     //     repeat
            //                     //         if PurchRcptLine."No." = ItemRec."No." then begin
            //                     //             PurchRcptLine."Color No." := ItemRec."Color No.";
            //                     //             PurchRcptLine."Color Name" := ItemRec."Color Name";
            //                     //             PurchRcptLine.Modify()
            //                     //         end;
            //                     //     until ItemRec.Next() = 0;
            //                     // end;


            //                     ItemRec.Reset();
            //                     ItemRec.SetRange("No.", PurchRcptLine."No.");
            //                     if ItemRec.FindFirst() then begin
            //                         PurchRcptLine."Color No." := ItemRec."Color No.";
            //                         PurchRcptLine."Color Name" := ItemRec."Color Name";
            //                         PurchRcptLine.Modify()
            //                     end;

            //                 end;
            //             until PurchRcptLine.Next() = 0;
            //         end;
            //     end;
            // }

            //Done By Sachith on 21/04/23
            action("PO Line vendor Add")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    VendorRec: Record Vendor;
                    PolineRec: Record "Purchase Line";
                begin

                    PolineRec.Reset();
                    PolineRec.SetFilter("Document Type", '=%1', PolineRec."Document Type"::Order);
                    if PolineRec.FindSet() then begin
                        repeat
                            if PolineRec."Buy-from Vendor No." <> '' then begin
                                VendorRec.Reset();
                                VendorRec.SetRange("No.", PolineRec."Buy-from Vendor No.");

                                if VendorRec.FindSet() then begin
                                    if PolineRec."Buy From Vendor Name" = '' then begin
                                        PolineRec."Buy From Vendor Name" := VendorRec.Name;
                                        PolineRec.Modify();
                                    end;
                                end;
                            end;
                        until PolineRec.Next() = 0;
                    end;
                end;
            }
        }
    }


    var
        Password: Text[50];
        contractNo: Text[50];
}