page 51167 BuyerWiseOrderBookingList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BuyerWiseOrderBookingHeader;
    CardPageId = BuyerWiseOrderBooking;
    SourceTableView = sorting(Year) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Year; rec.Year)
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
        end;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BuyerWiseOdrBookingAllBookRec: Record BuyerWiseOdrBookingAllBook;
        BuyerWiseOdrBookinBalatoSewRec: Record BuyerWiseOrderBookinBalatoSew;
        BuyerWiseOdrBookinBalatoShipRec: Record BuyerWiseOrderBookinBalatoShip;
        BuyerWiseOrderBookinGRWiseBookRec: Record BuyerWiseOrderBookinGRWiseBook;

    begin
        BuyerWiseOdrBookingAllBookRec.Reset();
        BuyerWiseOdrBookingAllBookRec.SetRange(Year, rec.Year);
        if BuyerWiseOdrBookingAllBookRec.FindSet() then
            BuyerWiseOdrBookingAllBookRec.DeleteAll();

        BuyerWiseOdrBookinBalatoSewRec.Reset();
        BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, rec.Year);
        if BuyerWiseOdrBookinBalatoSewRec.FindSet() then
            BuyerWiseOdrBookinBalatoSewRec.DeleteAll();

        BuyerWiseOdrBookinBalatoShipRec.Reset();
        BuyerWiseOdrBookinBalatoShipRec.SetRange(Year, rec.Year);
        if BuyerWiseOdrBookinBalatoShipRec.FindSet() then
            BuyerWiseOdrBookinBalatoShipRec.DeleteAll();

        BuyerWiseOrderBookinGRWiseBookRec.Reset();
        BuyerWiseOrderBookinGRWiseBookRec.SetRange(Year, rec.Year);
        if BuyerWiseOrderBookinGRWiseBookRec.FindSet() then
            BuyerWiseOrderBookinGRWiseBookRec.DeleteAll();
    end;
}