pageextension 50948 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {

            field("Fab Inspection Level"; rec."Fab Inspection Level")
            {
                ApplicationArea = All;
                Caption = 'Fabric Inspection Level (%)';
            }


            field("Group Id"; rec."Group Id")
            {
                ApplicationArea = All;
                Caption = 'Merchandizer Group';
            }
        }

        addafter(Shipping)
        {
            group("Samples Types")
            {
                part("Sample Type Buyer List part"; "Sample Type Buyer List part")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Buyer No." = FIELD("No.");
                }
            }
        }

    }

    actions
    {
        addlast("F&unctions")
        {
            action("Sample Types")
            {
                Caption = 'Sample Types';
                Image = Production;
                ApplicationArea = All;

                trigger OnAction();
                var
                    SampleList: Page "Sample Type List part";
                begin
                    Clear(SampleList);
                    SampleList.LookupMode(true);
                    SampleList.PassParameters(rec."No.");
                    SampleList.Run();
                end;
            }
        }
    }

}