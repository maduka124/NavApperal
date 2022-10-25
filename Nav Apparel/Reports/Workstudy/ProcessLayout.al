report 50632 ProcessLayoutReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Process Layout Report';
    RDLCLayout = 'Report_Layouts/Workstudy/ProcessLayoutReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Machine Layout Header"; "Machine Layout Header")
        {
            DataItemTableView = sorting("No.");
            column(Style_No_; "Style Name")
            { }
            column(Expected_Eff; "Expected Eff")
            { }
            column(Expected_Target; "Expected Target")
            { }
            column(Work_Center_Name; "Work Center Name")
            { }
            column(Garment_Type; "Garment Type")
            { }
            column(BuyerName; BuyerName)
            { }
            column(OrderQTY; OrderQTY)
            { }
            column(CompLogo; comRec.Picture)
            { }
            dataitem("Machine Layout Line1"; "Machine Layout Line1")
            {
                DataItemLinkReference = "Machine Layout Header";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");
                column(Minutes; Minutes)
                { }
                column(Machine_No_; "Machine No.")
                { }
                column(Description; Description)
                { }
                column(Machine_Name; "Machine Name")
                { }
                column(SMV; SMV)
                { }
                column(Target; Target)
                { }
                column(WP_No; "WP No")
                { }
                column(Manual; Manual)
                { }
                column(Auto; Auto)
                { }

                trigger OnAfterGetRecord()

                begin
                    Manual := 0;
                    Auto := 0;

                    if "Machine Name" = 'HEL' then begin
                        Manual := Minutes
                    end
                    else
                        Auto := Minutes;
                end;
            }
            trigger OnAfterGetRecord()
            var
            begin
                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    BuyerName := StyleRec."Buyer Name";
                    OrderQTY := StyleRec."Order Qty";
                end;
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                SetRange("Style No.", StyleFilter);
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
        McLayoutRec: Record "Machine Layout";
        MinutesMc: Decimal;
        Manual: Decimal;
        Auto: Decimal;
        StyleRec: Record "Style Master";
        StyleFilter: Text[50];
        comRec: Record "Company Information";
        BuyerName: Text[200];
        OrderQTY: BigInteger;
}