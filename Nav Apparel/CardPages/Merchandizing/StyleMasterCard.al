page 50607 "Style Master Card"
{
    PageType = Card;
    SourceTable = "Style Master";
    Caption = 'Style Master';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style No';
                }

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style Name';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Store';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Brand';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Garment Type';
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
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

                field("CM Price (Doz)"; rec."CM Price (Doz)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Efficiency %"; rec."Plan Efficiency %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(BPCD; rec.BPCD)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                // field("LC No/Contract"; "LC No/Contract")
                // {
                //     ApplicationArea = All;
                // }
            }

            group(" ")
            {
                part("SpecialOperationStyle Listpart"; "SpecialOperationStyle Listpart")
                {
                    ApplicationArea = All;
                    Caption = 'Special Operations';
                    SubPageLink = "Style No." = FIELD("No.");
                    Editable = false;
                }
            }

            group("")
            {
                part("Style Master PO ListPart"; "Style Master PO ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'Order Details';
                    SubPageLink = "Style No." = FIELD("No.");
                }
            }

            group("  ")
            {
                field("PO Total"; rec."PO Total")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }


        area(FactBoxes)
        {
            part("Style Picture"; "BOM Picture FactBox")
            {
                ApplicationArea = All;
                Caption = 'Style Picture';
                SubPageLink = "No." = FIELD("No.");
                Editable = false;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        Tot: BigInteger;
    begin

        rec.TestField(BPCD);

        if rec."Order Qty" = 0 then
            Error('Order quantity cannot be zero.');

        //Update Po Total         
        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange("Style No.", rec."No.");
        StyleMasterPORec.FindSet();

        repeat
            Tot += StyleMasterPORec.Qty;
        until StyleMasterPORec.Next() = 0;

        rec."PO Total" := Tot;
        CurrPage.Update();

        if rec."Order Qty" <> rec."PO Total" then
            Error('Order quantity should match PO total.');
    end;


    trigger OnOpenPage()
    var
        BOMEstimateCostRec: Record "BOM Estimate Cost";
        StyleMasterRec: Record "Style Master";
    begin
        BOMEstimateCostRec.Reset();
        BOMEstimateCostRec.SetCurrentKey("Style No.");
        BOMEstimateCostRec.SetRange("Style No.", rec."No.");

        if BOMEstimateCostRec.FindSet() then begin

            if Format(rec."CM Price (Doz)") = '0' then
                rec."CM Price (Doz)" := BOMEstimateCostRec."CM Doz";

            // if SMV = 0.00 then
            //     SMV := BOMEstimateCostRec.SMV;

            if rec."Plan Efficiency %" = 0.00 then
                rec."Plan Efficiency %" := BOMEstimateCostRec."Project Efficiency.";

            CurrPage.Update();

        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
    begin
        if rec.Status = rec.Status::Confirmed then
            Error('Style already confirmed. Cannot delete.');
    end;
}