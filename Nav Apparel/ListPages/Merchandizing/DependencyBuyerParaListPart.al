page 51038 "Dependency Buyer Para ListPart"
{
    PageType = Card;
    SourceTable = "Dependency Parameters";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                    Editable = false;
                }

                field("Dependency Group"; rec."Dependency Group")
                {
                    ApplicationArea = All;
                    Caption = 'Dependency';
                    Editable = false;
                }

                field("Action Description"; rec."Action Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Gap Days"; rec."Gap Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Select; rec.Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("MK Critical"; rec."MK Critical")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Action Type"; rec."Action Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Action User"; rec."Action User")
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
        DependencyBuyerParaRec: Record "Dependency Buyer Para";
        DependencyRec: Record "Dependency Parameters";
        BuyerRec: Record Customer;
        LineNo: BigInteger;
    begin

        //Get buyer name
        BuyerRec.Reset();
        BuyerRec.SetRange("No.", BuyerNo);
        BuyerRec.FindSet();


        //if CloseAction = Action::OK then begin
        DependencyBuyerParaRec.SetRange("Buyer No.", BuyerNo);
        DependencyBuyerParaRec.SetRange("Main Dependency No.", MainDependencyNo);
        DependencyBuyerParaRec.DeleteAll();

        //Get Max Lineno
        LineNo := 0;
        DependencyBuyerParaRec.Reset();

        if DependencyBuyerParaRec.FindLast() then
            LineNo := DependencyBuyerParaRec."No.";

        REPEAT
            if DependencyRec.Select = true then begin
                LineNo += 1;
                DependencyBuyerParaRec.Init();
                DependencyBuyerParaRec."No." := LineNo;
                DependencyBuyerParaRec."Buyer No." := BuyerNo;
                DependencyBuyerParaRec."Buyer Name" := BuyerRec.Name;
                DependencyBuyerParaRec."Main Dependency No." := MainDependencyNo;
                DependencyBuyerParaRec."Dependency Group No." := DependencyRec."Dependency Group No.";
                DependencyBuyerParaRec."Dependency Group" := DependencyRec."Dependency Group";
                DependencyBuyerParaRec."Action Type No." := DependencyRec."Action Type No.";
                DependencyBuyerParaRec."Action Type" := DependencyRec."Action Type";
                DependencyBuyerParaRec."Action Description" := DependencyRec."Action Description";
                DependencyBuyerParaRec."Gap Days" := DependencyRec."Gap Days";
                DependencyBuyerParaRec."MK Critical" := DependencyRec."MK Critical";
                DependencyBuyerParaRec.Select := DependencyRec.Select;
                DependencyBuyerParaRec."Action User" := DependencyRec."Action User";
                DependencyBuyerParaRec."Created User" := UserId;
                DependencyBuyerParaRec."Created Date" := WorkDate();
                DependencyBuyerParaRec.Insert();
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