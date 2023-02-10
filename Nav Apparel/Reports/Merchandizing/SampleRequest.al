report 50639 SampleRequest
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sample Requisition Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/SampleRequest.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sample Requsition Header"; "Sample Requsition Header")
        {
            // DataItemTableView = sorting("No.");
            // DataItemTableView = where("Merchandizer Group Name" = filter())
            column(Buyer_Name; "Buyer Name")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Wash_Plant_Name; "Wash Plant Name")
            { }
            column(Wash_Type_Name; "Wash Type Name")
            { }
            column(Created_Date; "Created Date")
            { }
            column(Created_User; "Created User")
            { }
            column(Style_No_; "Style No.")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(No_; "No.")
            { }
            column(Secondary_UserID; "Secondary UserID")
            { }

            // Done By Sachith on on 13/01/23
            column(Brand_Name; "Brand Name")
            { }
            column(Hide; Hide)
            { }

            // Done By Sachith on on 18/01/23
            column(Garment_Type_Name; "Garment Type Name")
            { }

            dataitem("Sample Requsition Line"; "Sample Requsition Line")
            {
                DataItemLinkReference = "Sample Requsition Header";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");
                column(Sample_Name; "Sample Name")
                { }
                column(Color_Name; "Color Name")
                { }
                column(Size; Size)
                { }
                column(Qty; Qty)
                { }
                column(Req_Date; "Req Date")
                { }
                column(Comment; Comment)
                { }
                column(Fabrication_Name; "Fabrication Name")
                { }
            }
            dataitem("Sample Requsition Acce"; "Sample Requsition Acce")
            {
                DataItemLinkReference = "Sample Requsition Header";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");
                column(Requirment; Requirment)
                { }
                column(AcceRemarks; Remarks)
                { }
                column(MainCategoryName; "Main Category Name")
                { }

                column(Item_Name; "Item Name")
                { }

                column(Item_Color_Name; "Item Color Name")
                { }

                column(Article_Name_; "Article Name.")
                { }

                column(Consumption; Consumption)
                { }

                column(Placement_of_GMT; "Placement of GMT")
                { }

                column(WST; WST)
                { }
            }

            trigger OnPreDataItem()

            begin
                UserRec.Reset();
                UserReC.SetRange("User Name", "Created User");
                if UserRec.FindSet() then begin

                end;

                UserSetup.Reset();
                UserSetup.SetRange("User ID", UserId);
                if UserSetup.FindFirst() then begin
                    MerchantGrpName := UserSetup."Merchandizer Group Name";
                end;


                SetRange("No.", HeaderNo);
                SetRange("Merchandizer Group Name", MerchantGrpName);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                Hide := 1;
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
                    field(HeaderNo; HeaderNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Sample Request No';
                        // TableRelation = "Sample Requsition Header"."No." where("Merchandizer Group Name" = field(gr));
                    }
                    field(MerchantGrpName; MerchantGrpName)
                    {
                        ApplicationArea = All;
                        Caption = 'Merchandizer Group Name';
                        
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
        MerchantGrpName: Text[200];
        UserSetup: Record "User Setup";
        UserRec: Record User;
        HeaderNo: Code[20];
        comRec: Record "Company Information";
        Hide: Integer;


}