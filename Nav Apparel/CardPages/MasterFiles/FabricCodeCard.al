page 50680 FabricCodeCard
{
    PageType = Card;
    SourceTable = FabricCodeMaster;
    Caption = 'Fabric Code';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(FabricCode; rec.FabricCode)
                {
                    ApplicationArea = All;
                    Caption = 'Fabric Code';

                    trigger OnValidate()
                    var
                        ArticleRec: Record Article;
                        MainCatRec: Record "Main Category";
                    begin
                        MainCatRec.Reset();
                        MainCatRec.SetRange("Main Category Name", 'FABRIC');
                        MainCatRec.FindSet();

                        ArticleRec.Reset();
                        ArticleRec.SetRange(Article, rec.FabricCode);
                        if not ArticleRec.FindSet() then begin
                            ArticleRec.Init();
                            ArticleRec."No." := rec.FabricCode;
                            ArticleRec.Article := rec.FabricCode;
                            ArticleRec."Created Date" := WorkDate();
                            ArticleRec."Created User" := UserId;
                            ArticleRec."Main Category No." := MainCatRec."No.";
                            ArticleRec."Main Category Name" := 'FABRIC';
                            ArticleRec.Insert();
                        end;
                    end;
                }

                field(Composition; rec.Composition)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        FabricCodeMasterRec: Record FabricCodeMaster;
                    begin
                        FabricCodeMasterRec.Reset();
                        FabricCodeMasterRec.SetRange(Composition, rec.Composition);
                        if FabricCodeMasterRec.FindSet() then
                            Error('Composition already exists.');
                    end;
                }

                field(Construction; rec.Construction)
                {
                    ApplicationArea = All;
                }

                field("Supplier Name"; rec."Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';

                    trigger OnValidate()
                    var
                        VendorRec: Record Vendor;
                    begin
                        VendorRec.Reset();
                        VendorRec.SetRange(Name, rec."Supplier Name");
                        if VendorRec.FindSet() then
                            rec."Supplier No." := VendorRec."No.";

                        CurrPage.Update();
                    end;
                }
            }
        }
    }
}