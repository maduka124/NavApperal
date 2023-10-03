page 50682 RTCAWCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = RTCAWHeader;
    Caption = 'Return To Customer (After Wash)';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Lot; Lot)
                {
                    ApplicationArea = all;
                    Caption = 'Return Full Lot';

                    trigger OnValidate()
                    var
                    begin

                        if lot = true then begin
                            J := true;
                        end
                        else begin
                            J := false;
                        end;

                        CurrPage.Update();
                    end;
                }

                field("JoB Card No"; rec."JoB Card No")
                {
                    ApplicationArea = All;
                    Editable = Not J;

                    trigger OnValidate()
                    var
                        jobcreaationRec: Record JobCreationLine;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
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
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;


                        jobcreaationRec.Reset();
                        jobcreaationRec.SetRange("Job Card (Prod Order)", rec."JoB Card No");

                        if jobcreaationRec.FindSet() then begin
                            rec.CustomerCode := jobcreaationRec.BuyerCode;
                            rec.CustomerName := jobcreaationRec.BuyerName;
                            rec."Req Date" := jobcreaationRec."Req Date";
                            rec."Line No" := jobcreaationRec."Line No";
                            rec."Slipt No" := jobcreaationRec."Split No";
                            rec."Req No" := jobcreaationRec.No;
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Req No"; rec."Req No")
                {
                    ApplicationArea = all;
                    Editable = J;

                    trigger OnValidate()
                    var
                        jobcreaationRec: Record JobCreationLine;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
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
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;


                        jobcreaationRec.Reset();
                        jobcreaationRec.SetRange(No, rec."Req No");

                        if jobcreaationRec.FindSet() then begin
                            rec.CustomerCode := jobcreaationRec.BuyerCode;
                            rec.CustomerName := jobcreaationRec.BuyerName;
                            rec."Req Date" := jobcreaationRec."Req Date";
                            rec."Line No" := jobcreaationRec."Line No";
                            //"Slipt No" := jobcreaationRec."Split No";
                            //"Req No" := jobcreaationRec.No;

                            //Delete existing items in the list part and Insert All Job card FG Items



                            CurrPage.Update();
                        end;
                    end;
                }

                field(CustomerName; rec.CustomerName)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Customer';
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Gate Pass No"; rec."Gate Pass No")
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    Caption = 'Status';
                    ApplicationArea = all;
                    Enabled = false;
                }
            }

            group(" ")
            {
                part("RTCAWListPart1"; RTCAWListPart)
                {
                    Visible = Not j;
                    ApplicationArea = All;
                    Caption = 'Return Details';
                    SubPageLink = "No." = field("No."), "Req No" = field("Req No"), "Header Line No" = field("Line No"), "Split No" = field("Slipt No");
                }
            }

            group("  ")
            {
                part("RTCAWListPart2"; RTCAWListPart)
                {
                    Visible = j;
                    ApplicationArea = All;
                    Caption = 'Return Details';
                    SubPageLink = "No." = field("No."), "Req No" = field("Req No"), "Header Line No" = field("Line No");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Mark as Return")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    interMediRec: Record IntermediateTable;
                    sampleReqline: Record "Washing Sample Requsition Line";
                    RTCAWLineRec: Record RTCAWLine;
                    RTCAWHeaderRec: Record RTCAWHeader;
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    SampleReqHeader: Record "Washing Sample Header";
                    users: Record "User Setup";
                    EntryNo: Integer;
                    lacation: Code[20];
                begin

                    if rec."Req No" = '' then
                        Error('Invalid request No');

                    RTCAWHeaderRec.Reset();
                    RTCAWHeaderRec.SetRange("No.", rec."No.");
                    RTCAWHeaderRec.SetRange("Line No", rec."Line No");
                    RTCAWHeaderRec.SetFilter(Status, '=%1', RTCAWHeaderRec."Status"::Pending);

                    if RTCAWHeaderRec.FindSet() then begin

                        if Lot = false then begin  //Return only a Job Card

                            RTCAWLineRec.Reset();
                            RTCAWLineRec.SetRange("No.", rec."No.");
                            RTCAWLineRec.SetRange("Header Line No", rec."Line No");

                            if RTCAWLineRec.FindSet() then begin
                                repeat
                                    interMediRec.Reset();
                                    interMediRec.SetRange(No, rec."Req No");
                                    interMediRec.SetRange("Line No", RTCAWLineRec."Header Line No");
                                    interMediRec.SetRange("Split No", RTCAWLineRec."Split No");

                                    if interMediRec.FindSet() then begin

                                        if interMediRec."Split Qty" < (interMediRec."Return Qty (AW)" + RTCAWLineRec.Qty) then
                                            Error('Return Qty is greater than the Job Card Qty.');

                                        interMediRec."Return Qty (AW)" += RTCAWLineRec.Qty;
                                        interMediRec.Modify();

                                        sampleReqline.Reset();
                                        sampleReqline.SetRange("No.", rec."Req No");
                                        sampleReqline.SetRange("Line no.", rec."Line No");

                                        if sampleReqline.FindSet() then begin
                                            sampleReqline."Return Qty (AW)" += RTCAWLineRec.Qty;
                                            sampleReqline.Modify();
                                        end;

                                        // Get Entry No
                                        ItemLedgerEntry.Reset();
                                        if ItemLedgerEntry.FindLast() then
                                            EntryNo := ItemLedgerEntry."Entry No.";

                                        SampleReqHeader.Reset();
                                        SampleReqHeader.SetRange("No.", rec."Req No");
                                        if SampleReqHeader.FindSet() then
                                            lacation := SampleReqHeader."Wash Plant No.";


                                        // create ledger entry  
                                        ItemLedgerEntry.Init();
                                        ItemLedgerEntry."Posting Date" := WorkDate();
                                        ItemLedgerEntry."Entry Type" := ItemLedgerEntry."Entry Type"::Transfer;
                                        ItemLedgerEntry."Document Type" := ItemLedgerEntry."Document Type"::"Direct Transfer";
                                        ItemLedgerEntry."Document Date" := rec."Req Date";
                                        ItemLedgerEntry."Document No." := rec."No.";
                                        ItemLedgerEntry."Entry No." := EntryNo + 1;
                                        ItemLedgerEntry."Location Code" := lacation;
                                        ItemLedgerEntry.Validate("Item No.", interMediRec."FG No");
                                        ItemLedgerEntry."Unit of Measure Code" := 'PCS';
                                        ItemLedgerEntry.Validate(Quantity, RTCAWLineRec.Qty * (-1));
                                        ItemLedgerEntry.Insert();

                                    end
                                    else
                                        Error('Cannot find split entries.');

                                until RTCAWLineRec.Next() = 0;
                                Message('Return qty updated');

                                RTCAWHeaderRec.Status := RTCAWHeaderRec.Status::Posted;
                                RTCAWHeaderRec.Modify();

                            end
                            else
                                Error('Cannot find Pass/Fail entries.');
                        end
                        else begin  //Return Full Lot
                        end;
                    end
                    else
                        Error('Already marke as returned.');
                end;
            }
        }
    }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."RTC AW No", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        RTCAWLineRec: Record RTCAWLine;
    begin

        if rec.status = rec.Status::Posted then
            Error('Entry already posted. Cannot delete.');

        RTCAWLineRec.Reset();
        RTCAWLineRec.SetRange("No.", rec."No.");
        if RTCAWLineRec.FindSet() then
            if rec.status = rec.Status::Posted then
                Error('Entry already posted. Cannot delete.');
        RTCAWLineRec.DeleteAll();

    end;

    trigger OnOpenPage()
    var
    begin
        if rec.Status = rec.Status::Posted then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;


    trigger OnInit()
    var
    begin
        j := false;
    end;


    var
        Lot: Boolean;
        J: Boolean;

}
