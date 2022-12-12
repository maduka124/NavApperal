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
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
    begin


        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            LoginSessionsRec.Reset();
            LoginSessionsRec.SetRange(SessionID, SessionId());
            LoginSessionsRec.FindSet();
        end;


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
                DependencyBuyerRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
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