page 51204 "Bank Ref Colle Dist ListPart"
{
    PageType = ListPart;
    SourceTable = BankRefDistribution;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // field("Document No"; Rec."Document No")
                // {
                //     ApplicationArea = All;
                // }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if (rec."Posting Date" < WorkDate()) then
                            Error('Posting date should be greater than or equal todays date.');
                    end;
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Debit Bank Account No"; Rec."Debit Bank Account No")
                {
                    ApplicationArea = All;
                }

                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."Credit Amount" := rec."Debit Amount" * -1;
                    end;
                }

                field("Credit Bank Account No"; rec."Credit Bank Account No")
                {
                    ApplicationArea = All;
                }

                field("Credit Amount"; rec."Credit Amount")
                {
                    ApplicationArea = All;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}