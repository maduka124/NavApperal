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
        //MIhiranga 2023/02/24
        addafter(Blocked)
        {
            field("General Item Vendor"; Rec."General Item Vendor")
            {
                ApplicationArea = VAT;
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

    //Done By Sachith On 29/03/23
    trigger OnDeleteRecord(): Boolean
    var
        BOMEstimateLineRec: Record "BOM Estimate Line";
    begin

        BOMEstimateLineRec.Reset();
        BOMEstimateLineRec.SetRange("Supplier No.", Rec."No.");

        if BOMEstimateLineRec.FindSet() then
            Error('This Vendor has been used in Estimate BOM. Cannot delete.');
    end;

}