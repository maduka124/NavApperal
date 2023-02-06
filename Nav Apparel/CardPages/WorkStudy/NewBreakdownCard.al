page 50459 "New Breakdown Card"
{
    PageType = Card;
    SourceTable = "New Breakdown";
    Caption = 'New Breakdown';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        NewBRRec: Record "New Breakdown";
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

                        //Check for duplicates
                        NewBRRec.Reset();
                        NewBRRec.SetRange("Style Name", rec."Style Name");
                        if NewBRRec.FindSet() then
                            Error('Style : %1 already used to create a New Breakdown', rec."Style Name");


                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasterRec.FindSet() then begin
                            rec."Style No." := StyleMasterRec."No.";
                            rec."Buyer No." := StyleMasterRec."Buyer No.";
                            rec."Season No." := StyleMasterRec."Season No.";
                            rec."Garment Type No." := StyleMasterRec."Garment Type No.";
                            rec."Buyer Name" := StyleMasterRec."Buyer Name";
                            rec."Season Name" := StyleMasterRec."Season Name";
                            rec."Garment Type Name" := StyleMasterRec."Garment Type Name";
                        end;
                        //Set_Status();
                        rec."Style Stage" := 'COSTING';
                    end;
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Season';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Item Type Name"; rec."Item Type Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Item Type';

                    trigger OnValidate()
                    var
                        ItemRec: Record "Item Type";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange("Item Type Name", rec."Item Type Name");
                        if ItemRec.FindSet() then
                            rec."Item Type No." := ItemRec."No.";
                    end;
                }

                field("Garment Part Name"; rec."Garment Part Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Garment Part';

                    trigger OnValidate()
                    var
                        GarmentPartRec: Record GarmentPart;
                        NewBrOpLine: Record "New Breakdown Op Line1";
                        NewOpLine: Record "New Operation";
                        LineNo: Integer;
                    begin

                        GarmentPartRec.Reset();
                        GarmentPartRec.SetRange("Item Type No.", rec."Item Type No.");
                        GarmentPartRec.SetRange(Description, rec."Garment Part Name");
                        if GarmentPartRec.FindSet() then
                            rec."Garment Part No." := GarmentPartRec."No.";

                        //delete list table
                        NewBrOpLine.Reset();
                        NewBrOpLine.SetRange("NewBRNo.", rec."No.");
                        NewBrOpLine.DeleteAll();

                        NewOpLine.Reset();
                        NewOpLine.SetRange("Item Type No.", rec."Item Type No.");
                        NewOpLine.SetRange("Garment Part No.", GarmentPartRec."No.");
                        NewOpLine.SetCurrentKey(Description);
                        NewOpLine.Ascending(true);

                        if NewOpLine.FindSet() then begin

                            repeat

                                //Get max line no
                                LineNo := 0;
                                NewBrOpLine.Reset();
                                NewBrOpLine.SetRange("NewBRNo.", rec."No.");

                                if NewBrOpLine.FindLast() then
                                    LineNo := NewBrOpLine."LineNo.";

                                NewBrOpLine.Init();
                                NewBrOpLine."NewBRNo." := rec."No.";
                                NewBrOpLine."LineNo." := LineNo + 1;
                                NewBrOpLine."Item Type No." := NewOpLine."Item Type No.";
                                NewBrOpLine."Item Type Name" := NewOpLine."Item Type Name";
                                NewBrOpLine."Garment Part No." := NewOpLine."Garment Part No.";
                                NewBrOpLine."Garment Part Name" := NewOpLine."Garment Part Name";
                                NewBrOpLine.Code := NewOpLine.Code;
                                NewBrOpLine.Description := NewOpLine.Description;
                                NewBrOpLine."Machine No." := NewOpLine."Machine No.";
                                NewBrOpLine."Machine Name" := NewOpLine."Machine Name";
                                NewBrOpLine.SMV := NewOpLine.SMV;
                                NewBrOpLine."Target Per Hour" := NewOpLine."Target Per Hour";
                                NewBrOpLine.Grade := NewOpLine.Grade;
                                NewBrOpLine."Department No." := NewOpLine."Department No.";
                                NewBrOpLine."Department Name" := NewOpLine."Department Name";
                                NewBrOpLine."Created User" := UserId;
                                NewBrOpLine.Insert();

                            until NewOpLine.Next = 0;

                        end;
                    end;

                }

                field("Style Stage"; rec."Style Stage")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Total SMV"; rec."Total SMV")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Machine; rec.Machine)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Machine SMV';
                }

                field(Manual; rec.Manual)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Manual SMV';
                }
            }

            group("New Operations")
            {
                part("New Breakdown Op Listpart1"; "New Breakdown Op Listpart1")
                {
                    ApplicationArea = All;
                    SubPageLink = "NewBRNo." = FIELD("No.");
                    Caption = ' ';
                }
            }

            group("Breakdown")
            {
                part("New Breakdown Op Listpart2"; "New Breakdown Op Listpart2")
                {
                    ApplicationArea = All;
                    SubPageLink = "No." = FIELD("No.");
                    Caption = ' ';
                }
            }
        }

        area(FactBoxes)
        {
            part(NewBreackdownFactBox; NewBreackdownFactBox)
            {
                ApplicationArea = All;
                Caption = ' Picture';
                SubPageLink = "No." = FIELD("Style No.");
                Editable = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Insert Header")
            {
                ApplicationArea = All;
                Image = NewRow;

                trigger OnAction();
                var
                    NewBreakOpLine2Rec: Record "New Breakdown Op Line2";
                    LineNo: Integer;
                    "GPart Position1": Integer;
                begin

                    NewBreakOpLine2Rec.Reset();
                    NewBreakOpLine2Rec.SetRange("No.", rec."No.");
                    NewBreakOpLine2Rec.SetRange(RefGPartName, rec."Garment Part Name");

                    if NewBreakOpLine2Rec.FindSet() then
                        "GPart Position1" := NewBreakOpLine2Rec."GPart Position"
                    else begin
                        NewBreakOpLine2Rec.Reset();
                        NewBreakOpLine2Rec.SetRange("No.", rec."No.");

                        if NewBreakOpLine2Rec.FindLast() then
                            "GPart Position1" := NewBreakOpLine2Rec."GPart Position" + 1
                        else
                            "GPart Position1" := 1;
                    end;



                    NewBreakOpLine2Rec.Reset();
                    NewBreakOpLine2Rec.SetRange("No.", rec."No.");
                    NewBreakOpLine2Rec.SetRange(Description, rec."Garment Part Name");
                    NewBreakOpLine2Rec.SetFilter(LineType, '=%1', 'H');

                    if not NewBreakOpLine2Rec.FindSet() then begin

                        //Get max line no
                        LineNo := 0;
                        NewBreakOpLine2Rec.Reset();
                        NewBreakOpLine2Rec.SetRange("No.", rec."No.");

                        if NewBreakOpLine2Rec.FindLast() then
                            LineNo := NewBreakOpLine2Rec."Line No.";

                        NewBreakOpLine2Rec.Init();
                        NewBreakOpLine2Rec."No." := rec."No.";
                        NewBreakOpLine2Rec."GPart Position" := "GPart Position1";
                        NewBreakOpLine2Rec."Line No." := LineNo + 1;
                        NewBreakOpLine2Rec."Line Position" := LineNo + 1;
                        NewBreakOpLine2Rec.Description := rec."Garment Part Name";
                        NewBreakOpLine2Rec.LineType := 'H';
                        NewBreakOpLine2Rec.RefGPartName := rec."Garment Part Name";
                        NewBreakOpLine2Rec.Barcode := NewBreakOpLine2Rec.Barcode::No;
                        NewBreakOpLine2Rec.Insert();

                    end;

                end;
            }

            action("Copy Breakdown")
            {
                ApplicationArea = All;
                Image = NewRow;

                trigger OnAction();
                var
                    CopyBreakRec: page "Copy Breakdown Card";
                begin

                    Clear(CopyBreakRec);
                    CopyBreakRec.LookupMode(true);
                    //CopyBreakRec.PassParameters("Buyer No.", "Dependency No.");
                    CopyBreakRec.RunModal();
                    //CurrPage.Update();

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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."NEWBR Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnOpenPage()
    var
        StyleRec: Record "Style Master";
        NoSeriesManagementCode: Codeunit NoSeriesManagement;
        StyleMasterRec: Record "Style Master";
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
            LoginSessionsRec.FindSet();
        end;


        if StyleNoGB <> '' then begin
            rec."No." := NoSeriesManagementCode.GetNextNo('NEWBR Nos', WorkDate(), true);

            StyleMasterRec.Reset();
            StyleMasterRec.SetRange("No.", StyleNoGB);

            if StyleMasterRec.FindSet() then begin
                rec."Style No." := StyleNoGB;
                rec."Style Name" := StyleMasterRec."Style No.";
                rec."Buyer No." := StyleMasterRec."Buyer No.";
                rec."Season No." := StyleMasterRec."Season No.";
                rec."Garment Type No." := StyleMasterRec."Garment Type No.";
                rec."Buyer Name" := StyleMasterRec."Buyer Name";
                rec."Season Name" := StyleMasterRec."Season Name";
                rec."Garment Type Name" := StyleMasterRec."Garment Type Name";
                rec."Style Stage" := 'COSTING';
                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
            end;

            CurrPage.Update();

        end;

        //Set_Status();

        // StyleRec.Reset();
        // StyleRec.SetRange("Style No.", "Style No.");
        // if StyleRec.FindSet() then begin

        //     if "Style Stage" = 'COSTING' then
        //         StyleRec.CostingSMV := "Total SMV"
        //     else
        //         if "Style Stage" = 'PRODUCTION' then
        //             StyleRec.ProductionSMV := "Total SMV"
        //         else
        //             if "Style Stage" = 'PLANNING' then
        //                 StyleRec.PlanningSMV := "Total SMV";

        //     StyleRec.Modify();

        // end;
    end;


    procedure Set_Status()
    var
        ProductionOutLineRec: Record ProductionOutLine;
        NavAppPlanningLinesRec: Record "NavApp Prod Plans Details";
    begin
        //Style Stage 
        ProductionOutLineRec.Reset();
        ProductionOutLineRec.SetRange("Style No.", rec."Style No.");

        if ProductionOutLineRec.FindSet() then
            rec."Style Stage" := 'PRODUCTION'
        else begin

            NavAppPlanningLinesRec.Reset();
            NavAppPlanningLinesRec.SetRange("Style No.", rec."Style No.");

            if NavAppPlanningLinesRec.FindSet() then
                rec."Style Stage" := 'PLANNING'
            else
                rec."Style Stage" := 'COSTING';
        end;

        CurrPage.Update();
    end;


    procedure PassParameters(StyleNoPara: code[20]);
    var
    begin
        StyleNoGB := StyleNoPara;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        NewBrOpLine1Rec: Record "New Breakdown Op Line1";
        NewBrOpLine2Rec: Record "New Breakdown Op Line2";
    begin
        NewBrOpLine1Rec.Reset();
        NewBrOpLine1Rec.SetRange("NewBRNo.", rec."No.");
        NewBrOpLine1Rec.DeleteAll();

        NewBrOpLine2Rec.Reset();
        NewBrOpLine2Rec.SetRange("No.", rec."No.");
        NewBrOpLine2Rec.DeleteAll();
    end;

    var
        StyleNoGB: Text[100];
}