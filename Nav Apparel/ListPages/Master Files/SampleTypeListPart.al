page 71012750 "Sample Type List part"
{
    PageType = ListPart;
    SourceTable = "Sample Type";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type No';
                }

                field("Sample Type Name"; "Sample Type Name")
                {
                    ApplicationArea = All;
                }

                field("Lead Time"; "Lead Time")
                {
                    ApplicationArea = All;
                }

                field(Selection; Selection)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Selected; Selected)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        BuyerNo: Code[20];


    trigger OnQueryClosePage(CloseAction: Action): Boolean;

    var
        SampleTypeBuyerRec: Record "Sample Type Buyer";
        SampleTypeRec: Record "Sample Type";
    begin

        if CloseAction = Action::OK then begin
            SampleTypeBuyerRec.SetRange("Buyer No.", BuyerNo, BuyerNo);
            SampleTypeBuyerRec.DeleteAll();

            REPEAT
                if SampleTypeRec.Selected = true then begin
                    SampleTypeBuyerRec.Init();
                    SampleTypeBuyerRec."Buyer No." := BuyerNo;
                    SampleTypeBuyerRec."No." := SampleTypeRec."No.";
                    SampleTypeBuyerRec."Sample Type Name" := SampleTypeRec."Sample Type Name";
                    SampleTypeBuyerRec."Lead Time" := SampleTypeRec."Lead Time";
                    SampleTypeBuyerRec."Created User" := UserId;
                    SampleTypeBuyerRec.Insert();
                end;
            UNTIL SampleTypeRec.NEXT <= 0;

        end;
    end;

    procedure PassParameters(BuyerNoPara: Text);
    var

    begin
        BuyerNo := BuyerNoPara;

    end;

}