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

                        // CurrPage.Update();
                        if CheckDuplicate() then
                            Error('Entry duplicates with same Factory/Service Type/Model/Brand/Machine Type');

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

                    trigger OnValidate()
                    var
                        BrandRec: Record Brand;
                    begin
                        if CheckDuplicate() then
                            Error('Entry duplicates with same Factory/Service Type/Model/Brand/Machine Type');

                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", rec."Brand Name");
                        if BrandRec.FindSet() then
                            rec."Brand No" := BrandRec."No.";
                    end;
                }

                field("Model Name"; rec."Model Name")
                {
                    ApplicationArea = All;
                    Caption = 'Model';

                    trigger OnValidate()
                    var
                        ModelRec: Record Model;
                    begin
                        if CheckDuplicate() then
                            Error('Entry duplicates with same Factory/Service Type/Model/Brand/Machine Type');

                        ModelRec.Reset();
                        ModelRec.SetRange("Model Name", rec."Model Name");
                        if ModelRec.FindSet() then
                            rec."Model No" := ModelRec."No.";
                    end;
                }

                field("Machine Category"; rec."Machine Category")
                {
                    ApplicationArea = All;
                    Caption = 'Type of Machine';

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                        ServiceScheLineRec: Record ServiceScheduleLineNew;
                        ServiceItemRec: Record "Service Item";
                        Seq: Integer;
                    begin
                        //Delete old records
                        // ServiceScheLineRec.Reset();
                        // ServiceScheLineRec.SetRange("Factory No.", rec."Factory No.");
                        // if ServiceScheLineRec.FindSet() then
                        //     ServiceScheLineRec.DeleteAll();

                        if CheckDuplicate() then
                            Error('Entry duplicates with same Factory/Service Type/Model/Brand/Machine Type');

                        Seq := 0;
                        ServiceScheLineRec.Reset();
                        ServiceScheLineRec.SetRange("No.", rec."No.");
                        if ServiceScheLineRec.FindSet() then
                            ServiceScheLineRec.DeleteAll();

                        //Get part nos for the brand/model/category
                        ItemRec.Reset();
                        ItemRec.SetRange(Article, rec."Brand Name");
                        ItemRec.SetRange("Color Name", rec."Model Name");
                        ItemRec.SetRange("Size Range No.", rec."Machine Category");
                        if ItemRec.FindSet() then begin
                            repeat
                                Seq += 1;
                                ServiceScheLineRec.Init();
                                ServiceScheLineRec."LineNo." := Seq;
                                ServiceScheLineRec."No." := rec."No.";
                                ServiceScheLineRec."Factory No." := rec."Factory No.";
                                ServiceScheLineRec."Factory Name" := rec."Factory Name";
                                ServiceScheLineRec."Part No" := ItemRec.Remarks;
                                ServiceScheLineRec."Part Name" := ItemRec.Description;
                                ServiceScheLineRec."Unit N0." := ItemRec."Base Unit of Measure";
                                ServiceScheLineRec.Qty := 1;
                                ServiceScheLineRec.Insert();
                            until ItemRec.Next() = 0;
                        end;

                        //Get Machine cat code
                        ServiceItemRec.Reset();
                        ServiceItemRec.SetRange(Description, rec."Machine Category");
                        if ServiceItemRec.FindSet() then
                            rec."Machine Category Code" := ServiceItemRec."No.";
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
                    SubPageLink = "No." = field("No.");
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
                    //Check whether user logged in or not
                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());
                    if not LoginSessionsRec.FindSet() then begin  //not logged in
                        Clear(LoginRec);
                        LoginRec.LookupMode(true);
                        LoginRec.RunModal();

                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());
                        LoginSessionsRec.FindSet();
                    end;

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
                            ServiceScheHeadRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                            ServiceScheHeadRec."Unit N0." := ServiceScheLineRec."Unit N0.";
                            ServiceScheHeadRec.Insert();
                        until ServiceScheLineRec.Next() = 0;
                    end;
                    Message('Completed');
                end;
            }
        }
    }

    // trigger OnOpenPage()
    // var
    //     ItemRec: Record Item;
    //     ServiceScheLineRec: Record ServiceScheduleLine;
    //     ServiceScheHeadRec: Record ServiceScheduleHeader;
    // begin
    //     //Delete old records
    //     ServiceScheLineRec.Reset();
    //     ServiceScheLineRec.SetRange("Factory No.", rec."Factory No.");
    //     if ServiceScheLineRec.FindSet() then
    //         ServiceScheLineRec.DeleteAll();

    //     //Get records for the brand/model/category/type
    //     ServiceScheHeadRec.Reset();
    //     ServiceScheHeadRec.SetRange(ServiceType, rec.ServiceType);
    //     ServiceScheHeadRec.SetRange("Factory No.", rec."Factory No.");
    //     ServiceScheHeadRec.SetRange("Brand Name", rec."Brand Name");
    //     ServiceScheHeadRec.SetRange("Model Name", rec."Model Name");
    //     ServiceScheHeadRec.SetRange("Machine Category", rec."Machine Category");

    //     if ServiceScheHeadRec.FindSet() then begin
    //         repeat
    //             ServiceScheLineRec.Init();
    //             ServiceScheLineRec."Part No" := ServiceScheHeadRec."Part No";
    //             ServiceScheLineRec."Part Name" := ServiceScheHeadRec."Part Name";
    //             ServiceScheLineRec."Unit N0." := ServiceScheHeadRec."Unit N0.";
    //             ServiceScheLineRec.Qty := ServiceScheHeadRec.Qty;
    //             ServiceScheLineRec."Factory No." := ServiceScheHeadRec."Factory No.";
    //             ServiceScheLineRec."Factory Name" := ServiceScheHeadRec."Factory Name";
    //             ServiceScheLineRec.Select := true;
    //             ServiceScheLineRec.Insert();
    //         until ServiceScheHeadRec.Next() = 0;
    //     end;

    // end;


    procedure CheckDuplicate(): Boolean
    var
        Exists: Boolean;
        ServiScheduleHeadRec: Record ServiceScheduleHeader;
    begin
        Exists := false;
        if (rec."Brand Name" <> '') and (rec."Model Name" <> '') and (format(rec.ServiceType) <> '')
        and (rec."Machine Category" <> '') and (rec."Factory Name" <> '') then begin
            ServiScheduleHeadRec.Reset();
            ServiScheduleHeadRec.SetRange("Brand Name", rec."Brand Name");
            ServiScheduleHeadRec.SetRange("model Name", rec."model Name");
            ServiScheduleHeadRec.SetRange("ServiceType", rec.ServiceType);
            ServiScheduleHeadRec.SetRange("Machine Category", rec."Machine Category");
            ServiScheduleHeadRec.SetRange("Factory Name", rec."Factory Name");
            ServiScheduleHeadRec.SetFilter("No.", '<>%1', rec."No.");
            if ServiScheduleHeadRec.FindSet() then
                Exists := true;
        end;

        exit(Exists);
    end;


    trigger OnDeleteRecord(): Boolean
    var
        ServiceScheLineRec: Record ServiceScheduleLineNew;
    begin
        //Delete old records
        ServiceScheLineRec.Reset();
        ServiceScheLineRec.SetRange("No.", rec."No.");
        if ServiceScheLineRec.FindSet() then
            ServiceScheLineRec.DeleteAll();
    end;
}