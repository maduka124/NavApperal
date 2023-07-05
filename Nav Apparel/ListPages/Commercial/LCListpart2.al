page 51355 "LC ListPart 2"
{
    PageType = ListPart;
    SourceTable = "LC Style 2";
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

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Qty"; Rec."Qty")
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
                Image = Delete;

                trigger OnAction()
                var
                    LCStyle2Rec: Record "LC Style 2";
                    LCMasterRec: Record LCMaster;
                    LCStyle: Record "LC Style";
                begin
                    LCStyle2Rec.Reset();
                    LCStyle2Rec.SetFilter(Select, '=%1', true);
                    if LCStyle2Rec.FindSet() then begin
                        repeat
                            LCStyle.Reset();
                            LCStyle.SetRange("Style No.", LCStyle2Rec."Style No.");
                            if LCStyle.FindSet() then begin
                                LCStyle."Assign LC No" := '';
                                LCStyle.Modify();
                            end;

                            LCStyle2Rec.Delete();

                        until LCStyle2Rec.Next() = 0;
                        CurrPage.Update();
                    end;

                end;
            }





        }
    }


}