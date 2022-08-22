page 50532 "GIT Baseon PI Card"
{
    PageType = Card;
    SourceTable = GITBaseonPI;
    Caption = 'Goods In Transit - Base On PI';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("GITPINo."; "GITPINo.")
                {
                    ApplicationArea = All;
                    Caption = 'GIT PI No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Suppler Name"; "Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';

                    trigger OnValidate()
                    var
                        VendorRec: Record Vendor;
                        PIDetMasterRec: Record "PI Details Header";
                    begin
                        VendorRec.Reset();
                        VendorRec.SetRange(Name, "Suppler Name");
                        if VendorRec.FindSet() then
                            "Suppler No." := VendorRec."No.";


                        PIDetMasterRec.Reset();
                        PIDetMasterRec.SetCurrentKey("Supplier No.");
                        PIDetMasterRec.SetRange("Supplier No.", VendorRec."No.");
                        PIDetMasterRec.SetFilter(AssignedB2BNo, '=%1', '');
                        PIDetMasterRec.SetFilter(AssignedGITPINo, '=%1', '');

                        if PIDetMasterRec.FindSet() then begin
                            repeat
                                PIDetMasterRec.GITPINo := "GITPINo.";
                                PIDetMasterRec.Modify();
                            until PIDetMasterRec.Next() = 0;
                        end;

                    end;
                }
            }

            group("Select PIs")
            {
                part("GIT PI ListPart1"; "GIT PI ListPart1")
                {
                    ApplicationArea = All;
                    Caption = 'Available PIs';
                    SubPageLink = "Supplier No." = FIELD("Suppler No.");
                }

                part("GIT PI ListPart2"; "GIT PI ListPart2")
                {
                    ApplicationArea = All;
                    Caption = 'Selected PIs';
                    SubPageLink = "GITPINo." = FIELD("GITPINo.");
                }
            }

            group("   ")
            {
                field("Invoice No"; "Invoice No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Invoice Value"; "Invoice Value")
                {
                    ApplicationArea = All;
                }

                field("Invoice Date"; "Invoice Date")
                {
                    ApplicationArea = All;
                }

                field("Original Doc. Recv. Date"; "Original Doc. Recv. Date")
                {
                    ApplicationArea = All;
                }

                field("Mode of Ship"; "Mode of Ship")
                {
                    ApplicationArea = All;
                }

                field("BL/AWB NO"; "BL/AWB NO")
                {
                    ApplicationArea = All;
                }

                field("BL Date"; "BL Date")
                {
                    ApplicationArea = All;
                }

                field("Container No"; "Container No")
                {
                    ApplicationArea = All;
                    Caption = 'Container';
                }

                field("Carrier Name"; "Carrier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Carrier';
                }

                field(Agent; Agent)
                {
                    ApplicationArea = All;
                }

                field("M. Vessel Name"; "M. Vessel Name")
                {
                    ApplicationArea = All;
                    Caption = 'M. Vessel';
                }

                field("M. Vessel ETD"; "M. Vessel ETD")
                {
                    ApplicationArea = All;
                }

                field("F. Vessel Name"; "F. Vessel Name")
                {
                    ApplicationArea = All;
                    Caption = 'F. Vessel';
                }

                field("F. Vessel ETA"; "F. Vessel ETA")
                {
                    ApplicationArea = All;
                }

                field("F. Vessel ETD"; "F. Vessel ETD")
                {
                    ApplicationArea = All;
                }

                field("N.N Docs DT"; "N.N Docs DT")
                {
                    ApplicationArea = All;
                }

                field("Original to C&F"; "Original to C&F")
                {
                    ApplicationArea = All;
                }

                field("Good inhouse"; "Good inhouse")
                {
                    ApplicationArea = All;
                }

                field("Bill of entry"; "Bill of entry")
                {
                    ApplicationArea = All;
                }
            }

            group("  ")
            {
                part("GIT Based on PI ListPart"; "GIT Based on PI ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "GITPINo." = FIELD("GITPINo.");
                }
            }

            group("    ")
            {
                field("GRN Balance"; "GRN Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."GITPI Nos.", xRec."GITPINo.", "GITPINo.") THEN BEGIN
            NoSeriesMngment.SetSeries("GITPINo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        GITBaseonPILineRec: Record GITBaseonPILine;
        GITPIPIRec: Record GITPIPI;
    begin
        GITBaseonPILineRec.Reset();
        GITBaseonPILineRec.SetRange("GITPINo.", "GITPINo.");
        GITBaseonPILineRec.DeleteAll();

        GITPIPIRec.Reset();
        GITPIPIRec.SetRange("GITPINo.", "GITPINo.");
        GITPIPIRec.DeleteAll();
    end;
}