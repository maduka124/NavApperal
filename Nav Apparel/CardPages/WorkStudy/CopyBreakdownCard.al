page 50471 "Copy Breakdown Card"
{
    PageType = Card;
    Caption = 'Copy Breakdown';
    UsageCategory = Tasks;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(SourceStyle; SourceStyle)
                {
                    ApplicationArea = All;
                    Caption = 'Source Style No';
                    TableRelation = "Style Master"."No.";
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
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
                        end;

                        StyleMasterRec.get(SourceStyle);
                        SourceStyleName := StyleMasterRec."Style No.";
                    end;
                }

                field(SourceStyleName; SourceStyleName)
                {
                    ApplicationArea = All;
                    Caption = 'Source Style';
                    Editable = false;
                }

                field(DestinationStyle; DestinationStyle)
                {
                    ApplicationArea = All;
                    Caption = 'Destination style No';
                    ShowMandatory = true;

                    trigger OnLookup(var texts: text): Boolean
                    var
                        NewBRRec: Record "New Breakdown";
                        StyleMasterRec: Record "Style Master";
                    begin

                        StyleMasterRec.RESET;
                        IF StyleMasterRec.FindSet() THEN BEGIN
                            REPEAT
                                NewBRRec.RESET;
                                NewBRRec.SetRange("Style No.", StyleMasterRec."No.");
                                if not NewBRRec.FindSet() then
                                    StyleMasterRec.MARK(TRUE);
                            UNTIL StyleMasterRec.NEXT = 0;
                            StyleMasterRec.MARKEDONLY(TRUE);

                            if Page.RunModal(51185, StyleMasterRec) = Action::LookupOK then begin
                                DestinationStyleName := StyleMasterRec."Style No.";
                                DestinationStyle := StyleMasterRec."No.";
                            end;

                        END;
                    END;
                }

                field(DestinationStyleName; DestinationStyleName)
                {
                    ApplicationArea = All;
                    Caption = 'Destination style';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Copy)
            {
                ApplicationArea = All;
                Image = CopyFromBOM;

                trigger OnAction()
                var
                    NewBrRec: Record "New Breakdown";
                    NavAppSetup: Record "NavApp Setup";
                    NewBrRec1: Record "New Breakdown";
                    NewBrOpLine1Rec: Record "New Breakdown Op Line1";
                    NewBrOpLine1Rec1: Record "New Breakdown Op Line1";
                    NewBrOpLineRec: Record "New Breakdown Op Line2";
                    NewBrOpLineRec1: Record "New Breakdown Op Line2";
                    NoSeriesManagementCode: Codeunit NoSeriesManagement;
                    StyleRec: Record "Style Master";
                    NextBRNO: Code[20];
                    LineNo: Integer;
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


                    if SourceStyle = '' then begin
                        Error('Source style cannot be empty');
                        exit
                    end;

                    if DestinationStyle = '' then begin
                        Error('Copy to style cannot be empty');
                        exit
                    end;


                    //Validate
                    if SourceStyle = DestinationStyle then
                        Error('Source style and copy to style cannot be same')
                    else begin

                        //Get destination style details
                        StyleRec.Reset();
                        StyleRec.SetRange("No.", DestinationStyle);
                        if StyleRec.FindSet() then begin

                            //Get old breakdown details
                            NewBrRec.Reset();
                            NewBrRec.SetRange("Style No.", SourceStyle);

                            if NewBrRec.FindSet() then begin

                                NewBrRec1.Reset();
                                NewBrRec1.SetRange("Style No.", DestinationStyle);
                                if NewBrRec1.FindSet() then
                                    Error('Destination Style : %1 already assigned for a Breakdown.', DestinationStyleName);

                                NavAppSetup.Get('0001');
                                NextBRNO := NoSeriesManagementCode.GetNextNo(NavAppSetup."NEWBR Nos.", Today(), true);

                                //Insert Header
                                NewBrRec1.Init();
                                NewBrRec1."No." := NextBRNO;
                                NewBrRec1."Style No." := DestinationStyle;
                                NewBrRec1."Style Name" := StyleRec."Style No.";
                                NewBrRec1."Season No." := StyleRec."Season No.";
                                NewBrRec1."Season Name" := StyleRec."Season Name";
                                NewBrRec1."Buyer No." := StyleRec."Buyer No.";
                                NewBrRec1."Buyer Name" := StyleRec."Buyer Name";
                                NewBrRec1."Garment Type No." := StyleRec."Garment Type No.";
                                NewBrRec1."Garment Type Name" := StyleRec."Garment Type Name";
                                NewBrRec1.Description := NewBrRec.Description + ' (Çopied Breakdown)';
                                NewBrRec1."Item Type No." := NewBrRec."Item Type No.";
                                NewBrRec1."Item Type Name" := NewBrRec."Item Type Name";
                                NewBrRec1."Garment Part No." := NewBrRec."Garment Part No.";
                                NewBrRec1."Garment Part Name" := NewBrRec."Garment Part Name";
                                NewBrRec1."Created User" := UserId;
                                NewBrRec1."Style Stage" := NewBrRec."Style Stage";
                                NewBrRec1."Total SMV" := NewBrRec."Total SMV";
                                NewBrRec1.Machine := NewBrRec.Machine;
                                NewBrRec1.Manual := NewBrRec.Manual;
                                NewBrRec1."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                NewBrRec1.Insert();

                                //Insert OP Lines
                                NewBrOpLine1Rec.Reset();
                                NewBrOpLine1Rec.SetRange("NewBRNo.", NewBrRec."No.");

                                if NewBrOpLine1Rec.FindSet() then begin
                                    repeat
                                        NewBrOpLine1Rec1.Init();
                                        NewBrOpLine1Rec1."NewBRNo." := NextBRNO;
                                        NewBrOpLine1Rec1."LineNo." := NewBrOpLine1Rec."LineNo.";
                                        NewBrOpLine1Rec1."Item Type No." := NewBrOpLine1Rec."Item Type No.";
                                        NewBrOpLine1Rec1."Item Type Name" := NewBrOpLine1Rec."Item Type Name";
                                        NewBrOpLine1Rec1."Garment Part No." := NewBrOpLine1Rec."Garment Part No.";
                                        NewBrOpLine1Rec1."Garment Part Name" := NewBrOpLine1Rec."Garment Part Name";
                                        NewBrOpLine1Rec1.Code := NewBrOpLine1Rec.Code;
                                        NewBrOpLine1Rec1.Description := NewBrOpLine1Rec.Description;
                                        NewBrOpLine1Rec1."Machine No." := NewBrOpLine1Rec."Machine No.";
                                        NewBrOpLine1Rec1."Machine Name" := NewBrOpLine1Rec."Machine Name";
                                        NewBrOpLine1Rec1.SMV := NewBrOpLine1Rec.SMV;
                                        NewBrOpLine1Rec1."Target Per Hour" := NewBrOpLine1Rec."Target Per Hour";
                                        NewBrOpLine1Rec1.Grade := NewBrOpLine1Rec.Grade;
                                        NewBrOpLine1Rec1."Department No." := NewBrOpLine1Rec."Department No.";
                                        NewBrOpLine1Rec1."Department Name" := NewBrOpLine1Rec."Department Name";
                                        NewBrOpLine1Rec1."Created User" := UserId;
                                        NewBrOpLine1Rec1."Created Date" := WorkDate();
                                        NewBrOpLine1Rec1.Video := NewBrOpLine1Rec.Video;
                                        NewBrOpLine1Rec1."Upload Video" := NewBrOpLine1Rec."Upload Video";
                                        NewBrOpLine1Rec1."Download Video" := NewBrOpLine1Rec."Download Video";
                                        NewBrOpLine1Rec1."Selected Seq" := 0;
                                        NewBrOpLine1Rec1.Select := false;
                                        NewBrOpLine1Rec1.Insert();
                                    until NewBrOpLine1Rec.Next() = 0
                                end;


                                //Insert BR Lines                        
                                NewBrOpLineRec.Reset();
                                NewBrOpLineRec.SetRange("No.", NewBrRec."No.");

                                if NewBrOpLineRec.FindSet() then begin
                                    repeat
                                        NewBrOpLineRec1.Init();
                                        NewBrOpLineRec1."No." := NextBRNO;
                                        NewBrOpLineRec1."Line No." := NewBrOpLineRec."Line No.";
                                        NewBrOpLineRec1."Item Type No." := NewBrOpLineRec."Item Type No.";
                                        NewBrOpLineRec1."Item Type Name" := NewBrOpLineRec."Item Type Name";
                                        NewBrOpLineRec1."Garment Part No." := NewBrOpLineRec."Garment Part No.";
                                        NewBrOpLineRec1."Garment Part Name" := NewBrOpLineRec."Garment Part Name";
                                        NewBrOpLineRec1.Code := NewBrOpLineRec.Code;
                                        NewBrOpLineRec1.Description := NewBrOpLineRec.Description;
                                        NewBrOpLineRec1."Machine No." := NewBrOpLineRec."Machine No.";
                                        NewBrOpLineRec1."Machine Name" := NewBrOpLineRec."Machine Name";
                                        NewBrOpLineRec1.SMV := NewBrOpLineRec.SMV;
                                        NewBrOpLineRec1."Target Per Hour" := NewBrOpLineRec."Target Per Hour";
                                        NewBrOpLineRec1.Grade := NewBrOpLineRec.Grade;
                                        NewBrOpLineRec1."Department No." := NewBrOpLineRec."Department No.";
                                        NewBrOpLineRec1."Department Name" := NewBrOpLineRec."Department Name";
                                        NewBrOpLineRec1.Barcode := NewBrOpLineRec.Barcode::No;
                                        NewBrOpLineRec1.Attachment := NewBrOpLineRec.Attachment;
                                        NewBrOpLineRec1.LineType := NewBrOpLineRec.LineType;
                                        NewBrOpLineRec1.MachineType := NewBrOpLineRec.MachineType;
                                        NewBrOpLineRec1."Created User" := UserId;
                                        NewBrOpLineRec1."Line Position" := NewBrOpLineRec."Line Position";
                                        NewBrOpLineRec1."Line Position1" := NewBrOpLineRec."Line Position1";
                                        NewBrOpLineRec1."GPart Position" := NewBrOpLineRec."GPart Position";
                                        NewBrOpLineRec1.RefGPartName := NewBrOpLineRec.RefGPartName;
                                        NewBrOpLineRec1.Insert();
                                    until NewBrOpLineRec.Next() = 0
                                end;

                                Message('Completed');

                            end
                            else
                                Error('No breakdown assigned for the style : %1', SourceStyle);

                        end
                        else
                            Error('Invalid Style.');
                    end;
                end;
            }
        }
    }

    var

        SourceStyle: Code[20];
        SourceStyleName: Text[50];
        DestinationStyle: Code[20];
        DestinationStyleName: Text[50];
}