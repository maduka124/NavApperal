page 50698 FabShadeShrinkageList
{
    PageType = List;
    SourceTable = FabShadeBandShriHeader;
    CardPageId = FabShadeShrinkageCard;
    SourceTableView = sorting("FabShadeNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FabShadeNo."; rec."FabShadeNo.")
                {
                    ApplicationArea = all;
                    Caption = 'Fab. Shade No';
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

    // trigger OnDeleteRecord(): Boolean
    // var
    //     FabShadeLineRec: Record FabShadeLine;
    // begin
    //     FabShadeLineRec.reset();
    //     FabShadeLineRec.SetRange("FabShadeNo.", "FabShadeNo.");
    //     if FabShadeLineRec.FindSet() then
    //         FabShadeLineRec.DeleteAll();
    // end;
}