page 50765 "Bank Ref Invoice ListPart2"
{
    PageType = ListPart;
    SourceTable = BankReferenceInvoice;
    DeleteAllowed = false;
    InsertAllowed = false;
    //Permissions = tabledata "Sales Invoice Header" = rm;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                }

                field("Ship Value"; Rec."Ship Value")
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
                    ContPostedInvRec: Record ContractPostedInvoices;
                    BankRefInvRec: Record BankReferenceInvoice;
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                begin
                    BankRefInvRec.Reset();
                    BankRefInvRec.SetRange("No.", Rec."No.");
                    BankRefInvRec.SetFilter(Select, '=%1', true);

                    if BankRefInvRec.FindSet() then begin
                        repeat
                            //Update Purchase order pi no
                            ContPostedInvRec.Reset();
                            ContPostedInvRec.SetRange("Inv No.", BankRefInvRec."Invoice No");
                            if ContPostedInvRec.FindSet() then begin
                                ContPostedInvRec.Select := false;
                                ContPostedInvRec.AssignedBankRefNo := '';
                                ContPostedInvRec.Modify();
                            end;
                        until BankRefInvRec.Next() = 0;
                    end;

                    //Delete from line table
                    BankRefInvRec.Reset();
                    BankRefInvRec.SetRange("No.", Rec."No.");
                    BankRefInvRec.SetFilter(Select, '=%1', true);
                    BankRefInvRec.DeleteAll();

                    CodeUnitNav.CalQtyBankRef(Rec."No.");
                    CurrPage.Update();
                end;
            }
        }
    }
}