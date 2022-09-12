page 71012827 "Gate Pass Card"
{
    PageType = Card;
    SourceTable = "Gate Pass Header";
    Caption = 'Gate Pass';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Gate Pass No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Vehicle No."; "Vehicle No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle No';
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                }

                field("Transfer Date"; "Transfer Date")
                {
                    ApplicationArea = All;
                }

                field("Transfer From Name"; "Transfer From Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer From';

                    // trigger OnValidate()
                    // var
                    //     BrandRec: Record "Brand";
                    // begin
                    //     BrandRec.Reset();
                    //     BrandRec.SetRange("Brand Name", "Brand Name");
                    //     if BrandRec.FindSet() then
                    //         "Brand No." := BrandRec."No.";
                    // end;
                }

                field("Transfer To Name"; "Transfer To Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer To';

                    // trigger OnValidate()
                    // var
                    //     BuyerRec: Record Customer;
                    // begin
                    //     BuyerRec.Reset();
                    //     BuyerRec.SetRange(Name, "Buyer Name");
                    //     if BuyerRec.FindSet() then begin
                    //         "Buyer No." := BuyerRec."No.";
                    //         "Currency No." := BuyerRec."Currency Code";
                    //     end;
                    // end;
                }

                // field("Consignment Type"; "Consignment Type")
                // {
                //     ApplicationArea = All;
                // }

                // field(Description; Description)
                // {
                //     ApplicationArea = All;
                //     MultiLine = true;
                // }

                field("Expected Return Date"; "Expected Return Date")
                {
                    ApplicationArea = All;
                }

                field("Sent By"; "Sent By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Approved By"; "Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Approved; Approved)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }

            group("Items")
            {
                part("Gate Pass ListPart"; "Gate Pass ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Calculate)
            {
                ApplicationArea = All;
                Image = Calculate;

                trigger OnAction()
                var
                    BOMEstimateLIneRec: Record "BOM Estimate Line";
                    Total: Decimal;
                begin



                    Message('Completed');

                end;
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Gatepass Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    // trigger OnDeleteRecord(): Boolean
    // var
    //     BOMEstimateRec: Record "BOM Estimate";
    //     BOMLineEstRec: Record "BOM Estimate Line";
    //     StyleMas: Record "Style Master";
    // begin
    //     BOMEstimateRec.SetRange("No.", "No.");
    //     BOMEstimateRec.DeleteAll();

    //     BOMLineEstRec.SetRange("No.", "No.");
    //     BOMLineEstRec.DeleteAll();

    //     StyleMas.Reset();
    //     StyleMas.SetRange("No.", "Style No.");
    //     StyleMas.FindSet();
    //     StyleMas.ModifyAll(EstimateBOM, '');

    // end;   

}