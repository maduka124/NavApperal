pageextension 50107 MainCat extends "Main Category Card"
{
    layout
    {
        addlast(General)
        {
            field("Routing Link Code"; rec."Routing Link Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
            field("General Issuing"; rec."General Issuing")
            {
                ApplicationArea = All;
            }
        }
    }
}
