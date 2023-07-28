page 51371 StyleChangeCard
{
    PageType = Card;
    Caption = 'Style Change Card';
    SourceTable = StyleChangeHeader;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Factory No"; rec."Factory No")
                {
                    ApplicationArea = All;
                    TableRelation = Location.Code where("Sewing Unit" = filter(true));
                    Caption = 'Factory';

                    trigger OnValidate()
                    var
                        StyleChangeLineRec: Record StyleChangeLine;
                    begin
                        StyleChangeLineRec.Reset();
                        if StyleChangeLineRec.FindSet() then
                            StyleChangeLineRec.DeleteAll();
                    end;
                }

                field(StartDate; StartDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }

                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
            }

            group("Line/Style Details")
            {
                part(StyleChangeListPart; StyleChangeListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Factory No" = field("Factory No");
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(Filter)
            {
                ApplicationArea = All;
                Image = Filter;
                Caption = 'Filter';

                trigger OnAction()
                var
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                    NavappProdDetRec: Record "NavApp Prod Plans Details";
                    StyleChangeRec: Record StyleChangeLine;
                    SeqNo1: BigInteger;
                    SeqNo: BigInteger;
                    LineNo: code[20];
                    Style: code[20];
                    Count: BigInteger;
                    Total: BigInteger;
                begin
                    if rec."Factory No" = '' then
                        Error('Factory is blank.');

                    if StartDate = 0D then
                        Error('Start Date is blank.');

                    if EndDate = 0D then
                        Error('End Date is blank.');

                    if StartDate > EndDate then
                        Error('End Date should be greater than Start Date');

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

                    Total := 0;
                    //Delete old records for the factory
                    StyleChangeRec.Reset();
                    StyleChangeRec.SetRange("Factory No", rec."Factory No");
                    if StyleChangeRec.Findset() then
                        StyleChangeRec.DeleteAll();

                    //Get Max Lineno
                    StyleChangeRec.Reset();
                    if StyleChangeRec.FindLast() then
                        SeqNo := StyleChangeRec.SeqNo;

                    NavappProdDetRec.Reset();
                    NavappProdDetRec.SetRange("Factory No.", rec."Factory No");
                    NavappProdDetRec.SetFilter(PlanDate, '%1..%2', StartDate, EndDate);
                    NavappProdDetRec.SetCurrentKey("Resource No.", "Style Name");
                    NavappProdDetRec.Ascending(true);
                    if NavappProdDetRec.Findset() then begin
                        repeat
                            if NavappProdDetRec."Resource No." <> LineNo then begin
                                SeqNo += 1;
                                StyleChangeRec.Init();
                                StyleChangeRec.SeqNo := SeqNo;
                                StyleChangeRec."Resource No." := NavappProdDetRec."Resource No.";
                                StyleChangeRec."Factory No" := NavappProdDetRec."Factory No.";
                                StyleChangeRec.Qty := 1;
                                //StyleChangeRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                StyleChangeRec.Insert();

                                //reset the count
                                Count := 1;
                            end
                            else begin
                                if NavappProdDetRec."Style No." <> Style then     //Increment if style change
                                    Count += 1;

                                StyleChangeRec.Reset();
                                StyleChangeRec.SetRange("Resource No.", NavappProdDetRec."Resource No.");
                                //StyleChangeRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                                if StyleChangeRec.Findset() then
                                    StyleChangeRec.ModifyAll(Qty, Count);
                            end;

                            LineNo := NavappProdDetRec."Resource No.";
                            Style := NavappProdDetRec."Style No.";

                        until NavappProdDetRec.Next() = 0;

                        StyleChangeRec.Reset();
                        StyleChangeRec.SetRange("Factory No", rec."Factory No");
                        if StyleChangeRec.FindSet() then begin
                            StyleChangeRec.CalcSums(Qty);
                            Total := StyleChangeRec.Qty;
                        end;

                        StyleChangeRec.Reset();
                        if StyleChangeRec.FindLast() then
                            SeqNo1 := StyleChangeRec.SeqNo;

                        SeqNo1 += 1;
                        StyleChangeRec.Init();
                        StyleChangeRec.SeqNo := SeqNo1;
                        StyleChangeRec."Resource No." := 'TOTAL';
                        // StyleChangeRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        StyleChangeRec.Qty := Total;
                        StyleChangeRec.Insert();
                    end;

                    Message('Completed');
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        BOMEstimateCostRec: Record "BOM Estimate Cost";
        StyleMasterRec: Record "Style Master";
        StyleChangeLineRec: Record StyleChangeLine;
    begin
        StyleChangeLineRec.Reset();
        if StyleChangeLineRec.FindSet() then
            StyleChangeLineRec.DeleteAll();

        if not rec.get() then begin
            rec.INIT();
            rec.INSERT();
        end;

        StartDate := WorkDate();
        EndDate := WorkDate();
    end;


    var
        StartDate: Date;
        EndDate: Date;
}