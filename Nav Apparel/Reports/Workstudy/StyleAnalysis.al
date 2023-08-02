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
            // DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
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
                DataItemTableView = sorting("Line Position");

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
                column(RefGPartName; RefGPartName)
                { }
                column(Line_Position; "Line Position")
                { }
                column(GPart_Position; "GPart Position")
                { }

                trigger OnPreDataItem()
                var
                begin
                    SetFilter("Department Name", '<>%1', '');
                end;


                trigger OnAfterGetRecord()
                begin
                    Manual := 0;
                    Auto := 0;
                    if "Machine No." = 'HEL' then begin
                        Manual := SMV
                    end
                    else
                        Auto := SMV;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;
        }
    }

    var
        color: Text;
        StyleFilter: Text[50];
        comRec: Record "Company Information";
        Manual: Decimal;
        Auto: Decimal;

}