page 50115 "General Issue Subform"
{
    ApplicationArea = Suite;
    UsageCategory = Lists;
    Caption = 'General Issue Subform';
    PageType = ListPart;
    SourceTable = "General Issue Line";
    AutoSplitKey = true;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Main Category"; Rec."Main Category")
                {
                    ApplicationArea = All;
                }
                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
