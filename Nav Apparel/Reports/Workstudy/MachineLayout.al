report 50649 MachineLayoutReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Machine Layout Report';
    RDLCLayout = 'Report_Layouts/Workstudy/MachineLayoutReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Machine Layout Header"; "Machine Layout Header")
        {
            DataItemTableView = sorting("No.");
            column(LayoutNo; "No.")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Work_Center_Name; "Work Center Name")
            { }
            column(Expected_Eff; "Expected Eff")
            { }
            column(Expected_Target; "Expected Target")
            { }
            column(Garment_Type; "Garment Type")
            { }
            column(No_of_Workstation; "No of Workstation")
            { }
            column(CompLogo; comRec.Picture)
            { }
            // column(WP_No_; WPNo)
            // { }
            // column(Seq_No; SeqNo)
            // { }
            // column(Code; OPCode)
            // { }
            // column(Description; DesCrip)
            // { }
            dataitem("Machine Layout"; "Machine Layout")
            {
                DataItemLinkReference = "Machine Layout Header";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting(PKey);
                column(WP_No_; WPNo)
                { }
                column(Seq_No; SeqNo)
                { }
                column(Code; OPCode)
                { }
                column(Description; DesCrip)
                { }
                column(WPNo2; WPNo2)
                { }
                column(SeqNo2; SeqNo2)
                { }
                column(OPCode2; OPCode2)
                { }
                column(DesCrip2; DesCrip2)
                { }

                trigger OnAfterGetRecord()
                begin
                    WPNo := 0;
                    SeqNo := 0;
                    DesCrip := '';
                    OPCode := '';
                    WPNo2 := 0;
                    SeqNo2 := 0;
                    DesCrip2 := '';
                    OPCode2 := '';
                    // SetFilter("Line No.", '>=%1', 1);

                    if Type = 1 then begin
                        WPNo := "WP No.";
                        SeqNo := "Line No.";
                        OPCode := Code;
                        DesCrip := Description;
                    end else

                        if Type = 2 then begin
                            WPNo2 := "WP No.";
                            SeqNo2 := "Line No.";
                            OPCode2 := Code;
                            DesCrip2 := Description;
                        end;

                end;

            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("No.", MachineLayout);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(MachineLayout; MachineLayout)
                    {
                        ApplicationArea = All;
                        Caption = 'Machine Layout No';
                        TableRelation = "Machine Layout Header"."No.";
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    var
        MachineLayout: Code[20];
        comRec: Record "Company Information";
        WPNo: Integer;
        SeqNo: Integer;
        OPCode: Code[50];
        DesCrip: Text[200];
        MachineLayoutRec: Record "Machine Layout";
        WPNo2: Integer;
        SeqNo2: Integer;
        OPCode2: Code[50];
        DesCrip2: Text[200];

}