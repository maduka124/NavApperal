pageextension 71012824 RequisitionLinesExt extends "Planning Worksheet"
{
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