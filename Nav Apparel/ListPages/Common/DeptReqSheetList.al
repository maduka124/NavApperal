page 50821 "Department Requisition Sheet"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DeptReqSheetHeader;
    CardPageId = DepReqSheetHeaderCard;
    SourceTableView = sorting("Req No") order(descending);
    //CardPageId = "Department Requisition Sheet Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Req No"; "Req No")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition No';
                }

                field("Request Date"; "Request Date")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    // trigger OnDeleteRecord(): Boolean
    // var
    //     GatePassLineRec: Record "Gate Pass Line";
    // begin
    //     GatePassLineRec.SetRange("No.", "No.");
    //     GatePassLineRec.DeleteAll();
    // end;


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then begin
            Rec.SetCurrentKey("Factory Code");
            Rec.SETFILTER("Factory Code", '%1', STRSUBSTNO('*%1*', UserRec."Factory Code"));
        end;
    end;
}