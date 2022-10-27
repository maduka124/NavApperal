page 50617 "Table Creation Line ListPart"
{
    PageType = ListPart;
    SourceTable = TableCreartionLine;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then
                            "Style No." := StyleMasterRec."No.";

                    end;
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
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

                field("Component Group"; "Component Group")
                {
                    ApplicationArea = All;
                }

                field("Marker Name"; "Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Cut No"; "Cut No")
                {
                    ApplicationArea = All;
                }

                field("Layering Start Date/Time"; "Layering Start Date/Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LayStartTime: DateTime;
                        LayEndTime: DateTime;
                    begin

                        if format("Layering Start Date/Time") = '' then
                            Error('Enter " Layering Start  Date/Time"');

                        if format("Layering End Date/Time") <> '' then begin

                            LayStartTime := "Layering Start Date/Time";
                            LayEndTime := "Layering End Date/Time";

                            if LayStartTime > LayEndTime then
                                Error('Invalid time');

                        end;

                    end;
                }

                field("Layering End Date/Time"; "Layering End Date/Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LayStartTime: DateTime;
                        LayEndTime: DateTime;
                    begin

                        if format("Layering Start Date/Time") = '' then
                            Error('Enter "Layering Start Date/Time"');

                        if format("Layering End Date/Time") = '' then
                            Error('Enter "Layering End Date/Time"');

                        LayStartTime := "Layering Start Date/Time";
                        LayEndTime := "Layering End Date/Time";

                        if LayStartTime > LayEndTime then
                            Error('Invalid time');

                    end;
                }

                field("Cut Start Date/Time"; "Cut Start Date/Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CutStartTime: DateTime;
                        CutEndTime: DateTime;
                    begin

                        if format("Cut Start Date/Time") = '' then
                            Error('Enter "Cut Start Date/Time"');

                        if format("Cut End Date/Time") <> '' then begin

                            CutStartTime := "Cut Start Date/Time";
                            CutEndTime := "Cut End Date/Time";

                            if CutStartTime > CutEndTime then
                                Error('Invalid time');

                        end;

                    end;
                }

                field("Cut End Date/Time"; "Cut End Date/Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CutStartTime: DateTime;
                        CutEndTime: DateTime;
                    begin

                        if format("Cut Start Date/Time") = '' then
                            Error('Enter "Plan Cut Start Time"');

                        if format("Cut End Date/Time") = '' then
                            Error('Enter "Cut End Date/Time"');

                        CutStartTime := "Cut Start Date/Time";
                        CutEndTime := "Cut End Date/Time";

                        if CutStartTime > CutEndTime then
                            Error('Invalid time');

                    end;
                }
            }
        }
    }
}