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

                field(Type; Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Type = Type::"TT or Cash" then begin
                            VisibleVar := false;
                            "B2BLC No" := '';
                            "B2BLC No (System)" := '';
                        end
                        else
                            VisibleVar := true;
                    end;
                }

                field("Suppler Name"; "Suppler Name")
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

                        VendorRec.Reset();
                        VendorRec.SetRange(Name, "Suppler Name");
                        if VendorRec.FindSet() then
                            "Suppler No." := VendorRec."No.";

                        CurrPage.Update();

                        if (Type = Type::"TT or Cash") and ("Suppler No." <> '') then begin

                            //Delete old records
                            AcceptanceInv1Rec.Reset();
                            AcceptanceInv1Rec.DeleteAll();

                            //Get invoices for the selected supplier
                            GITBaseonPIRec.Reset();
                            GITBaseonPIRec.SetRange("Suppler No.", "Suppler No.");
                            GITBaseonPIRec.SetFilter(AssignedAccNo, '=%1', '');

                            if GITBaseonPIRec.FindSet() then begin
                                repeat

                                    //insert invoices for the TT
                                    AcceptanceInv1Rec.Init();
                                    AcceptanceInv1Rec.Type := Type::"TT or Cash";
                                    AcceptanceInv1Rec."AccNo." := "AccNo.";
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

                field("B2BLC No (System)"; "B2BLC No (System)")
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

                        if (Type = Type::"Based On B2B LC") and ("B2BLC No (System)" <> '') then begin

                            //Get B2B LC No
                            B2BLCMasRce.Reset();
                            B2BLCMasRce.SetRange("No.", "B2BLC No (System)");
                            B2BLCMasRce.FindSet();
                            "B2BLC No" := B2BLCMasRce."B2B LC No";

                            //Delete old records
                            AcceptanceInv1Rec.Reset();
                            AcceptanceInv1Rec.DeleteAll();

                            //Get invoices for the selected 'B2B LC No'
                            GITBaseonLCRec.Reset();
                            GITBaseonLCRec.SetRange("B2B LC No. (System)", "B2BLC No (System)");
                            GITBaseonLCRec.SetFilter(AssignedAccNo, '=%1', '');

                            if GITBaseonLCRec.FindSet() then begin
                                repeat

                                    //insert invoices for the TT
                                    AcceptanceInv1Rec.Init();
                                    AcceptanceInv1Rec.Type := Type::"Based On B2B LC";
                                    AcceptanceInv1Rec."B2BLC No." := GITBaseonLCRec."B2B LC No.";
                                    AcceptanceInv1Rec."B2BLC No. (System)" := GITBaseonLCRec."B2B LC No. (System)";
                                    AcceptanceInv1Rec."AccNo." := "AccNo.";
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

                field("B2BLC No"; "B2BLC No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //Editable = VisibleVar;
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
                field("Accept Date"; "Accept Date")
                {
                    ApplicationArea = All;
                }

                field("Accept Value"; "Accept Value")
                {
                    ApplicationArea = All;
                }

                field("Acceptance S/N"; "Acceptance S/N")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; "Maturity Date")
                {
                    ApplicationArea = All;
                }

                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = All;
                }
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
        AcceptanceLineRec.SetRange("AccNo.", "AccNo.");
        AcceptanceLineRec.DeleteAll();

        AcceptanceInv1Rec.reset();
        AcceptanceInv1Rec.SetRange("AccNo.", "AccNo.");
        AcceptanceInv1Rec.DeleteAll();

        AcceptanceInv2Rec.reset();
        AcceptanceInv2Rec.SetRange("AccNo.", "AccNo.");
        AcceptanceInv2Rec.DeleteAll();


        GITBaseonLCRec.reset();
        GITBaseonLCRec.SetRange(AssignedAccNo, "AccNo.");
        if GITBaseonLCRec.FindSet() then
            GITBaseonLCRec.ModifyAll(AssignedAccNo, '');

        GITBaseonPIRec.reset();
        GITBaseonPIRec.SetRange(AssignedAccNo, "AccNo.");
        if GITBaseonPIRec.FindSet() then
            GITBaseonPIRec.ModifyAll(AssignedAccNo, '');

    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Acc Nos.", xRec."AccNo.", "AccNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("AccNo.");
            EXIT(TRUE);
        END;
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