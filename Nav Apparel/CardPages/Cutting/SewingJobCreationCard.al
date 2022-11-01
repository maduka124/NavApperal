page 50587 "Sewing Job Creation Card"
{
    PageType = Card;
    SourceTable = SewingJobCreation;
    Caption = 'Sewing Job Creation';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(SJCNo; SJCNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Creation No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, "Buyer Name");
                        if BuyerRec.FindSet() then
                            "Buyer No." := BuyerRec."No.";
                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    ShowMandatory = true;


                    // trigger OnLookup(var Texts: Text): Boolean
                    // var
                    //     NavapplaningLinrRec: Record "NavApp Planning Lines";
                    //     BuyerRec: Record Customer;
                    // begin

                    //     BuyerRec.Reset();
                    //     BuyerRec.SetRange("No.", "Buyer No.");

                    //     if BuyerRec.FindSet() then begin

                    //         NavapplaningLinrRec.Reset();
                    //         NavapplaningLinrRec.SetRange("Style No.");

                    //         if NavapplaningLinrRec.FindSet() then begin

                    //         end;

                    //         // if Page.RunModal(71012677, BuyerRec) = Action::LookupOK then begin

                    //         // end;
                    //     end

                    // end;

                    trigger OnValidate()
                    var
                        StyleMasterRec: Record "Style Master";
                        Codeunit1: Codeunit NavAppCodeUnit;
                    begin
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("Style No.", "Style Name");
                        if StyleMasterRec.FindSet() then
                            "Style No." := StyleMasterRec."No.";

                        Codeunit1.Generate_Line1(SJCNo, "Style No.", "Style Name");
                    end;
                }

                field(MarkerCatName; MarkerCatName)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Marker Category';

                    trigger OnValidate()
                    var
                        MarkerCategoryRec: Record MarkerCategory;
                    begin
                        MarkerCategoryRec.Reset();
                        MarkerCategoryRec.SetRange("Marker Category", MarkerCatName);
                        if MarkerCategoryRec.FindSet() then
                            MarkerCatNo := MarkerCategoryRec."No.";
                    end;
                }

                field("Group ID"; "Group ID")
                {
                    ApplicationArea = All;
                }
            }

            group("PO/Lot Details")
            {
                part("Sewing Job Creation ListPart1"; "Sewing Job Creation ListPart1")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Style No." = FIELD("Style No.");
                }
            }

            group("Planning Information")
            {
                part("Sewing Job Creation ListPart2"; "Sewing Job Creation ListPart2")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "SJCNo." = FIELD(SJCNo);
                }
            }

            group("Sub Scheduling")
            {
                part("Sewing Job Creation ListPart3"; "Sewing Job Creation ListPart3")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "SJCNo." = FIELD(SJCNo), "Style No." = field("Style No."), "Style Name" = field("Style Name");
                }
            }

            group("Daily Line Requirement")
            {
                part("Sewing Job Creation ListPart4"; "Sewing Job Creation ListPart4")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "SJCNo." = FIELD(SJCNo), "Style No." = field("Style No."), "Style Name" = field("Style Name");
                }
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."SJC Nos.", xRec."SJCNo", "SJCNo") THEN BEGIN
            NoSeriesMngment.SetSeries(SJCNo);
            CurrPage.Update();
            EXIT(TRUE);
        END;
    end;


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