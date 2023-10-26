page 51446 WashSequenceSMVCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = WashSequenceSMVHeader;
    Caption = 'Washing Sequence';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Caption = 'No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        UserRec: Record "User Setup";
                        LocationRec: Record Location;
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

                        UserRec.get(UserId);
                        Rec."Factory code" := UserRec."Factory Code";

                        LocationRec.Reset();
                        LocationRec.SetRange(Code, Rec."Factory code");

                        if LocationRec.FindSet() then
                            Rec."Factory Name" := LocationRec.Name;

                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, Rec."Buyer Name");

                        if CustomerRec.FindSet() then
                            Rec."Buyer No." := CustomerRec."No.";

                    end;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StylemasterRec: Record "Style Master";
                    begin

                        StylemasterRec.Reset();
                        StylemasterRec.SetRange("Style No.", Rec."Style Name");

                        if StylemasterRec.FindSet() then
                            Rec."Style No." := StylemasterRec."No.";
                    end;
                }

                field("Lot No"; Rec."Lot No")
                {
                    ApplicationArea = All;
                    Caption = 'Lot';

                    trigger OnValidate()
                    var
                        StyleMsterRec: Record "Style Master PO";

                    begin
                        StyleMsterRec.Reset();
                        StyleMsterRec.SetRange("Style No.", Rec."Style No.");
                        StyleMsterRec.SetRange("Lot No.", Rec."Lot No");

                        if StyleMsterRec.FindSet() then
                            Rec."PO No" := StyleMsterRec."PO No.";
                    end;
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO';
                    Editable = False;
                }

                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';

                    trigger OnValidate()
                    var
                        ColorRec: Record Colour;
                        WashingProcesRec: Record WashingProcessing;
                        WashiSeqSMVLineRec: Record WashSequenceSMVLine;
                        ProcessCode: Code[20];
                        LineNo: Integer;
                        TotSMV: Decimal;
                    begin

                        TotSMV := 0;

                        ColorRec.Reset();
                        ColorRec.SetRange("Colour Name", Rec."Color Name");

                        if ColorRec.FindSet() then
                            Rec."Color Code" := ColorRec."No.";

                        WashiSeqSMVLineRec.Reset();
                        WashiSeqSMVLineRec.SetRange(No, Rec.No);

                        if WashiSeqSMVLineRec.FindSet() then
                            WashiSeqSMVLineRec.DeleteAll(true);

                        WashingProcesRec.Reset();
                        if WashingProcesRec.FindSet() then begin
                            repeat

                                LineNo += 1;
                                WashiSeqSMVLineRec.Init();
                                WashiSeqSMVLineRec.No := Rec.No;
                                WashiSeqSMVLineRec."Line No" := LineNo;
                                WashiSeqSMVLineRec."Record Type" := 'R';
                                WashiSeqSMVLineRec."Processing Code" := WashingProcesRec."Processing Code";
                                WashiSeqSMVLineRec."Processing Name" := WashingProcesRec."Processing Name";
                                WashiSeqSMVLineRec.Seq := WashingProcesRec.Seq;
                                WashiSeqSMVLineRec.SMV := WashingProcesRec.SMV;
                                WashiSeqSMVLineRec.Insert();

                                TotSMV += WashingProcesRec.SMV;

                            until WashingProcesRec.Next() = 0;

                            WashiSeqSMVLineRec.Init();
                            WashiSeqSMVLineRec.No := Rec.No;
                            WashiSeqSMVLineRec."Line No" := 9999;
                            WashiSeqSMVLineRec."Record Type" := 'T';
                            WashiSeqSMVLineRec."Processing Name" := 'TOTAL';
                            WashiSeqSMVLineRec.Seq := WashingProcesRec.Seq;
                            WashiSeqSMVLineRec.SMV := TotSMV;
                            WashiSeqSMVLineRec.Insert();
                        end;
                    end;
                }

            }

            group("Process")
            {
                part(WashSequenceSMVLine; WashSequenceSMVLine)
                {
                    ApplicationArea = All;
                    SubPageLink = No = field(No);
                    Caption = '  ';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Image = Allocate;

                trigger OnAction()
                var
                    WashingMasterRec: Record WashingMaster;
                    WashSmvlineRec: Record WashSequenceSMVLine;
                begin

                    if Rec.Posting = false then begin

                        WashingMasterRec.Reset();
                        WashingMasterRec.SetRange("Style No", Rec."Style No.");
                        WashingMasterRec.SetRange(Lot, Rec."Lot No");
                        WashingMasterRec.SetRange("PO No", Rec."PO No");
                        WashingMasterRec.SetRange("Color Name", Rec."Color Name");

                        if WashingMasterRec.FindSet() then begin

                            WashSmvlineRec.Reset();
                            WashSmvlineRec.SetRange(No, Rec.No);

                            if WashSmvlineRec.FindSet() then begin
                                repeat

                                    if WashSmvlineRec."Processing Code" = 'WHISKERS' then begin
                                        WashingMasterRec."SMV WHISKERS" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                    if WashSmvlineRec."Processing Code" = 'ACID/ RANDOM WASH' then begin
                                        WashingMasterRec."SMV ACID/ RANDOM WASH" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                    if WashSmvlineRec."Processing Code" = 'BASE WASH' then begin
                                        WashingMasterRec."SMV BASE WASH" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                    if WashSmvlineRec."Processing Code" = 'BRUSH' then begin
                                        WashingMasterRec."SMV BRUSH" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                    if WashSmvlineRec."Processing Code" = 'DESTROY' then begin
                                        WashingMasterRec."SMV DESTROY" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                    if WashSmvlineRec."Processing Code" = 'FINAL WASH' then begin
                                        WashingMasterRec."SMV FINAL WASH" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                    if WashSmvlineRec."Processing Code" = 'LASER BRUSH' then begin
                                        WashingMasterRec."SMV LASER BRUSH" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                    if WashSmvlineRec."Processing Code" = 'LASER DESTROY' then begin
                                        WashingMasterRec."SMV LASER DESTROY" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                    if WashSmvlineRec."Processing Code" = 'LASER WHISKERS' then begin
                                        WashingMasterRec."SMV LASER WHISKERS" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                    if WashSmvlineRec."Processing Code" = 'PP SPRAY' then begin
                                        WashingMasterRec."SMV PP SPRAY" := WashSmvlineRec.SMV;
                                        WashingMasterRec."SMV Updated" := true;
                                        WashingMasterRec.Modify(true);
                                    end;

                                until WashSmvlineRec.Next() = 0;

                                Rec.Posting := true;
                                Rec."Posting Date" := WorkDate();
                                Rec.WashMasterNoTemp := WashingMasterRec."Line No";
                                Rec.Modify(true);

                                Message('SMV Updated');

                            end;
                        end
                        else
                            Error('Record not in allocated list');
                    end
                    else
                        Error('Record already post');
                end;
            }

            action("Style Copy And Post ")
            {
                ApplicationArea = All;
                Image = Copy;


                trigger OnAction()
                var
                    NavAppSetupRec: Record "NavApp Setup";
                    WashingMaterRec: Record WashingMaster;
                    WashingMater2Rec: Record WashingMaster;
                    WashingProcesRec: Record WashingProcessing;
                    WashiSeqSMVLineRec: Record WashSequenceSMVLine;
                    WashiSeqSMVLine2Rec: Record WashSequenceSMVLine;
                    WashSeqSmvHdrRec: Record WashSequenceSMVHeader;
                    NoSeriesManagementCode: Codeunit NoSeriesManagement;
                    No: Code[20];
                    LineNo: Integer;
                begin
                    LineNo := 0;

                    if Rec.Posting = true then begin

                        WashingMaterRec.Reset();
                        WashingMaterRec.SetRange("Style No", Rec."Style No.");
                        WashingMaterRec.SetCurrentKey("Line No");
                        WashingMaterRec.Ascending(true);

                        if WashingMaterRec.FindSet() then begin

                            NavAppSetupRec.Reset();
                            NavAppSetupRec.FindSet();

                            repeat

                                if WashingMaterRec."Line No" <> Rec.WashMasterNoTemp then begin

                                    if WashingMaterRec."SMV Updated" = false then begin

                                        No := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Wash Sequence SMV Nos.", Today(), true);


                                        ////Header insert
                                        WashSeqSmvHdrRec.Init();
                                        WashSeqSmvHdrRec.No := No;
                                        WashSeqSmvHdrRec."Buyer No." := WashingMaterRec."Buyer Code";
                                        WashSeqSmvHdrRec."Buyer Name" := WashingMaterRec."Buyer Name";
                                        WashSeqSmvHdrRec."Style No." := WashingMaterRec."Style No";
                                        WashSeqSmvHdrRec."Style Name" := WashingMaterRec."Style Name";
                                        WashSeqSmvHdrRec."Lot No" := WashingMaterRec.Lot;
                                        WashSeqSmvHdrRec."PO No" := WashingMaterRec."PO No";
                                        WashSeqSmvHdrRec."Color Code" := WashingMaterRec."Color Code";
                                        WashSeqSmvHdrRec."Color Name" := WashingMaterRec."Color Name";
                                        WashSeqSmvHdrRec.Posting := true;
                                        WashSeqSmvHdrRec."Posting Date" := WorkDate();
                                        WashSeqSmvHdrRec."Secondary UserID" := Rec."Secondary UserID";
                                        WashSeqSmvHdrRec."Factory code" := Rec."Factory code";
                                        WashSeqSmvHdrRec."Factory Name" := Rec."Factory Name";
                                        WashSeqSmvHdrRec."Color Name" := WashingMaterRec."Color Name";
                                        WashSeqSmvHdrRec.WashMasterNoTemp := WashingMaterRec."Line No";
                                        WashSeqSmvHdrRec.Insert();

                                        WashiSeqSMVLineRec.Reset();
                                        WashiSeqSMVLineRec.SetRange(No, Rec.No);

                                        if WashiSeqSMVLineRec.FindSet() then begin
                                            repeat

                                                ///////Line Insert
                                                LineNo += 1;
                                                WashiSeqSMVLine2Rec.Init();
                                                WashiSeqSMVLine2Rec.No := No;
                                                WashiSeqSMVLine2Rec."Line No" := LineNo;
                                                WashiSeqSMVLine2Rec."Processing Code" := WashiSeqSMVLineRec."Processing Code";
                                                WashiSeqSMVLine2Rec."Processing Name" := WashiSeqSMVLineRec."Processing Name";
                                                WashiSeqSMVLine2Rec.Seq := WashiSeqSMVLineRec.Seq;
                                                WashiSeqSMVLine2Rec.SMV := WashiSeqSMVLineRec.SMV;
                                                WashiSeqSMVLine2Rec.Insert();

                                                WashingMater2Rec.SetRange("Line No", WashingMaterRec."Line No");

                                                if WashingMater2Rec.FindSet() then begin

                                                    ////Washing Master File Update

                                                    if WashiSeqSMVLineRec."Processing Code" = 'WHISKERS' then begin
                                                        WashingMater2Rec."SMV WHISKERS" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                    if WashiSeqSMVLineRec."Processing Code" = 'ACID/ RANDOM WASH' then begin
                                                        WashingMater2Rec."SMV ACID/ RANDOM WASH" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                    if WashiSeqSMVLineRec."Processing Code" = 'BASE WASH' then begin
                                                        WashingMater2Rec."SMV BASE WASH" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                    if WashiSeqSMVLineRec."Processing Code" = 'BRUSH' then begin
                                                        WashingMater2Rec."SMV BRUSH" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                    if WashiSeqSMVLineRec."Processing Code" = 'DESTROY' then begin
                                                        WashingMater2Rec."SMV DESTROY" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                    if WashiSeqSMVLineRec."Processing Code" = 'FINAL WASH' then begin
                                                        WashingMater2Rec."SMV FINAL WASH" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                    if WashiSeqSMVLineRec."Processing Code" = 'LASER BRUSH' then begin
                                                        WashingMater2Rec."SMV LASER BRUSH" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                    if WashiSeqSMVLineRec."Processing Code" = 'LASER DESTROY' then begin
                                                        WashingMater2Rec."SMV LASER DESTROY" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                    if WashiSeqSMVLineRec."Processing Code" = 'LASER WHISKERS' then begin
                                                        WashingMater2Rec."SMV LASER WHISKERS" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                    if WashiSeqSMVLineRec."Processing Code" = 'PP SPRAY' then begin
                                                        WashingMater2Rec."SMV PP SPRAY" := WashiSeqSMVLineRec.SMV;
                                                        WashingMater2Rec."SMV Updated" := true;
                                                        WashingMater2Rec.Modify(true);
                                                    end;

                                                end;

                                            until WashiSeqSMVLineRec.Next() = 0;
                                        end;
                                    end;
                                end;
                            until WashingMaterRec.Next() = 0;
                            Message('SMV updated');
                        end;
                    end
                    else
                        Error('Current record must be posted');
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Wash Sequence SMV Nos.", xRec.No, rec.No) THEN BEGIN
            NoSeriesMngment.SetSeries(rec.No);
            EXIT(TRUE);
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        WashSeqSmvLineRec: Record WashSequenceSMVLine;
    begin

        WashSeqSmvLineRec.Reset();
        WashSeqSmvLineRec.SetRange(No, Rec.No);

        if WashSeqSmvLineRec.FindSet() then
            WashSeqSmvLineRec.DeleteAll(true);
    end;

}