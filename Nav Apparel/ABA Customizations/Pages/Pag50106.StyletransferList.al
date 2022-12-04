page 50106 "Style transfer List"
{
    ApplicationArea = All;
    Caption = 'Style transfer List';
    PageType = List;
    SourceTable = "Style transfer Header";
    UsageCategory = Lists;
    Editable = false;

    CardPageId = 50105;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("From Prod. Order No."; Rec."From Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("From Style Name"; Rec."From Style Name")
                {
                    ApplicationArea = All;
                }
                field("To Prod. Order No."; Rec."To Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("To Style Name"; Rec."To Style Name")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
