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
                field(FabricCode; FabricCode)
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
                        ArticleRec.SetRange(Article, FabricCode);
                        if not ArticleRec.FindSet() then begin
                            ArticleRec.Init();
                            ArticleRec."No." := FabricCode;
                            ArticleRec.Article := FabricCode;
                            ArticleRec."Created Date" := WorkDate();
                            ArticleRec."Created User" := UserId;
                            ArticleRec."Main Category No." := MainCatRec."No.";
                            ArticleRec."Main Category Name" := 'FABRIC';
                            ArticleRec.Insert();
                        end;
                    end;
                }

                field(Composition; Composition)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        FabricCodeMasterRec: Record FabricCodeMaster;
                    begin
                        FabricCodeMasterRec.Reset();
                        FabricCodeMasterRec.SetRange(Composition, Composition);
                        if FabricCodeMasterRec.FindSet() then
                            Error('Composition already exists.');
                    end;
                }

                field(Construction; Construction)
                {
                    ApplicationArea = All;
                }

                field("Supplier Name"; "Supplier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';

                    trigger OnValidate()
                    var
                        VendorRec: Record Vendor;
                    begin
                        VendorRec.Reset();
                        VendorRec.SetRange(Name, "Supplier Name");
                        if VendorRec.FindSet() then
                            "Supplier No." := VendorRec."No.";

                        CurrPage.Update();
                    end;
                }
            }
        }
    }
}