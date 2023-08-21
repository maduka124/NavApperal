page 50764 "Bank Ref Invoice ListPart1"
{
    PageType = ListPart;
    // SourceTable = "Sales Invoice Header";
    SourceTable = ContractPostedInvoices;
    //SourceTableView = where(AssignedBankRefNo = filter(''));
    SourceTableView = where(AssignedBankRefNo = filter(''));
    DeleteAllowed = false;
    InsertAllowed = false;
    Permissions = tabledata "Sales Invoice Header" = rm;
    // Permissions = tabledata BankReferenceHeader = rimd;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }

                field("Inv No."; Rec."Inv No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Invoice No';
                    Visible = false;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Po No';
                }
                field("Factory Inv No"; Rec."Factory Inv No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Factory Inv No';
                }
                field("Inv Value"; Rec."Inv Value")
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
                    // SalesInvRec: Record "Sales Invoice Header";
                    ContPostedInvRec1: Record ContractPostedInvoices;
                    ContPostedInvRec: Record ContractPostedInvoices;
                    BankRefInvRec: Record BankReferenceInvoice;
                    BankRefHeadRec: Record BankReferenceHeader;
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    BankRefNo1: Code[20];
                begin

                    ContPostedInvRec.Reset();
                    ContPostedInvRec.SetFilter(Select, '=%1', true);

                    if ContPostedInvRec.FindSet() then begin
                        repeat

                            BankRefHeadRec.Reset();
                            BankRefHeadRec.SetRange("No.", ContPostedInvRec.BankRefNo);
                            if BankRefHeadRec.FindSet() then begin


                                //add new Invoice to the Bankref
                                BankRefNo1 := ContPostedInvRec.BankRefNo;
                                BankRefInvRec.Init();

                                BankRefInvRec.BankRefNo := BankRefHeadRec."BankRefNo.";
                                BankRefInvRec."No." := ContPostedInvRec.BankRefNo;  //System no series
                                BankRefInvRec."Invoice No" := ContPostedInvRec."Inv No.";
                                BankRefInvRec."Ship Value" := ContPostedInvRec."Inv Value";
                                BankRefInvRec."Invoice Date" := ContPostedInvRec."Inv Date";
                                BankRefInvRec."Order No" := ContPostedInvRec."Order No";
                                BankRefInvRec."Factory Inv No" := ContPostedInvRec."Factory Inv No";
                                BankRefInvRec."Created User" := UserId;
                                BankRefInvRec."Created Date" := WorkDate();
                                BankRefInvRec."Contract No" := ContPostedInvRec."LC/Contract No.";
                                BankRefInvRec.Insert();


                                //Update Style master contractno
                                ContPostedInvRec.AssignedBankRefNo := Rec.BankRefNo;
                                ContPostedInvRec.Modify();
                                CurrPage.Update();

                                // SalesInvRec.Reset();
                                // SalesInvRec.SetRange("No.", BankRefInvRec."Invoice No");
                                // if SalesInvRec.FindSet() then begin
                                //     SalesInvRec.Status := 1;
                                //     SalesInvRec.Modify();
                                // end;
                            end;
                        until ContPostedInvRec.Next() = 0;

                    end;


                    //Update Select as false
                    ContPostedInvRec.Reset();
                    ContPostedInvRec.SetFilter(Select, '=%1', true);

                    if ContPostedInvRec.FindSet() then begin
                        ContPostedInvRec.ModifyAll(Select, false);
                    end;

                    CodeUnitNav.CalQtyBankRef(BankRefNo1);
                    CurrPage.Update();



                    BankRefInvRec.Reset();
                    BankRefInvRec.SetRange("No.", rec.BankRefNo);
                    if BankRefInvRec.FindSet() then begin
                        BankRefHeadRec.Reset();
                        BankRefHeadRec.SetRange("No.", rec.BankRefNo);
                        if BankRefHeadRec.FindSet() then begin
                            BankRefHeadRec."Row Count" := BankRefInvRec.Count();
                            BankRefHeadRec.Modify();
                            // CurrPage.Update();
                        end;
                    end;
                end;
            }
        }
    }
}