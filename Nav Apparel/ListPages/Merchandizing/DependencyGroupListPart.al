page 51040 "Dependency Group ListPart"
{
    PageType = Card;
    SourceTable = "Dependency Group";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Dependency No';
                    Editable = false;
                }

                field("Dependency Group"; rec."Dependency Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Selected; rec.Selected)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }

    var
        BuyerNo: Code[20];
        MainDependencyNo: Code[20];


    trigger OnClosePage()
    var
        DependencyBuyerRec: Record "Dependency Buyer";
        DependencyRec: Record "Dependency Group";
    begin

        //if CloseAction = Action::OK then begin
        DependencyBuyerRec.SetRange("Buyer No.", BuyerNo);
        DependencyBuyerRec.SetRange("Main Dependency No.", MainDependencyNo);
        DependencyBuyerRec.DeleteAll();

        REPEAT
            if DependencyRec.Selected = true then begin
                DependencyBuyerRec.Init();
                DependencyBuyerRec."Buyer No." := BuyerNo;
                DependencyBuyerRec."Main Dependency No." := MainDependencyNo;
                DependencyBuyerRec."Dependency No." := DependencyRec."No.";
                DependencyBuyerRec.Dependency := DependencyRec."Dependency Group";
                DependencyBuyerRec."Created User" := UserId;
                DependencyBuyerRec.Insert();
            end;
        UNTIL DependencyRec.NEXT <= 0;

        //end;
    end;


    procedure PassParameters(BuyerNoPara: Text; MainDependencyNoPara: Code[20]);
    var

    begin
        BuyerNo := BuyerNoPara;
        MainDependencyNo := MainDependencyNoPara;
    end;

}