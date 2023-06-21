page 51325 "SalesInvoiceTemp"
{
    PageType = Card;
    SourceTable = "Sales Invoice Header";

    Permissions = tabledata "Sales Invoice Header" = rm;
    // Permissions = tabledata BankReferenceHeader = rimd;


    layout
    {
        area(Content)
        {
            group(General)
            {

                field("No."; No)
                {
                    ApplicationArea = All;
                }
                field("Style No"; Rec."Style No")
                {
                    ApplicationArea = All;
                }
                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                }
                field("Lc Contract No"; "Lc Contract No")
                {
                    ApplicationArea = All;
                    TableRelation = "Contract/LCMaster"."No.";

                    trigger OnValidate()
                    var
                        LCRec: Record "Contract/LCMaster";
                    begin
                        LCRec.Reset();
                        LCRec.SetRange("No.", "Lc Contract No");
                        if LCRec.FindSet() then begin
                            Rec."Contract No" := LCRec."Contract No";
                        end;

                    end;
                }

                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Export Ref No."; Rec."Export Ref No.")
                {
                    ApplicationArea = All;
                }
            }

        }
    }


    actions
    {
        area(Processing)
        {
            action("Add Contract No")
            {
                ApplicationArea = all;

                trigger OnAction()
                var
                    salesInvRec: Record "Sales Invoice Header";
                begin
                    salesInvRec.Reset();
                    salesInvRec.SetRange("No.", No);
                    if salesInvRec.FindSet() then begin
                        salesInvRec."Contract No" := Rec."Contract No";
                        salesInvRec.Modify();
                        Message('Contract No Added');
                    end;
                end;
            }
        }
    }
    var

        No: Code[20];
        "Lc Contract No": Code[20];
}