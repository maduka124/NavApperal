pageextension 71012824 RequisitionLinesExt extends "Planning Worksheet"
{

    layout
    {
        addbefore("No.")
        {
            field("Main Category"; "Main Category")
            {
                ApplicationArea = ALL;
            }
        }

        addafter("No.")
        {
            field(Description1; Description)
            {
                ApplicationArea = ALL;
                Caption = 'Description';
            }

            field(StyleName; StyleName)
            {
                ApplicationArea = ALL;
                Caption = 'Style';
            }

            field(PONo; PONo)
            {
                ApplicationArea = ALL;
                Caption = 'PO';
            }

            field(Lot; Lot)
            {
                ApplicationArea = ALL;
            }
        }

        modify(Description)
        {
            Visible = false;
        }

        modify("Vendor No.")
        {
            Visible = true;
        }

        modify("Location Code")
        {
            Visible = true;
        }

        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }

        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
    }


    actions
    {
        addlast("F&unctions")
        {
            action("Select All")
            {
                Caption = 'Select All';
                Image = SelectMore;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ReqRec: Record "Requisition Line";
                begin
                    ReqRec.Reset();
                    //ReqRec.SetRange("No.", "No.");
                    ReqRec.FindSet();

                    repeat
                        ReqRec."Accept Action Message" := true;
                        ReqRec.Modify();
                    until ReqRec.Next() = 0;

                    CurrPage.Update();
                end;
            }

            action("De-Select All")
            {
                Caption = 'De-Select All';
                Image = RemoveLine;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ReqRec: Record "Requisition Line";
                begin
                    ReqRec.Reset();
                    //ReqRec.SetRange("No.", "No.");
                    ReqRec.FindSet();

                    repeat
                        ReqRec."Accept Action Message" := false;
                        ReqRec.Modify();
                    until ReqRec.Next() = 0;

                    CurrPage.Update();
                end;
            }
        }
    }
}