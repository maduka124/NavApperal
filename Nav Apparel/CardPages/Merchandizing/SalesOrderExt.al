pageextension 50999 SalesOrderCardExt extends "Sales Order"
{
    layout
    {
        addafter(Status)
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Work Description")
        {

            field("Style Name"; rec."Style Name")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
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
                        rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    end
                    else begin   //logged in
                        rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    end;
                end;
            }

            field("PO No"; rec."PO No")
            {
                ApplicationArea = All;
            }

            field(Lot; rec.Lot)
            {
                ApplicationArea = All;
            }
        }

        modify("Order Date")
        {
            trigger OnAfterValidate()
            var
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
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end
                else begin   //logged in
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end;
            end;
        }

        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
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
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end
                else begin   //logged in
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end;
            end;
        }

        modify("Due Date")
        {
            trigger OnAfterValidate()
            var
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
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end
                else begin   //logged in
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end;
            end;
        }

        addafter(Lot)
        {
            field("No of Cartons"; rec."No of Cartons")
            {
                ApplicationArea = All;
            }

            field(CBM; rec.CBM)
            {
                ApplicationArea = All;
            }

            field("Exp No"; rec."Exp No")
            {
                ApplicationArea = All;
            }

            field("Exp Date"; rec."Exp Date")
            {
                ApplicationArea = All;
            }

            field("UD No"; rec."UD No")
            {
                ApplicationArea = All;
            }

            // Done by sachith On 15/03/23
            field("Contract No"; Rec."Contract No")
            {
                ApplicationArea = All;
            }
        }

        modify("Shortcut Dimension 1 Code")
        {
            trigger OnBeforeValidate()
            var
                SalesLineRec: Record "Sales Line";
                ReservEntryRec: Record "Reservation Entry";
                ProdOrderRec: Record "Production Order";
                ProdOrderLineRec: Record "Prod. Order Line";
                Temp: code[20];
            begin

                Temp := rec."Shortcut Dimension 1 Code";

                //Update sales line location code               
                SalesLineRec.Reset();
                SalesLineRec.SetRange("Document No.", rec."No.");
                SalesLineRec.SetRange("Document Type", rec."Document Type"::Order);
                if SalesLineRec.FindSet() then begin
                    repeat

                        //Delete reservation entry
                        ReservEntryRec.Reset();
                        ReservEntryRec.SetFilter("Reservation Status", '=%1', ReservEntryRec."Reservation Status"::Reservation);
                        ReservEntryRec.SetRange("Item No.", SalesLineRec."No.");
                        ReservEntryRec.SetRange("Source ID", SalesLineRec."Document No.");
                        if ReservEntryRec.FindSet() then
                            ReservEntryRec.DeleteAll();

                        SalesLineRec.Validate("Location Code", rec."Shortcut Dimension 1 Code");
                        SalesLineRec.Modify();

                    until SalesLineRec.Next() = 0;
                end;

                //Update location in Firm Plan Prod Order
                ProdOrderRec.SetFilter(Status, '=%1', ProdOrderRec.Status::"Firm Planned");
                ProdOrderRec.SetFilter("Source Type", '=%1', ProdOrderRec."Source Type"::"Sales Header");
                ProdOrderRec.SetRange("Source No.", rec."No.");

                if ProdOrderRec.FindSet() then begin
                    ProdOrderRec.ModifyAll("Location Code", Temp);
                end;


                //Update location in Firm Plan Prod Order lines
                ProdOrderLineRec.SetFilter(Status, '=%1', ProdOrderRec.Status::"Firm Planned");
                ProdOrderLineRec.SetRange("Prod. Order No.", ProdOrderRec."No.");

                if ProdOrderLineRec.FindSet() then begin
                    repeat
                        ProdOrderLineRec.ModifyAll("Location Code", Temp);
                    until ProdOrderLineRec.Next() = 0;
                end;


                CurrPage.Update();
                //Update header record location code
                rec.Validate("Location Code", rec."Shortcut Dimension 1 Code");
                rec."Shortcut Dimension 1 Code" := Temp;

            end;
        }
    }
}