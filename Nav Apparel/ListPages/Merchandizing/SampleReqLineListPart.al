page 51062 SampleReqLineListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Sample Requsition Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Seq No';
                }

                field("Fabrication Name"; rec."Fabrication Name")
                {
                    ApplicationArea = All;
                    Caption = 'Fabrication';

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                        SampleReqHeaderRec: Record "Sample Requsition Header";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, rec."Fabrication Name");
                        if ItemRec.FindSet() then
                            rec."Fabrication No." := ItemRec."No."
                        else
                            Error('Invalid Fabrication');

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');

                        //Insert garment type 
                        SampleReqHeaderRec.Reset();
                        SampleReqHeaderRec.SetRange("No.", rec."No.");
                        if SampleReqHeaderRec.FindSet() then begin
                            rec."Garment Type No" := SampleReqHeaderRec."Garment Type No";
                            rec."Garment Type" := SampleReqHeaderRec."Garment Type Name";
                            //Done By Maduka 13/02/23
                            Rec."Brand Name" := SampleReqHeaderRec."Brand Name";
                            Rec."Brand No" := SampleReqHeaderRec."Brand No";
                            //Done By sachith 15/05/23
                            Rec."Group Head" := SampleReqHeaderRec."Group HD";

                        end;

                        //done by sachith on 10/02/23
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
                    end;
                }

                field("Sample Name"; rec."Sample Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type';

                    trigger OnValidate()
                    var
                        SampleRec: Record "Sample Type";
                        SampleReqHeaderRec: Record "Sample Requsition Header";
                    begin
                        SampleRec.Reset();
                        SampleRec.SetRange("Sample Type Name", rec."Sample Name");
                        if SampleRec.FindSet() then
                            rec."Sample No." := SampleRec."No."
                        else
                            Error('Invalid Sample Type');

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');

                        //Insert garment type 
                        SampleReqHeaderRec.Reset();
                        SampleReqHeaderRec.SetRange("No.", rec."No.");
                        if SampleReqHeaderRec.FindSet() then begin
                            rec."Garment Type No" := SampleReqHeaderRec."Garment Type No";
                            rec."Garment Type" := SampleReqHeaderRec."Garment Type Name";
                            //Done By Sachith 09/02/23
                            Rec."Brand Name" := SampleReqHeaderRec."Brand Name";
                            Rec."Brand No" := SampleReqHeaderRec."Brand No";
                            //add sample type to Header Table (Mihiranga 2023/04/10)
                            SampleReqHeaderRec."Sample Type" := Rec."Sample Name";
                        end;
                        SampleReqHeaderRec.Modify();
                        CurrPage.Update();

                    end;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                        SampleReqHeaderRec: Record "Sample Requsition Header";
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", rec."Color Name");
                        if ColourRec.FindSet() then
                            rec."Color No" := ColourRec."No."
                        else
                            Error('Invalid Color');

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');

                        //Insert garment type 
                        SampleReqHeaderRec.Reset();
                        SampleReqHeaderRec.SetRange("No.", rec."No.");
                        if SampleReqHeaderRec.FindSet() then begin
                            rec."Garment Type No" := SampleReqHeaderRec."Garment Type No";
                            rec."Garment Type" := SampleReqHeaderRec."Garment Type Name";
                        end;
                    end;
                }

                field("Garment Type"; rec."Garment Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Size; rec.Size)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        "SampleReqHeader": Record "Sample Requsition Header";
                        "SampleReqLine": Record "Sample Requsition Line";
                        Total: Integer;
                    begin

                        CurrPage.Update();
                        SampleReqLine.Reset();
                        SampleReqLine.SetRange("No.", rec."No.");

                        if SampleReqLine.FindSet() then begin
                            repeat
                                Total := Total + SampleReqLine.Qty;
                            until SampleReqLine.Next() = 0;
                        end;

                        SampleReqHeader.Reset();
                        SampleReqHeader.SetRange("No.", rec."No.");
                        SampleReqHeader.FindSet();
                        SampleReqHeader.Qty := Total;
                        SampleReqHeader.Modify();

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');

                    end;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SampleReqLine: Record "Sample Requsition Line";
                    begin

                        //Done by Sachith 22/12/27
                        SampleReqLine.Reset();
                        SampleReqLine.SetRange("No.", Rec."No.");

                        if SampleReqLine.FindSet() then begin
                            if rec."Req Date" < WorkDate() then
                                Error('Req. Date should be greater than todays date.');
                        end;

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }
            }
        }
    }


    procedure Get_Count(): Integer
    var
        SampleReqLineRec: Record "Sample Requsition Line";
    begin
        SampleReqLineRec.Reset();
        SampleReqLineRec.SetRange("No.", rec."No.");
        SampleReqLineRec.SetFilter("Line No.", '<>%1', rec."Line No.");
        if SampleReqLineRec.FindSet() then
            exit(SampleReqLineRec.Count)
        else
            exit(0);
    end;
}