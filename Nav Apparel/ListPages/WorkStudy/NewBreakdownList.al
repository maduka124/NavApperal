page 50458 "New Breakdown"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "New Breakdown";
    CardPageId = "New Breakdown Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field("CostingSMV"; rec.CostingSMV)
                {
                    ApplicationArea = All;
                    Caption = 'Costing SMV';
                }

                field("ProductionSMV"; rec.ProductionSMV)
                {
                    ApplicationArea = All;
                    Caption = 'Production SMV';
                }

                field("PlanningSMV"; rec.PlanningSMV)
                {
                    ApplicationArea = All;
                    Caption = 'Planning SMV';
                }

                field("Total SMV"; rec."Total SMV")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;


    trigger OnDeleteRecord(): Boolean
    var
        NewBrOpLine1Rec: Record "New Breakdown Op Line1";
        NewBrOpLine2Rec: Record "New Breakdown Op Line2";
    begin

        NewBrOpLine1Rec.Reset();
        NewBrOpLine1Rec.SetRange("NewBRNo.", rec."No.");
        NewBrOpLine1Rec.DeleteAll();

        NewBrOpLine2Rec.Reset();
        NewBrOpLine2Rec.SetRange("No.", rec."No.");
        NewBrOpLine2Rec.DeleteAll();

    end;


    trigger OnAfterGetCurrRecord()
    var
        StyleMasRec: Record "Style Master";
    begin
        StyleMasRec.Reset();
        StyleMasRec.SetRange("No.", rec."Style No.");

        if StyleMasRec.FindSet() then begin
            rec.CostingSMV := StyleMasRec.CostingSMV;
            rec.PlanningSMV := StyleMasRec.PlanningSMV;
            rec.ProductionSMV := StyleMasRec.ProductionSMV;
        end;
        //CurrPage.SaveRecord();
    end;

}