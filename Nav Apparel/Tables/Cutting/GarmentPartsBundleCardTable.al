table 51268 BundleCardTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bundle Card No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No';
        }

        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Fabric,Sewing,Washing';
            OptionMembers = Fabric,Sewing,Washing;
        }

        field(3; "Bundle Guide Header No"; Code[20])
        {
            Caption = 'Bundle Guide No';
            DataClassification = ToBeClassified;
            TableRelation = BundleGuideHeader."BundleGuideNo.";

            trigger OnValidate()
            var
                BundleCardRec: Record BundleGuideHeader;
            begin
                BundleCardRec.Reset();
                BundleCardRec.SetRange("BundleGuideNo.", Rec."Bundle Guide Header No");
                if BundleCardRec.FindFirst() then begin
                    Rec."Style Name" := BundleCardRec."Style Name";
                    Rec."Style No" := BundleCardRec."Style No.";
                end;
            end;
        }

        field(4; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(6; PoNo; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created User"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(9; Type1; text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            TableRelation = MarkerCategory."Marker Category";
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "Bundle Card No")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("BundleGuideCard Nos.");
        "Bundle Card No" := NoSeriesMngment.GetNextNo(NavAppSetup."BundleGuideCard Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}