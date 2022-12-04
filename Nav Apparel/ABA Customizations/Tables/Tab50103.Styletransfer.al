table 50103 "Style transfer Header"
{
    Caption = 'Style transfer Header';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Style transfer List";
    LookupPageId = "Style transfer List";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "From Prod. Order No."; Code[20])
        {
            Caption = 'From Prod. Order No.';
            DataClassification = ToBeClassified;
            TableRelation = "Production Order"."No." where(Status = filter(Released));
            trigger OnValidate()
            var
                ProdOrderRec: Record "Production Order";
                StyleTransLines: Record "Style Transfer Line";
                ProdOrdComp: Record "Prod. Order Component";
                Inx: Integer;
                GrpItem: Code[20];
            begin
                Inx := 0;
                if "From Prod. Order No." <> '' then
                    ProdOrderRec.Get(ProdOrderRec.Status::Released, "From Prod. Order No.");

                "From Style Name" := ProdOrderRec."Style Name";

                ProdOrdComp.Reset();
                ProdOrdComp.SetCurrentKey("Item No.", "Variant Code", "Location Code", Status, "Due Date");
                ProdOrdComp.SetRange("Prod. Order No.", "From Prod. Order No.");
                ProdOrdComp.SetFilter("Remaining Quantity", '<>%1', 0);
                if ProdOrdComp.FindFirst() then begin
                    repeat
                        if GrpItem <> ProdOrdComp."Item No." then begin
                            Inx += 10000;
                            StyleTransLines.Init();
                            StyleTransLines."Document No." := Rec."No.";
                            StyleTransLines."Line No." := Inx;
                            StyleTransLines.Validate("Main Category", ProdOrdComp."Item Cat. Code");
                            StyleTransLines."From Prod. Order No." := "From Prod. Order No.";
                            StyleTransLines."To Prod. Order No." := "To Prod. Order No.";
                            StyleTransLines.Validate("Item Code", ProdOrdComp."Item No.");
                            StyleTransLines.Insert();
                            GrpItem := ProdOrdComp."Item No.";
                        end;
                    until ProdOrdComp.Next() = 0;
                end;
            end;
        }
        field(3; "From Style Name"; Text[50])
        {
            Caption = 'From Style Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "To Prod. Order No."; Code[20])
        {
            Caption = 'To Prod. Order No.';
            DataClassification = ToBeClassified;
            TableRelation = "Production Order"."No." where(Status = filter(Released));
            trigger OnValidate()
            var
                ProdOrderRec: Record "Production Order";
            begin
                if "To Prod. Order No." <> '' then
                    ProdOrderRec.Get(ProdOrderRec.Status::Released, "To Prod. Order No.");

                "To Style Name" := ProdOrderRec."Style Name";
            end;
        }
        field(5; "To Style Name"; Text[50])
        {
            Caption = 'To Style Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
        }
        field(9; "Buyer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            var
                CustRec: Record Customer;
            begin
                Buyer := '';

                if "Buyer Code" <> '' then
                    CustRec.get("Buyer Code");
                Buyer := CustRec.Name;
            end;
        }
        field(10; Buyer; Text[100])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Customer.Name;
            //ValidateTableRelation = false;
        }
        field(11; "Style No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Style Name';
            TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer Code"));
            ValidateTableRelation = false;
        }
        field(12; PO; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Production Order".PO where(Status = filter(Released), BuyerCode = field("Buyer Code"), "Style Name" = field("Style No."));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                ProdOrder: Record "Production Order";
            begin
                ProdOrder.Reset();
                ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                ProdOrder.SetRange(BuyerCode, "Buyer Code");
                ProdOrder.SetRange("Style Name", "Style No.");
                ProdOrder.SetRange(PO, PO);
                if not ProdOrder.FindFirst() then
                    Error('There is no Production order');

                Validate("From Prod. Order No.", ProdOrder."No.");
            end;
        }

        field(13; "To Buyer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
            trigger OnValidate()
            var
                CustRec: Record Customer;
            begin
                Buyer := '';

                if "To Buyer Code" <> '' then
                    CustRec.get("To Buyer Code");
                "To Buyer" := CustRec.Name;
            end;
        }
        field(14; "To Buyer"; Text[100])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Customer.Name;
            //ValidateTableRelation = false;
        }
        field(15; "To Style No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'To Style Name';
            TableRelation = "Style Master"."Style No." where("Buyer No." = field("To Buyer Code"));
            ValidateTableRelation = false;
        }
        field(16; "To PO"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Production Order".PO where(Status = filter(Released), BuyerCode = field("To Buyer Code"), "Style Name" = field("To Style No."));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                ProdOrder: Record "Production Order";
            begin
                ProdOrder.Reset();
                ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                ProdOrder.SetRange(BuyerCode, "To Buyer Code");
                ProdOrder.SetRange("Style Name", "To Style No.");
                ProdOrder.SetRange(PO, "To PO");
                if not ProdOrder.FindFirst() then
                    Error('There is no Production order');

                Validate("To Prod. Order No.", ProdOrder."No.");
            end;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "From Style Name", "To Style Name", Buyer)
        {

        }
    }
    trigger OnInsert()

    var
        ManufacSetup: Record "Manufacturing Setup";
        NosMangmnet: Codeunit NoSeriesManagement;
    begin
        if "No." = '' then begin
            ManufacSetup.Get();
            ManufacSetup.TestField("Style Transfer Nos.");
            "No." := NosMangmnet.GetNextNo(ManufacSetup."Style Transfer Nos.", WorkDate(), true);
            "Document Date" := WorkDate();
        end;
    end;

    procedure AssistEdit(OldStyleTransHedd: Record "Style transfer Header"): Boolean
    var
        StyleTranshed: Record "Style transfer Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ManuSetup: Record "Manufacturing Setup";
    begin
        COPY(Rec);
        ManuSetup.Get();
        ManuSetup.TestField("Style Transfer Nos.");

        IF NoSeriesMgt.SelectSeries(ManuSetup."Style Transfer Nos.", OldStyleTransHedd."No.", "No.") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            IF StyleTranshed.GET("No.") THEN
                EXIT(TRUE);
        END;
    end;
}
