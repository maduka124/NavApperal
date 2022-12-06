page 50663 "Cutting Progress List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CuttingProgressHeader;
    CardPageId = "Cutting Progress Card";
    SourceTableView = sorting("CutProNo.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("CutProNo."; Rec."CutProNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Cutting Progress No';
                }

                field(LaySheetNo; Rec.LaySheetNo)
                {
                    ApplicationArea = All;
                    Caption = 'Lay Sheet No';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }

                field("Cut No."; Rec."Cut No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cut No';
                }

                field("Marker Name"; Rec."Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Marker Length"; Rec."Marker Length")
                {
                    ApplicationArea = All;
                }

                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
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
        CuttingProgressLineRec: Record CuttingProgressLine;
    begin
        CuttingProgressLineRec.reset();
        CuttingProgressLineRec.SetRange("CutProNo.", Rec."CutProNo.");
        CuttingProgressLineRec.DeleteAll();
    end;
}