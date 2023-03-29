page 51267 "Bundle Card List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BundleCardTable;
    CardPageId = Bundlecard;
    Caption = 'Bundle Card List';


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Bundle Card No"; Rec."Bundle Card No")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Card No';
                }

                field(StyleNo; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field(Type; Rec.Type)
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
        GMTPartsBdlCard2Rec: Record GarmentPartsBundleCard2;
    begin
        GMTPartsBdlCard2Rec.reset();
        GMTPartsBdlCard2Rec.SetRange(BundleCardNo, rec."Bundle Card No");
        if GMTPartsBdlCard2Rec.FindSet() then
            GMTPartsBdlCard2Rec.DeleteAll();
    end;

}