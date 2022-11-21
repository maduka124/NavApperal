page 50839 "PreProductionfollowupList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PreProductionFollowUpHeader;
    CardPageId = PreProductionfollowup;
    Caption = 'Pre-Production Follow Up';
    //SourceTableView = where();

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        UserSetupRec: Record "User Setup";
    begin
        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then
            SetFilter("Factory Code", UserSetupRec."Factory Code");
    end;
}