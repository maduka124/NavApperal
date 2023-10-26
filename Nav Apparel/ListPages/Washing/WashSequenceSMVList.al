page 51448 WashSequenceSMVList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashSequenceSMVHeader;
    CardPageId = WashSequenceSMVCard;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Caption = 'No';
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

                field("Lot No"; Rec."Lot No")
                {
                    ApplicationArea = All;
                    Caption = 'Lot';
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO';
                }

                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Factory Name"; Rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Fatory';
                }

                field("Secondary UserID"; Rec."Secondary UserID")
                {
                    ApplicationArea = All;
                    Caption = 'Create User';
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        WashSeqSmvLineRec: Record WashSequenceSMVLine;
    begin

        WashSeqSmvLineRec.Reset();
        WashSeqSmvLineRec.SetRange(No, Rec.No);

        if WashSeqSmvLineRec.FindSet() then
            WashSeqSmvLineRec.DeleteAll(true);
    end;
}