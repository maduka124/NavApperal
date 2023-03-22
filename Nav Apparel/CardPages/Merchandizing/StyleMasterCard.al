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
                    Editable = false;

                    trigger OnValidate()
                    var
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        "Contract/LCStyleRec": Record "Contract/LCStyle";
                    //NavappPlanLineRec: Record "NavApp Planning Lines";
                    begin
                        // NavappPlanLineRec.Reset();
                        // NavappPlanLineRec.SetRange("Style No.", rec."No.");
                        // if NavappPlanLineRec.FindSet() then
                        //     Error('Style already planned. Cannot change quantity.');

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

                        //Done By Sachith on 10/03/23
                        "Contract/LCStyleRec".Reset();
                        "Contract/LCStyleRec".SetRange("Style No.", Rec."No.");

                        if "Contract/LCStyleRec".FindSet() then
                            Error('Style allocated to a Contract. Cannot change the Quantity.');
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

                // field("Merchandizer Group Name"; rec."Merchandizer Group Name")
                // {
                //     ApplicationArea = All;
                //     TableRelation = MerchandizingGroupTable."Group Name";

                // }

                // field(BPCD; rec.BPCD)
                // {
                //     ApplicationArea = All;
                //     ShowMandatory = true;

                //     trigger OnValidate()
                //     var
                //     begin
                //         if rec.BPCD < WorkDate() then
                //             Error('BPCD should be greater than todays date');
                //     end;
                // }

                // field("LC No/Contract"; "LC No/Contract")
                // {
                //     ApplicationArea = All;
                // }
            }

            group("Special Operations")
            {
                part("SpecialOperationStyle Listpart"; "SpecialOperationStyle Listpart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("No.");
                    Editable = false;
                }
            }

            group("Order Details")
            {
                part("Style Master PO ListPart"; "Style Master PO ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
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

        //rec.TestField(BPCD);

        if rec."Order Qty" = 0 then
            Error('Order quantity cannot be zero.');

        //Update Po Total         
        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange("Style No.", rec."No.");
        StyleMasterPORec.FindSet();

        repeat
            Tot += StyleMasterPORec.Qty;
            StyleMasterPORec.TestField(BPCD);
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