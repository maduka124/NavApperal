report 50614 ManningLevelsReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Manning Levels Report';
    RDLCLayout = 'Report_Layouts/Workstudy/ManningLevelsReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Maning Level"; "Maning Level")
        {
            // DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(Style_Name; "Style Name")
            { }
            column(Line_No_; "Line No.")
            { }
            column(Created_Date; "Created Date")
            { }
            column(Created_User; "Created User")
            { }
            column(Buyer; styleRec."Buyer Name")
            { }
            column(Order_Qty; styleRec."Order Qty")
            { }
            column(Garment_Type_Name; styleRec."Garment Type Name")
            { }
            column(BPT; BPT)
            { }
            column(Eff; Eff)
            { }
            column(Expected_Target; "Expected Target")
            { }
            column(MOTheo; MOTheo)
            { }
            column(MOAct; MOAct)
            { }
            column(MODiff; MODiff)
            { }
            column(MOBil; MOBil)
            { }
            column(HPTheo; HPTheo)
            { }
            column(HPAct; HPAct)
            { }
            column(HPODiff; HPODiff)
            { }
            column(HPBil; HPBil)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Factory; Factory)
            { }
            column("Target"; "100Target")
            { }


            dataitem("Maning Levels Line"; "Maning Levels Line")
            {
                DataItemLinkReference = "Maning Level";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");

                column(Line_No_Line; "Line No.")
                { }
                column(Code; Code)
                { }
                column(Description; Description)
                { }
                column(Machine_Name; "Machine Name")
                { }
                column(Department_Name; "Department Name")
                { }
                column(SMV_Machine; "SMV Machine")
                { }
                column(SMV_Manual; "SMV Manual")
                { }
                column(Theo_MO; "Theo MO")
                { }
                column(Theo_HP; "Theo HP")
                { }
                column(Act_MO; "Act MO")
                { }
                column(Act_HP; "Act HP")
                { }
                column(Act_MC; "Act MC")
                { }
                column(Comments; Comments)
                { }
                column(Target_Per_Hour; "Target Per Hour")
                { }
                column(RefGPartName; RefGPartName)
                { }
                trigger OnAfterGetRecord()
                var
                begin
                    styleRec.Get("Maning Level"."Style No.");
                end;
            }

            trigger OnAfterGetRecord()
            var
                StyleMasRec: Record "Style Master";
                ManLevelRec: Record "Maning Levels Line";
                TotVAL: Decimal;
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                NavappLine.Reset();
                NavappLine.SetRange("Style No.", "Style No.");
                if NavappLine.FindSet() then begin
                    Factory := NavappLine.Factory;
                end;

                if Type = Type::"Based on Machine Operator" then begin
                    if "Total SMV" > 0 then
                        "100Target" := (60 / "Total SMV") * Val
                    else
                        "100Target" := 0
                end
                else begin
                    ManLevelRec.Reset();
                    ManLevelRec.SetRange("No.", "No.");
                    if ManLevelRec.FindSet() then begin
                        repeat
                            TotVAL += ManLevelRec."Act MO" + ManLevelRec."Act HP";
                        until ManLevelRec.Next() = 0;
                    end;

                    if "Total SMV" > 0 then
                        "100Target" := (60 / "Total SMV") * TotVAL
                    else
                        "100Target" := 0

                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                //                 group(GroupName)
                //                 {
                //                     Caption = 'Filter By';
                //                     field(StyleFilter; StyleFilter)
                //                     {
                //                         ApplicationArea = All;
                //                         Caption = 'Style';
                //                         TableRelation = "Style Master"."No.";

                //                     }

                //                     field(LineFilter; LineFilter)
                //                     {
                //                         ApplicationArea = All;
                //                         Caption = 'Line';
                //                         TableRelation = "Work Center"."No.";
                //                         //TableRelation = "NavApp Planning Lines"."Resource Name" where("Style No." = filter(StyleFilter));
                //                         trigger OnValidate()
                //                         var
                //                             styleRec: Record "Style Master";
                //                         begin
                //                             styleRec.Reset();
                //                             styleRec.SetRange("No.", "Maning Level"."Style No.");
                //                             if styleRec.FindSet() then 
                // ;
                //                         end;
                //                     }
                //                 }
            }
        }
    }

    var
        styleRec: Record "Style Master";
        StyleFilter: Text[50];
        comRec: Record "Company Information";
        LineFilter: Code[20];
        NavappLine: Record "NavApp Planning Lines";
        Factory: Code[20];
        "100Target": Decimal;

}