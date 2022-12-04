page 71012822 "YY Requsition Card"
{
    PageType = Card;
    SourceTable = "YY Requsition Header";
    Caption = 'YY Requisition';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'YY Request No';
                    Editable = SetEdit1;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    ShowMandatory = true;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange("Name", rec."Buyer Name");
                        if BuyerRec.FindSet() then begin
                            rec."Buyer No." := BuyerRec."No.";
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    ShowMandatory = true;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        StyleMasRec: Record "Style Master";
                        StyleRec: Record "Style Master";
                    begin

                        StyleMasRec.Reset();
                        StyleMasRec.SetRange("Style No.", rec."Style Name");
                        if StyleMasRec.FindSet() then begin
                            rec."Style No." := StyleMasRec."No.";
                            rec."Garment Type No." := StyleMasRec."Garment Type No.";
                            rec."Garment Type Name" := StyleMasRec."Garment Type Name";
                        end;
                    end;
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                    Editable = false;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }
            }

            group("YY Request Details")
            {
                part("YY Requsition ListPart"; "YY Requsition ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Sample YY Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        YYReqLineRec: Record "YY Requsition Line";
    begin
        YYReqLineRec.Reset();
        YYReqLineRec.SetRange("No.", rec."No.");
        YYReqLineRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then
            UserRole := UserRec.UserRole;

        if UserRole = 'CAD' then
            SetEdit1 := false
        else
            SetEdit1 := true;
    end;

    var
        SetEdit1: Boolean;
        UserRole: Text[50];
}