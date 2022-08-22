page 50551 "SupplierPaymentList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SupplierPayments;
    SourceTableView = sorting(Year, "Suppler Name") order(ascending);
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Caption = 'Supplier Wise Payment List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Suppler Name"; "Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field(January; January)
                {
                    ApplicationArea = All;
                }

                field(February; February)
                {
                    ApplicationArea = All;
                }

                field(March; March)
                {
                    ApplicationArea = All;
                }

                field(April; April)
                {
                    ApplicationArea = All;
                }

                field(May; May)
                {
                    ApplicationArea = All;
                }

                field(June; June)
                {
                    ApplicationArea = All;
                }

                field(July; July)
                {
                    ApplicationArea = All;
                }

                field(August; August)
                {
                    ApplicationArea = All;
                }

                field(September; September)
                {
                    ApplicationArea = All;
                }

                field(October; October)
                {
                    ApplicationArea = All;
                }

                field(November; November)
                {
                    ApplicationArea = All;
                }

                field(December; December)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}