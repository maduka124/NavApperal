page 50673 "FabricProceList"
{
    PageType = List;
    SourceTable = FabricProceHeader;
    CardPageId = FabricProceCard;
    SourceTableView = sorting("FabricProceNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabricProceNo."; rec."FabricProceNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Fabric Proc. No';
                }

                field("Buyer Name."; rec."Buyer Name.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No';
                }

                field(GRN; rec.GRN)
                {
                    ApplicationArea = All;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field("No of Roll"; rec."No of Roll1")
                {
                    ApplicationArea = All;
                    Caption = 'No of Rolls';
                }
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

    trigger OnDeleteRecord(): Boolean
    var
        FabricProLineRec: Record FabricProceLine;
    begin
        FabricProLineRec.reset();
        FabricProLineRec.SetRange("FabricProceNo.", rec."FabricProceNo.");
        if FabricProLineRec.FindSet() then
            FabricProLineRec.DeleteAll();
    end;
}