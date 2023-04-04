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

                field(Type1; Rec.Type1)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
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
        GMTPartsBdlCard2Rec: Record GarmentPartsBundleCard2Right;
        GMTPartsBdlCardLeftRec: Record GarmentPartsBundleCardLeft;
        UserRec: Record "User Setup";
    begin

        //Done By sachith on 03/04/23
        UserRec.Reset();
        UserRec.Get(UserId);

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

        GMTPartsBdlCard2Rec.reset();
        GMTPartsBdlCard2Rec.SetRange(BundleCardNo, rec."Bundle Card No");
        if GMTPartsBdlCard2Rec.FindSet() then
            GMTPartsBdlCard2Rec.DeleteAll();

        GMTPartsBdlCardLeftRec.reset();
        GMTPartsBdlCardLeftRec.SetRange(BundleCardNo, rec."Bundle Card No");
        if GMTPartsBdlCardLeftRec.FindSet() then
            GMTPartsBdlCardLeftRec.DeleteAll();
    end;

}