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
            DataItemTableView = sorting("No.");
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

                trigger OnAfterGetRecord()
                var

                begin
                    styleRec.Get("Maning Level"."Style No.");

                end;
            }
            trigger OnPreDataItem()

            begin
                SetRange("Style No.", StyleFilter);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
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
                    Caption = 'Filter By';
                    field(StyleFilter; StyleFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';
                        TableRelation = "Style Master"."No.";

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
        myInt: Integer;
        styleRec: Record "Style Master";
        StyleFilter: Text[50];
        comRec: Record "Company Information";
}