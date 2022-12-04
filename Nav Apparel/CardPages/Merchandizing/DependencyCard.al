page 71012699 "Dependency Card"
{
    PageType = Card;
    SourceTable = Dependency;
    Caption = 'Dependency';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Buyer Name."; rec."Buyer Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, rec."Buyer Name.");

                        if CustomerRec.FindSet() then
                           rec. "Buyer No." := CustomerRec."No.";
                    end;
                }

                field(Dependency; rec.Dependency)
                {
                    ApplicationArea = All;
                    Caption = 'Dependency';

                    trigger OnValidate()
                    var
                        DependencyGroupRec: Record "Dependency Group";
                    begin
                        DependencyGroupRec.Reset();
                        DependencyGroupRec.SetRange("Dependency Group", rec.Dependency);

                        if DependencyGroupRec.FindSet() then
                            rec."Dependency No." := DependencyGroupRec."No.";
                    end;
                }
            }

            group("Buyer Dependency List")
            {
                part("Buyer Dependency List1"; "Buyer Dependency List")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Buyer No." = FIELD("Buyer No."), "Main Dependency No." = field("Dependency No.");
                }
            }

            group("Buyer Dependency Parameters")
            {
                part("Dependency Buyer Para List"; "Dependency Buyer Para List")
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = "Buyer No." = FIELD("Buyer No."), "Main Dependency No." = field("Dependency No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add Dependency")
            {
                Caption = 'Add Dependency';
                ApplicationArea = All;
                Image = Departments;

                trigger OnAction();
                var
                    DependencyList: Page "Dependency Group ListPart";
                begin
                    Clear(DependencyList);
                    DependencyList.LookupMode(true);
                    DependencyList.PassParameters(rec."Buyer No.", rec."Dependency No.");
                    DependencyList.RunModal();
                    CurrPage.Update();
                end;
            }

            action("Select Parameters For the Buyer")
            {
                Caption = 'Select Parameters For the Buyer';
                ApplicationArea = All;
                Image = SelectMore;

                trigger OnAction();
                var
                    DependencyBuyerParaList: Page "Dependency Buyer Para ListPart";
                begin
                    Clear(DependencyBuyerParaList);
                    DependencyBuyerParaList.LookupMode(true);
                    DependencyBuyerParaList.PassParameters(rec."Buyer No.", rec."Dependency No.");
                    DependencyBuyerParaList.RunModal();
                    CurrPage.Update();

                end;
            }
        }
    }
}