page 51371 StyleChangeCard
{
    PageType = Card;
    Caption = 'Style Change Card';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Factory; Factory)
                {
                    ApplicationArea = All;
                    TableRelation = Location.Code where("Sewing Unit" = filter(true));
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
                    SeqNo: BigInteger;
                    LineNo: code[20];
                    Style: code[20];
                    Count: BigInteger;
                begin
                    if Factory = '' then
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

                    //Delete old records for the user
                    StyleChangeRec.Reset();
                    StyleChangeRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                    if StyleChangeRec.Findset() then
                        StyleChangeRec.DeleteAll();

                    //Get Max Lineno
                    StyleChangeRec.Reset();
                    if StyleChangeRec.FindLast() then
                        SeqNo := StyleChangeRec.SeqNo;

                    NavappProdDetRec.Reset();
                    NavappProdDetRec.SetRange("Factory No.", Factory);
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
                                StyleChangeRec.Qty := 1;
                                StyleChangeRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                StyleChangeRec.Insert();

                                //reset the count
                                Count := 1;
                            end
                            else begin
                                if NavappProdDetRec."Style No." <> Style then     //Increment if style change
                                    Count += 1;

                                StyleChangeRec.Reset();
                                StyleChangeRec.SetRange("Resource No.", NavappProdDetRec."Resource No.");
                                StyleChangeRec.SetRange("Secondary UserID", LoginSessionsRec."Secondary UserID");
                                if StyleChangeRec.Findset() then
                                    StyleChangeRec.ModifyAll(Qty, Count);
                            end;

                            LineNo := NavappProdDetRec."Resource No.";
                            Style := NavappProdDetRec."Style No.";

                        until NavappProdDetRec.Next() = 0;
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
    begin
        StartDate := WorkDate();
        EndDate := WorkDate();
    end;

    var
        Factory: Code[20];
        StartDate: Date;
        EndDate: Date;
}