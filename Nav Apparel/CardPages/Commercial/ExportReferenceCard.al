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
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
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
                    end;
                }

                field("Invoice No"; rec."Invoice No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SalesInvRec: Record "Sales Invoice Header";
                        SalesInvLineRec: Record "Sales Invoice Line";
                        ExportRefLineRec: Record ExportReferenceLine;
                    begin

                        if xRec."Invoice No" <> '' then begin
                            SalesInvRec.Reset();
                            SalesInvRec.SetRange("No.", xRec."Invoice No");
                            SalesInvRec.FindSet();
                            SalesInvRec."Export Ref No." := '';
                            SalesInvRec.Modify();
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

                            //Assign "Export Ref No."
                            SalesInvRec."Export Ref No." := rec."No.";
                            SalesInvRec.Modify();
                        end;
                    end;
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
                }

                field("BL Date"; rec."BL Date")
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
        SalesInvLineRec: Record "Sales Invoice Line";
        SalesInvRec: Record "Sales Invoice Header";
    begin
        SalesInvLineRec.Reset();
        SalesInvLineRec.SetRange("No.", rec."No.");
        if SalesInvLineRec.FindSet() then
            SalesInvLineRec.DeleteAll();

        SalesInvRec.Reset();
        SalesInvRec.SetRange("Export Ref No.", rec."No.");
        if SalesInvRec.FindSet() then begin
            SalesInvRec."Export Ref No." := '';
            SalesInvRec.Modify();
        end;
    end;
}