report 50615 StyleAnalysis
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Style Analysis Report';
    RDLCLayout = 'Report_Layouts/Workstudy/StyleAnalysis.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("New Breakdown"; "New Breakdown")
        {
            DataItemTableView = sorting("No.");
            column(Style_Name; "Style Name")
            { }
            column(Description; Description)
            { }
            column(Created_User; "Created User")
            { }
            column(Created_Date; "Created Date")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Item_Type_Name; "Item Type Name")
            { }
            // column(Garment_Part_Name; "Garment Part Name")
            // { }
            column(Machine; Machine)
            { }
            column(Manual; Manual)
            { }
            column(Total_SMV; "Total SMV")
            { }
            column(CompLogo; comRec.Picture)
            { }



            dataitem("New Breakdown Op Line2"; "New Breakdown Op Line2")
            {
                DataItemLinkReference = "New Breakdown";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");
                column(Line_No_; "Line No.")
                { }
                column(Code; Code)
                { }
                column(DescriptionLine; Description)
                { }
                column(Machine_Name; "Machine No.")
                { }
                column(SMV; SMV)
                { }
                column(Target_Per_Hour; "Target Per Hour")
                { }
                column(color; color)
                { }
                column(LineType; LineType)
                { }
                column(Department_Name; "Department Name")
                { }
                column(Garment_Part_Name; "Garment Part Name")
                { }
                column(ManualLine; Manual)
                { }
                column(Auto; Auto)
                { }

                trigger OnAfterGetRecord()

                begin
                    // color := '';


                    // if "New Breakdown Op Line2".Description = 'FRONT' then
                    //     color := 'teal'
                    // else
                    //     if "New Breakdown Op Line2".Description = 'BACK' then
                    //         color := 'teal'
                    //     else
                    //         color := 'black';

                    Manual := 0;
                    Auto := 0;
                    if "Machine Name" = 'HEL' then begin
                        Manual := SMV
                    end
                    else
                        // if "Machine Name" = 'HELPER' then begin
                        //     Manual := SMV
                        // end
                        // else
                        //     if "Machine Name" = 'Helper' then begin
                        //         Manual := SMV
                        //     end
                        //     else
                        //         if "Machine Name" = 'helper' then begin
                        //             Manual := SMV
                        //         end
                        //         else
                                    Auto := SMV;

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
        color: Text;
        StyleFilter: Text[50];
        comRec: Record "Company Information";
        Manual: Decimal;
        Auto: Decimal;

}