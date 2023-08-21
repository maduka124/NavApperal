pageextension 51058 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field(StatusGB; StatusGB)
            {
                ApplicationArea = ALL;
                Caption = 'Plan Status';
            }

            field("Style Name"; Rec."Style Name")
            {
                ApplicationArea = ALL;
                Caption = 'Style';
            }

            field("PO No"; Rec."PO No")
            {
                ApplicationArea = ALL;
            }

            field(Lot; Rec.Lot)
            {
                ApplicationArea = ALL;
            }
        }

        addafter("Completely Shipped")
        {
            field("Total Quantity_Shipped"; "Total Quantity_Shipped")
            {
                ApplicationArea = all;
                Caption = 'Total Qty. Shipped';
                Editable = false;
                ToolTip = 'Specifies the sum of shipped quantity on all lines in the document.';
            }
        }
    }


    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

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

    trigger OnAfterGetRecord()
    var
        ProdOrderRec: Record "Production Order";
        SalesLineRec: Record "Sales Invoice Line";
    begin
        StatusGB := '';
        ProdOrderRec.Reset();
        ProdOrderRec.SetRange("Source No.", rec."No.");
        ProdOrderRec.SetRange("Source Type", ProdOrderRec."Source Type"::"Sales Header");
        if ProdOrderRec.FindSet() then begin
            case ProdOrderRec.Status of
                ProdOrderRec.Status::"Firm Planned":
                    StatusGB := 'Firm Planned';
                ProdOrderRec.Status::Released:
                    StatusGB := 'Released';
                ProdOrderRec.Status::Finished:
                    StatusGB := 'Finished';
                ProdOrderRec.Status::Planned:
                    StatusGB := 'Planned';
            end;
        end
        else
            StatusGB := '';

        //Add shipped qty
        SalesLineRec.Reset();
        SalesLineRec.SetRange("Order No.", rec."No.");
        SalesLineRec.SetFilter(Type, '=%1', SalesLineRec.Type::Item);
        SalesLineRec.CalcSums(Quantity);
        "Total Quantity_Shipped" := SalesLineRec.Quantity;
    end;



    var
        StatusGB: Text[20];
        "Total Quantity_Shipped": BigInteger;
}