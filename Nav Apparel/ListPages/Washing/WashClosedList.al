page 51462 WashClosedList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashCloseHrd;
    CardPageId = WashCloseCard;
    // Editable = false;
    // InsertAllowed = false;
    Caption = 'Wash Close';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO';
                }

                field("Lot No"; Rec."Lot No")
                {
                    ApplicationArea = All;
                    Caption = 'Lot';
                }

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; Rec."Factory Name")
                {
                    Caption = 'Factory';
                }

                field("Secondary UserID"; Rec."Secondary UserID")
                {
                    ApplicationArea = All;

                    Caption = 'Created User';
                }
            }
        }
    }
}