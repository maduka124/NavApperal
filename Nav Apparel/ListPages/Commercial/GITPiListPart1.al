page 50535 "GIT PI ListPart1"
{
    PageType = ListPart;
    SourceTable = "PI Details Header";
    SourceTableView = where(AssignedB2BNo = filter(''), AssignedGITPINo = filter(''));
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; Select)
                {
                    ApplicationArea = All;
                }

                field("PI No"; "PI No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PI Date"; "PI Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("PI Value"; "PI Value")
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
                    PIHeaderRec: Record "PI Details Header";
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    GITPIPIRec: Record "GITPIPI";
                    GITPINo1: Code[20];
                begin

                    PIHeaderRec.Reset();
                    PIHeaderRec.SetCurrentKey("Supplier No.");
                    PIHeaderRec.SetRange("Supplier No.", "Supplier No.");
                    PIHeaderRec.SetFilter(Select, '=%1', true);

                    if PIHeaderRec.FindSet() then begin

                        repeat

                            GITPINo1 := PIHeaderRec.GITPINo;
                            GITPIPIRec.Init();
                            GITPIPIRec."GITPINo." := PIHeaderRec.GITPINo;
                            GITPIPIRec."PI Sys No." := PIHeaderRec."No.";
                            GITPIPIRec."Suppler No." := PIHeaderRec."Supplier No.";
                            GITPIPIRec."PI No." := PIHeaderRec."PI No";
                            GITPIPIRec."PI Date" := PIHeaderRec."PI Date";
                            GITPIPIRec."PI Value" := PIHeaderRec."PI Value";
                            GITPIPIRec."Created User" := UserId;
                            GITPIPIRec.Insert();

                            //Update PI Header with  B2Bno
                            PIHeaderRec.AssignedGITPINo := GITPINo1;
                            PIHeaderRec.Modify();

                        until PIHeaderRec.Next() = 0;

                        //Add items
                        CodeUnitNav.Add_GIT_PI_Items(GITPINo1);

                    end;

                    //Update Select as false
                    PIHeaderRec.Reset();
                    PIHeaderRec.SetRange("Supplier No.", "Supplier No.");
                    PIHeaderRec.SetFilter(Select, '=%1', true);

                    if PIHeaderRec.FindSet() then begin
                        PIHeaderRec.ModifyAll(Select, false);
                    end;

                    //GRN Balance
                    CodeUnitNav.CalGRNBalance(GITPINo1);

                    CurrPage.Update();
                end;
            }
        }
    }
}