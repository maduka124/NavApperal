page 51247 "Buyer Style PO Search"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                    TableRelation = Customer."No.";

                    trigger OnLookup(var text: Text): Boolean
                    var
                        CutomerRec: Record Customer;
                        UsersetupRec: Record "User Setup";
                    begin

                        UsersetupRec.Get(UserId);

                        if UsersetupRec."Merchandizer Group Name" = '' then begin
                            if Page.RunModal(22, CutomerRec) = Action::LookupOK then
                                Buyer := CutomerRec."No.";
                        end

                        else
                            if Page.RunModal(22, CutomerRec) = Action::LookupOK then begin
                                Buyer := CutomerRec."No.";
                            end


                        // if Page.RunModal(22,) = Action::LookupOK then begin
                        //     
                        // end;
                    end;
                }

                field(Style; Style)
                {
                    ApplicationArea = all;
                    //TableRelation = "Style Master"."No." where("Buyer No." = field('Buyer'));



                }

                field(Posted; Posted)
                {
                    ApplicationArea = All;
                }
            }

            group(" ")
            {
                part("Buyer Style PO Search Listpart"; "Buyer Style PO Search Listpart")
                {
                    Caption = ' ';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Load PO Details")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UsersetupRec: Record "User Setup";
    begin

        UsersetupRec.Reset();
        UsersetupRec.FindSet();

        UserID := UsersetupRec."User ID";
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;

    var
        Buyer: Code[20];
        Style: Text[50];
        UserID: Code[50];
        Posted: Boolean;

}