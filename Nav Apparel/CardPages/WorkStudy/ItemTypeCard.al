page 50462 "Item Type Card"
{
    PageType = Card;
    SourceTable = "Item Type";
    Caption = 'Item Type ';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item Type No';
                }

                field("Item Type Name"; rec."Item Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemTypeRec: Record "Item Type";
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
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;


                        ItemTypeRec.Reset();
                        ItemTypeRec.SetRange("Item Type Name", rec."Item Type Name");
                        if ItemTypeRec.FindSet() then
                            Error('Item Type Name already exists.');
                    end;
                }
            }
        }
    }
}