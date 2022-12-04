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
                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", Rec."Style Name");
                        if StyleMasterRec.FindSet() then
                            Rec."Style No." := StyleMasterRec."No.";

                    end;
                }

                field("Colour Name"; Rec."Colour Name")
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
                        AssoDetailsRec.SetRange("Style No.", Rec."Style No.");

                        IF AssoDetailsRec.FINDFIRST THEN BEGIN
                            REPEAT
                                IF Colour <> AssoDetailsRec."Colour No" THEN BEGIN
                                    Colour := AssoDetailsRec."Colour No";

                                    AssoDetailsRec.MARK(TRUE);
                                END;
                            UNTIL AssoDetailsRec.NEXT = 0;
                            AssoDetailsRec.MARKEDONLY(TRUE);

                            if Page.RunModal(71012677, AssoDetailsRec) = Action::LookupOK then begin
                                Rec."Colour No" := AssoDetailsRec."Colour No";
                                colorRec.Reset();
                                colorRec.SetRange("No.", Rec."Colour No");
                                colorRec.FindSet();
                                Rec."Colour Name" := colorRec."Colour Name";
                            end;

                        END;
                    END;

                }

                field("Group ID"; Rec."Group ID")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SewJobLine4Rec: Record SewingJobCreationLine4;
                    begin
                        SewJobLine4Rec.Reset();
                        SewJobLine4Rec.SetRange("Style No.", Rec."Style No.");
                        SewJobLine4Rec.SetRange("Colour No", Rec."Colour No");
                        SewJobLine4Rec.SetRange("Group ID", Rec."Group ID");
                        if SewJobLine4Rec.FindSet() then
                            Rec."Po No." := SewJobLine4Rec."PO No."
                        else
                            Error('Cannot find sewing Job details for Style/Color/Group');

                        CurrPage.Update();
                    end;
                }

                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Component Group"; Rec."Component Group")
                {
                    ApplicationArea = All;
                }

                field("Marker Name"; Rec."Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Cut No"; Rec."Cut No")
                {
                    ApplicationArea = All;
                }

                field("Layering Start Date/Time"; Rec."Layering Start Date/Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LayStartTime: DateTime;
                        LayEndTime: DateTime;
                    begin

                        if format(Rec."Layering Start Date/Time") = '' then
                            Error('Enter " Layering Start  Date/Time"');

                        if format(Rec."Layering End Date/Time") <> '' then begin

                            LayStartTime := Rec."Layering Start Date/Time";
                            LayEndTime := Rec."Layering End Date/Time";

                            if LayStartTime > LayEndTime then
                                Error('Invalid time');

                        end;

                    end;
                }

                field("Layering End Date/Time"; Rec."Layering End Date/Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LayStartTime: DateTime;
                        LayEndTime: DateTime;
                    begin

                        if format(Rec."Layering Start Date/Time") = '' then
                            Error('Enter "Layering Start Date/Time"');

                        if format(Rec."Layering End Date/Time") = '' then
                            Error('Enter "Layering End Date/Time"');

                        LayStartTime := Rec."Layering Start Date/Time";
                        LayEndTime := Rec."Layering End Date/Time";

                        if LayStartTime > LayEndTime then
                            Error('Invalid time');

                    end;
                }

                field("Cut Start Date/Time"; Rec."Cut Start Date/Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CutStartTime: DateTime;
                        CutEndTime: DateTime;
                    begin

                        if format(Rec."Cut Start Date/Time") = '' then
                            Error('Enter "Cut Start Date/Time"');

                        if format(Rec."Cut End Date/Time") <> '' then begin

                            CutStartTime := Rec."Cut Start Date/Time";
                            CutEndTime := Rec."Cut End Date/Time";

                            if CutStartTime > CutEndTime then
                                Error('Invalid time');

                        end;

                    end;
                }

                field("Cut End Date/Time"; Rec."Cut End Date/Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        CutStartTime: DateTime;
                        CutEndTime: DateTime;
                    begin

                        if format(Rec."Cut Start Date/Time") = '' then
                            Error('Enter "Plan Cut Start Time"');

                        if format(Rec."Cut End Date/Time") = '' then
                            Error('Enter "Cut End Date/Time"');

                        CutStartTime := Rec."Cut Start Date/Time";
                        CutEndTime := Rec."Cut End Date/Time";

                        if CutStartTime > CutEndTime then
                            Error('Invalid time');

                    end;
                }
            }
        }
    }
}