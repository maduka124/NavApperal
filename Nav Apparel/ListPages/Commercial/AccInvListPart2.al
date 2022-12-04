page 50543 "Acc Inv ListPart2"
{
    PageType = ListPart;
    SourceTable = "AcceptanceInv2";
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
                    Editable = true;
                }

                field("Inv No."; Rec."Inv No.")
                {
                    ApplicationArea = All;
                    Caption = 'Inv No';
                }

                field("Inv Date"; Rec."Inv Date")
                {
                    ApplicationArea = All;
                }

                field("Inv Value"; Rec."Inv Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Remove)
            {
                ApplicationArea = All;
                Image = RemoveLine;

                trigger OnAction()
                var
                    AcceptanceInv1Rec: Record AcceptanceInv1;
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    AcceptanceInv2Rec: Record AcceptanceInv2;
                begin

                    AcceptanceInv2Rec.Reset();
                    AcceptanceInv2Rec.SetRange("AccNo.", Rec."AccNo.");
                    AcceptanceInv2Rec.SetFilter(Select, '=%1', true);

                    if AcceptanceInv2Rec.FindSet() then begin
                        repeat
                            //Update Purchase order pi no
                            AcceptanceInv1Rec.Reset();
                            AcceptanceInv1Rec.SetRange("Inv No.", AcceptanceInv2Rec."Inv No.");
                            AcceptanceInv1Rec.FindSet();

                            AcceptanceInv1Rec.Select := false;
                            AcceptanceInv1Rec."AssignedAccNo." := '';
                            AcceptanceInv1Rec.Modify();
                        until AcceptanceInv2Rec.Next() = 0;
                    end;

                    //Delete from line table
                    AcceptanceInv2Rec.Reset();
                    AcceptanceInv2Rec.SetRange("AccNo.", Rec."AccNo.");
                    AcceptanceInv2Rec.SetFilter(Select, '=%1', true);
                    AcceptanceInv2Rec.DeleteAll();

                    CodeUnitNav.Add_ACC_INV_Items(Format(Rec.Type), Rec."AccNo.");

                    CurrPage.Update();
                end;
            }
        }
    }


}