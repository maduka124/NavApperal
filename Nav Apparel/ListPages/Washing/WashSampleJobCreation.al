page 50711 "Wash Sample Job Creationdd"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Wash Sample Job Creation";
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Seq No."; rec."Seq No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                    Editable = false;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    Editable = false;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;

                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field(PO; rec.PO)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';
                    Editable = false;
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Gament Type"; rec."Gament Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sample Type"; rec.SampleType)
                {
                    Caption = 'Sample Type';
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Size; rec.Size)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(" Req Qty"; rec." Req Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Sample Item Name"; rec."Sample Item Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Item';
                    Editable = false;
                }

                field("REC Qty"; rec."REC Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                // field("Gate Pass No"; "Gate Pass No")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }

                field("GRN No"; rec."GRN No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Option; rec.Option)
                {
                    ApplicationArea = All;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SampleJobCreationRec: Record "Wash Sample Job Creation";
                        quantity: Integer;

                    begin

                        if rec.Qty >= rec."REC Qty" then
                            Error('Quntity Greater Then Rec Qty');

                        CurrPage.Update();

                        quantity := 0;
                        SampleJobCreationRec.Reset();
                        SampleJobCreationRec.SetRange("No.", rec."No.");
                        SampleJobCreationRec.SetRange("Line No", rec."Line No");

                        if SampleJobCreationRec.FindSet() then begin

                            repeat

                                quantity += SampleJobCreationRec.Qty;

                                if quantity > SampleJobCreationRec."REC Qty" then
                                    Error('Quantity Total Must Be qual on Rec Qty');

                            until SampleJobCreationRec.Next() = 0;
                        end;
                    end;


                }

                field("Wash Type"; rec."Wash Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashTypeRec: Record "Wash Type";
                    begin
                        WashTypeRec.get(rec."Wash Type");
                        rec."Wash Type" := WashTypeRec."Wash Type Name";
                    end;
                }

                field(Remark; rec.Remark)
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
            action("Create Job")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    washsampleJobcreate: Record "Wash Sample Job Creation";
                    WashSampleReqDataRec: Record "Washing Sample Requsition Line";
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                    MaxLineNo: Integer;
                begin

                    //Check whether user logged in or not
                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());

                    if not LoginSessionsRec.FindSet() then begin  //not logged in
                        Clear(LoginRec);
                        LoginRec.LookupMode(true);
                        LoginRec.RunModal();

                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());
                        LoginSessionsRec.FindSet();
                    end;


                    //Get max line
                    washsampleJobcreate.Reset();
                    washsampleJobcreate.SetRange("No.", rec."No.");
                    washsampleJobcreate.SetRange("Line No", rec."Line No");

                    if washsampleJobcreate.FindLast() then
                        MaxLineNo := washsampleJobcreate."Seq No.";

                    MaxLineNo += 1;

                    WashSampleReqDataRec.Reset();
                    WashSampleReqDataRec.SetRange("No.", rec."No.");
                    WashSampleReqDataRec.SetRange("Line no.", rec."Line No");

                    if WashSampleReqDataRec.FindSet() then begin

                        washsampleJobcreate.Init();
                        washsampleJobcreate."No." := WashSampleReqDataRec."No.";
                        washsampleJobcreate."Line No" := WashSampleReqDataRec."Line no.";
                        washsampleJobcreate."Seq No." := MaxLineNo;
                        washsampleJobcreate."Factory Name" := WashSampleReqDataRec."Factory Name";
                        washsampleJobcreate.Type := WashSampleReqDataRec.Type;
                        washsampleJobcreate.Buyer := WashSampleReqDataRec.Buyer;
                        washsampleJobcreate."Style Name" := WashSampleReqDataRec."Style Name";
                        washsampleJobcreate.PO := WashSampleReqDataRec.PO;
                        washsampleJobcreate."Color Name" := WashSampleReqDataRec."Color Name";
                        washsampleJobcreate."Order Qty" := WashSampleReqDataRec."Order Qty";
                        washsampleJobcreate."Gament Type" := WashSampleReqDataRec."Gament Type";
                        washsampleJobcreate.SampleType := WashSampleReqDataRec.SampleType;
                        washsampleJobcreate."Wash Type" := WashSampleReqDataRec."Wash Type";
                        washsampleJobcreate.Size := WashSampleReqDataRec.Size;
                        washsampleJobcreate."Req Date" := WashSampleReqDataRec."Req Date";
                        washsampleJobcreate." Req Qty" := WashSampleReqDataRec."Req Qty";
                        washsampleJobcreate."REC Qty" := WashSampleReqDataRec."REC Qty";
                        washsampleJobcreate."GRN No" := WashSampleReqDataRec."GRN No";
                        washsampleJobcreate."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        washsampleJobcreate.Insert()

                    end;

                end;
            }
        }
    }
}