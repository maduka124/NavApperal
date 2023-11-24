page 50104 "Style Transfer Subform"
{
    Caption = 'Style Transfer Subform';
    PageType = ListPart;
    SourceTable = "Style Transfer Line";
    SourceTableView = where("Main Category" = filter(<> ''));
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    LinksAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Lines)
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
                field("Available Inventory"; rec."Available Inventory")
                {
                    ApplicationArea = All;
                }
                field("Required Quantity"; Rec."Required Quantity")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
