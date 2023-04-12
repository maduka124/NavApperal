page 50464 "New Breakdown Op Listpart1"
{
    PageType = ListPart;
    SourceTable = "New Breakdown Op Line1";
    ShowFilter = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Select; rec.Select)
                {
                    ApplicationArea = All;

                    //Done By Sachith
                    trigger OnValidate()
                    var
                        NewBreackDwnOP1Rec: Record "New Breakdown Op Line1";
                        Max: Integer;
                    begin

                        CurrPage.Update();

                        NewBreackDwnOP1Rec.Reset();
                        NewBreackDwnOP1Rec.SetRange("NewBRNo.", Rec."NewBRNo.");
                        NewBreackDwnOP1Rec.SetCurrentKey("Selected Seq");
                        NewBreackDwnOP1Rec.Ascending(true);

                        if NewBreackDwnOP1Rec.FindLast() then
                            Max := NewBreackDwnOP1Rec."Selected Seq";

                        if Rec.Select = true then
                            Rec."Selected Seq" := Max + 1;

                        if Rec.Select = false then
                            Rec."Selected Seq" := 0;

                        CurrPage.Update();

                    end;
                }

                // field("Order of Selection"; rec."Selected Seq")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Target Per Hour"; rec."Target Per Hour")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Machine Name"; rec."Machine Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Machine';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Department';
                }

                field(Grade; rec.Grade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Video; rec.Video)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Upload Video"; rec."Upload Video")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;

                    trigger OnAssistEdit()
                    var
                    begin
                        UploadFile();
                    end;
                }

                field("Download Video"; rec."Download Video")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                    Caption = 'Download/View Video';

                    trigger OnAssistEdit()
                    var
                    begin
                        DownloadFile();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Insert Line")
            {
                ApplicationArea = All;
                Image = Line;

                trigger OnAction();
                var
                    NewBreakOpLine1Rec: Record "New Breakdown Op Line1";
                    Listpart2: page "New Breakdown Op Listpart2";
                    NewBreakOpLine2Rec: Record "New Breakdown Op Line2";
                    MachineRec: Record "Machine Master";
                    NewBrRec: Record "New Breakdown";
                    LineNo: Integer;
                    Code1: Code[20];
                    Count1: Integer;
                    "GPart Position1": Integer;
                begin

                    CurrPage.Update();
                    NewBreakOpLine1Rec.Reset();
                    NewBreakOpLine1Rec.SetRange("NewBRNo.", rec."NewBRNo.");
                    NewBreakOpLine1Rec.SetCurrentKey("Selected Seq");
                    NewBreakOpLine1Rec.Ascending(true);

                    if NewBreakOpLine1Rec.FindSet() then begin

                        NewBrRec.Reset();
                        NewBrRec.SetRange("No.", NewBreakOpLine1Rec."NewBRNo.");
                        NewBrRec.FindSet();

                        repeat

                            if NewBreakOpLine1Rec.Select = true then begin

                                NewBreakOpLine2Rec.Reset();
                                NewBreakOpLine2Rec.SetRange("No.", NewBreakOpLine1Rec."NewBRNo.");
                                NewBreakOpLine2Rec.SetRange(RefGPartName, NewBreakOpLine1Rec."Garment Part Name");

                                if NewBreakOpLine2Rec.FindSet() then
                                    "GPart Position1" := NewBreakOpLine2Rec."GPart Position"
                                else
                                    Error('Please insert Header.');

                                NewBreakOpLine2Rec.Reset();
                                NewBreakOpLine2Rec.SetRange("No.", NewBreakOpLine1Rec."NewBRNo.");
                                NewBreakOpLine2Rec.SetRange(Code, NewBreakOpLine1Rec.Code);

                                if not NewBreakOpLine2Rec.FindSet() then begin

                                    //Get Machine Type
                                    MachineRec.Reset();
                                    MachineRec.SetRange("Machine No.", NewBreakOpLine1Rec."Machine No.");
                                    MachineRec.FindSet();

                                    //Get max line no
                                    LineNo := 0;
                                    NewBreakOpLine2Rec.Reset();
                                    NewBreakOpLine2Rec.SetRange("No.", NewBreakOpLine1Rec."NewBRNo.");

                                    if NewBreakOpLine2Rec.FindLast() then
                                        LineNo := NewBreakOpLine2Rec."Line No.";

                                    NewBreakOpLine2Rec.Init();
                                    NewBreakOpLine2Rec."No." := NewBreakOpLine1Rec."NewBRNo.";
                                    NewBreakOpLine2Rec."Line No." := LineNo + 1000;
                                    NewBreakOpLine2Rec."Line Position" := LineNo + 1;
                                    NewBreakOpLine2Rec."GPart Position" := "GPart Position1";
                                    NewBreakOpLine2Rec."Item Type No." := NewBreakOpLine1Rec."Item Type No.";
                                    NewBreakOpLine2Rec."Item Type Name" := NewBreakOpLine1Rec."Item Type Name";
                                    NewBreakOpLine2Rec."Garment Part No." := NewBreakOpLine1Rec."Garment Part No.";
                                    NewBreakOpLine2Rec."Garment Part Name" := NewBreakOpLine1Rec."Garment Part Name";
                                    NewBreakOpLine2Rec.Code := NewBreakOpLine1Rec.Code;
                                    NewBreakOpLine2Rec.Description := NewBreakOpLine1Rec.Description;
                                    NewBreakOpLine2Rec."Machine No." := NewBreakOpLine1Rec."Machine No.";
                                    NewBreakOpLine2Rec."Machine Name" := NewBreakOpLine1Rec."Machine Name";
                                    NewBreakOpLine2Rec.SMV := NewBreakOpLine1Rec.SMV;
                                    NewBreakOpLine2Rec."Target Per Hour" := NewBreakOpLine1Rec."Target Per Hour";
                                    NewBreakOpLine2Rec.Grade := NewBreakOpLine1Rec.Grade;
                                    NewBreakOpLine2Rec."Department No." := NewBreakOpLine1Rec."Department No.";
                                    NewBreakOpLine2Rec."Department Name" := NewBreakOpLine1Rec."Department Name";
                                    NewBreakOpLine2Rec.Barcode := NewBreakOpLine2Rec.Barcode::No;
                                    NewBreakOpLine2Rec.LineType := 'L';
                                    NewBreakOpLine2Rec.MachineType := format(MachineRec."Machine Type");
                                    NewBreakOpLine2Rec."Created User" := UserId;
                                    NewBreakOpLine2Rec.RefGPartName := NewBrRec."Garment Part Name";
                                    NewBreakOpLine2Rec.Insert();

                                end;
                                NewBreakOpLine1Rec.Select := false;
                                NewBreakOpLine1Rec."Selected Seq" := 0;
                                NewBreakOpLine1Rec.Modify();
                                CurrPage.Update();
                            end;

                        until NewBreakOpLine1Rec.Next = 0;



                        //Copy seq to a nother field
                        NewBreakOpLine2Rec.Reset();
                        NewBreakOpLine2Rec.SetRange("No.", rec."NewBRNo.");
                        if NewBreakOpLine2Rec.FindSet() then begin
                            repeat
                                NewBreakOpLine2Rec."Line Position1" := NewBreakOpLine2Rec."Line Position";
                                NewBreakOpLine2Rec.Modify();
                            until NewBreakOpLine2Rec.Next() = 0;
                        end;

                        //Rearrange
                        Count1 := 0;
                        NewBreakOpLine2Rec.Reset();
                        NewBreakOpLine2Rec.SetCurrentKey("GPart Position", "Line Position1");
                        NewBreakOpLine2Rec.Ascending(true);
                        NewBreakOpLine2Rec.SetRange("No.", rec."NewBRNo.");
                        if NewBreakOpLine2Rec.FindSet() then begin
                            repeat
                                Count1 += 1;
                                NewBreakOpLine2Rec."Line Position" := Count1;
                                NewBreakOpLine2Rec.Modify();
                            until NewBreakOpLine2Rec.Next() = 0;
                        end;

                    end;

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    begin
        CurrentNo := rec."NewBRNo.";
    end;


    trigger OnAfterGetRecord()
    var
    begin
        rec."Upload Video" := 'Upload Video File.....';
        rec."Download Video" := 'Download/View Video File.....';
    end;


    procedure UploadFile()
    var
        PicInStream: InStream;
        FromFileName: Text;
        Override: Label 'The existing file will be replaced. Do you want to continue?', Locked = false, MaxLength = 250;
    begin
        if not Confirm(Override) then
            exit;
        if UploadIntoStream('Import', '', 'MP4 Files (*.MP4)|*.MP4', FromFileName, PicInStream) then begin
            Clear(rec.Video);
            rec.Video.ImportStream(PicInStream, FromFileName);
            rec.Modify(true);

            Message('Uploaded');
        end;
    end;


    procedure DownloadFile()
    var
        NewBrOpLineRec: Record "New Breakdown Op Line1";
        TenMediaRec: Record "Tenant Media";
        PicInStream: InStream;
        Filename: Text;
    begin
        TenMediaRec.Get(rec.Video.MediaId);
        TenMediaRec.CalcFields(Content);
        Filename := 'Video.mp4';
        TenMediaRec.Content.CreateInStream(PicInStream);
        DownloadFromStream(PicInStream, 'Download', '', '', Filename);
    end;


    var
        CurrentNo: Code[20];
        xxx: text[100];
        z: Integer;
}