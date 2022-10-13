page 50764 "Bank Ref Invoice ListPart1"
{
    PageType = ListPart;
    SourceTable = "Sales Invoice Header";
    SourceTableView = where(AssignedBankRefNo = filter(''));
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
                }

                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Invoice No';
                }

                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Ship Value';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Add)
            {
                ApplicationArea = All;
                Image = Add;

                trigger OnAction()
                var
                    SalesInvRec: Record "Sales Invoice Header";
                    BankRefInvRec: Record BankReferenceInvoice;
                    BankRefHeadRec: Record BankReferenceHeader;
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    BankRefNo1: Code[20];
                begin

                    SalesInvRec.Reset();
                    SalesInvRec.SetFilter(Select, '=%1', true);

                    if SalesInvRec.FindSet() then begin
                        repeat

                            BankRefHeadRec.Reset();
                            BankRefHeadRec.SetRange("No.", SalesInvRec.BankRefNo);
                            BankRefHeadRec.FindSet();

                            //add new Invoice to the Bankref
                            BankRefNo1 := SalesInvRec.BankRefNo;
                            BankRefInvRec.Init();
                            BankRefInvRec.BankRefNo := BankRefHeadRec."BankRefNo.";
                            BankRefInvRec."No." := SalesInvRec.BankRefNo;
                            BankRefInvRec."Invoice No" := SalesInvRec."No.";
                            SalesInvRec.CalcFields("Amount Including VAT");
                            BankRefInvRec."Ship Value" := SalesInvRec."Amount Including VAT";
                            BankRefInvRec."Invoice Date" := SalesInvRec."Document Date";
                            BankRefInvRec."Created User" := UserId;
                            BankRefInvRec."Created Date" := WorkDate();
                            BankRefInvRec.Insert();

                            //Update Style master contractno
                            SalesInvRec.AssignedBankRefNo := BankRefNo;
                            SalesInvRec.Modify();

                        until SalesInvRec.Next() = 0;

                    end;

                    //Update Select as false
                    SalesInvRec.Reset();
                    SalesInvRec.SetFilter(Select, '=%1', true);

                    if SalesInvRec.FindSet() then begin
                        SalesInvRec.ModifyAll(Select, false);
                    end;

                    CodeUnitNav.CalQtyBankRef(BankRefNo1);
                    CurrPage.Update();
                end;
            }
        }
    }
}