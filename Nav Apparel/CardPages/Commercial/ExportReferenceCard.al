page 51241 "Export Reference Card"
{
    PageType = Card;
    SourceTable = ExportReferenceHeader;
    UsageCategory = Tasks;
    Caption = 'Export Reference';
    Permissions = tabledata "Sales Invoice Header" = rm;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                    end;
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        SalesInvRec: Record "Sales Invoice Header";
                        CustomerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, Rec."Buyer Name");

                        if CustomerRec.FindSet() then
                            Rec."Buyer No" := CustomerRec."No.";

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                        //Assign "Export Ref No."



                    end;
                }

                field("Invoice No"; rec."Invoice No")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var texts: text): Boolean
                    var
                        ExportReFHeadRec: Record ExportReferenceHeader;
                        SalesInvRec: Record "Sales Invoice Header";
                        ContracStRec: Record "Contract/LCStyle";
                        LcMaterRec: Record "Contract/LCMaster";
                        // SalesInvRec: Record "Sales Invoice Header";
                        SalesInvLineRec: Record "Sales Invoice Line";
                        ExportRefLineRec: Record ExportReferenceLine;
                    begin
                        InvValue := 0;
                        SalesInvRec.Reset();
                        SalesInvRec.SetRange("Sell-to Customer No.", Rec."Buyer No");
                        SalesInvRec.SetFilter("Export Ref No.", '=%1', '');

                        if Page.RunModal(51321, SalesInvRec) = Action::LookupOK then begin
                            Rec."Invoice No" := SalesInvRec."No.";

                            // //Assign "Export Ref No."
                            SalesInvRec."Export Ref No." := rec."No.";
                            SalesInvRec.Modify();
                        end;

                        if xRec."Invoice No" <> '' then begin
                            SalesInvRec.Reset();
                            SalesInvRec.SetRange("No.", xRec."Invoice No");
                            if SalesInvRec.FindSet() then begin
                                SalesInvRec."Export Ref No." := '';
                                SalesInvRec.Modify();
                            end;

                        end;

                        SalesInvRec.Reset();
                        SalesInvRec.SetRange("No.", rec."Invoice No");

                        if SalesInvRec.FindSet() then begin

                            //Delete old record
                            ExportRefLineRec.Reset();
                            ExportRefLineRec.SetRange("No.", rec."No.");
                            if ExportRefLineRec.FindSet() then
                                ExportRefLineRec.DeleteAll();

                            //Insert new line
                            ExportRefLineRec.Init();
                            ExportRefLineRec."No." := rec."No.";
                            ExportRefLineRec."Created Date" := WorkDate();
                            ExportRefLineRec."Created User" := UserId;
                            ExportRefLineRec."Fty Inv No." := SalesInvRec."Your Reference";
                            SalesInvRec.CalcFields(SalesInvRec."Amount Including VAT");
                            ExportRefLineRec."Inv Value" := SalesInvRec."Amount Including VAT";
                            InvValue += SalesInvRec."Amount Including VAT";
                            ExportRefLineRec."Invoice Date" := SalesInvRec."Document Date";
                            ExportRefLineRec."Invoice No" := rec."Invoice No";
                            ExportRefLineRec."Line No." := 1;


                            //Get qty 
                            SalesInvLineRec.Reset();
                            SalesInvLineRec.SetRange("Document No.", rec."Invoice No");
                            if SalesInvLineRec.FindSet() then
                                repeat
                                    ExportRefLineRec.Qty += SalesInvLineRec.Quantity;
                                until SalesInvLineRec.Next() = 0;

                            ExportRefLineRec.Insert();



                            Rec."Factory Inv No" := SalesInvRec."Your Reference";
                            Rec."Order No" := SalesInvRec."PO No";

                            SalesInvRec.Reset();
                            SalesInvRec.SetRange("No.", Rec."Invoice No");
                            if SalesInvRec.FindSet() then begin
                                Rec."Contract No" := SalesInvRec."Contract No";
                                Rec."Invoice Date" := SalesInvRec."Document Date";
                                Rec."X Factory Date" := SalesInvRec."Shipment Date";
                                CurrPage.Update();
                                Rec.Modify();
                            end;
                        end;
                        ExportReFHeadRec.Reset();
                        ExportReFHeadRec.SetRange("No.", Rec."No.");
                        if ExportReFHeadRec.FindSet() then begin
                            Rec."Invoice Value" := InvValue;
                            ExportReFHeadRec.Modify();
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Factory Inv No"; Rec."Factory Inv No")
                {
                    ApplicationArea = All;
                    Caption = 'Factory Invoice No';

                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                }
            }

            group("Invoice Details")
            {
                part("Export Ref ListPart"; "Export Ref ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }

            group("General ll")
            {
                field("BL No"; rec."BL No")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesInvRec: Record "Sales Invoice Header";
                    begin
                        SalesInvRec.Reset();
                        SalesInvRec.SetRange("No.", Rec."Invoice No");
                        if SalesInvRec.FindSet() then begin
                            SalesInvRec."BL No" := Rec."BL No";
                            SalesInvRec.Modify();
                        end;

                    end;
                }

                field("BL Date"; rec."BL Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SalesInvRec: Record "Sales Invoice Header";
                    begin
                        SalesInvRec.Reset();
                        SalesInvRec.SetRange("No.", Rec."Invoice No");
                        if SalesInvRec.FindSet() then begin
                            SalesInvRec."BL Date" := Rec."BL Date";
                            SalesInvRec.Modify();
                        end;

                    end;

                }

                // Done By sachith 15/03/23
                field("Shipping Bill No"; Rec."Shipping Bill No")
                {
                    ApplicationArea = All;
                }

                field("DOC Sub Bank Date"; rec."DOC Sub Bank Date")
                {
                    ApplicationArea = All;
                }

                field("DOC Sub Buyer Date"; rec."DOC Sub Buyer Date")
                {
                    ApplicationArea = All;
                }

                // Done By sachith 15/03/23
                field("Shipping Bill Date"; Rec."Shipping Bill Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    // actions
    // {
    //     area(Creation)
    //     {
    //         action("remove value")
    //         {
    //             ApplicationArea = All;


    //             trigger OnAction()
    //             var
    //                 SalesInvRec: Record "Sales Invoice Header";
    //             begin
    //                 SalesInvRec.Reset();
    //                 SalesInvRec.SetRange("No.", 'VDL-PSI-0009');
    //                 SalesInvRec.FindSet();
    //                 SalesInvRec."Export Ref No." := '';
    //                 SalesInvRec.Modify();

    //                 SalesInvRec.Reset();
    //                 SalesInvRec.SetRange("No.", 'VDL-PSI-0005');
    //                 SalesInvRec.FindSet();
    //                 SalesInvRec."Export Ref No." := '';
    //                 SalesInvRec.Modify();
    //             end;
    //         }
    //     }
    // }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."ExpoRef Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        ExportRefRec: Record ExportReferenceLine;
        // SalesInvLineRec: Record "Sales Invoice Line";
        SalesInvRec: Record "Sales Invoice Header";
    begin
        // SalesInvLineRec.Reset();
        // SalesInvLineRec.SetRange("No.", rec."No.");
        // if SalesInvLineRec.FindSet() then
        //     SalesInvLineRec.DeleteAll();

        ExportRefRec.Reset();
        ExportRefRec.SetRange("No.", Rec."No.");
        if ExportRefRec.FindSet() then
            ExportRefRec.DeleteAll();

        SalesInvRec.Reset();
        SalesInvRec.SetRange("Export Ref No.", rec."No.");
        if SalesInvRec.FindSet() then begin
            // SalesInvRec."Export Ref No." := '';
            SalesInvRec.ModifyAll("Export Ref No.", '');
        end;
    end;

    var
        InvValue: Decimal;
}