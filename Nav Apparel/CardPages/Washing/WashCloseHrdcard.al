page 51458 WashCloseCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = WashCloseHrd;
    Caption = 'Wash Close';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = EditableGB;
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;

                }

                // field("Close Date";Rec."Close Date")
                // {
                //     ApplicationArea = All;

                //     trigger OnValidate()
                //     var
                //         UserRec: Record "User Setup";
                //         LocationRec: Record Location;
                //     begin

                //         if Rec."Production Date" < WorkDate() then
                //             Error('Invalid production date');

                //         UserRec.Reset();
                //         UserRec.Get(UserId);

                //         if Rec."Washing Plant Code" = '' then begin

                //             if UserRec."Factory Code" <> '' then begin

                //                 Rec."Washing Plant Code" := UserRec."Factory Code";

                //                 LocationRec.Reset();
                //                 LocationRec.SetRange(Code, UserRec."Factory Code");

                //                 if LocationRec.FindSet() then
                //                     Rec."Washing Plant" := LocationRec.Name;
                //             end;

                //         end;

                //     end;
                // }

                // field("Washing Plant"; Rec."Washing Plant")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

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

                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, Rec."Buyer Name");

                        if CustomerRec.FindSet() then
                            Rec."Buyer Code" := CustomerRec."No.";

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
                        WashCloseLineRec: Record WashCloseLine;
                    begin

                        WashCloseLineRec.Reset();
                        WashCloseLineRec.SetRange(No, Rec.No);

                        if WashCloseLineRec.FindSet() then
                            WashCloseLineRec.DeleteAll(true);

                        WashCloseLineRec.Init();
                        WashCloseLineRec.No := Rec.No;
                        WashCloseLineRec."Line No" := 1;
                        WashCloseLineRec."Style No" := Rec."Style No.";
                        WashCloseLineRec."Style Name" := Rec."Style Name";
                        WashCloseLineRec."PO No" := Rec."PO No";
                        WashCloseLineRec.Lot := Rec."Lot No";
                        WashCloseLineRec."Color Code" := Rec."Color Code";
                        WashCloseLineRec."Color Name" := Rec."Color Name";
                        WashCloseLineRec.Insert();


                    end;
                }
            }

            group(Line)
            {
                part(WashCloseLine; WashCloseLine)
                {
                    Editable = EditableGB;
                    ApplicationArea = All;
                    SubPageLink = No = field(No);
                    Caption = '  ';
                }
            }

        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        WashCloseLineRec: Record WashCloseLine;
        WashinMasterRec: Record WashingMaster;
    begin

        WashCloseLineRec.Reset();
        WashCloseLineRec.SetRange(No, rec.No);

        if WashCloseLineRec.FindSet() then begin

            WashinMasterRec.Reset();
            WashinMasterRec.SetRange("Style No", WashCloseLineRec."Style No");
            WashinMasterRec.SetRange("PO No", WashCloseLineRec."PO No");
            WashinMasterRec.SetRange(Lot, WashCloseLineRec.Lot);
            WashinMasterRec.SetRange("Color Name", WashCloseLineRec."Color Name");

            if WashinMasterRec.FindSet() then begin
                Message('');
            end;
        end;

    end;

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Wash Colse Nos.", xRec."No", rec."No") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No");
            EXIT(TRUE);
        END;
    end;


    trigger OnOpenPage()
    var
        WashingCloseLineRec: Record WashCloseLine;
    begin

        if Rec.No <> '' then begin
            WashingCloseLineRec.Reset();
            WashingCloseLineRec.SetRange(No, Rec.No);

            if WashingCloseLineRec.FindFirst() then begin
                if WashingCloseLineRec."Closing Status" = WashingCloseLineRec."Closing Status"::Closed then
                    EditableGB := false
                else
                    EditableGB := true;
            end;
        end
        else
            EditableGB := true;



    end;


    var
        EditableGB: Boolean;
}