page 51359 ReqToApprove
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Approval Entry";
    Caption = 'ReqToApprove';


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Number of Approved Requests"; Rec."Number of Approved Requests")
                {
                    ApplicationArea = All;
                }
                field("Number of Rejected Requests"; Rec."Number of Rejected Requests")
                {
                    ApplicationArea = All;
                }
                field("Approval Type"; Rec."Approval Type")
                {
                    ApplicationArea = All;
                }
                field("Pending Approvals"; Rec."Pending Approvals")
                {
                    ApplicationArea = All;
                }

            }
        }
    }





}