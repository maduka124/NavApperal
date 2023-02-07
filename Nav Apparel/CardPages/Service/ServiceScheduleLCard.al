page 51228 ServiceScheduleLCard
{
    PageType = Card;
    Caption = 'Service Schedule List';
    SourceTable = ServiceScheduleHeader;

    layout
    {
        area(Content)
        {
            group(General)
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

                    trigger OnValidate()
                    var
                        LoginRec: Page "Login Card";
                        LoginSessionsRec: Record LoginSessions;
                        UserSetupRec: Record "User Setup";
                        Locationrec: Record Location;
                    begin
                        //Get Global Dimension
                        UserSetupRec.Reset();
                        UserSetupRec.SetRange("User ID", UserId);

                        if UserSetupRec.FindSet() then begin
                            rec."Global Dimension Code" := UserSetupRec."Global Dimension Code";
                            rec."Factory No." := UserSetupRec."Factory Code";

                            //Get factory
                            Locationrec.Reset();
                            Locationrec.SetRange(Code, UserSetupRec."Factory Code");
                            if Locationrec.FindSet() then
                                rec."Factory Name" := Locationrec.Name;
                        end;


                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else    //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                    end;
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
                    Caption = 'Type of Machine';

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                        ServiceScheLineRec: Record ServiceScheduleLine;
                    begin
                        //Delete old records
                        ServiceScheLineRec.Reset();
                        ServiceScheLineRec.SetRange("Factory No.", rec."Factory No.");
                        if ServiceScheLineRec.FindSet() then
                            ServiceScheLineRec.DeleteAll();

                        //Get part nos for the brand/model/category
                        ItemRec.Reset();
                        ItemRec.SetRange(Article, rec."Brand Name");
                        ItemRec.SetRange("Color Name", rec."Model Name");
                        ItemRec.SetRange("Size Range No.", rec."Machine Category");

                        if ItemRec.FindSet() then begin
                            repeat
                                ServiceScheLineRec.Init();
                                ServiceScheLineRec."Factory No." := rec."Factory No.";
                                ServiceScheLineRec."Factory Name" := rec."Factory Name";
                                ServiceScheLineRec."Part No" := ItemRec.Remarks;
                                ServiceScheLineRec."Part Name" := ItemRec.Description;
                                ServiceScheLineRec."Unit N0." := ItemRec."Base Unit of Measure";
                                ServiceScheLineRec.Qty := 1;
                                ServiceScheLineRec.Insert();
                            until ItemRec.Next() = 0;
                        end;
                    end;
                }
            }

            group("Part No Details")
            {
                part(ServiceScheduleListPart; ServiceScheduleListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    Editable = true;
                    SubPageLink = "Factory No." = field("Factory No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Service Schedule")
            {
                ApplicationArea = All;
                Image = ServiceItemWorksheet;

                trigger OnAction()
                var
                    ServiceScheHeadRec: Record ServiceScheduleHeader;
                    ServiceScheLineRec: Record ServiceScheduleLine;
                    UserSetupRec: Record "User Setup";
                    LoginRec: Page "Login Card";
                    LoginSessionsRec: Record LoginSessions;
                    MaxLineNo: BigInteger;
                begin

                    //Delete old records
                    ServiceScheHeadRec.Reset();
                    ServiceScheHeadRec.SetRange("Factory No.", rec."Factory No.");
                    ServiceScheHeadRec.SetRange("Brand Name", rec."Brand Name");
                    ServiceScheHeadRec.SetRange("Model Name", rec."Model Name");
                    ServiceScheHeadRec.SetRange("Machine Category", rec."Machine Category");
                    ServiceScheHeadRec.SetRange(ServiceType, rec.ServiceType);
                    if ServiceScheHeadRec.FindSet() then
                        ServiceScheHeadRec.DeleteAll();

                    //Get Max Lineno
                    MaxLineNo := 0;
                    ServiceScheHeadRec.Reset();
                    if ServiceScheHeadRec.FindLast() then
                        MaxLineNo := ServiceScheHeadRec."No.";

                    ServiceScheLineRec.Reset();
                    ServiceScheLineRec.SetFilter(Select, '=%1', true);
                    if ServiceScheLineRec.FindSet() then begin
                        repeat

                            MaxLineNo += 1;

                            //Insert Part no
                            ServiceScheHeadRec.Init();
                            ServiceScheHeadRec."No." := MaxLineNo;
                            ServiceScheHeadRec."Factory Name" := rec."Factory Name";
                            ServiceScheHeadRec."Factory No." := rec."Factory No.";
                            ServiceScheHeadRec."Brand Name" := rec."Brand Name";
                            ServiceScheHeadRec."Brand No" := rec."Brand No";
                            ServiceScheHeadRec."Created Date" := WorkDate();
                            ServiceScheHeadRec."Created User" := UserId;

                            //Get Global Dimension
                            UserSetupRec.Reset();
                            UserSetupRec.SetRange("User ID", UserId);

                            if UserSetupRec.FindSet() then
                                ServiceScheHeadRec."Global Dimension Code" := UserSetupRec."Global Dimension Code";

                            ServiceScheHeadRec.ServiceType := rec.ServiceType;
                            ServiceScheHeadRec."Machine Category" := rec."Machine Category";
                            ServiceScheHeadRec."Machine Category Code" := rec."Machine Category Code";
                            ServiceScheHeadRec."Model Name" := rec."Model Name";
                            ServiceScheHeadRec."Model No" := rec."Model No";
                            ServiceScheHeadRec."Part Name" := ServiceScheLineRec."Part Name";
                            ServiceScheHeadRec."Part No" := ServiceScheLineRec."Part No";
                            ServiceScheHeadRec.Qty := ServiceScheLineRec.Qty;

                            //Check whether user logged in or not
                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());

                            if not LoginSessionsRec.FindSet() then begin  //not logged in
                                Clear(LoginRec);
                                LoginRec.LookupMode(true);
                                LoginRec.RunModal();

                                LoginSessionsRec.Reset();
                                LoginSessionsRec.SetRange(SessionID, SessionId());
                                if LoginSessionsRec.FindSet() then
                                    ServiceScheHeadRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                            end
                            else    //logged in
                                ServiceScheHeadRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";

                            ServiceScheHeadRec."Unit N0." := ServiceScheLineRec."Unit N0.";
                            ServiceScheHeadRec.Insert();
                        until ServiceScheLineRec.Next() = 0;
                    end;

                    Message('Completed');

                end;
            }


            // action("Generate Worksheet")
            // {
            //     ApplicationArea = All;
            //     Image = Create;

            //     trigger OnAction()
            //     var
            //         ServiceWrokRec: Record ServiceWorksheet;
            //         WorkCenRec: Record "Work Center";
            //         ServiceItem: Record "Service Item";
            //         NextNo: BigInteger;
            //         LoginSessionsRec: Record LoginSessions;
            //         LoginRec: Page "Login Card";
            //     begin

            //         //Check whether user logged in or not
            //         LoginSessionsRec.Reset();
            //         LoginSessionsRec.SetRange(SessionID, SessionId());

            //         if not LoginSessionsRec.FindSet() then begin  //not logged in
            //             Clear(LoginRec);
            //             LoginRec.LookupMode(true);
            //             LoginRec.RunModal();

            //             LoginSessionsRec.Reset();
            //             LoginSessionsRec.SetRange(SessionID, SessionId());
            //             LoginSessionsRec.FindSet();
            //         end;


            //         // if StartDate = 0D then
            //         //     Error('Start date is blank');

            //         // if EndDate = 0D then
            //         //     Error('End date is blank');

            //         //Get Max No
            //         ServiceWrokRec.Reset();
            //         ServiceWrokRec.SetCurrentKey("No.");
            //         ServiceWrokRec.setAscending("No.", true);
            //         if ServiceWrokRec.FindLast() then
            //             NextNo := ServiceWrokRec."No.";

            //         NextNo += 1;
            //         rec."No." := NextNo;

            //         //Get All selected Work stations
            //         WorkCenRec.Reset();
            //         WorkCenRec.SetFilter("Linked To Service Item", '=%1', true);
            //         WorkCenRec.SetFilter(Select, '=%1', true);

            //         if WorkCenRec.FindSet() then begin
            //             repeat
            //                 //Get All Service Items for the date period and work station 
            //                 ServiceItem.Reset();
            //                 ServiceItem.SetRange("Work center Code", WorkCenRec."No.");
            //                 //ServiceItem.SetFilter("Service due date", '%1..%2', StartDate, EndDate);

            //                 if ServiceItem.FindSet() then begin
            //                     repeat

            //                         //Check for duplicates
            //                         ServiceWrokRec.Reset();
            //                         ServiceWrokRec.SetRange("Service Item No", ServiceItem."No.");

            //                         if not ServiceWrokRec.FindSet() then begin

            //                             //Insert recor
            //                             ServiceWrokRec.Init();
            //                             ServiceWrokRec."No." := NextNo;
            //                             ServiceWrokRec."Service Item No" := ServiceItem."No.";
            //                             ServiceWrokRec."Service Item Name" := ServiceItem.Description;
            //                             ServiceWrokRec."Work Center No" := WorkCenRec."No.";
            //                             ServiceWrokRec."Work Center Name" := WorkCenRec.Name;
            //                             ServiceWrokRec."Service Date" := ServiceItem."Service due date";
            //                             ServiceWrokRec.Approval := false;
            //                             ServiceWrokRec."Created User" := UserId;
            //                             ServiceWrokRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
            //                             ServiceWrokRec."Created Date" := WorkDate();
            //                             ServiceWrokRec.Insert();

            //                         end
            //                         else
            //                             ServiceWrokRec.ModifyAll("No.", NextNo);

            //                     until ServiceItem.Next() = 0;
            //                 end;

            //             until WorkCenRec.Next() = 0;
            //         end;

            //         CurrPage.Update();
            //         Message('Completed');

            //     end;
            // }

            // action("Post")
            // {
            //     ApplicationArea = All;
            //     Image = Post;

            //     trigger OnAction()
            //     var
            //         ServiceWrokRec: Record ServiceWorksheet;
            //         GenJrnlRec: record "Gen. Journal Line";
            //         ServiceItem: Record "Service Item";
            //         NavappRec: Record "NavApp Setup";
            //         StServLineRec: Record "Standard Service Line";
            //         ItemJrnlRec: Record "Item Journal Line";
            //         ResJrnlRec: Record "Res. Journal Line";
            //         NoSeriesMngment: Codeunit NoSeriesManagement;
            //         GenJnlCodeUnit: Codeunit "Gen. Jnl.-Post";
            //         ItemJnlCodeUnit: Codeunit "Item Jnl.-Post";
            //         ResJnlCodeUnit: Codeunit "Res. Jnl.-Post";
            //         GenJnlTemRec: Record "Gen. Journal Template";
            //         ServiceLdgrRec: Record "Service Ledger Entry";
            //         Users: Record "User Setup";
            //         TempDate: Date;
            //         GenLineNo: BigInteger;
            //         itemLineNo: BigInteger;
            //         ResLineNo: BigInteger;
            //         DocNo: code[20];
            //         BalAccountNo: code[20];
            //     begin

            //         NavappRec.Reset();
            //         NavappRec.FindSet();

            //         //Get Gen,Jnl Template bal account
            //         GenJnlTemRec.Reset();
            //         GenJnlTemRec.SetRange(name, NavappRec."Gen Journal Template Name");

            //         if GenJnlTemRec.Findset() then
            //             BalAccountNo := GenJnlTemRec."Bal. Account No.";


            //         //Get Last line No
            //         GenJrnlRec.Reset();
            //         GenJrnlRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
            //         GenJrnlRec.SetRange("Journal Template Name", NavappRec."Gen Journal Template Name");
            //         GenJrnlRec.SetRange("Journal Batch Name", NavappRec."Gen Journal Batch Name");

            //         if GenJrnlRec.FindLast() then
            //             GenLineNo := GenJrnlRec."Line No.";

            //         //Get Last line No
            //         ItemJrnlRec.Reset();
            //         ItemJrnlRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
            //         ItemJrnlRec.SetRange("Journal Template Name", NavappRec."Gen Journal Template Name");
            //         ItemJrnlRec.SetRange("Journal Batch Name", NavappRec."Gen Journal Batch Name");
            //         if ItemJrnlRec.FindLast() then
            //             itemLineNo := ItemJrnlRec."Line No.";

            //         //Get Last line No
            //         ResJrnlRec.Reset();
            //         ResJrnlRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
            //         ResJrnlRec.SetRange("Journal Template Name", NavappRec."Gen Journal Template Name");
            //         ResJrnlRec.SetRange("Journal Batch Name", NavappRec."Gen Journal Batch Name");
            //         if ResJrnlRec.FindLast() then
            //             ResLineNo := ResJrnlRec."Line No.";

            //         //Get user location
            //         Users.Reset();
            //         Users.SetRange("User ID", UserId());
            //         Users.FindSet();


            //         //get all the eligible records
            //         ServiceWrokRec.Reset();
            //         ServiceWrokRec.SetRange("No.", rec."No.");
            //         ServiceWrokRec.SetFilter(Approval, '=%1', true);

            //         if ServiceWrokRec.FindSet() then begin
            //             repeat
            //                 if ServiceWrokRec."Standard Service Code" = '' then
            //                     Error('Standard Service Code has not updated for Service Item : %1', ServiceWrokRec."Service Item Name");

            //                 DocNo := NoSeriesMngment.GetNextNo(NavappRec."Service Doc Nos.", Today, true);

            //                 //Get Standard service Line details
            //                 StServLineRec.Reset();
            //                 StServLineRec.SetRange("Standard Service Code", ServiceWrokRec."Standard Service Code");

            //                 if StServLineRec.FindSet() then begin
            //                     repeat
            //                         if StServLineRec.Type = StServLineRec.Type::Item then begin
            //                             //Write to item Journal entry   
            //                             itemLineNo += 10000;
            //                             ItemJrnlRec.Init();
            //                             ItemJrnlRec.Validate("Journal Template Name", NavappRec."Gen Journal Template Name");
            //                             ItemJrnlRec.Validate("Journal Batch Name", NavappRec."Gen Journal Batch Name");
            //                             ItemJrnlRec.validate("Line No.", itemLineNo);
            //                             ItemJrnlRec.Validate("Item No.", StServLineRec."No.");
            //                             ItemJrnlRec.Validate("Posting Date", WorkDate());
            //                             ItemJrnlRec.Validate("Entry Type", ItemJrnlRec."Entry Type"::"Negative Adjmt.");
            //                             ItemJrnlRec.Validate("Document No.", DocNo);
            //                             ItemJrnlRec.Validate("Location Code", Users."Factory Code");
            //                             ItemJrnlRec.Validate(Quantity, StServLineRec.Quantity);
            //                             ItemJrnlRec.Validate("Document Date", WorkDate());
            //                             ItemJrnlRec.Validate("Document Type", ItemJrnlRec."Document Type"::"Service Invoice");
            //                             ItemJrnlRec.Insert();
            //                         end;

            //                         if StServLineRec.Type = StServLineRec.Type::Resource then begin
            //                             //Write to Resource Journal entry   
            //                             ResLineNo += 10000;
            //                             ResJrnlRec.Init();
            //                             ResJrnlRec.Validate("Journal Template Name", NavappRec."Gen Journal Template Name");
            //                             ResJrnlRec.Validate("Journal Batch Name", NavappRec."Gen Journal Batch Name");
            //                             ResJrnlRec.validate("Line No.", ResLineNo);
            //                             ResJrnlRec.Validate("Entry Type", ResJrnlRec."Entry Type"::Usage);
            //                             ResJrnlRec.Validate("Document No.", DocNo);
            //                             ResJrnlRec.Validate("Posting Date", WorkDate());
            //                             ResJrnlRec.Validate("Resource No.", StServLineRec."No.");
            //                             ResJrnlRec.Validate(Quantity, StServLineRec.Quantity);
            //                             ResJrnlRec.Validate("Document Date", WorkDate());
            //                             ResJrnlRec.Insert();
            //                         end;

            //                         if StServLineRec.Type = StServLineRec.Type::"G/L Account" then begin
            //                             //Write to General Journal
            //                             GenLineNo += 10000;
            //                             GenJrnlRec.Init();
            //                             GenJrnlRec.Validate("Journal Template Name", NavappRec."Gen Journal Template Name");
            //                             GenJrnlRec.Validate("Journal Batch Name", NavappRec."Gen Journal Batch Name");
            //                             GenJrnlRec.validate("Line No.", GenLineNo);
            //                             GenJrnlRec.Validate("Account Type", GenJrnlRec."Account Type"::"G/L Account");
            //                             GenJrnlRec.Validate("Account No.", StServLineRec."No.");
            //                             GenJrnlRec.Validate("Posting Date", WorkDate);
            //                             GenJrnlRec.Validate("Document Type", GenJrnlRec."Document Type"::Invoice);
            //                             GenJrnlRec.Validate("Document No.", DocNo);
            //                             GenJrnlRec.Validate("Document Date", WorkDate());
            //                             GenJrnlRec.Validate("Bal. Account No.", BalAccountNo);
            //                             //GenJrnlRec.Validate("Currency Code", '');
            //                             GenJrnlRec.Validate(Amount, StServLineRec.Quantity);
            //                             GenJrnlRec.Insert();
            //                         end;

            //                     until StServLineRec.Next() = 0;
            //                 end;


            //                 //Update next Service Date
            //                 ServiceItem.Reset();
            //                 ServiceItem.SetRange("No.", ServiceWrokRec."Service Item No");

            //                 if ServiceItem.FindSet() then begin
            //                     if ServiceWrokRec."Next Service Date" = 0D then begin
            //                         if ServiceItem."Service Period" = ServiceItem."Service Period"::"''" then
            //                             Error('Service Period has not updated for Service Item : %1', ServiceItem.Name);

            //                         case ServiceItem."Service Period" of
            //                             ServiceItem."Service Period"::"1 Week":
            //                                 begin
            //                                     TempDate := CalcDate('<+1W>', ServiceWrokRec."Service Date");
            //                                     //break;
            //                                 end;
            //                             ServiceItem."Service Period"::"2 Weeks":
            //                                 begin
            //                                     TempDate := CalcDate('<+2W>', ServiceWrokRec."Service Date");
            //                                     //break;
            //                                 end;
            //                             ServiceItem."Service Period"::"3 Weeks":
            //                                 begin
            //                                     TempDate := CalcDate('<+3W>', ServiceWrokRec."Service Date");
            //                                     //break;
            //                                 end;
            //                             ServiceItem."Service Period"::"1 Month":
            //                                 begin
            //                                     TempDate := CalcDate('<+1M>', ServiceWrokRec."Service Date");
            //                                     //break;
            //                                 end;
            //                             ServiceItem."Service Period"::"2 Months":
            //                                 begin
            //                                     TempDate := CalcDate('<+2M>', ServiceWrokRec."Service Date");
            //                                     //break;
            //                                 end;
            //                             ServiceItem."Service Period"::"3 Months":
            //                                 begin
            //                                     TempDate := CalcDate('<+3M>', ServiceWrokRec."Service Date");
            //                                     //break;
            //                                 end;
            //                         end;
            //                     end
            //                     else
            //                         TempDate := ServiceWrokRec."Next Service Date";

            //                     ServiceItem."Service due date" := TempDate;
            //                     ServiceItem."Last Service Date" := WorkDate();
            //                     ServiceItem.Modify();
            //                 end;

            //                 // //Write to service ledger entry
            //                 // ServiceLdgrRec.Init();
            //                 // ServiceLdgrRec."Service Contract No." := ServiceWrokRec."Doc No";
            //                 // ServiceLdgrRec."Document Type" := ServiceLdgrRec."Document Type"::Invoice;
            //                 // ServiceLdgrRec."Document No." := ServiceWrokRec."Doc No";
            //                 // ServiceLdgrRec."Posting Date" := WorkDate();
            //                 // ServiceLdgrRec.Amount := 0;
            //                 // ServiceLdgrRec
            //                 // ServiceLdgrRec.Insert();


            //                 //Delete entry from worksheet
            //                 ServiceWrokRec.Delete();
            //             until ServiceWrokRec.Next() = 0;

            //             //Post General Journal
            //             GenJrnlRec.Reset();
            //             GenJrnlRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
            //             GenJrnlRec.SetRange("Journal Template Name", NavappRec."Gen Journal Template Name");
            //             GenJrnlRec.SetRange("Journal Batch Name", NavappRec."Gen Journal Batch Name");

            //             if GenJrnlRec.FindSet() then
            //                 GenJnlCodeUnit.Run(GenJrnlRec);

            //             //Post Item Journal
            //             ItemJrnlRec.Reset();
            //             ItemJrnlRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
            //             ItemJrnlRec.SetRange("Journal Template Name", NavappRec."Gen Journal Template Name");
            //             ItemJrnlRec.SetRange("Journal Batch Name", NavappRec."Gen Journal Batch Name");

            //             if ItemJrnlRec.FindSet() then
            //                 ItemJnlCodeUnit.Run(ItemJrnlRec);

            //             //Post Resource Journal
            //             ResJrnlRec.Reset();
            //             ResJrnlRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
            //             ResJrnlRec.SetRange("Journal Template Name", NavappRec."Gen Journal Template Name");
            //             ResJrnlRec.SetRange("Journal Batch Name", NavappRec."Gen Journal Batch Name");

            //             if ResJrnlRec.FindSet() then
            //                 ResJnlCodeUnit.Run(ResJrnlRec);

            //         end;

            //         Message('Posting Completed');
            //     end;
            // }

            // action("Send For Approval")
            // {
            //     ApplicationArea = All;
            //     Image = Email;

            //     trigger OnAction()
            //     var
            //         UserRec: Record "User Setup";
            //         EmailRec: Codeunit Email;
            //         EmailMessRec: Codeunit "Email Message";
            //         Body: Text[500];
            //     //EmailAccRec: Record "Email Account";
            //     begin

            //         // EmailAccRec.Reset();
            //         // EmailAccRec.SetFilter(Connector, '=%1', EmailAccRec.Connector);
            //         // if EmailAccRec.FindSet() then begin

            //         Body := 'Dear User <br><br> There are new pending service item approvals in the system. Please log in to the system and approve them. <br>';
            //         Body := Body + 'This is a system generated email. Please do not reply to this email.';

            //         UserRec.Reset();
            //         UserRec.SetFilter("Service Approval", '=%1', true);
            //         if UserRec.FindSet() then begin
            //             EmailMessRec.Create(UserRec."E-Mail", 'Machine Service Approval', Body, true);
            //             if (EmailRec.Send(EmailMessRec, Enum::"Email Scenario"::"Service Invoice") = true) then
            //                 Message('Email sent to %1', UserRec."E-Mail");
            //         end;
            //         //end;
            //     end;
            // }

            // action("Upload from Excel")
            // {
            //     ApplicationArea = All;
            //     Image = ImportExcel;

            //     trigger OnAction()
            //     var
            //         ExcelUplaod: Codeunit ExcelUplaod;
            //     begin
            //         ExcelUplaod.Run();
            //     end;
            // }
        }
    }

    trigger OnOpenPage()
    var
        ItemRec: Record Item;
        ServiceScheLineRec: Record ServiceScheduleLine;
        ServiceScheHeadRec: Record ServiceScheduleHeader;
    begin
        //Delete old records
        ServiceScheLineRec.Reset();
        ServiceScheLineRec.SetRange("Factory No.", rec."Factory No.");
        if ServiceScheLineRec.FindSet() then
            ServiceScheLineRec.DeleteAll();

        //Get records for the brand/model/category/type
        ServiceScheHeadRec.Reset();
        ServiceScheHeadRec.SetRange(ServiceType, rec.ServiceType);
        ServiceScheHeadRec.SetRange("Factory No.", rec."Factory No.");
        ServiceScheHeadRec.SetRange("Brand Name", rec."Brand Name");
        ServiceScheHeadRec.SetRange("Model Name", rec."Model Name");
        ServiceScheHeadRec.SetRange("Machine Category", rec."Machine Category");

        if ServiceScheHeadRec.FindSet() then begin
            repeat
                ServiceScheLineRec.Init();
                ServiceScheLineRec."Part No" := ServiceScheHeadRec."Part No";
                ServiceScheLineRec."Part Name" := ServiceScheHeadRec."Part Name";
                ServiceScheLineRec."Unit N0." := ServiceScheHeadRec."Unit N0.";
                ServiceScheLineRec.Qty := ServiceScheHeadRec.Qty;
                ServiceScheLineRec."Factory No." := ServiceScheHeadRec."Factory No.";
                ServiceScheLineRec."Factory Name" := ServiceScheHeadRec."Factory Name";
                ServiceScheLineRec.Select := true;
                ServiceScheLineRec.Insert();
            until ServiceScheHeadRec.Next() = 0;
        end;

    end;

}