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
                field("GITPINo."; rec."GITPINo.")
                {
                    ApplicationArea = All;
                    Caption = 'GIT PI No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Suppler Name"; rec."Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';

                    trigger OnValidate()
                    var
                        VendorRec: Record Vendor;
                        PIDetMasterRec: Record "PI Details Header";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        VendorRec.Reset();
                        VendorRec.SetRange(Name, rec."Suppler Name");
                        if VendorRec.FindSet() then
                            rec."Suppler No." := VendorRec."No.";


                        PIDetMasterRec.Reset();
                        PIDetMasterRec.SetCurrentKey("Supplier No.");
                        PIDetMasterRec.SetRange("Supplier No.", VendorRec."No.");
                        PIDetMasterRec.SetFilter(AssignedB2BNo, '=%1', '');
                        PIDetMasterRec.SetFilter(AssignedGITPINo, '=%1', '');

                        if PIDetMasterRec.FindSet() then begin
                            repeat
                                PIDetMasterRec.GITPINo := rec."GITPINo.";
                                PIDetMasterRec.Modify();
                            until PIDetMasterRec.Next() = 0;
                        end;


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
                field("Invoice No"; rec."Invoice No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Invoice Value"; rec."Invoice Value")
                {
                    ApplicationArea = All;
                }

                field("Invoice Date"; rec."Invoice Date")
                {
                    ApplicationArea = All;
                }

                field("Original Doc. Recv. Date"; rec."Original Doc. Recv. Date")
                {
                    ApplicationArea = All;
                }

                field("Mode of Ship"; rec."Mode of Ship")
                {
                    ApplicationArea = All;
                }

                field("BL/AWB NO"; rec."BL/AWB NO")
                {
                    ApplicationArea = All;
                }

                field("BL Date"; rec."BL Date")
                {
                    ApplicationArea = All;
                }

                field("Container No"; rec."Container No")
                {
                    ApplicationArea = All;
                    Caption = 'Container';
                }

                field("Carrier Name"; rec."Carrier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Carrier';
                }

                field(Agent; rec.Agent)
                {
                    ApplicationArea = All;
                }

                field("M. Vessel Name"; rec."M. Vessel Name")
                {
                    ApplicationArea = All;
                    Caption = 'M. Vessel';
                }

                field("M. Vessel ETD"; rec."M. Vessel ETD")
                {
                    ApplicationArea = All;
                }

                field("F. Vessel Name"; rec."F. Vessel Name")
                {
                    ApplicationArea = All;
                    Caption = 'F. Vessel';
                }

                field("F. Vessel ETA"; rec."F. Vessel ETA")
                {
                    ApplicationArea = All;
                }

                field("F. Vessel ETD"; rec."F. Vessel ETD")
                {
                    ApplicationArea = All;
                }

                field("N.N Docs DT"; rec."N.N Docs DT")
                {
                    ApplicationArea = All;
                }

                field("Original to C&F"; rec."Original to C&F")
                {
                    ApplicationArea = All;
                }

                field("Good inhouse"; rec."Good inhouse")
                {
                    ApplicationArea = All;
                }

                field("Bill of entry"; rec."Bill of entry")
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
                field("GRN Balance"; rec."GRN Balance")
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."GITPI Nos.", xRec."GITPINo.", rec."GITPINo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."GITPINo.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        GITBaseonPILineRec: Record GITBaseonPILine;
        GITPIPIRec: Record GITPIPI;
    begin
        GITBaseonPILineRec.Reset();
        GITBaseonPILineRec.SetRange("GITPINo.", rec."GITPINo.");
        GITBaseonPILineRec.DeleteAll();

        GITPIPIRec.Reset();
        GITPIPIRec.SetRange("GITPINo.", rec."GITPINo.");
        GITPIPIRec.DeleteAll();
    end;
}