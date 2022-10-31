page 50666 "Bundle Guide List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BundleGuideHeader;
    CardPageId = "Bundle Guide Card";
    SourceTableView = sorting("BundleGuideNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("BundleGuideNo."; "BundleGuideNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Bundle Guide No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                }

                field("Component Group"; "Component Group")
                {
                    ApplicationArea = All;
                }

                field("Cut No"; "Cut No")
                {
                    ApplicationArea = All;
                }

                field("Bundle Rule"; "Bundle Rule")
                {
                    ApplicationArea = All;
                }

                field("Bundle Method"; "Bundle Method")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        BundleGuideLineRec: Record BundleGuideLine;
    begin
        BundleGuideLineRec.reset();
        BundleGuideLineRec.SetRange("BundleGuideNo.", "BundleGuideNo.");
        BundleGuideLineRec.DeleteAll();
    end;

}