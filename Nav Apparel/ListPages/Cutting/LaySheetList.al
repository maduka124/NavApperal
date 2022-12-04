page 50651 "Lay Sheet List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LaySheetHeader;
    CardPageId = LaySheetCard;
    SourceTableView = sorting("LaySheetNo.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("LaySheetNo."; Rec."LaySheetNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Lay Sheet No';
                }

                field("FabReqNo."; Rec."FabReqNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Fab. Req. No';
                }

                field("Plan Date"; Rec."Plan Date")
                {
                    ApplicationArea = All;
                }

                field("Cut No."; Rec."Cut No.")
                {
                    ApplicationArea = All;
                    Caption = 'Cut No';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Group ID"; Rec."Group ID")
                {
                    ApplicationArea = All;
                    Caption = 'Sew. Job Group';
                }

                field(Color; Rec.Color)
                {
                    ApplicationArea = All;
                }

                field("Component Group Name"; Rec."Component Group Name")
                {
                    ApplicationArea = All;
                    Caption = 'Component Group';
                }

                field("Marker Name"; Rec."Marker Name")
                {
                    ApplicationArea = All;
                    Caption = 'Marker';
                }

                field("Fab Direction"; Rec."Fab Direction")
                {
                    ApplicationArea = All;
                }

            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        LaySheetLine1Rec: Record LaySheetLine1;
        LaySheetLine2Rec: Record LaySheetLine2;
        LaySheetLine3Rec: Record LaySheetLine3;
        LaySheetLine4Rec: Record LaySheetLine4;
        LaySheetLine5Rec: Record LaySheetLine5;
        CutProRec: Record CuttingProgressHeader;
        BundleGuideRec: Record BundleGuideHeader;
    begin

        //Check in the cutting progress
        CutProRec.Reset();
        CutProRec.SetRange(LaySheetNo, Rec."LaySheetNo.");

        if CutProRec.FindSet() then begin
            Message('Cannot delete. Lay Sheet No already used in the Cutting Progress No : %1', CutProRec."CutProNo.");
            exit(false);
        end;


        //Check in the Lay SHeet
        BundleGuideRec.Reset();
        BundleGuideRec.SetRange("Style No.", Rec."Style No.");
        BundleGuideRec.SetRange("Color No", Rec."Color No.");
        BundleGuideRec.SetRange("Group ID", Rec."Group ID");
        BundleGuideRec.SetRange("Component Group", Rec."Component Group Code");
        BundleGuideRec.SetRange("Cut No", Rec."Cut No.");

        if BundleGuideRec.FindSet() then begin
            Message('Cannot delete. Lay Sheet details already used in the Bundle Guide No : %1', BundleGuideRec."BundleGuideNo.");
            exit(false);
        end;



        LaySheetLine1Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine1Rec.DeleteAll();

        LaySheetLine2Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine2Rec.DeleteAll();

        LaySheetLine3Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine3Rec.DeleteAll();

        LaySheetLine4Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine4Rec.DeleteAll();

        LaySheetLine5Rec.SetRange("LaySheetNo.", Rec."LaySheetNo.");
        LaySheetLine5Rec.DeleteAll();
    end;


}