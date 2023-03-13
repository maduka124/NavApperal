report 50634 BundleGuideReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Bundle Guide Report';
    RDLCLayout = 'Report_Layouts/Cutting/BundleGuideReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(BundleGuideHeader; BundleGuideHeader)
        {
            DataItemTableView = sorting("BundleGuideNo.");

            column(Style_Name; "Style Name")
            { }
            column(Cut_No; "Cut No")
            { }
            column(Created_Date; "Created Date")
            { }
            column(Quantity; Quantity)
            { }
            column(CompLogo; comRec.Picture)
            { }
            //Done By sachith on 20/02/23
            column(PO_No_; "PO No.")
            { }

            dataitem(BundleGuideLine; BundleGuideLine)
            {
                DataItemLinkReference = BundleGuideHeader;
                DataItemLink = "BundleGuideNo." = field("BundleGuideNo.");
                DataItemTableView = sorting("Line No");

                column(Bundle_No; "Bundle No")
                { }
                column(Color_Name; "Color Name")
                { }
                column(Shade_Name; "Shade Name")
                { }
                column(Sticker_Sequence; "Sticker Sequence")
                { }
                column(Role_ID; "Role ID")
                { }
                column(Size; Size)
                { }
                column(BQty; Qty)
                { }
                column(FactoryName; FactoryName)
                { }
                column(PO; PO)
                { }

                trigger OnAfterGetRecord()
                begin
                    styleRec.SetRange("No.", BundleGuideHeader."Style No.");
                    if styleRec.FindFirst() then begin
                        Quantity := styleRec."Order Qty";
                        FactoryName := styleRec."Factory Name";
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
                // SetRange("Style No.", styleNo);

                SetRange("BundleGuideNo.", BundleGuideNo);
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

                    //Done By Sachith On 20/02/23
                    // field(styleNo; styleNo)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Style';

                    //     // TableRelation = BundleGuideHeader."Style No.";

                    //     // trigger OnLookup(var Text: Text): Boolean
                    //     // begin
                    //     //     if Page.RunModal(50666, BundleGuideHeader) = Action::LookupOK then begin
                    //     //         Editable := false;
                    //     //         styleNo := BundleGuideHeader."Style No.";
                    //     //     end;
                    //     // end;

                    //     TableRelation = "Style Master"."No.";

                    //     trigger OnValidate()
                    //     var
                    //         StyleMasterRec: Record "Style Master";
                    //     begin
                    //         StyleMasterRec.Reset();
                    //         StyleMasterRec.SetRange("No.", BundleGuideHeader."Style No.");

                    //         if StyleMasterRec.FindSet() then
                    //             styleNo := StyleMasterRec."No.";
                    //     end;
                    // }

                    field(BundleGuideNo; BundleGuideNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Bundle Guide No';
                        TableRelation = BundleGuideHeader."BundleGuideNo.";
                    }
                }
            }
        }
    }


    var
        styleRec: Record "Style Master";
        Quantity: BigInteger;
        comRec: Record "Company Information";
        BundleGuideNo: code[50];
        FactoryName: Text[50];
        styleNo: Code[20];
}