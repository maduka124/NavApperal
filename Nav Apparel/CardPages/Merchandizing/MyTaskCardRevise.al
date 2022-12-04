page 71012793 "MyTask Revise Card"
{
    PageType = Card;
    Caption = 'My Task Revise';
    SourceTable = "Dependency Review Header";

    layout
    {
        area(Content)
        {
            group(" ")
            {
                part(MyTaskRevise; "My Task Revise")
                {
                    ApplicationArea = All;
                    SubPageLink = "Style No." = field("Style No."), "Buyer No." = field("Buyer No.");
                }
            }
        }
    }


    var
        StyleNo: Code[20];
        LineNo: BigInteger;
        BuyerNo: Code[20];


    procedure PassParameters(StyleNoPara: Text; LineNoPara: BigInteger; BuyerNoPAra: Code[20]);
    var

    begin
        StyleNo := StyleNoPara;
        LineNo := LineNoPara;
        BuyerNo := BuyerNoPara;

        rec."Style No." := StyleNo;
        rec."Line No." := LineNo;

    end;


    trigger OnOpenPage()
    var
        DependencyStyleLineRec1: Record "Dependency Style Line";
        DependencyReviewLineRec: Record "Dependency Review Line";
        MaxNo: BigInteger;
    begin

        rec."Style No." := StyleNo;
        rec."Line No." := LineNo;
        rec."Buyer No." := BuyerNo;
        CurrPage.Update();

        //Check for existance
        DependencyReviewLineRec.Reset();
        DependencyReviewLineRec.SetRange("Style No.", StyleNo);
        DependencyReviewLineRec.SetRange("Buyer No.", BuyerNo);

        if not DependencyReviewLineRec.FindSet() then begin

            //Get all style actions
            DependencyStyleLineRec1.Reset();
            DependencyStyleLineRec1.SetRange("Buyer No.", BuyerNo);
            DependencyStyleLineRec1.SetRange("Style No.", StyleNo);
            DependencyStyleLineRec1.SetCurrentKey("Plan Date");
            DependencyStyleLineRec1.Ascending(true);

            if DependencyStyleLineRec1.FindSet() then begin

                //Get Max no
                MaxNo := 0;
                DependencyReviewLineRec.Reset();

                if DependencyReviewLineRec.FindLast() then
                    MaxNo := DependencyReviewLineRec."No.";

                repeat
                    MaxNo += 1;

                    DependencyReviewLineRec.Init();
                    DependencyReviewLineRec."No." := MaxNo;
                    DependencyReviewLineRec."Style No." := StyleNo;
                    DependencyReviewLineRec."Line No." := DependencyStyleLineRec1."Line No.";
                    DependencyReviewLineRec."Buyer No." := BuyerNo;
                    DependencyReviewLineRec."Dependency Group No." := DependencyStyleLineRec1."Dependency Group No.";
                    DependencyReviewLineRec."Dependency Group" := DependencyStyleLineRec1."Dependency Group";
                    DependencyReviewLineRec."Action Description" := DependencyStyleLineRec1."Action Description";
                    DependencyReviewLineRec."Gap Days" := DependencyStyleLineRec1."Gap Days";
                    DependencyReviewLineRec."Action User" := DependencyStyleLineRec1."Action User";
                    DependencyReviewLineRec."Plan Date" := DependencyStyleLineRec1."Plan Date";
                    DependencyReviewLineRec.BPCD := DependencyStyleLineRec1.BPCD;
                    DependencyReviewLineRec."Created User" := UserId;
                    DependencyReviewLineRec."Created Date" := WorkDate();
                    DependencyReviewLineRec.Insert();

                until DependencyStyleLineRec1.Next() = 0;

            end;
        end;
    end;


}