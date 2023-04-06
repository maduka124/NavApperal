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

                Editable = EditableGB;

                field(SJCNo; rec.SJCNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sewing Job Creation No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, rec."Buyer Name");
                        if BuyerRec.FindSet() then
                            rec."Buyer No." := BuyerRec."No.";

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                    end;
                }

                field("Style Name"; rec."Style Name")
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
                        StyleMasterRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasterRec.FindSet() then
                            rec."Style No." := StyleMasterRec."No.";

                        Codeunit1.Generate_Line1(rec.SJCNo, rec."Style No.", rec."Style Name");
                    end;
                }

                field(MarkerCatName; rec.MarkerCatName)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Marker Category';

                    trigger OnValidate()
                    var
                        MarkerCategoryRec: Record MarkerCategory;
                    begin
                        MarkerCategoryRec.Reset();
                        MarkerCategoryRec.SetRange("Marker Category", rec.MarkerCatName);
                        if MarkerCategoryRec.FindSet() then
                            rec.MarkerCatNo := MarkerCategoryRec."No.";
                    end;
                }

                field("Group ID"; rec."Group ID")
                {
                    ApplicationArea = All;
                }
            }

            group("PO/Lot Details")
            {

                Editable = EditableGB;

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

                Editable = EditableGB;

                part("Sewing Job Creation ListPart3"; "Sewing Job Creation ListPart3")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "SJCNo." = FIELD(SJCNo), "Style No." = field("Style No."), "Style Name" = field("Style Name");
                }
            }

            group("Daily Line Requirement")
            {

                Editable = EditableGB;

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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."SJC Nos.", xRec."SJCNo", rec."SJCNo") THEN BEGIN
            NoSeriesMngment.SetSeries(rec.SJCNo);
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
        UserRec: Record "User Setup";
    begin

        //Done By sachith on 06/04/23
        UserRec.Reset();
        UserRec.Get(UserId);

        UserRec.Reset();
        UserRec.Get(UserId);
        if UserRec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> rec."Factory Code") then
                Error('You are not authorized to delete this record.')
        end
        else
            Error('You are not authorized to delete records.');


        //Check whether ratio created or not
        SJC4.Reset();
        SJC4.SetRange("SJCNo.", rec.SJCNo);
        SJC4.SetFilter("Record Type", '=%1', 'L');

        if SJC4.FindSet() then begin
            repeat
                RatioRec.Reset();
                RatioRec.SetRange("Style No.", rec."Style No.");
                RatioRec.SetRange("Group ID", SJC4."Group ID");
                RatioRec.SetRange("Colour No", SJC4."Colour No");

                if RatioRec.FindSet() then begin
                    Message('Cannot delete. Ratio already created for the style %1 ,Group ID %2 , Color %3 ', rec."Style Name", SJC4."Group ID", SJC4."Colour Name");
                    exit(false);
                end;
            until SJC4.Next() = 0;
        end;


        //Delete "DAILY LINE REQUIRMENT"
        SJC4.Reset();
        SJC4.SetRange("SJCNo.", rec.SJCNo);
        if SJC4.FindSet() then
            SJC4.DeleteAll();

        //Delete group master record
        GroupMasterRec.Reset();
        GroupMasterRec.SetRange("Style No.", rec."Style No.");
        if GroupMasterRec.FindSet() then
            GroupMasterRec.DeleteAll();

        //Delete "SUB SCHEDULING"
        SJC3.SetRange("SJCNo.", rec.SJCNo);
        if SJC3.FindSet() then
            SJC3.DeleteAll();

        SJC2.SetRange("SJCNo.", rec.SJCNo);
        if SJC2.FindSet() then
            SJC2.DeleteAll();

    end;

    //Done By Sachith on 03/04/23 
    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin

        UserRec.Reset();
        UserRec.Get(UserId);

        if rec."Factory Code" <> '' then begin
            if (UserRec."Factory Code" <> '') then begin
                if (UserRec."Factory Code" = rec."Factory Code") then
                    EditableGB := true
                else
                    EditableGB := false;
            end
            else
                EditableGB := false;
        end
        else
            if (UserRec."Factory Code" = '') then begin
                Error('Factory not assigned for the user.');
                EditableGB := false;
            end
            else
                EditableGB := true;
    end;

    var
        EditableGB: Boolean;
}