page 51051 "My Task Revise"
{
    PageType = ListPart;
    SourceTable = "Dependency Review Line";
    SourceTableView = sorting("No.") order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Action Description"; rec."Action Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Gap Days"; rec."Gap Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Date"; rec."Plan Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(BPCD; rec.BPCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Revise Date"; rec."Revise Date")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    var
                        DependencyReviewLineRec: Record "Dependency Review Line";
                        DependencyBuyer: Record "Dependency Buyer";
                        DependencyGroupNo: code[20];
                        GapDays: Integer;
                    begin

                        GapDays := rec."Revise Date" - rec."Plan Date";
                        Recursive(GapDays, rec."Style No.", rec."Buyer No.", rec."No.");

                    end;
                }
            }
        }
    }

    procedure Recursive(GapDays: Integer; StyleNo: code[20]; BuyerNo: Code[20]; No: BigInteger)

    var
        DependencyReviewLineRec: Record "Dependency Review Line";
        DependencyBuyer: Record "Dependency Buyer";
        DependencyGroupNo: code[20];
    // GapDays: Integer;

    begin
        //Get dependency for the selected action
        DependencyReviewLineRec.Reset();
        DependencyReviewLineRec.SetRange("No.", No);

        if DependencyReviewLineRec.FindSet() then begin

            DependencyGroupNo := DependencyReviewLineRec."Dependency Group No.";

            //Get all the dependencies for the selected groupno
            DependencyBuyer.Reset();
            DependencyBuyer.SetRange("Buyer No.", BuyerNo);
            DependencyBuyer.SetRange("Main Dependency No.", DependencyGroupNo);

            if DependencyBuyer.FindSet() then begin

                repeat
                    //Find actions for the dependency
                    DependencyReviewLineRec.Reset();
                    DependencyReviewLineRec.SetRange("Dependency Group No.", DependencyBuyer."Dependency No.");
                    DependencyReviewLineRec.SetRange("Style No.", StyleNo);
                    DependencyReviewLineRec.SetRange("Buyer No.", BuyerNo);
                    DependencyReviewLineRec.SetFilter("No.", '>%1', No);

                    if DependencyReviewLineRec.FindSet() then begin

                        repeat
                            DependencyReviewLineRec."Revise Date" := DependencyReviewLineRec."Plan Date" + GapDays;
                            DependencyReviewLineRec.Modify();
                            Recursive(GapDays, StyleNo, BuyerNo, DependencyReviewLineRec."No.");
                        until DependencyReviewLineRec.Next() = 0;

                    end;

                until DependencyBuyer.Next() = 0;

            end;

        end;

    end;


    trigger OnOpenPage()
    begin
        rec.SetRange("Action User", UserId);
    end;


}