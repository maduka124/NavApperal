page 50288 "Special Operation List part"
{
    PageType = Card;
    SourceTable = "Special Operation";
    Caption = 'Special Operation List';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Special Op. No';
                    Editable = false;
                }

                field("SpecialOperation Name"; "SpecialOperation Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Special Op. Name';
                }

                field(Selected; Selected)
                {
                    ApplicationArea = All;
                    Caption = 'Select';
                }
            }
        }
    }

    var
        StyleNo: Code[20];


    trigger OnClosePage()
    var
        SpecialOperationStyleRec: Record "Special Operation Style";
        SpecialOperationRec: Record "Special Operation";
    begin

        //if CloseAction = Action::OK then begin
        SpecialOperationStyleRec.SetRange("Style No.", StyleNo, StyleNo);
        SpecialOperationStyleRec.DeleteAll();

        REPEAT
            if SpecialOperationRec.Selected = true then begin
                SpecialOperationStyleRec.Init();
                SpecialOperationStyleRec."Style No." := StyleNo;
                SpecialOperationStyleRec."No." := SpecialOperationRec."No.";
                SpecialOperationStyleRec."Special Operation Name" := SpecialOperationRec."SpecialOperation Name";
                SpecialOperationStyleRec."Created User" := UserId;
                SpecialOperationStyleRec.Insert();
            end;
        UNTIL SpecialOperationRec.NEXT <= 0;

        //end;
    end;

    procedure PassParameters(StyleNoPara: Text);
    var

    begin
        StyleNo := StyleNoPara;
    end;

}