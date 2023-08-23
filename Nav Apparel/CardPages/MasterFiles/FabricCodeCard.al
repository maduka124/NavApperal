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
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        NoSeriesMngment: Codeunit NoSeriesManagement;
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
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;

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
                            ArticleRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                            ArticleRec.Insert();
                        end;

                        //get Next Ref no
                        if rec.Reference = '' then
                            rec.Reference := NoSeriesMngment.GetNextNo('ABA-REF', Today(), true);
                    end;
                }

                field(Reference; Rec.Reference)
                {
                    ApplicationArea = All;
                    Editable = false;
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
                            rec."Supplier No." := VendorRec."No."
                        else
                            Error('Invalid Supplier');

                        CurrPage.Update();
                    end;
                }
            }
        }
    }
}