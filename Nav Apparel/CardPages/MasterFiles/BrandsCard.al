page 50945 "Brand Card"
{
    PageType = Card;
    SourceTable = Brand;
    Caption = 'Brand';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Brand No';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BrandRec: Record Brand;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", rec."Brand Name");
                        if BrandRec.FindSet() then
                            Error('Brand name already exists.');

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                    end;
                }
                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, rec."Buyer Name");
                        if BuyerRec.FindSet() then begin
                            rec."Buyer No." := BuyerRec."No.";
                        end;
                    end;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}