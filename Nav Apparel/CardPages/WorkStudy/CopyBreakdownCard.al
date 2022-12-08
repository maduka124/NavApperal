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
                    TableRelation = "Style Master"."No.";
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                    begin
                        StyleMasterRec.get(DestinationStyle);
                        DestinationStyleName := StyleMasterRec."Style No.";
                    end;
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
                        StyleRec.FindSet();

                        //Get old breakdown details
                        NewBrRec.Reset();
                        NewBrRec.SetRange("Style No.", SourceStyle);

                        if NewBrRec.FindSet() then begin

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


                            //Insert Lines                        
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
                                    NewBrOpLineRec1.Insert();
                                until NewBrOpLineRec.Next() = 0
                            end;

                            Message('Completed');

                        end
                        else
                            Error('No breakdown assigned for the style : %1', SourceStyle);
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