page 50953 "Garment Store Card"
{
    PageType = Card;
    SourceTable = "Garment Store";
    Caption = 'Garment Store';

    layout
    {

        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Store No';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", rec."Store Name");
                        GarmentStoreRec.SetRange("Country No_", rec."Country No_");
                        if GarmentStoreRec.FindSet() then
                            Error('Store name already exists for the country %1', rec.Country);


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

                field("Country No_"; rec."Country No_")
                {
                    ApplicationArea = All;
                    TableRelation = "Country/Region".Code;
                    Caption = 'Country';

                    trigger OnValidate()
                    var
                        countryrec: Record "Country/Region";
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        countryrec.get(rec."Country No_");
                        Name := countryrec.Name;
                        rec.Country := Name;

                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", rec."Store Name");
                        GarmentStoreRec.SetRange("Country No_", rec."Country No_");
                        if GarmentStoreRec.FindSet() then
                            Error('Store name already exists for the country %1', rec.Country);
                    end;
                }

                field(Country; rec.Country)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    var
        Name: Text[20];

}