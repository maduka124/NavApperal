page 50537 "GIT PI ListPart2"
{
    PageType = ListPart;
    SourceTable = "GITPIPI";
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
                    Editable = true;
                }

                field("PI No."; "PI No.")
                {
                    ApplicationArea = All;
                    Caption = 'PI No';
                }

                field("PI Date"; "PI Date")
                {
                    ApplicationArea = All;
                }

                field("PI Value"; "PI Value")
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
                    PIHeaderRec: Record "PI Details Header";
                    CodeUnitNav: Codeunit NavAppCodeUnit;
                    GITPIPIRec: Record "GITPIPI";
                begin

                    GITPIPIRec.Reset();
                    GITPIPIRec.SetRange("GITPINo.", "GITPINo.");
                    GITPIPIRec.SetFilter(Select, '=%1', true);

                    if GITPIPIRec.FindSet() then begin
                        repeat
                            //Update Purchase order pi no
                            PIHeaderRec.Reset();
                            PIHeaderRec.SetRange("PI No", GITPIPIRec."PI No.");
                            PIHeaderRec.FindSet();
                            PIHeaderRec.Select := false;
                            PIHeaderRec.AssignedGITPINo := '';
                            PIHeaderRec.Modify();
                        until GITPIPIRec.Next() = 0;
                    end;

                    //Delete from line table
                    GITPIPIRec.Reset();
                    GITPIPIRec.SetRange("GITPINo.", "GITPINo.");
                    GITPIPIRec.SetFilter(Select, '=%1', true);
                    GITPIPIRec.DeleteAll();

                    CodeUnitNav.Add_GIT_PI_Items("GITPINo.");

                    //GRN Balance
                    CodeUnitNav.CalGRNBalance("GITPINo.");

                    CurrPage.Update();
                end;
            }
        }
    }


}