page 71012826 "Gate Pass List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Gate Pass Header";
    CardPageId = "Gate Pass Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Gate Pass No';
                }

                field("Transfer Date"; "Transfer Date")
                {
                    ApplicationArea = All;
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

                field("Transfer From Name"; "Transfer From Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer From';
                }

                field("Transfer To Name"; "Transfer To Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer To';
                }

                field("Sent By"; "Sent By")
                {
                    ApplicationArea = All;
                }

                field(Approved; Approved)
                {
                    ApplicationArea = All;
                }

                field("Approved By"; "Approved By")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        BOMEstimateRec: Record "BOM Estimate";
        BOMLineEstRec: Record "BOM Estimate Line";
    begin
        BOMEstimateRec.SetRange("No.", "No.");
        BOMEstimateRec.DeleteAll();

        BOMLineEstRec.SetRange("No.", "No.");
        BOMLineEstRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
    begin
        CurrPage.Editable(false);
    end;
}