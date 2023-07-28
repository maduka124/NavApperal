report 51285 SampleRequirementDetails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sample Requirement Details Report';
    RDLCLayout = 'Report_Layouts/Samples/SampleRequirementDetails.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sample Requsition Header"; "Sample Requsition Header")
        {
            DataItemTableView = sorting("No.");
            column(Group_Head; "Group HD")
            { }
            column(Brand_Name; "Brand Name")
            { }
            column(ReqQty; Qty)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }

            dataitem("Sample Requsition Line"; "Sample Requsition Line")
            {
                DataItemLinkReference = "Sample Requsition Header";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.", "Line No.");

                column(Style_Name; "Style Name")
                { }
                column(Sample_Name; "Sample Name")
                { }
                column(Buyer_Name; "Buyer Name")
                { }
                column(Reject_Qty; "Reject Qty")
                { }
                column(Qty; Qty)
                { }
                column(No_; "No.")
                { }
                column(Line_No_; "Line No.")
                { }
            }

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                if GroupHD <> '' then
                    SetRange("Group HD", GroupHD);

                if (stDate <> 0D) and (endDate <> 0D) then begin
                    if (stDate > endDate) then
                        Error('Invalid date period.');

                    SetRange("Created Date", stDate, endDate);
                end;

                SetFilter(Qty, '>%1', 0);
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
                    field(GroupHD; GroupHD)
                    {
                        ApplicationArea = All;
                        Caption = 'Merchandiser Group Head';
                        //  TableRelation = "User Setup"."Merchandizer Group Name" where("Merchandizer Head" = filter(true));
                        // TableRelation = MerchandizingGroupTable."Group Head";


                        //Done By Sachith on 26/07/23
                        trigger OnLookup(Var Text: Text): Boolean
                        var
                            UserRec: Record MerchandizingGroupTable;
                            MerchantName: Text[200];
                        begin

                            UserRec.Reset();
                            if Page.RunModal(50848, UserRec) = Action::LookupOK then begin
                                GroupHD := UserRec."Group Head";
                            end;
                        end;
                    }

                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }


    var
        ReqQty: BigInteger;
        BrandName: Text[50];
        GroupHD: Code[20];
        SampleReqHeadRec: Record "Sample Requsition Header";
        comRec: Record "Company Information";
        stDate: Date;
        endDate: Date;
}