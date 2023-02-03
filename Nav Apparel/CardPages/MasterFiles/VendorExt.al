pageextension 50980 VendorCardExt extends "Vendor Card"
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

                // trigger OnAction();
                // var
                //     MainCategoryList: Page "Main Category List part";
                // begin

                //     Clear(MainCategoryList);
                //     MainCategoryList.LookupMode(true);
                //     MainCategoryList.PassParameters(rec."No.");
                //     MainCategoryList.Run();
                // end;

                //Done By Sachith on 03/02/23
                trigger OnAction();
                var
                    MainCategoryList: Page "Main Category List part";
                begin
                    Clear(MainCategoryList);
                    MainCategoryList.LookupMode(true);
                    MainCategoryList.PassParameters(rec."No.");
                    MainCategoryList.RunModal();
                    CurrPage.Update();
                end;
            }
        }
    }

}