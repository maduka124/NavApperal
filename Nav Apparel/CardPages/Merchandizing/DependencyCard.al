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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Buyer Name."; "Buyer Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, "Buyer Name.");

                        if CustomerRec.FindSet() then
                            "Buyer No." := CustomerRec."No.";
                    end;
                }

                field(Dependency; Dependency)
                {
                    ApplicationArea = All;
                    Caption = 'Dependency';

                    trigger OnValidate()
                    var
                        DependencyGroupRec: Record "Dependency Group";
                    begin
                        DependencyGroupRec.Reset();
                        DependencyGroupRec.SetRange("Dependency Group", Dependency);

                        if DependencyGroupRec.FindSet() then
                            "Dependency No." := DependencyGroupRec."No.";
                    end;
                }
            }

            group("Dependency List")
            {
                part("Buyer Dependency List"; "Buyer Dependency List")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer Dependency List';
                    SubPageLink = "Buyer No." = FIELD("Buyer No."), "Main Dependency No." = field("Dependency No.");
                }
            }

            group("Dependency Parameters")
            {
                part("Dependency Buyer Para List"; "Dependency Buyer Para List")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer Parameter List ';
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
                    DependencyList.PassParameters("Buyer No.", "Dependency No.");
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
                    DependencyBuyerParaList.PassParameters("Buyer No.", "Dependency No.");
                    DependencyBuyerParaList.RunModal();
                    CurrPage.Update();

                end;
            }
        }
    }
}