pageextension 50119 InventorySetupPage extends "Inventory Setup"
{
    layout
    {
        addlast(General)
        {
            field("Gen. Issue Template"; rec."Gen. Issue Template")
            {
                ApplicationArea = All;
            }
        }
        addlast(Numbering)
        {
            field("Gen. Issue Nos."; rec."Gen. Issue Nos.")
            {
                ApplicationArea = All;
            }
            field("Posted Gen. Issue Nos."; rec."Posted Gen. Issue Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
}
