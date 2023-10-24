page 50445 "Acc Inv ListPart1"
{
    PageType = ListPart;
    SourceTable = AcceptanceInv1;
    SourceTableView = where("AssignedAccNo." = filter(''));
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }

                field("Inv No."; Rec."Inv No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Inv No';
                }

                field("Inv Date"; Rec."Inv Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Inv Value"; Rec."Inv Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Add)
            {
                ApplicationArea = All;
                Image = Add;

                trigger OnAction()
                var
                    AcceptanceInv12Rec: Record AcceptanceInv1;
                    AcceptanceInv1Rec: Record AcceptanceInv1;
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    AcceptanceInv2Rec: Record AcceptanceInv2;
                    GITBaseonPIRec: Record GITBaseonPI;
                    GITBaseonLCRec: Record GITBaseonLC;
                    AccNo1: Code[20];
                begin

                    AcceptanceInv1Rec.Reset();
                    AcceptanceInv1Rec.SetFilter(Select, '=%1', true);

                    if AcceptanceInv1Rec.FindSet() then begin

                        repeat
                            AccNo1 := AcceptanceInv1Rec."AccNo.";
                            AcceptanceInv2Rec.Init();
                            AcceptanceInv2Rec."B2BLC No" := AcceptanceInv1Rec."B2BLC No.";
                            AcceptanceInv2Rec."Line No" := AcceptanceInv1Rec."Line No";
                            AcceptanceInv2Rec."B2BLC No (System)" := AcceptanceInv1Rec."B2BLC No. (System)";
                            AcceptanceInv2Rec."accNo." := AcceptanceInv1Rec."AccNo.";
                            AcceptanceInv2Rec."Inv No." := AcceptanceInv1Rec."Inv No.";
                            AcceptanceInv2Rec."Inv Date" := AcceptanceInv1Rec."Inv Date";
                            AcceptanceInv2Rec."Inv Value" := AcceptanceInv1Rec."Inv Value";
                            AcceptanceInv2Rec."Created User" := UserId;
                            AcceptanceInv2Rec.Type := AcceptanceInv1Rec.Type;
                            AcceptanceInv2Rec.Insert();

                            if AcceptanceInv1Rec.Type = Rec.Type::"TT or Cash" then begin
                                GITBaseonPIRec.Reset();
                                GITBaseonPIRec.SetRange("GITPINo.", AcceptanceInv1Rec."GITNo.");
                                GITBaseonPIRec.SetRange("Invoice No", AcceptanceInv1Rec."Inv No.");
                                GITBaseonPIRec.FindSet();

                                GITBaseonPIRec.AssignedAccNo := AccNo1;
                                GITBaseonPIRec.Modify();
                            end
                            else begin
                                GITBaseonLCRec.Reset();
                                GITBaseonLCRec.SetRange("GITLCNo.", AcceptanceInv1Rec."GITNo.");
                                //GITBaseonLCRec.SetRange("B2B LC No. (System)", AcceptanceInv1Rec."GITNo.");
                                GITBaseonLCRec.SetRange("Invoice No", AcceptanceInv1Rec."Inv No.");
                                GITBaseonLCRec.FindSet();

                                GITBaseonLCRec.AssignedAccNo := AccNo1;
                                GITBaseonLCRec.Modify();
                            end;

                            //Update Select as false
                            AcceptanceInv12Rec.Reset();
                            AcceptanceInv12Rec.SetFilter(Select, '=%1', true);
                            AcceptanceInv12Rec.SetRange("Line No", AcceptanceInv1Rec."Line No");

                            if AcceptanceInv12Rec.FindSet() then begin
                                repeat
                                    AcceptanceInv12Rec."AssignedAccNo." := AccNo1;
                                    AcceptanceInv12Rec.Select := false;
                                until AcceptanceInv12Rec.Next() = 0;
                                AcceptanceInv12Rec.Modify();
                            end;

                        until AcceptanceInv1Rec.Next() = 0;
                    end;
                    CurrPage.Update();
                    CodeUnitNav.Add_ACC_INV_Items(Format(Rec.Type), AccNo1);



                end;
            }
        }
    }


}