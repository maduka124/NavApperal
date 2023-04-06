page 50622 "Fabric Requisition Card"
{
    PageType = Card;
    SourceTable = FabricRequsition;
    Caption = 'Fabric Requisition';

    layout
    {
        area(Content)
        {
            group(General)
            {

                Editable = EditableGB;

                field("FabReqNo."; rec."FabReqNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Requisition No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        UserRec: Record "User Setup";
                        LocationRec: Record Location;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasterRec.FindSet() then
                            rec."Style No." := StyleMasterRec."No.";

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


                        //Get location
                        UserRec.Reset();
                        UserRec.SetRange("User ID", UserId);

                        if UserRec.FindSet() then begin
                            rec."Location Code" := UserRec."Factory Code";

                            LocationRec.Reset();
                            LocationRec.SetRange(Code, UserRec."Factory Code");
                            if LocationRec.FindSet() then
                                rec."Location Name" := LocationRec.Name;
                        end;
                        CurrPage.Update();
                    end;
                }

                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Colour';

                    trigger OnLookup(var texts: text): Boolean
                    var
                        AssoDetailsRec: Record AssortmentDetails;
                        Colour: Code[20];
                        colorRec: Record Colour;
                    begin
                        AssoDetailsRec.RESET;
                        AssoDetailsRec.SetCurrentKey("Colour No");
                        AssoDetailsRec.SetRange("Style No.", rec."Style No.");

                        IF AssoDetailsRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF Colour <> AssoDetailsRec."Colour No" THEN BEGIN
                                    Colour := AssoDetailsRec."Colour No";

                                    AssoDetailsRec.MARK(TRUE);
                                END;
                            UNTIL AssoDetailsRec.NEXT = 0;
                            AssoDetailsRec.MARKEDONLY(TRUE);

                            if Page.RunModal(51014, AssoDetailsRec) = Action::LookupOK then begin
                                rec."Colour No" := AssoDetailsRec."Colour No";
                                colorRec.Reset();
                                colorRec.SetRange("No.", rec."Colour No");
                                colorRec.FindSet();
                                rec."Colour Name" := colorRec."Colour Name";
                            end;

                        END;
                    END;
                }

                field("Group ID"; rec."Group ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        SewJobLine4Rec: Record SewingJobCreationLine4;
                    begin
                        SewJobLine4Rec.Reset();
                        SewJobLine4Rec.SetRange("Style No.", rec."Style No.");
                        SewJobLine4Rec.SetRange("Colour No", rec."Colour No");
                        SewJobLine4Rec.SetRange("Group ID", rec."Group ID");
                        if SewJobLine4Rec.FindSet() then
                            rec."Po No." := SewJobLine4Rec."PO No."
                        else
                            Error('Cannot find sewing Job details for Style/Color/Group');

                        CurrPage.Update();
                    end;
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Component Group Code"; rec."Component Group Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Component Group';

                    trigger OnValidate()
                    var
                    begin
                        rec."Component Group Name" := rec."Component Group Code";
                        CurrPage.Update();
                    end;
                }

                field("Marker Name"; rec."Marker Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Marker';

                    trigger OnValidate()
                    var
                        RatioCreaLineRec: Record RatioCreationLine;
                    begin
                        RatioCreaLineRec.Reset();
                        RatioCreaLineRec.SetRange("Group ID", rec."Group ID");
                        RatioCreaLineRec.SetRange("Component Group Code", rec."Component Group Code");
                        RatioCreaLineRec.SetRange("Marker Name", rec."Marker Name");
                        RatioCreaLineRec.SetRange("Style No.", rec."Style No.");

                        if RatioCreaLineRec.FindSet() then begin

                            if RatioCreaLineRec."UOM Code" = 'YDS' then begin
                                rec."Marker Width" := RatioCreaLineRec.Width + ((RatioCreaLineRec."Width Tollarance" * 2) / 36);
                                rec."Required Length" := (RatioCreaLineRec.Length + ((RatioCreaLineRec."Length Tollarance  " * 2) / 36)) * RatioCreaLineRec.Plies;
                            end
                            else
                                if RatioCreaLineRec."UOM Code" = 'MTS' then begin
                                    begin
                                        rec."Marker Width" := RatioCreaLineRec.Width + ((RatioCreaLineRec."Width Tollarance" * 2) / 100);
                                        rec."Required Length" := (RatioCreaLineRec.Length + ((RatioCreaLineRec."Length Tollarance  " * 2) / 100)) * RatioCreaLineRec.Plies;
                                    end;
                                end;

                            rec."UOM Code" := RatioCreaLineRec."UOM Code";
                            rec."UOM" := RatioCreaLineRec."UOM";
                        end
                        else begin
                            rec."Marker Width" := 0;
                            rec."Required Length" := 0;
                            rec."UOM Code" := '';
                            rec."UOM" := '';
                        end;
                    end;
                }

                field("Cut No"; rec."Cut No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        FabRequRec: Record FabricRequsition;
                    begin
                        FabRequRec.Reset();
                        FabRequRec.SetRange("Style No.", rec."Style No.");
                        FabRequRec.SetRange("Colour No", rec."Colour No");
                        FabRequRec.SetRange("Group ID", rec."Group ID");
                        FabRequRec.SetRange("PO No.", rec."PO No.");
                        FabRequRec.SetRange("Component Group Code", rec."Component Group Code");
                        FabRequRec.SetRange("Marker Name", rec."Marker Name");
                        FabRequRec.SetRange("Cut No", rec."Cut No");
                        FabRequRec.SetFilter("FabReqNo.", '<>%1', rec."FabReqNo.");

                        if FabRequRec.FindSet() then
                            Error('You have already created Fabric Requisition for this Cut No');

                    end;
                }

                field("Marker Width"; rec."Marker Width")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(UOM; rec.UOM)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Table Name"; rec."Table Name")
                {
                    ApplicationArea = All;
                    Caption = 'Table No';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        TableMasterRec: Record TableMaster;
                        FabricReqLineRec: Record FabricRequsitionLine;
                        TableCreaLineRec: Record TableCreartionLine;
                        LineNo: Integer;
                    begin

                        TableMasterRec.Reset();
                        TableMasterRec.SetRange("Table Name", rec."Table Name");

                        if TableMasterRec.FindSet() then begin
                            rec."Table No." := TableMasterRec."Table No.";

                            TableCreaLineRec.Reset();
                            TableCreaLineRec.SetRange("Style No.", rec."Style No.");
                            TableCreaLineRec.SetRange("Group ID", rec."Group ID");
                            TableCreaLineRec.SetRange("Component Group", rec."Component Group Code");
                            TableCreaLineRec.SetRange("Marker Name", rec."Marker Name");
                            TableCreaLineRec.SetRange("Cut No", rec."Cut No");

                            if TableCreaLineRec.FindSet() then begin

                                FabricReqLineRec.Reset();
                                FabricReqLineRec.SetRange("FabReqNo.", rec."FabReqNo.");
                                FabricReqLineRec.DeleteAll();

                                repeat

                                    LineNo += 1;
                                    FabricReqLineRec.Init();
                                    FabricReqLineRec."FabReqNo." := rec."FabReqNo.";
                                    FabricReqLineRec."Created Date" := Today;
                                    FabricReqLineRec."Created User" := UserId;
                                    FabricReqLineRec."Line No" := LineNo;
                                    FabricReqLineRec."Layering Start Date/Time" := TableCreaLineRec."Layering Start Date/Time";
                                    FabricReqLineRec."Cut Start Date/Time" := TableCreaLineRec."Cut Start Date/Time";
                                    FabricReqLineRec.Insert();

                                until TableCreaLineRec.Next() = 0;

                            end;

                        end;

                        CurrPage.Update();

                    end;
                }

                field("Required Length"; rec."Required Length")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Planned Date/Time")
            {
                part(FabricRequisitionLineListPart; FabricRequisitionLineListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "FabReqNo." = FIELD("FabReqNo.");
                }
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."FabReqNo Nos.", xRec."FabReqNo.", rec."FabReqNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."FabReqNo.");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        FabricRequLine: Record FabricRequsitionLine;
        LaySheetRec: Record LaySheetHeader;
        RoleIssueRec: Record RoleIssuingNoteHeader;
        UserRec: Record "User Setup";
    begin

        //Done By sachith on 03/04/23
        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Location Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');

        //Check in the laysheet
        LaySheetRec.Reset();
        LaySheetRec.SetRange("FabReqNo.", rec."FabReqNo.");

        if LaySheetRec.FindSet() then begin
            Message('Cannot delete. Fabric Requsition No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
            exit(false);
        end;


        //Check in the Role Issuing
        RoleIssueRec.Reset();
        RoleIssueRec.SetRange("Req No.", rec."FabReqNo.");

        if RoleIssueRec.FindSet() then begin
            Message('Cannot delete. Fabric Requsition No already used in the Role Issuing No : %1', RoleIssueRec."RoleIssuNo.");
            exit(false);
        end;


        FabricRequLine.Reset();
        FabricRequLine.SetRange("FabReqNo.", rec."FabReqNo.");
        if FabricRequLine.FindSet() then
            FabricRequLine.DeleteAll();
    end;

    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin

        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Location Code" <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" = rec."Location Code") then
                    EditableGB := true
                else
                    EditableGB := false;
            end
            else
                EditableGB := false;
        end
        else
            if (UserRec."Factory Code" = '') then begin
                Error('Factory not assigned for the user.');
                EditableGB := false;
            end
            else
                EditableGB := true;
    end;

    var
        EditableGB: Boolean;
}