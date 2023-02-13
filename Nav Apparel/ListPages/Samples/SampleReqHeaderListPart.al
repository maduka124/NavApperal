page 50427 "Sample Request Header ListPart"
{
    PageType = ListPart;
    SourceTable = "Sample Requsition Header";
    SourceTableView = where(Status = filter(Pending));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';
                    Editable = false;
                }

                // Done By Sachith on 10/02/23
                field("Brand Name"; Rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                    Editable = false;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Secondary UserID"; rec."Secondary UserID")
                {
                    ApplicationArea = All;
                    Caption = 'Merchant';
                    Editable = false;
                }

                field("Created Date"; rec."Created Date")
                {
                    ApplicationArea = All;
                    Caption = 'Ent. Date';
                    Editable = false;
                }

                field("Sample Room Name"; rec."Sample Room Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room';
                    Editable = false;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Merchandizer Group Name"; rec."Merchandizer Group Name")
                {
                    ApplicationArea = All;
                }

                field("Group HD"; rec."Group HD")
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
            action("Load")
            {
                ApplicationArea = All;
                Image = GetOrder;
                // Scope = Repeater;
                // Promoted = true;

                trigger OnAction()
                var
                    WIP: Record wip;
                begin
                    if rec."No." = '' then
                        Error('Select a record.');

                    wip.Reset();
                    wip.FindSet();
                    wip.ModifyAll("Req No.", rec."No.");
                end;
            }
            //Mihiranga 2023/01/23
            action(viewForSampleDetails)
            {
                ApplicationArea = All;
                Image = View;
                Caption = 'View For Sample Details';


                trigger OnAction()
                var
                    SampleCardRec: Page "Sample Request Card";
                //SampleReq: Record "Sample Requsition Header";
                begin



                    Clear(SampleCardRec);
                    SampleCardRec.PassParameters(Rec."No.", false, false);
                    SampleCardRec.Editable := false;
                    SampleCardRec.RunModal();


                end;
            }


        }
    }
}