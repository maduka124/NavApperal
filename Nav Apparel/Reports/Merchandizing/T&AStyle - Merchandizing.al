report 51078 TnAStyleMerchandizing
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Time And Action Plan';
    RDLCLayout = 'Report_Layouts/Merchandizing/T&AStyle.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Dependency Style Header"; "Dependency Style Header")
        {
            DataItemTableView = sorting("No.");
            column(Style_No_; "Style Name.")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("Dependency Style Line"; "Dependency Style Line")
            {

                DataItemLinkReference = "Dependency Style Header";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Style No.");
                column(Garment_Type_Name; "Garment Type Name")
                { }
                column(Qty; Qty)
                { }
                column(Action_Description; "Action Description")
                { }
                column(BPCD; BPCD)
                { }
                column(Created_User; "Created User")
                { }
                column(Plan_Date; "Plan Date")
                { }
                column(Revise; Revise)
                { }
                column(Remarks; Remarks)
                { }
                column(Gap_Days; "Gap Days")
                { }
                column(MK_Critical; "MK Critical")
                { }


            }
            trigger OnPreDataItem()
            var

            begin
                SetRange("No.", styleName);
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
                    field(styleName; styleName)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';
                        Editable = not EditableGB;
                        TableRelation = "Dependency Style Header"."No.";
                    }
                }
            }
        }
    }

    procedure PassParameters(StyleNoPara: Code[20])
    var
    begin
        styleName := StyleNoPara;
        EditableGB := true;
    end;

    var
        styleName: Code[20];
        comRec: Record "Company Information";
        EditableGB: Boolean;
}