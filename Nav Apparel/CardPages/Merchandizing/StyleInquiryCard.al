page 50602 "Style Inquiry Card"
{
    PageType = Card;
    SourceTable = "Style Master";
    Caption = 'Style Inquiry';

    layout
    {
        area(Content)
        {
            // group(General1)
            // {
            //     field("LC No/Contract"; rec."LC No/Contract")
            //     {
            //         ApplicationArea = All;
            //     }

            //     field(ContractNo; rec.ContractNo)
            //     {
            //         ApplicationArea = All;
            //     }

            //     field(AssignedContractNo; rec.AssignedContractNo)
            //     {
            //         ApplicationArea = All;
            //     }
            // }

            group(General)
            {
                Editable = EditableGb;

                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    //Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        StyleMasRec: Record "Style Master";
                        SampleReqRec: Record "Sample Requsition Header";
                        EstBOMRec: Record "BOM Estimate";
                        NewBRRec: Record "New Breakdown";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
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

                        if rec."Style No.".Contains('/') then
                            Error('Cannot use "/" within Style Name');

                        if rec."No." <> '' then begin

                            //Check for style rename  
                            SampleReqRec.Reset();
                            SampleReqRec.SetFilter("Style No.", rec."No.");
                            if SampleReqRec.FindSet() then
                                Error('Style Name : %1 already usade in Sample requests. Cannot rename', rec."Style No.");

                            EstBOMRec.Reset();
                            EstBOMRec.SetFilter("Style No.", rec."No.");
                            if EstBOMRec.FindSet() then
                                Error('Style Name : %1 already usade in Estimate BOM. Cannot rename', rec."Style No.");

                            NewBRRec.Reset();
                            NewBRRec.SetFilter("Style No.", rec."No.");
                            if NewBRRec.FindSet() then
                                Error('Style Name : %1 already usade in New Breakdown. Cannot rename', rec."Style No.");

                            if rec.Status = rec.Status::Confirmed then
                                Error('Style Name : %1 already confirmed. Cannot rename', rec."Style No.");


                            StyleMasRec.Reset();
                            StyleMasRec.SetFilter("No.", '<>%1', rec."No.");

                            if StyleMasRec.FindSet() then begin
                                repeat
                                    if UpperCase(StyleMasRec."Style No.") = UpperCase(rec."Style No.") then
                                        Error('Style Name : %1 already exists', rec."Style No.");
                                until StyleMasRec.Next() = 0;
                            end;

                        end;

                        rec."Style Display Name" := rec."Style No.";
                        CurrPage.Update();
                    end;
                }

                field("Style Display Name"; rec."Style Display Name")
                {
                    ApplicationArea = All;
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        GarmentStoreRec: Record "Garment Store";
                    begin
                        GarmentStoreRec.Reset();
                        GarmentStoreRec.SetRange("Store Name", rec."Store Name");
                        if GarmentStoreRec.FindSet() then
                            rec."Store No." := GarmentStoreRec."No."
                        else
                            Error('Invalid Store Name');

                        CurrPage.Update();
                    end;
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        SeasonsRec: Record "Seasons";
                    begin
                        SeasonsRec.Reset();
                        SeasonsRec.SetRange("Season Name", rec."Season Name");
                        if SeasonsRec.FindSet() then
                            rec."Season No." := SeasonsRec."No."
                        else
                            Error('Invalid Season Name');

                        CurrPage.Update();
                    end;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange("Name", rec."Buyer Name");
                        if BuyerRec.FindSet() then
                            rec."Buyer No." := BuyerRec."No."
                        else
                            Error('Invalid Buyer Name');

                        CurrPage.Update();
                    end;
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        BrandRec: Record Brand;
                    begin
                        BrandRec.Reset();
                        BrandRec.SetRange("Brand Name", rec."Brand Name");
                        if BrandRec.FindSet() then
                            rec."Brand No." := BrandRec."No."
                        else
                            Error('Invalid Brand Name');

                        CurrPage.Update();

                        // BrandRec.Reset();
                        // BrandRec.SetRange("Buyer Name", Rec."Buyer Name");
                        // if BrandRec.FindSet() then
                        //     Rec."Brand Name" := BrandRec."Brand Name";

                    end;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        DepartmentRec: Record "Department Style";
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", rec."Department Name");
                        if DepartmentRec.FindSet() then
                            rec."Department No." := DepartmentRec."No."
                        else
                            Error('Invalid Department Name');

                        CurrPage.Update();
                    end;
                }



                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        GarmentTypeRec: Record "Garment Type";
                    begin
                        GarmentTypeRec.Reset();
                        GarmentTypeRec.SetRange("Garment Type Description", rec."Garment Type Name");
                        if GarmentTypeRec.FindSet() then
                            rec."Garment Type No." := GarmentTypeRec."No."
                        else
                            Error('Invalid Garment Type');

                        CurrPage.Update();
                    end;
                }

                field("Size Range Name"; rec."Size Range Name")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        SizeRangeRec: Record SizeRange;
                    begin
                        SizeRangeRec.Reset();
                        SizeRangeRec.SetRange("Size Range", rec."Size Range Name");
                        if SizeRangeRec.FindSet() then
                            rec."Size Range No." := SizeRangeRec."No."
                        else
                            Error('Invalid Size Range');

                        CurrPage.Update();
                    end;
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        NavappPlanLineRec: Record "NavApp Planning Lines";
                    begin
                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."No.");
                        if NavappPlanLineRec.FindSet() then
                            Error('Style already planned. Cannot change quantity.');
                    end;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        NavappPlanLineRec: Record "NavApp Planning Lines";
                    begin
                        NavappPlanLineRec.Reset();
                        NavappPlanLineRec.SetRange("Style No.", rec."No.");
                        if NavappPlanLineRec.FindSet() then
                            Error('Style already planned. Cannot change Ship Date.');

                        if rec."Ship Date" < WorkDate() then
                            Error('Ship Date should be greater than todays date');

                        rec."Lead Time" := rec."Ship Date" - WorkDate();
                    end;
                }

                field("Lead Time"; rec."Lead Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."Ship Date" := WorkDate() + rec."Lead Time";
                    end;
                }

                field(Front; rec.Front)
                {
                    ApplicationArea = All;
                }

                field(Back; rec.Back)
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                // field("Item No"; "Item No")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Finished Good Item';
                //     Editable = false;
                // }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if rec.Type = rec.Type::Online then begin
                            EditableSMVGB := true;
                            rec.SMV := 0;
                            rec.CostingSMV := 0;
                        end
                        else begin
                            EditableSMVGB := false;
                            rec.SMV := 0;
                            rec.CostingSMV := 0;
                        end;
                    end;
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                    Editable = EditableSMVGB;

                    trigger OnValidate()
                    var
                    begin
                        rec.CostingSMV := rec.SMV;
                    end;
                }

                field("Production File Handover Date"; rec."Production File Handover Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Production File Handover Date" < WorkDate() then
                            Error('Production File Handover Date should be greater than todays date');

                        if rec."Production File Handover Date" > rec."Ship Date" then
                            Error('Production File Handover Date should be less than Ship date');
                    end;
                }

                // field("Merchandizer Group Name"; rec."Merchandizer Group Name")
                // {
                //     ApplicationArea = All;
                //     TableRelation = MerchandizingGroupTable."Group Name";
                // }
            }

            group(" ")
            {
                Editable = EditableGb;

                part("SpecialOperationStyle Listpart"; "SpecialOperationStyle Listpart")
                {
                    ApplicationArea = All;
                    Caption = 'Special Operations';
                    SubPageLink = "Style No." = FIELD("No.");
                    Editable = false;
                }
            }
        }

        area(FactBoxes)
        {
            part(MyFactBox; "Style Picture FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add Special Operations")
            {
                Caption = 'Add Special Operations';
                Image = SpecialOrder;
                ApplicationArea = All;

                trigger OnAction();
                var
                    SpecialOperationList: Page "Special Operation List part";
                begin
                    // HyperLink('https://www.microsoft.com');

                    Clear(SpecialOperationList);
                    SpecialOperationList.LookupMode(true);
                    SpecialOperationList.PassParameters(rec."No.");
                    SpecialOperationList.RunModal();
                    CurrPage.Update();
                end;
            }

            action(Confirm)
            {
                Image = Confirm;
                ApplicationArea = All;

                trigger OnAction()
                var
                    EstimatecostRec: Record "BOM Estimate Cost";
                begin
                    if rec.Status = rec.Status::Confirmed then begin
                        Message('This Style is already confirmed');
                    end
                    else begin

                        EstimatecostRec.Reset();
                        EstimatecostRec.SetRange("Style No.", Rec."No.");

                        if EstimatecostRec.FindSet() then begin
                            if EstimatecostRec.Status = EstimatecostRec.Status::Approved then begin
                                rec.Status := rec.Status::Confirmed;
                                CurrPage.Update();
                                Message('Style confirmed');
                            end
                            else
                                Error('Estimate costing not approved');
                        end
                        else
                            Error('Estimate costing not done for the Style : %1', rec."Style No.");
                    end;
                end;
            }

            action(Reject)
            {
                Image = Reject;
                ApplicationArea = All;

                trigger OnAction()
                var
                begin
                    if rec.Status = rec.Status::Confirmed then begin
                        Message('Style opened for changes.');
                        rec.Status := rec.Status::Open;
                    end
                    else
                        if rec.Status = rec.Status::Rejected then
                            Message('Style already rejected')
                        else begin
                            rec.Status := rec.Status::Rejected;
                            CurrPage.Update();
                            Message('Style rejected');
                        end;

                end;
            }

            // action("Delete Style")
            // {
            //     Image = "8ball";
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         styemaster: Record "Style Master";
            //         styemasterpo: Record "Style Master PO";
            //     begin

            //         styemasterpo.Reset();
            //         styemasterpo.SetRange("Style Name", 'P-GASTON S3');
            //         if styemasterpo.FindSet() then
            //             styemasterpo.DeleteAll();

            //         styemasterpo.Reset();
            //         styemasterpo.SetRange("Style Name", 'P-GASPARDTH-S3');
            //         if styemasterpo.FindSet() then
            //             styemasterpo.DeleteAll();

            //         styemasterpo.Reset();
            //         styemasterpo.SetRange("Style Name", 'Laurie SS23');
            //         if styemasterpo.FindSet() then
            //             styemasterpo.DeleteAll();

            //         styemasterpo.Reset();
            //         styemasterpo.SetRange("Style Name", 'TEST001');
            //         if styemasterpo.FindSet() then
            //             styemasterpo.DeleteAll();

            //         /////////////////////////////
            //         /// 
            //         styemaster.Reset();
            //         styemaster.SetRange("Style No.", 'P-GASTON S3');
            //         styemaster.FindSet();
            //         styemaster.Delete();

            //         styemaster.Reset();
            //         styemaster.SetRange("Style No.", 'P-GASPARDTH-S3');
            //         styemaster.FindSet();
            //         styemaster.Delete();

            //         styemaster.Reset();
            //         styemaster.SetRange("Style No.", 'Laurie SS23');
            //         styemaster.FindSet();
            //         styemaster.Delete();

            //         styemaster.Reset();
            //         styemaster.SetRange("Style No.", 'TEST001');
            //         styemaster.FindSet();
            //         styemaster.Delete();


            //         Message('completed');

            //     end;
            // }

            // action("Remove/")
            // {
            //     Image = "8ball";
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         styemaster: Record "Style Master";
            //         styemasterpo: Record "Style Master PO";
            //         bomestimate: Record "BOM Estimate";
            //         bomestimatecost: Record "BOM Estimate Cost";
            //         NavAppplaline: Record "NavApp Planning Lines";
            //         NavAppprodline: Record "NavApp Prod Plans Details";
            //         stylename: Text[50];
            //         pono: Text[50];
            //     begin
            //         styemaster.Reset();
            //         styemaster.FindSet();
            //         repeat
            //             stylename := styemaster."Style No.";
            //             stylename := stylename.Replace('/', '-');
            //             styemaster."Style No." := stylename;
            //             styemaster.Modify();
            //         until styemaster.Next() = 0;

            //         styemasterpo.Reset();
            //         styemasterpo.FindSet();
            //         repeat
            //             pono := styemasterpo."PO No.";
            //             pono := pono.Replace('/', '-');
            //             styemasterpo."PO No." := pono;
            //             styemasterpo.Modify();
            //         until styemasterpo.Next() = 0;


            //         bomestimate.Reset();
            //         bomestimate.FindSet();
            //         repeat
            //             stylename := bomestimate."Style Name";
            //             stylename := stylename.Replace('/', '-');
            //             bomestimate."Style Name" := stylename;
            //             bomestimate.Modify();
            //         until bomestimate.Next() = 0;


            //         bomestimatecost.Reset();
            //         bomestimatecost.FindSet();
            //         repeat
            //             stylename := bomestimatecost."Style Name";
            //             stylename := stylename.Replace('/', '-');
            //             bomestimatecost."Style Name" := stylename;
            //             bomestimatecost.Modify();
            //         until bomestimatecost.Next() = 0;


            //         NavAppplaline.Reset();
            //         NavAppplaline.FindSet();
            //         repeat
            //             stylename := NavAppplaline."Style Name";
            //             pono := NavAppplaline."PO No.";
            //             stylename := stylename.Replace('/', '-');
            //             pono := pono.Replace('/', '-');
            //             NavAppplaline."Style Name" := stylename;
            //             NavAppplaline."PO No." := pono;
            //             NavAppplaline.Modify();
            //         until NavAppplaline.Next() = 0;


            //         NavAppprodline.Reset();
            //         NavAppprodline.FindSet();
            //         repeat
            //             stylename := NavAppprodline."Style Name";
            //             pono := NavAppprodline."PO No.";
            //             stylename := stylename.Replace('/', '-');
            //             pono := pono.Replace('/', '-');
            //             NavAppprodline."Style Name" := stylename;
            //             NavAppprodline."PO No." := pono;
            //             NavAppprodline.Modify();
            //         until NavAppprodline.Next() = 0;


            //         NavAppprodline.Reset();
            //         NavAppprodline.FindSet();
            //         repeat
            //             stylename := NavAppprodline."Style Name";
            //             pono := NavAppprodline."PO No.";
            //             stylename := stylename.Replace('/', '-');
            //             pono := pono.Replace('/', '-');
            //             NavAppprodline."Style Name" := stylename;
            //             NavAppprodline."PO No." := pono;
            //             NavAppprodline.Modify();
            //         until NavAppprodline.Next() = 0;

            //         Message('completed');

            //     end;
            // }                       
        }
    }


    trigger OnOpenPage()
    var
    begin
        if rec.Status = rec.Status::Confirmed then begin
            EditableGb := false;
            EditableSMVGB := false;
        end
        else begin
            EditableGb := true;

            if rec.Type = rec.Type::Online then
                EditableSMVGB := true
            else
                EditableSMVGB := false;
        end;

        // if rec.Status = rec.Status::Confirmed then
        //     CurrPage.Editable := false;
    end;


    // trigger OnClosePage()
    // var
    //     ItemRec: Record Item;
    //     NoSeriesManagementCode: Codeunit NoSeriesManagement;
    //     NextNo: Code[20];
    //     StyleRec: Record "Style Master";

    //     Client: HttpClient;
    //     Content: HttpContent;
    //     ResponseFront: HttpResponseMessage;
    //     ResponseBack: HttpResponseMessage;
    //     InStrFront: InStream;
    //     InStrBack: InStream;
    // begin    
    //     StyleRec.Reset();
    //     StyleRec.SetRange("No.", "No.");

    //     if StyleRec.FindSet() then begin
    //         Clear(StyleRec.PictureFront);
    //         Clear(StyleRec.PictureBack);
    //         StyleRec.Modify(true);
    //     end;
    // end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Style Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        //StyleRec: Record "Style Master";
        StylePORec: Record "Style Master PO";
        SpecialOpRec: Record "Special Operation Style";
        NavAppPlanLineRec: Record "NavApp Planning Lines";
        ContractLCStyleRec: Record "Contract/LCStyle";
    begin
        if rec.Status = rec.status::Confirmed then
            Error('Style already confirmed. Cannot delete.');

        NavAppPlanLineRec.Reset();
        NavAppPlanLineRec.SetRange("Style No.", rec."No.");
        if NavAppPlanLineRec.FindSet() then
            Error('Style already planned. Cannot delete.');

        SpecialOpRec.SetRange("Style No.", rec."No.");
        if SpecialOpRec.FindSet() then
            SpecialOpRec.DeleteAll();

        StylePORec.SetRange("Style No.", rec."No.");
        if StylePORec.FindSet() then
            StylePORec.DeleteAll();

        //Done By Sachith on 18/05/23
        ContractLCStyleRec.Reset();
        ContractLCStyleRec.SetRange("Style No.", Rec."No.");

        if ContractLCStyleRec.FindFirst() then
            Error('Style already added to Contract.Cannot delete');
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
    begin
        if rec."No." <> '' then begin
            //rec.TestField("Style No.");
            if rec."Style No." = '' then
                Error('Style Name cannot blank.');

            rec.TestField("Store Name");
            rec.TestField("Season Name");
            rec.TestField("Brand Name");
            rec.TestField("Department Name");
            rec.TestField("Buyer Name");
            rec.TestField("Garment Type Name");
            rec.TestField("Size Range Name");
            rec.TestField("Order Qty");
            rec.TestField("Ship Date");
        end;
    end;


    trigger OnAfterGetCurrRecord()
    var
    begin
        if rec.Status = rec.Status::Confirmed then begin
            EditableGb := false;
            EditableSMVGB := false;
        end
        else begin
            EditableGb := true;

            if rec.Type = rec.Type::Online then
                EditableSMVGB := true
            else
                EditableSMVGB := false;
        end;
    end;


    var
        EditableGB: Boolean;
        EditableSMVGB: Boolean;

}