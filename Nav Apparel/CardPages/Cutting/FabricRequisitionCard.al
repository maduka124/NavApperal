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
                field("FabReqNo."; "FabReqNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Requisition No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        UserRec: Record "User Setup";
                        LocationRec: Record Location;
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then
                            "Style No." := StyleMasterRec."No.";

                        //Get location

                        UserRec.Reset();
                        UserRec.SetRange("User ID", UserId);

                        if UserRec.FindSet() then begin
                            "Location Code" := UserRec."Factory Code";

                            LocationRec.Reset();
                            LocationRec.SetRange(Code, UserRec."Factory Code");
                            if LocationRec.FindSet() then
                                "Location Name" := LocationRec.Name;
                        end;

                        CurrPage.Update();
                    end;
                }

                field("Colour Name"; "Colour Name")
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
                        AssoDetailsRec.SetRange("Style No.", "Style No.");

                        IF AssoDetailsRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF Colour <> AssoDetailsRec."Colour No" THEN BEGIN
                                    Colour := AssoDetailsRec."Colour No";

                                    AssoDetailsRec.MARK(TRUE);
                                END;
                            UNTIL AssoDetailsRec.NEXT = 0;
                            AssoDetailsRec.MARKEDONLY(TRUE);

                            if Page.RunModal(71012677, AssoDetailsRec) = Action::LookupOK then begin
                                "Colour No" := AssoDetailsRec."Colour No";
                                colorRec.Reset();
                                colorRec.SetRange("No.", "Colour No");
                                colorRec.FindSet();
                                "Colour Name" := colorRec."Colour Name";
                            end;

                        END;
                    END;
                }

                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        SewJobLine4Rec: Record SewingJobCreationLine4;
                    begin
                        SewJobLine4Rec.Reset();
                        SewJobLine4Rec.SetRange("Style No.", "Style No.");
                        SewJobLine4Rec.SetRange("Colour No", "Colour No");
                        SewJobLine4Rec.SetRange("Group ID", "Group ID");
                        if SewJobLine4Rec.FindSet() then
                            "Po No." := SewJobLine4Rec."PO No."
                        else
                            Error('Cannot find sewing Job details for Style/Color/Group');

                        CurrPage.Update();
                    end;
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Component Group Code"; "Component Group Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Component Group';

                    trigger OnValidate()
                    var
                    begin
                        "Component Group Name" := "Component Group Code";
                        CurrPage.Update();
                    end;
                }

                field("Marker Name"; "Marker Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Marker';

                    trigger OnValidate()
                    var
                        RatioCreaLineRec: Record RatioCreationLine;
                    begin
                        RatioCreaLineRec.Reset();
                        RatioCreaLineRec.SetRange("Group ID", "Group ID");
                        RatioCreaLineRec.SetRange("Component Group Code", "Component Group Code");
                        RatioCreaLineRec.SetRange("Marker Name", "Marker Name");
                        RatioCreaLineRec.SetRange("Style No.", "Style No.");

                        if RatioCreaLineRec.FindSet() then begin

                            if RatioCreaLineRec."UOM Code" = 'YDS' then begin
                                "Marker Width" := RatioCreaLineRec.Width + ((RatioCreaLineRec."Width Tollarance" * 2) / 36);
                                "Required Length" := (RatioCreaLineRec.Length + ((RatioCreaLineRec."Length Tollarance  " * 2) / 36)) * RatioCreaLineRec.Plies;
                            end
                            else
                                if RatioCreaLineRec."UOM Code" = 'MTS' then begin
                                    begin
                                        "Marker Width" := RatioCreaLineRec.Width + ((RatioCreaLineRec."Width Tollarance" * 2) / 100);
                                        "Required Length" := (RatioCreaLineRec.Length + ((RatioCreaLineRec."Length Tollarance  " * 2) / 100)) * RatioCreaLineRec.Plies;
                                    end;
                                end;

                            "UOM Code" := RatioCreaLineRec."UOM Code";
                            "UOM" := RatioCreaLineRec."UOM";
                        end
                        else begin
                            "Marker Width" := 0;
                            "Required Length" := 0;
                            "UOM Code" := '';
                            "UOM" := '';
                        end;
                    end;
                }

                field("Cut No"; "Cut No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Marker Width"; "Marker Width")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Table Name"; "Table Name")
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
                        TableMasterRec.SetRange("Table Name", "Table Name");

                        if TableMasterRec.FindSet() then begin
                            "Table No." := TableMasterRec."Table No.";

                            TableCreaLineRec.Reset();
                            TableCreaLineRec.SetRange("Style No.", "Style No.");
                            TableCreaLineRec.SetRange("Group ID", "Group ID");
                            TableCreaLineRec.SetRange("Component Group", "Component Group Code");
                            TableCreaLineRec.SetRange("Marker Name", "Marker Name");
                            TableCreaLineRec.SetRange("Cut No", "Cut No");

                            if TableCreaLineRec.FindSet() then begin

                                FabricReqLineRec.Reset();
                                FabricReqLineRec.SetRange("FabReqNo.", "FabReqNo.");
                                FabricReqLineRec.DeleteAll();

                                repeat

                                    LineNo += 1;
                                    FabricReqLineRec.Init();
                                    FabricReqLineRec."FabReqNo." := "FabReqNo.";
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

                field("Required Length"; "Required Length")
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."FabReqNo Nos.", xRec."FabReqNo.", "FabReqNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("FabReqNo.");
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        FabricRequLine: Record FabricRequsitionLine;
        LaySheetRec: Record LaySheetHeader;
        RoleIssueRec: Record RoleIssuingNoteHeader;
    begin

        //Check in the laysheet
        LaySheetRec.Reset();
        LaySheetRec.SetRange("FabReqNo.", "FabReqNo.");

        if LaySheetRec.FindSet() then begin
            Message('Cannot delete. Fabric Requsition No already used in the Laysheet No : %1', LaySheetRec."LaySheetNo.");
            exit(false);
        end;


        //Check in the Role Issuing
        RoleIssueRec.Reset();
        RoleIssueRec.SetRange("Req No.", "FabReqNo.");

        if RoleIssueRec.FindSet() then begin
            Message('Cannot delete. Fabric Requsition No already used in the Role Issuing No : %1', RoleIssueRec."RoleIssuNo.");
            exit(false);
        end;


        FabricRequLine.Reset();
        FabricRequLine.SetRange("FabReqNo.", "FabReqNo.");
        if FabricRequLine.FindSet() then
            FabricRequLine.DeleteAll();
    end;
}