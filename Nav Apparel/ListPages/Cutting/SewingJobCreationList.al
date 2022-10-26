page 50586 "Sewing Job Creation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SewingJobCreation;
    CardPageId = "Sewing Job Creation Card";
    SourceTableView = sorting(SJCNo) order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(SJCNo; SJCNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Creation No';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field(MarkerCatName; MarkerCatName)
                {
                    ApplicationArea = All;
                    Caption = 'Marker Category';
                }

                field("Created Date"; "Created Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        SJC2: Record SewingJobCreationLine2;
        SJC3: Record SewingJobCreationLine3;
        SJC4: Record SewingJobCreationLine4;
        GroupMasterRec: Record GroupMaster;
        RatioRec: Record RatioCreation;
    begin

        //Check whether ratio created or not
        SJC4.Reset();
        SJC4.SetRange("SJCNo.", SJCNo);
        SJC4.SetFilter("Record Type", '=%1', 'L');

        if SJC4.FindSet() then begin
            repeat
                RatioRec.Reset();
                RatioRec.SetRange("Style No.", "Style No.");
                RatioRec.SetRange("Group ID", SJC4."Group ID");
                RatioRec.SetRange("Colour No", SJC4."Colour No");

                if RatioRec.FindSet() then begin
                    Message('Cannot delete. Ratio already created for the style %1 ,Group ID %2 , Color %3 ', "Style Name", SJC4."Group ID", SJC4."Colour Name");
                    exit(false);
                end;
            until SJC4.Next() = 0;
        end;


        //Delete "DAILY LINE REQUIRMENT"
        SJC4.Reset();
        SJC4.SetRange("SJCNo.", SJCNo);
        if SJC4.FindSet() then
            SJC4.DeleteAll();

        //Delete group master record
        GroupMasterRec.Reset();
        GroupMasterRec.SetRange("Style No.", "Style No.");
        if GroupMasterRec.FindSet() then
            GroupMasterRec.DeleteAll();

        //Delete "SUB SCHEDULING"
        SJC3.SetRange("SJCNo.", SJCNo);
        if SJC3.FindSet() then
            SJC3.DeleteAll();

        SJC2.SetRange("SJCNo.", SJCNo);
        if SJC2.FindSet() then
            SJC2.DeleteAll();

    end;
}