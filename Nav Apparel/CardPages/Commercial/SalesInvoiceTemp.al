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

                field("Contract No"; ContractNo)
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
                        salesInvRec."Contract No" := ContractNo;
                        salesInvRec.Modify();
                        Message('Contract No Added');
                    end;
                end;
            }
        }
    }
    var
        ContractNo: Text[50];
        No: Code[20];
}