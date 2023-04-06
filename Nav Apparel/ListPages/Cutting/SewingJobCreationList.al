page 50586 "Sewing Job Creation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SewingJobCreation;
    CardPageId = "Sewing Job Creation Card";
    SourceTableView = sorting(SJCNo) order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(SJCNo; Rec.SJCNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Creation No';
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field(MarkerCatName; Rec.MarkerCatName)
                {
                    ApplicationArea = All;
                    Caption = 'Marker Category';
                }

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserSetupRec: Record "User Setup";
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;


        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then begin
            if UserSetupRec."Factory Code" = '' then
                Error('Factory has not setup for the user : %1', UserId)
            else
                rec.SetFilter("Factory Code", '=%1', UserSetupRec."Factory Code");
        end
        else
            Error('Cannot find user details in user setup table');

    end;


    trigger OnDeleteRecord(): Boolean
    var
        SJC2: Record SewingJobCreationLine2;
        SJC3: Record SewingJobCreationLine3;
        SJC4: Record SewingJobCreationLine4;
        GroupMasterRec: Record GroupMaster;
        RatioRec: Record RatioCreation;
        UserRec: Record "User Setup";
    begin

        //Done By sachith on 06/04/23
        UserRec.Reset();
        UserRec.Get(UserId);

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');


        //Check whether ratio created or not
        SJC4.Reset();
        SJC4.SetRange("SJCNo.", Rec.SJCNo);
        SJC4.SetFilter("Record Type", '=%1', 'L');

        if SJC4.FindSet() then begin
            repeat
                RatioRec.Reset();
                RatioRec.SetRange("Style No.", Rec."Style No.");
                RatioRec.SetRange("Group ID", SJC4."Group ID");
                RatioRec.SetRange("Colour No", SJC4."Colour No");

                if RatioRec.FindSet() then begin
                    Message('Cannot delete. Ratio already created for the style %1 ,Group ID %2 , Color %3 ', Rec."Style Name", SJC4."Group ID", SJC4."Colour Name");
                    exit(false);
                end;
            until SJC4.Next() = 0;
        end;


        //Delete "DAILY LINE REQUIRMENT"
        SJC4.Reset();
        SJC4.SetRange("SJCNo.", Rec.SJCNo);
        if SJC4.FindSet() then
            SJC4.DeleteAll();

        //Delete group master record
        GroupMasterRec.Reset();
        GroupMasterRec.SetRange("Style No.", Rec."Style No.");
        if GroupMasterRec.FindSet() then
            GroupMasterRec.DeleteAll();

        //Delete "SUB SCHEDULING"
        SJC3.SetRange("SJCNo.", Rec.SJCNo);
        if SJC3.FindSet() then
            SJC3.DeleteAll();

        SJC2.SetRange("SJCNo.", Rec.SJCNo);
        if SJC2.FindSet() then
            SJC2.DeleteAll();

    end;
}