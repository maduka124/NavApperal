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
                field("Suppler Name"; Rec."Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field(January; Rec.January)
                {
                    ApplicationArea = All;
                }

                field(February; Rec.February)
                {
                    ApplicationArea = All;
                }

                field(March; Rec.March)
                {
                    ApplicationArea = All;
                }

                field(April; Rec.April)
                {
                    ApplicationArea = All;
                }

                field(May; Rec.May)
                {
                    ApplicationArea = All;
                }

                field(June; Rec.June)
                {
                    ApplicationArea = All;
                }

                field(July; Rec.July)
                {
                    ApplicationArea = All;
                }

                field(August; Rec.August)
                {
                    ApplicationArea = All;
                }

                field(September; Rec.September)
                {
                    ApplicationArea = All;
                }

                field(October; Rec.October)
                {
                    ApplicationArea = All;
                }

                field(November; Rec.November)
                {
                    ApplicationArea = All;
                }

                field(December; Rec.December)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}