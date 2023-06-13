page 51322 BundleGuideReportLookup
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BundleGuideHeader;
    SourceTableView = sorting("BundleGuideNo.") order(descending);
    Caption = 'Bundle Guide No List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("BundleGuideNo."; rec."BundleGuideNo.")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                }

                field("Cut No"; rec."Cut No New")
                {
                    ApplicationArea = All;
                }

                field("Component Group"; rec."Component Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}