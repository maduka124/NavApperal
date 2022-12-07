page 50684 "FabShrinkageTestList"
{
    PageType = List;
    SourceTable = FabShrinkageTestHeader;
    CardPageId = FabShrinkageTestCard;
    SourceTableView = sorting("FabShrTestNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabShrTestNo."; rec."FabShrTestNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Doc No';
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

                field("Fabric Code"; rec."Fabric Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric';
                }

                field(Composition; rec.Composition)
                {
                    ApplicationArea = All;
                }

                field(Construction; rec.Construction)
                {
                    ApplicationArea = All;
                }

                field("No of Roll"; rec."No of Roll")
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
        FabShrTestLineRec: Record FabShrinkageTestLine;
    begin
        FabShrTestLineRec.reset();
        FabShrTestLineRec.SetRange("FabShrTestNo.", rec."FabShrTestNo.");
        if FabShrTestLineRec.FindSet() then
            FabShrTestLineRec.DeleteAll();
    end;
}