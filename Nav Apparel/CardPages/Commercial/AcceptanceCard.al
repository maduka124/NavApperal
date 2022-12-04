page 50542 "Acceptance Card"
{
    PageType = Card;
    SourceTable = AcceptanceHeader;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("AccNo."; rec."AccNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Acceptance No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."Acceptance S/N" := format(rec."Acceptance S/N 2").PadLeft(7 - strlen(format(rec."Acceptance S/N 2")), '0');

                        if rec.Type = rec.Type::"TT or Cash" then begin
                            VisibleVar := false;
                            rec."B2BLC No" := '';
                            rec."B2BLC No (System)" := '';
                        end
                        else
                            VisibleVar := true;
                    end;
                }

                field("Suppler Name"; rec."Suppler Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Suppler';

                    trigger OnValidate()
                    var
                        VendorRec: Record Vendor;
                        AcceptanceInv1Rec: Record AcceptanceInv1;
                        GITBaseonPIRec: Record GITBaseonPI;
                    begin

                        rec."Acceptance S/N" := format(rec."Acceptance S/N 2").PadLeft(7 - strlen(format(rec."Acceptance S/N 2")), '0');

                        VendorRec.Reset();
                        VendorRec.SetRange(Name, rec."Suppler Name");
                        if VendorRec.FindSet() then
                            rec."Suppler No." := VendorRec."No.";

                        CurrPage.Update();

                        if (rec.Type = rec.Type::"TT or Cash") and (rec."Suppler No." <> '') then begin

                            //Delete old records
                            AcceptanceInv1Rec.Reset();
                            AcceptanceInv1Rec.DeleteAll();

                            //Get invoices for the selected supplier
                            GITBaseonPIRec.Reset();
                            GITBaseonPIRec.SetRange("Suppler No.", rec."Suppler No.");
                            GITBaseonPIRec.SetFilter(AssignedAccNo, '=%1', '');

                            if GITBaseonPIRec.FindSet() then begin
                                repeat

                                    //insert invoices for the TT
                                    AcceptanceInv1Rec.Init();
                                    AcceptanceInv1Rec.Type := rec.Type::"TT or Cash";
                                    AcceptanceInv1Rec."AccNo." := rec."AccNo.";
                                    AcceptanceInv1Rec."Created Date" := Today;
                                    AcceptanceInv1Rec."Created User" := UserId;
                                    AcceptanceInv1Rec."Inv Date" := GITBaseonPIRec."Invoice Date";
                                    AcceptanceInv1Rec."Inv No." := GITBaseonPIRec."Invoice No";
                                    AcceptanceInv1Rec."Inv Value" := GITBaseonPIRec."Invoice Value";
                                    AcceptanceInv1Rec."GITNo." := GITBaseonPIRec."GITPINo.";
                                    AcceptanceInv1Rec.Insert();

                                until GITBaseonPIRec.Next() = 0;

                            end;

                        end;

                    end;
                }

                field("B2BLC No (System)"; rec."B2BLC No (System)")
                {
                    ApplicationArea = All;
                    Editable = VisibleVar;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        AcceptanceInv1Rec: Record AcceptanceInv1;
                        GITBaseonLCRec: Record GITBaseonLC;
                        B2BLCMasRce: Record B2BLCMaster;
                    begin

                        rec."Acceptance S/N" := format(rec."Acceptance S/N 2").PadLeft(7 - strlen(format(rec."Acceptance S/N 2")), '0');

                        if (rec.Type = rec.Type::"Based On B2B LC") and (rec."B2BLC No (System)" <> '') then begin

                            //Get B2B LC No
                            B2BLCMasRce.Reset();
                            B2BLCMasRce.SetRange("No.", rec."B2BLC No (System)");
                            if B2BLCMasRce.FindSet() then begin
                                rec."B2BLC No" := B2BLCMasRce."B2B LC No";
                                rec."LC Issue Bank" := B2BLCMasRce."Issue Bank";
                                rec."LC Issue Bank No." := B2BLCMasRce."LC Issue Bank No.";
                            end;

                            //Delete old records
                            AcceptanceInv1Rec.Reset();
                            AcceptanceInv1Rec.DeleteAll();

                            //Get invoices for the selected 'B2B LC No'
                            GITBaseonLCRec.Reset();
                            GITBaseonLCRec.SetRange("B2B LC No. (System)", rec."B2BLC No (System)");
                            GITBaseonLCRec.SetFilter(AssignedAccNo, '=%1', '');

                            if GITBaseonLCRec.FindSet() then begin
                                repeat

                                    //insert invoices for the TT
                                    AcceptanceInv1Rec.Init();
                                    AcceptanceInv1Rec.Type := rec.Type::"Based On B2B LC";
                                    AcceptanceInv1Rec."B2BLC No." := GITBaseonLCRec."B2B LC No.";
                                    AcceptanceInv1Rec."B2BLC No. (System)" := GITBaseonLCRec."B2B LC No. (System)";
                                    AcceptanceInv1Rec."AccNo." := rec."AccNo.";
                                    AcceptanceInv1Rec."Created Date" := Today;
                                    AcceptanceInv1Rec."Created User" := UserId;
                                    AcceptanceInv1Rec."Inv Date" := GITBaseonLCRec."Invoice Date";
                                    AcceptanceInv1Rec."Inv No." := GITBaseonLCRec."Invoice No";
                                    AcceptanceInv1Rec."Inv Value" := GITBaseonLCRec."Invoice Value";
                                    AcceptanceInv1Rec."GITNo." := GITBaseonLCRec."GITLCNo.";
                                    AcceptanceInv1Rec.Insert();

                                until GITBaseonLCRec.Next() = 0;

                            end;

                        end;

                    end;
                }

                field("B2BLC No"; rec."B2BLC No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //Editable = VisibleVar;
                }

                field("LC Issue Bank"; rec."LC Issue Bank")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(" ")
            {
                part("Acc Inv ListPart1"; "Acc Inv ListPart1")
                {
                    ApplicationArea = All;
                    Caption = 'Available Commercial Invoices';
                }

                part("Acc Inv ListPart2"; "Acc Inv ListPart2")
                {
                    ApplicationArea = All;
                    Caption = 'Selected Commercial Invoices';
                    SubPageLink = "AccNo." = FIELD("AccNo.");
                }
            }

            group("Items")
            {
                part("Acc Inv Items ListPart"; "Acc Inv Items ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "AccNo." = FIELD("AccNo.");
                }
            }


            group("   ")
            {
                field("Accept Date"; rec."Accept Date")
                {
                    ApplicationArea = All;
                }

                field("Accept Value"; rec."Accept Value")
                {
                    ApplicationArea = All;
                }

                field("Acceptance S/N"; rec."Acceptance S/N")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Maturity Date"; rec."Maturity Date")
                {
                    ApplicationArea = All;
                }

                field("Payment Mode"; rec."Payment Mode")
                {
                    ApplicationArea = All;
                }

                // field("Acceptance S/N 2"; "Acceptance S/N 2")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Approve")
            {
                ApplicationArea = all;
                Image = Approve;

                trigger OnAction()
                var
                begin
                    rec.Approved := true;
                    rec.ApproveDate := Today;
                    CurrPage.Update();
                end;
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        AcceptanceLineRec: Record AcceptanceLine;
        AcceptanceInv1Rec: Record AcceptanceInv1;
        AcceptanceInv2Rec: Record AcceptanceInv2;
        GITBaseonLCRec: Record GITBaseonLC;
        GITBaseonPIRec: Record GITBaseonPI;
    begin
        AcceptanceLineRec.reset();
        AcceptanceLineRec.SetRange("AccNo.", rec."AccNo.");
        AcceptanceLineRec.DeleteAll();

        AcceptanceInv1Rec.reset();
        AcceptanceInv1Rec.SetRange("AccNo.", rec."AccNo.");
        AcceptanceInv1Rec.DeleteAll();

        AcceptanceInv2Rec.reset();
        AcceptanceInv2Rec.SetRange("AccNo.", rec."AccNo.");
        AcceptanceInv2Rec.DeleteAll();


        GITBaseonLCRec.reset();
        GITBaseonLCRec.SetRange(AssignedAccNo, rec."AccNo.");
        if GITBaseonLCRec.FindSet() then
            GITBaseonLCRec.ModifyAll(AssignedAccNo, '');

        GITBaseonPIRec.reset();
        GITBaseonPIRec.SetRange(AssignedAccNo, rec."AccNo.");
        if GITBaseonPIRec.FindSet() then
            GITBaseonPIRec.ModifyAll(AssignedAccNo, '');

    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Acc Nos.", xRec."AccNo.", rec."AccNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."AccNo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnOpenPage()
    var
    begin
        //  "Acceptance S/N" := PADSTR('', 3 - strlen(format("Acceptance S/N 2")), '0') + format("Acceptance S/N 2");
        rec."Acceptance S/N" := format(rec."Acceptance S/N 2").PadLeft(7 - strlen(format(rec."Acceptance S/N 2")), '0');
        CurrPage.Update();
    end;

    var
        VisibleVar: Boolean;

    trigger OnInit()
    var
        myInt: Integer;
    begin
        VisibleVar := true;
    end;
}