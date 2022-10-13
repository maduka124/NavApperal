page 50765 "Bank Ref Invoice ListPart2"
{
    PageType = ListPart;
    SourceTable = BankReferenceInvoice;
    DeleteAllowed = false;
    InsertAllowed = false;
    Permissions = tabledata "Sales Invoice Header" = rm;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Invoice No"; "Invoice No")
                {
                    ApplicationArea = All;
                }

                field("Ship Value"; "Ship Value")
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
            action(Remove)
            {
                ApplicationArea = All;
                Image = RemoveLine;

                trigger OnAction()
                var
                    SalesInvRec: Record "Sales Invoice Header";
                    BankRefInvRec: Record BankReferenceInvoice;
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                begin
                    BankRefInvRec.Reset();
                    BankRefInvRec.SetRange("No.", "No.");
                    BankRefInvRec.SetFilter(Select, '=%1', true);

                    if BankRefInvRec.FindSet() then begin
                        repeat
                            //Update Purchase order pi no
                            SalesInvRec.Reset();
                            SalesInvRec.SetRange("No.", BankRefInvRec."Invoice No");
                            SalesInvRec.FindSet();
                            SalesInvRec.Select := false;
                            SalesInvRec.AssignedBankRefNo := '';
                            SalesInvRec.Modify();
                        until BankRefInvRec.Next() = 0;
                    end;

                    //Delete from line table
                    BankRefInvRec.Reset();
                    BankRefInvRec.SetRange("No.", "No.");
                    BankRefInvRec.SetFilter(Select, '=%1', true);
                    BankRefInvRec.DeleteAll();

                    CodeUnitNav.CalQtyBankRef("No.");
                    CurrPage.Update();
                end;
            }
        }
    }
}