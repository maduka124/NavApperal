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
            DataClassification = ToBeClassified;
        }
        field(3; "From Style Name"; Text[50])
        {
            Caption = 'From Style Name';
            DataClassification = ToBeClassified;

            TableRelation = "Style Master"."Style No." where("Buyer No." = field("Buyer Code"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                StyleRec: Record "Style Master";
            begin
                StyleRec.Reset();
                StyleRec.SetRange("Style No.", Rec."From Style Name");
                if StyleRec.FindSet() then begin
                    Rec."From Style No" := StyleRec."No.";
                    Rec.Modify();
                end;
            end;
        }
        field(4; "To Prod. Order No."; Code[20])
        {

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
            Caption = 'From Buyer Code';
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

        }
        field(12; PO; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("From Style No"));
            ValidateTableRelation = false;
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
            // TableRelation = "Style Master"."Style No." where("Buyer No." = field("To Buyer Code"));
            // ValidateTableRelation = false;

            trigger OnLookup()
            var
                StyleRec: Record "Style Master";
            begin
                StyleRec.Reset();
                StyleRec.SetRange("Buyer No.", Rec."To Buyer Code");
                if StyleRec.FindSet() then begin
                    if Page.RunModal(51067, StyleRec) = Action::LookupOK then begin
                        Rec."To Style No." := StyleRec."Style No.";
                        rec."To Style No" := StyleRec."No.";
                        Modify();
                    end;
                end;
            end;


        }
        field(16; "To PO"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Production Order".PO where(Status = filter('Released'), BuyerCode = field("To Buyer Code"), "Style Name" = field("To Style No."));
            TableRelation = "Style Master PO"."PO No." where("Style No." = field("To Style No"));
            ValidateTableRelation = false;


        }
        field(17; "To Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "From Lot"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."Lot No." where("PO No." = field(PO), "Style No." = field("From Style No"));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ProdOrder: Record "Production Order";
            begin
                // ProdOrder.Reset();
                // ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                // ProdOrder.SetRange(BuyerCode, "Buyer Code");
                // ProdOrder.SetRange("Style Name", "From Style Name");
                // ProdOrder.SetRange(PO, PO);
                // // ProdOrder.SetRange("Lot No.", Rec."From Lot");
                // if not ProdOrder.FindFirst() then
                //     Error('There is no Production order');

                // Validate("From Prod. Order No.", ProdOrder."No.");
            end;
        }
        field(19; "To Lot"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."Lot No." where("Style No." = field("To Style No"), "PO No." = field("To PO"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                ProdOrder: Record "Production Order";
            begin
                ProdOrder.Reset();
                ProdOrder.SetRange(Status, ProdOrder.Status::Released);
                ProdOrder.SetRange(BuyerCode, "To Buyer Code");
                ProdOrder.SetRange("Style No.", "To Style No");
                ProdOrder.SetRange(PO, "To PO");
                // ProdOrder.SetRange("Lot No.", "To Lot");
                if not ProdOrder.FindFirst() then
                    // Error('There is no Production order');

                Validate("To Prod. Order No.", ProdOrder."No.");
            end;
        }
        field(20; "From Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
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
