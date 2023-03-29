page 51027 "Sample Type List part"
{
    PageType = Card;
    SourceTable = "Sample Type";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type No';
                }

                field("Sample Type Name"; Rec."Sample Type Name")
                {
                    ApplicationArea = All;
                }

                field("Lead Time"; Rec."Lead Time")
                {
                    ApplicationArea = All;
                }

                field(Selection; Rec.Selection)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Selected; Rec.Selected)
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
            // Done By sachith On 29/03/23
            action("Select All")
            {
                ApplicationArea = All;
                Image = SelectMore;

                trigger OnAction()
                var
                    SampleTypeRec: Record "Sample Type";
                begin

                    SampleTypeRec.Reset();
                    SampleTypeRec.FindSet();
                    repeat
                        SampleTypeRec.Selected := true;
                        SampleTypeRec.Modify();
                    until SampleTypeRec.Next() = 0;
                    CurrPage.Update();
                end;
            }

            // Done By sachith On 29/03/23
            action("De-Select All")
            {
                ApplicationArea = All;
                Image = SelectMore;

                trigger OnAction()
                var
                    SampleTypeRec: Record "Sample Type";
                begin

                    SampleTypeRec.Reset();
                    SampleTypeRec.FindSet();
                    repeat
                        SampleTypeRec.Selected := false;
                        SampleTypeRec.Modify();
                    until SampleTypeRec.Next() = 0;
                    CurrPage.Update();
                end;
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

        if CloseAction = Action::LookupOK then begin
            //Done By Sachith on 03/02/23
            SampleTypeBuyerRec.Reset();
            SampleTypeBuyerRec.SetRange("Buyer No.", BuyerNo);
            if SampleTypeBuyerRec.FindSet() then
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

    procedure PassParameters(BuyerNoPara: Code[20]);
    var

    begin
        BuyerNo := BuyerNoPara;

    end;

    //Done By Sachith 01/03/23
    trigger OnOpenPage()
    var
        SampleTypeBuyerRec: Record "Sample Type Buyer";
        SampleTypeRec: Record "Sample Type";
    begin

        SampleTypeRec.Reset();
        if SampleTypeRec.FindSet() then begin
            repeat
                SampleTypeRec.Selected := false;
                SampleTypeRec.Modify()
            until SampleTypeRec.Next() = 0;
        end;

        SampleTypeBuyerRec.Reset();
        SampleTypeBuyerRec.SetRange("Buyer No.", BuyerNo);

        if SampleTypeBuyerRec.FindSet() then begin
            repeat
                SampleTypeRec.Reset();
                SampleTypeRec.SetRange("No.", SampleTypeBuyerRec."No.");
                if SampleTypeRec.FindSet() then begin
                    SampleTypeRec.Selected := true;
                    SampleTypeRec.Modify();
                end;
            until SampleTypeBuyerRec.Next() = 0;
        end;

    end;

}