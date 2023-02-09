page 51227 ServiceScheduleList
{
    PageType = List;
    Caption = 'Service Schedule List';
    SourceTable = ServiceScheduleHeader;
    SourceTableView = sorting(ServiceType, "Brand Name", "Model Name", "Machine Category");
    CardPageId = ServiceScheduleLCard;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(ServiceType; rec.ServiceType)
                {
                    ApplicationArea = All;
                    Caption = 'Service Type';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Model Name"; rec."Model Name")
                {
                    ApplicationArea = All;
                    Caption = 'Model';
                }

                field("Machine Category"; rec."Machine Category")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Category';
                }

                field("Part No"; rec."Part No")
                {
                    ApplicationArea = All;
                    Caption = 'Part No';
                }

                field("Part Name"; rec."Part Name")
                {
                    ApplicationArea = All;
                    Caption = 'Part Name';
                }

                field("Unit N0."; rec."Unit N0.")
                {
                    ApplicationArea = All;
                    Caption = 'Unit';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
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
            rec.SetFilter("Factory No.", '=%1', UserSetupRec."Factory Code")
        else
            Error('Cannot find user details in user setup table');
    end;



    trigger OnDeleteRecord(): Boolean
    var
        ServiceScheLineRec: Record ServiceScheduleLine;
    begin
        //Delete old records
        ServiceScheLineRec.Reset();
        ServiceScheLineRec.SetRange("Factory No.", rec."Factory No.");
        if ServiceScheLineRec.FindSet() then
            ServiceScheLineRec.DeleteAll();

    end;

}