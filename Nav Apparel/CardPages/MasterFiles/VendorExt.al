pageextension 71012744 VendorCardExt extends "Vendor Card"
{
    layout
    {
        addafter(Receiving)
        {
            group("Main Category")
            {
                part("Main Category Vendor List part"; "Main Category Vendor List part")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Vendor No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        addlast("F&unctions")
        {
            action("Add Category")
            {
                Caption = 'Add  Category';
                ApplicationArea = All;
                Image = Production;

                trigger OnAction();
                var
                    MainCategoryList: Page "Main Category List part";
                begin
                    Clear(MainCategoryList);
                    MainCategoryList.LookupMode(true);
                    MainCategoryList.PassParameters("No.");
                    MainCategoryList.Run();
                end;
            }
        }
    }

}