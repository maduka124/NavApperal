page 51179 BuyWisOdrBookAllBookDashBoard
{
    PageType = Card;
    Caption = 'Buyer Wise Order Booking  - All Booking';
    Editable = true;
    ModifyAllowed = true;


    layout
    {
        area(Content)
        {
            part(Control98; "Power BI Report Spinner Part")
            {
                AccessByPermission = TableData "Power BI User Configuration" = I;
                ApplicationArea = Basic, Suite;
                Enabled = true;
                Editable = true;
            }
        }
    }

    trigger OnOpenPage();
    begin
        CurrPage.Editable(true);
    end;
}