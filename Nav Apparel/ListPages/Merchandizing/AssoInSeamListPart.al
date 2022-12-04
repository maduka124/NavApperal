page 51016 AssoInSeamListPart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = AssortmentDetailsInseam;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Com Size"; rec."Com Size")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StyleRec: Record "Style Master PO";
                        AssDetInseamRec: Record AssortmentDetailsInseam;
                        BOMRec: Record BOM;
                        BOMAutoGenRec: Record "BOM Line AutoGen";
                    begin

                        if rec."Lot No." = '' then
                            Error('Invalid Lot No');


                        //Check for whether BOm created for the style
                        BOMRec.SetRange("Style No.", rec."Style No.");
                        if BOMRec.FindSet() then begin
                            BOMAutoGenRec.Reset();
                            BOMAutoGenRec.SetRange("No.", BOMRec.No);
                            if BOMAutoGenRec.FindSet() then begin
                                repeat
                                    if BOMAutoGenRec."Included in PO" = true then
                                        Error('MRP Posting has been completed for BOM : %1. To add new Size, run the Reverse MRP process for BOM : %1.', BOMRec.No);
                                until BOMAutoGenRec.Next() = 0;
                            end;
                        end;

                        AssDetInseamRec.Reset();
                        AssDetInseamRec.SetRange("Style No.", rec."Style No.");
                        AssDetInseamRec.SetRange("Lot No.", rec."Lot No.");
                        AssDetInseamRec.SetRange("Com Size", rec."Com Size");

                        if AssDetInseamRec.FindSet() then
                            Error('Com Size already defined.');

                        if rec.InSeam <> 0 then
                            rec."GMT Size" := format(rec."Com Size") + '/' + format(rec.InSeam)
                        else
                            rec."GMT Size" := format(rec."Com Size");

                        StyleRec.Reset();
                        StyleRec.SetRange("Style No.", rec."Style No.");
                        StyleRec.SetRange("Lot No.", rec."Lot No.");
                        StyleRec.FindLast();

                        rec."PO No." := StyleRec."PO No.";
                    end;
                }

                field(InSeam; rec.InSeam)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if rec."Lot No." = '' then
                            Error('Invalid Lot No');

                        if rec.InSeam <> 0 then
                            rec."GMT Size" := format(rec."Com Size") + '/' + format(rec.InSeam)
                        else
                            rec."GMT Size" := format(rec."Com Size");
                    end;
                }

                field("GMT Size"; rec."GMT Size")
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
            // action("Auto Inseam")
            // {
            //     ApplicationArea = All;
            //     Image = ExpandDepositLine;

            //     trigger OnAction();
            //     var
            //         AssorDetailsInseamRec: Record AssortmentDetailsInseam;
            //     begin
            //         AssorDetailsInseamRec.Reset();
            //         AssorDetailsInseamRec.SetRange("Style No.", "Style No.");
            //         AssorDetailsInseamRec.SetRange("lot No.", "lot No.");
            //         AssorDetailsInseamRec.FINDSET();

            //         repeat
            //             if AssorDetailsInseamRec.InSeam <> 0 then
            //                 AssorDetailsInseamRec."GMT Size" := format(AssorDetailsInseamRec."Com Size") + '/' + format(AssorDetailsInseamRec.InSeam)
            //             else
            //                 AssorDetailsInseamRec."GMT Size" := format(AssorDetailsInseamRec."Com Size");

            //             AssorDetailsInseamRec.Modify();
            //         until AssorDetailsInseamRec.Next() = 0;

            //         CurrPage.Update();
            //     end;
            // }

            // action("Copy Size/Colour/Country To All PO")
            // {
            //     ApplicationArea = All;
            //     Image = CopyCosttoGLBudget;

            //     trigger OnAction();
            //     var
            //         AssorDetailsRec: Record AssortmentDetails;
            //         AssorDetailsNewRec: Record AssortmentDetails;
            //         AssorDetailsInseamNewRec: Record AssortmentDetailsInseam;
            //         AssorDetailsInseamRec: Record AssortmentDetailsInseam;
            //         PORec: Record "Style Master PO";
            //         LineNo: Integer;
            //     begin
            //         //Color
            //         AssorDetailsRec.Reset();
            //         AssorDetailsRec.SetRange("Style No.", "Style No.");
            //         AssorDetailsRec.SetRange("lot No.", "lot No.");
            //         AssorDetailsRec.SetRange(Type, '1');

            //         //Size
            //         AssorDetailsInseamRec.Reset();
            //         AssorDetailsInseamRec.SetRange("Style No.", "Style No.");
            //         AssorDetailsInseamRec.SetRange("lot No.", "lot No.");

            //         /////////////////////Copying Colors
            //         PORec.Reset();
            //         PORec.SetRange("Style No.", "Style No.");
            //         PORec.FindSet();

            //         if not AssorDetailsRec.FINDSET() then
            //             Message('Cannot find color details for PO NO %1', "PO No.")
            //         else begin
            //             repeat
            //                 LineNo := 0;
            //                 if "Lot No." <> PORec."Lot No." then begin
            //                     //Delete Existing records                                    
            //                     AssorDetailsNewRec.Reset();
            //                     AssorDetailsNewRec.SetRange("Style No.", "Style No.");
            //                     AssorDetailsNewRec.SetRange("Lot No.", PORec."Lot No.");
            //                     AssorDetailsNewRec.SetRange(Type, '1');
            //                     AssorDetailsNewRec.DeleteAll();

            //                     repeat
            //                         //Add new record
            //                         LineNo += 10000;
            //                         AssorDetailsNewRec.Init();
            //                         AssorDetailsNewRec."Style No." := "Style No.";
            //                         AssorDetailsNewRec."PO No." := PORec."PO No.";
            //                         AssorDetailsNewRec."Lot No." := PORec."Lot No.";
            //                         AssorDetailsNewRec.Type := '1';
            //                         AssorDetailsNewRec."Line No." := LineNo;
            //                         AssorDetailsNewRec."Colour No" := AssorDetailsRec."Colour No";
            //                         AssorDetailsNewRec."Colour Name" := AssorDetailsRec."Colour Name";
            //                         AssorDetailsNewRec.Qty := AssorDetailsRec.Qty;
            //                         AssorDetailsNewRec."Created User" := UserId;
            //                         AssorDetailsNewRec."Created Date" := WorkDate();
            //                         AssorDetailsNewRec.Insert();
            //                     until AssorDetailsRec.Next() = 0;
            //                     AssorDetailsRec.FindFirst();
            //                 end;
            //             until PORec.Next() = 0;
            //         end;


            //         /////////////////////Copying Size
            //         PORec.Reset();
            //         PORec.SetRange("Style No.", "Style No.");
            //         PORec.FindSet();

            //         if not AssorDetailsInseamRec.FINDSET() then
            //             Message('Cannot find size information for PO NO %1', "PO No.")
            //         else begin
            //             repeat
            //                 LineNo := 0;

            //                 if "Lot No." <> PORec."Lot No." then begin
            //                     //Delete Existing records                                    
            //                     AssorDetailsInseamNewRec.Reset();
            //                     AssorDetailsInseamNewRec.SetRange("Style No.", "Style No.");
            //                     AssorDetailsInseamNewRec.SetRange("Lot No.", PORec."Lot No.");
            //                     AssorDetailsInseamNewRec.DeleteAll();

            //                     repeat
            //                         //Add new record
            //                         LineNo += 10000;
            //                         AssorDetailsInseamNewRec.Init();
            //                         AssorDetailsInseamNewRec."Style No." := "Style No.";
            //                         AssorDetailsInseamNewRec."Lot No." := PORec."Lot No.";
            //                         AssorDetailsInseamNewRec."PO No." := PORec."PO No.";
            //                         AssorDetailsInseamNewRec."Line No." := LineNo;
            //                         AssorDetailsInseamNewRec."Com Size" := AssorDetailsInseamRec."Com Size";
            //                         AssorDetailsInseamNewRec.InSeam := AssorDetailsInseamRec.InSeam;
            //                         AssorDetailsInseamNewRec."GMT Size" := AssorDetailsInseamRec."GMT Size";
            //                         AssorDetailsInseamNewRec."Created User" := UserId;
            //                         AssorDetailsInseamNewRec."Created Date" := WorkDate();
            //                         AssorDetailsInseamNewRec.Insert();
            //                     until AssorDetailsInseamRec.Next() = 0;
            //                     AssorDetailsInseamRec.FindFirst();
            //                 end;
            //             until PORec.Next() = 0;
            //         end;


            //         /////////////////////Copying Country
            //         AssorDetailsRec.Reset();
            //         AssorDetailsRec.SetRange("Style No.", "Style No.");
            //         AssorDetailsRec.SetRange("lot No.", "lot No.");
            //         AssorDetailsRec.SetRange(Type, '2');

            //         PORec.Reset();
            //         PORec.SetRange("Style No.", "Style No.");
            //         PORec.FindSet();

            //         if not AssorDetailsRec.FINDSET() then
            //             Message('Cannot find country details for PO NO %1', "PO No.")
            //         else begin
            //             repeat
            //                 LineNo := 0;
            //                 if "Lot No." <> PORec."Lot No." then begin
            //                     //Delete Existing records                                    
            //                     AssorDetailsNewRec.Reset();
            //                     AssorDetailsNewRec.SetRange("Style No.", "Style No.");
            //                     AssorDetailsNewRec.SetRange("Lot No.", PORec."Lot No.");
            //                     AssorDetailsNewRec.SetRange(Type, '2');
            //                     AssorDetailsNewRec.DeleteAll();

            //                     repeat
            //                         //Add new record
            //                         LineNo += 10000;
            //                         AssorDetailsNewRec.Init();
            //                         AssorDetailsNewRec."Style No." := "Style No.";
            //                         AssorDetailsNewRec."PO No." := PORec."PO No.";
            //                         AssorDetailsNewRec."Lot No." := PORec."Lot No.";
            //                         AssorDetailsNewRec.Type := '2';
            //                         AssorDetailsNewRec."Line No." := LineNo;
            //                         AssorDetailsNewRec."Country Code" := AssorDetailsRec."Country Code";
            //                         AssorDetailsNewRec."Country Name" := AssorDetailsRec."Country Name";
            //                         AssorDetailsNewRec."Pack No" := AssorDetailsRec."Pack No";
            //                         AssorDetailsNewRec."Pack" := AssorDetailsRec."Pack";
            //                         AssorDetailsNewRec.Type := AssorDetailsRec.Type;
            //                         AssorDetailsNewRec."SID/REF No" := AssorDetailsRec."SID/REF No";
            //                         AssorDetailsNewRec."No Pack" := AssorDetailsRec."No Pack";
            //                         AssorDetailsNewRec.Qty := AssorDetailsRec.Qty;
            //                         AssorDetailsNewRec."Created User" := UserId;
            //                         AssorDetailsNewRec."Created Date" := WorkDate();
            //                         AssorDetailsNewRec.Insert();
            //                     until AssorDetailsRec.Next() = 0;
            //                     AssorDetailsRec.FindFirst();
            //                 end;
            //             until PORec.Next() = 0;
            //         end;


            //         Message('Size/Color/Country copied to all PO');
            //         CurrPage.Update();
            //     end;
            // }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        BOMRec: Record BOM;
        Style1Rec: Record "Style Master";
        AssorDetailsRec: Record AssortmentDetailsInseam;
        AssorColorSizeRatioRec: Record AssorColorSizeRatio;
        AssorColorSizeRatio1Rec: Record AssorColorSizeRatio;
        AssorColorSizeRatioView: Record AssorColorSizeRatioView;
        AssorColorSizeRatio1View: Record AssorColorSizeRatioView;
        AssorColorSizeRatioPriceRec: Record AssorColorSizeRatioPrice;
        AssorCardPage: page "Assortment Card";
        Confirm: Boolean;
        LotTemp: Code[20];
        Question: Text;
        Count: Integer;
        Col: Integer;
        Count1: Integer;
        Text: Label 'Quantity has been entered for the Size : %1 in LOT : %2 . Do you want to delete size from all POs.?';
    begin

        //Check for whether BOM created for the style
        BOMRec.SetRange("Style No.", rec."Style No.");
        if BOMRec.FindSet() then
            Error('Style %1 already assigned for the BOM %2 . You cannot delete sizes.', Style1Rec."Style No.", BOMRec.No)
        else begin

            ///////////Inform user about size usage in other POs
            AssorColorSizeRatioRec.Reset();
            AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
            AssorColorSizeRatioRec.SetCurrentKey("lot No.");
            AssorColorSizeRatioRec.SetFilter("Lot No.", '<>%1', rec."Lot No.");
            AssorColorSizeRatioRec.SetFilter("Colour Name", '=%1', '*');

            if AssorColorSizeRatioRec.FindSet() then begin
                repeat
                    FOR Count := 1 TO 64 DO begin
                        case Count of
                            1:
                                if AssorColorSizeRatioRec."1" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            2:
                                if AssorColorSizeRatioRec."2" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            3:
                                if AssorColorSizeRatioRec."3" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            4:
                                if AssorColorSizeRatioRec."4" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            5:
                                if AssorColorSizeRatioRec."5" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            6:
                                if AssorColorSizeRatioRec."6" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            7:
                                if AssorColorSizeRatioRec."7" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            8:
                                if AssorColorSizeRatioRec."8" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            9:
                                if AssorColorSizeRatioRec."9" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            10:
                                if AssorColorSizeRatioRec."10" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            11:
                                if AssorColorSizeRatioRec."11" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            12:
                                if AssorColorSizeRatioRec."12" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            13:
                                if AssorColorSizeRatioRec."13" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            14:
                                if AssorColorSizeRatioRec."14" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            15:
                                if AssorColorSizeRatioRec."15" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            16:
                                if AssorColorSizeRatioRec."16" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            17:
                                if AssorColorSizeRatioRec."17" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            18:
                                if AssorColorSizeRatioRec."18" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            19:
                                if AssorColorSizeRatioRec."19" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            20:
                                if AssorColorSizeRatioRec."20" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            21:
                                if AssorColorSizeRatioRec."21" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            22:
                                if AssorColorSizeRatioRec."22" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            23:
                                if AssorColorSizeRatioRec."23" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            24:
                                if AssorColorSizeRatioRec."24" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            25:
                                if AssorColorSizeRatioRec."25" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            26:
                                if AssorColorSizeRatioRec."26" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            27:
                                if AssorColorSizeRatioRec."27" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            28:
                                if AssorColorSizeRatioRec."28" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            29:
                                if AssorColorSizeRatioRec."29" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            30:
                                if AssorColorSizeRatioRec."30" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            31:
                                if AssorColorSizeRatioRec."31" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            32:
                                if AssorColorSizeRatioRec."32" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            33:
                                if AssorColorSizeRatioRec."33" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            34:
                                if AssorColorSizeRatioRec."34" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            35:
                                if AssorColorSizeRatioRec."35" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            36:
                                if AssorColorSizeRatioRec."36" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            37:
                                if AssorColorSizeRatioRec."37" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            38:
                                if AssorColorSizeRatioRec."38" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            39:
                                if AssorColorSizeRatioRec."39" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            40:
                                if AssorColorSizeRatioRec."40" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            41:
                                if AssorColorSizeRatioRec."41" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            42:
                                if AssorColorSizeRatioRec."42" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            43:
                                if AssorColorSizeRatioRec."43" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            44:
                                if AssorColorSizeRatioRec."44" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            45:
                                if AssorColorSizeRatioRec."45" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            46:
                                if AssorColorSizeRatioRec."46" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            47:
                                if AssorColorSizeRatioRec."47" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            48:
                                if AssorColorSizeRatioRec."48" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            49:
                                if AssorColorSizeRatioRec."49" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            50:
                                if AssorColorSizeRatioRec."50" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            51:
                                if AssorColorSizeRatioRec."51" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            52:
                                if AssorColorSizeRatioRec."52" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            53:
                                if AssorColorSizeRatioRec."53" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            54:
                                if AssorColorSizeRatioRec."54" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            55:
                                if AssorColorSizeRatioRec."55" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            56:
                                if AssorColorSizeRatioRec."56" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            57:
                                if AssorColorSizeRatioRec."57" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            58:
                                if AssorColorSizeRatioRec."58" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            59:
                                if AssorColorSizeRatioRec."59" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            60:
                                if AssorColorSizeRatioRec."60" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            61:
                                if AssorColorSizeRatioRec."61" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            62:
                                if AssorColorSizeRatioRec."62" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            63:
                                if AssorColorSizeRatioRec."63" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                            64:
                                if AssorColorSizeRatioRec."64" = rec."GMT Size" then begin
                                    LotTemp := AssorColorSizeRatioRec."Lot No.";
                                    break;
                                end;
                        end;
                    end;
                until AssorColorSizeRatioRec.Next() = 0;
            end;

            if LotTemp <> '' then begin
                Question := Text;
                if (Dialog.Confirm(Question, true, rec."GMT Size", LotTemp) = true) then
                    Confirm := true
                else
                    Confirm := false;
            end
            else begin

                if (Dialog.CONFIRM('"Do you want to delete size from all POs.?', true) = true) then
                    Confirm := true
                else
                    Confirm := false;
            end;


            /////////////////Delete from size TAB (Other POs)
            if Confirm = true then begin
                AssorDetailsRec.Reset();
                AssorDetailsRec.SetRange("Style No.", rec."Style No.");
                AssorDetailsRec.SetRange("GMT Size", rec."GMT Size");

                if AssorDetailsRec.FindSet() then
                    AssorDetailsRec.DeleteAll();
            end;


            ///////////////Delete size from size/ratio TAB
            //* rows
            AssorColorSizeRatioRec.Reset();
            AssorColorSizeRatioRec.SetRange("Style No.", rec."Style No.");
            AssorColorSizeRatioRec.SetFilter("Colour Name", '=%1', '*');

            if Confirm = false then
                AssorColorSizeRatioRec.SetRange("lot No.", rec."Lot No.");

            if AssorColorSizeRatioRec.FindSet() then begin
                repeat
                    col := 0;
                    FOR Count := 1 TO 64 DO begin
                        case Count of
                            1:
                                if AssorColorSizeRatioRec."1" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."1" := '';
                                    Col := Count;
                                    break;
                                end;
                            2:
                                if AssorColorSizeRatioRec."2" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."2" := '';
                                    Col := Count;
                                    break;
                                end;
                            3:
                                if AssorColorSizeRatioRec."3" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."3" := '';
                                    Col := Count;
                                    break;
                                end;
                            4:
                                if AssorColorSizeRatioRec."4" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."4" := '';
                                    Col := Count;
                                    break;
                                end;
                            5:
                                if AssorColorSizeRatioRec."5" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."5" := '';
                                    Col := Count;
                                    break;
                                end;
                            6:
                                if AssorColorSizeRatioRec."6" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."6" := '';
                                    Col := Count;
                                    break;
                                end;
                            7:
                                if AssorColorSizeRatioRec."7" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."7" := '';
                                    Col := Count;
                                    break;
                                end;
                            8:
                                if AssorColorSizeRatioRec."8" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."8" := '';
                                    Col := Count;
                                    break;
                                end;
                            9:
                                if AssorColorSizeRatioRec."9" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."9" := '';
                                    Col := Count;
                                    break;
                                end;
                            10:
                                if AssorColorSizeRatioRec."10" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."10" := '';
                                    Col := Count;
                                    break;
                                end;
                            11:
                                if AssorColorSizeRatioRec."11" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."11" := '';
                                    Col := Count;
                                    break;
                                end;
                            12:
                                if AssorColorSizeRatioRec."12" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."12" := '';
                                    Col := Count;
                                    break;
                                end;
                            13:
                                if AssorColorSizeRatioRec."13" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."13" := '';
                                    Col := Count;
                                    break;
                                end;
                            14:
                                if AssorColorSizeRatioRec."14" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."14" := '';
                                    Col := Count;
                                    break;
                                end;
                            15:
                                if AssorColorSizeRatioRec."15" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."15" := '';
                                    Col := Count;
                                    break;
                                end;
                            16:
                                if AssorColorSizeRatioRec."16" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."16" := '';
                                    Col := Count;
                                    break;
                                end;
                            17:
                                if AssorColorSizeRatioRec."17" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."17" := '';
                                    Col := Count;
                                    break;
                                end;
                            18:
                                if AssorColorSizeRatioRec."18" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."18" := '';
                                    Col := Count;
                                    break;
                                end;
                            19:
                                if AssorColorSizeRatioRec."19" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."19" := '';
                                    Col := Count;
                                    break;
                                end;
                            20:
                                if AssorColorSizeRatioRec."20" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."20" := '';
                                    Col := Count;
                                    break;
                                end;
                            21:
                                if AssorColorSizeRatioRec."21" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."21" := '';
                                    Col := Count;
                                    break;
                                end;
                            22:
                                if AssorColorSizeRatioRec."22" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."22" := '';
                                    Col := Count;
                                    break;
                                end;
                            23:
                                if AssorColorSizeRatioRec."23" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."23" := '';
                                    Col := Count;
                                    break;
                                end;
                            24:
                                if AssorColorSizeRatioRec."24" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."24" := '';
                                    Col := Count;
                                    break;
                                end;
                            25:
                                if AssorColorSizeRatioRec."25" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."25" := '';
                                    Col := Count;
                                    break;
                                end;
                            26:
                                if AssorColorSizeRatioRec."26" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."26" := '';
                                    Col := Count;
                                    break;
                                end;
                            27:
                                if AssorColorSizeRatioRec."27" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."27" := '';
                                    Col := Count;
                                    break;
                                end;
                            28:
                                if AssorColorSizeRatioRec."28" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."28" := '';
                                    Col := Count;
                                    break;
                                end;
                            29:
                                if AssorColorSizeRatioRec."29" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."29" := '';
                                    Col := Count;
                                    break;
                                end;
                            30:
                                if AssorColorSizeRatioRec."30" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."30" := '';
                                    Col := Count;
                                    break;
                                end;
                            31:
                                if AssorColorSizeRatioRec."31" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."31" := '';
                                    Col := Count;
                                    break;
                                end;
                            32:
                                if AssorColorSizeRatioRec."32" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."32" := '';
                                    Col := Count;
                                    break;
                                end;
                            33:
                                if AssorColorSizeRatioRec."33" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."33" := '';
                                    Col := Count;
                                    break;
                                end;
                            34:
                                if AssorColorSizeRatioRec."34" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."34" := '';
                                    Col := Count;
                                    break;
                                end;
                            35:
                                if AssorColorSizeRatioRec."35" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."35" := '';
                                    Col := Count;
                                    break;
                                end;
                            36:
                                if AssorColorSizeRatioRec."36" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."36" := '';
                                    Col := Count;
                                    break;
                                end;
                            37:
                                if AssorColorSizeRatioRec."37" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."37" := '';
                                    Col := Count;
                                    break;
                                end;
                            38:
                                if AssorColorSizeRatioRec."38" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."38" := '';
                                    Col := Count;
                                    break;
                                end;
                            39:
                                if AssorColorSizeRatioRec."39" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."39" := '';
                                    Col := Count;
                                    break;
                                end;
                            40:
                                if AssorColorSizeRatioRec."40" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."40" := '';
                                    Col := Count;
                                    break;
                                end;
                            41:
                                if AssorColorSizeRatioRec."41" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."41" := '';
                                    Col := Count;
                                    break;
                                end;
                            42:
                                if AssorColorSizeRatioRec."42" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."42" := '';
                                    Col := Count;
                                    break;
                                end;
                            43:
                                if AssorColorSizeRatioRec."43" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."43" := '';
                                    Col := Count;
                                    break;
                                end;
                            44:
                                if AssorColorSizeRatioRec."44" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."44" := '';
                                    Col := Count;
                                    break;
                                end;
                            45:
                                if AssorColorSizeRatioRec."45" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."45" := '';
                                    Col := Count;
                                    break;
                                end;
                            46:
                                if AssorColorSizeRatioRec."46" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."46" := '';
                                    Col := Count;
                                    break;
                                end;
                            47:
                                if AssorColorSizeRatioRec."47" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."47" := '';
                                    Col := Count;
                                    break;
                                end;
                            48:
                                if AssorColorSizeRatioRec."48" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."48" := '';
                                    Col := Count;
                                    break;
                                end;
                            49:
                                if AssorColorSizeRatioRec."49" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."49" := '';
                                    Col := Count;
                                    break;
                                end;
                            50:
                                if AssorColorSizeRatioRec."50" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."50" := '';
                                    Col := Count;
                                    break;
                                end;
                            51:
                                if AssorColorSizeRatioRec."51" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."51" := '';
                                    Col := Count;
                                    break;
                                end;
                            52:
                                if AssorColorSizeRatioRec."52" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."52" := '';
                                    Col := Count;
                                    break;
                                end;
                            53:
                                if AssorColorSizeRatioRec."53" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."53" := '';
                                    Col := Count;
                                    break;
                                end;
                            54:
                                if AssorColorSizeRatioRec."54" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."54" := '';
                                    Col := Count;
                                    break;
                                end;
                            55:
                                if AssorColorSizeRatioRec."55" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."55" := '';
                                    Col := Count;
                                    break;
                                end;
                            56:
                                if AssorColorSizeRatioRec."56" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."56" := '';
                                    Col := Count;
                                    break;
                                end;
                            57:
                                if AssorColorSizeRatioRec."57" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."57" := '';
                                    Col := Count;
                                    break;
                                end;
                            58:
                                if AssorColorSizeRatioRec."58" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."58" := '';
                                    Col := Count;
                                    break;
                                end;
                            59:
                                if AssorColorSizeRatioRec."59" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."59" := '';
                                    Col := Count;
                                    break;
                                end;
                            60:
                                if AssorColorSizeRatioRec."60" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."60" := '';
                                    Col := Count;
                                    break;
                                end;
                            61:
                                if AssorColorSizeRatioRec."61" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."61" := '';
                                    Col := Count;
                                    break;
                                end;
                            62:
                                if AssorColorSizeRatioRec."62" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."62" := '';
                                    Col := Count;
                                    break;
                                end;
                            63:
                                if AssorColorSizeRatioRec."63" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."63" := '';
                                    Col := Count;
                                    break;
                                end;
                            64:
                                if AssorColorSizeRatioRec."64" = rec."GMT Size" then begin
                                    AssorColorSizeRatioRec."64" := '';
                                    Col := Count;
                                    break;
                                end;
                        end;

                        if Col <> 0 then
                            break;
                    end;

                    //Color rows
                    AssorColorSizeRatio1Rec.Reset();
                    AssorColorSizeRatio1Rec.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatio1Rec.SetFilter("Colour Name", '<>%1', '*');
                    AssorColorSizeRatio1Rec.SetRange("lot No.", AssorColorSizeRatioRec."Lot No.");
                    if AssorColorSizeRatio1Rec.FindSet() then begin

                        repeat
                            FOR Count1 := 1 TO 64 DO begin
                                case Count1 of
                                    1:
                                        if Count1 = Col then begin
                                            AssorColorSizeRatio1Rec."1" := '0';
                                            break;
                                        end;
                                    2:
                                        if Count1 = Col then begin
                                            AssorColorSizeRatio1Rec."2" := '0';
                                            break;
                                        end;
                                    3:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."3" := '0';
                                            break;
                                        end;
                                    4:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."4" := '0';
                                            break;
                                        end;
                                    5:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."5" := '0';
                                            break;
                                        end;
                                    6:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."6" := '0';
                                            break;
                                        end;
                                    7:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."7" := '0';
                                            break;
                                        end;
                                    8:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."8" := '0';
                                            break;
                                        end;
                                    9:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."9" := '0';
                                            break;
                                        end;
                                    10:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."10" := '0';
                                            break;
                                        end;
                                    11:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."11" := '0';
                                            break;
                                        end;
                                    12:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."12" := '0';
                                            break;
                                        end;
                                    13:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."13" := '0';
                                            break;
                                        end;
                                    14:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."14" := '0';
                                            break;
                                        end;
                                    15:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."15" := '0';
                                            break;
                                        end;
                                    16:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."16" := '0';
                                            break;
                                        end;
                                    17:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."17" := '0';
                                            break;
                                        end;
                                    18:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."18" := '0';
                                            break;
                                        end;
                                    19:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."19" := '0';
                                            break;
                                        end;
                                    20:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."20" := '0';
                                            break;
                                        end;
                                    21:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."21" := '0';
                                            break;
                                        end;
                                    22:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."22" := '0';
                                            break;
                                        end;
                                    23:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."23" := '0';
                                            break;
                                        end;
                                    24:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."24" := '0';
                                            break;
                                        end;
                                    25:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."25" := '0';
                                            break;
                                        end;
                                    26:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."26" := '0';
                                            break;
                                        end;
                                    27:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."27" := '0';
                                            break;
                                        end;
                                    28:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."28" := '0';
                                            break;
                                        end;
                                    29:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."29" := '0';
                                            break;
                                        end;
                                    30:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."30" := '0';
                                            break;
                                        end;
                                    31:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."31" := '0';
                                            break;
                                        end;
                                    32:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."32" := '0';
                                            break;
                                        end;
                                    33:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."33" := '0';
                                            break;
                                        end;
                                    34:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."34" := '0';
                                            break;
                                        end;
                                    35:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."35" := '0';
                                            break;
                                        end;
                                    36:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."36" := '0';
                                            break;
                                        end;
                                    37:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."37" := '0';
                                            break;
                                        end;
                                    38:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."38" := '0';
                                            break;
                                        end;
                                    39:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."39" := '0';
                                            break;
                                        end;
                                    40:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."40" := '0';
                                            break;
                                        end;
                                    41:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."41" := '0';
                                            break;
                                        end;
                                    42:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."42" := '0';
                                            break;
                                        end;
                                    43:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."43" := '0';
                                            break;
                                        end;
                                    44:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."44" := '0';
                                            break;
                                        end;
                                    45:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."45" := '0';
                                            break;
                                        end;
                                    46:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."46" := '0';
                                            break;
                                        end;
                                    47:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."47" := '0';
                                            break;
                                        end;
                                    48:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."48" := '0';
                                            break;
                                        end;
                                    49:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."49" := '0';
                                            break;
                                        end;
                                    50:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."50" := '0';
                                            break;
                                        end;
                                    51:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."51" := '0';
                                            break;
                                        end;
                                    52:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."52" := '0';
                                            break;
                                        end;
                                    53:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."53" := '0';
                                            break;
                                        end;
                                    54:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."54" := '0';
                                            break;
                                        end;
                                    55:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."55" := '0';
                                            break;
                                        end;
                                    56:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."56" := '0';
                                            break;
                                        end;
                                    57:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."57" := '0';
                                            break;
                                        end;
                                    58:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."58" := '0';
                                            break;
                                        end;
                                    59:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."59" := '0';
                                            break;
                                        end;
                                    60:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."60" := '0';
                                            break;
                                        end;
                                    61:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."61" := '0';
                                            break;
                                        end;
                                    62:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."62" := '0';
                                            break;
                                        end;
                                    63:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."63" := '0';
                                            break;
                                        end;
                                    64:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1Rec."64" := '0';
                                            break;
                                        end;
                                end;
                            end;
                            AssorColorSizeRatio1Rec.Modify();

                            //Calculate Total
                            AssorColorSizeRatio1Rec.Total := CalTotal(AssorColorSizeRatio1Rec."Colour Name");
                            AssorColorSizeRatio1Rec.Modify();

                        until AssorColorSizeRatio1Rec.Next() = 0;

                    end;

                    AssorColorSizeRatioRec.Modify();
                until AssorColorSizeRatioRec.Next() = 0;
            end;



            /////////////////////////Delete size from Quantity breakdown TAB
            //* rows
            AssorColorSizeRatioView.Reset();
            AssorColorSizeRatioView.SetRange("Style No.", rec."Style No.");
            AssorColorSizeRatioView.SetFilter("Colour Name", '=%1', '*');

            if Confirm = false then
                AssorColorSizeRatioView.SetRange("lot No.", rec."Lot No.");

            if AssorColorSizeRatioView.FindSet() then begin
                repeat
                    col := 0;
                    FOR Count := 1 TO 64 DO begin
                        case Count of
                            1:
                                if AssorColorSizeRatioView."1" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."1" := '';
                                    Col := Count;
                                    break;
                                end;
                            2:
                                if AssorColorSizeRatioView."2" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."2" := '';
                                    Col := Count;
                                    break;
                                end;
                            3:
                                if AssorColorSizeRatioView."3" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."3" := '';
                                    Col := Count;
                                    break;
                                end;
                            4:
                                if AssorColorSizeRatioView."4" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."4" := '';
                                    Col := Count;
                                    break;
                                end;
                            5:
                                if AssorColorSizeRatioView."5" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."5" := '';
                                    Col := Count;
                                    break;
                                end;
                            6:
                                if AssorColorSizeRatioView."6" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."6" := '';
                                    Col := Count;
                                    break;
                                end;
                            7:
                                if AssorColorSizeRatioView."7" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."7" := '';
                                    Col := Count;
                                    break;
                                end;
                            8:
                                if AssorColorSizeRatioView."8" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."8" := '';
                                    Col := Count;
                                    break;
                                end;
                            9:
                                if AssorColorSizeRatioView."9" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."9" := '';
                                    Col := Count;
                                    break;
                                end;
                            10:
                                if AssorColorSizeRatioView."10" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."10" := '';
                                    Col := Count;
                                    break;
                                end;
                            11:
                                if AssorColorSizeRatioView."11" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."11" := '';
                                    Col := Count;
                                    break;
                                end;
                            12:
                                if AssorColorSizeRatioView."12" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."12" := '';
                                    Col := Count;
                                    break;
                                end;
                            13:
                                if AssorColorSizeRatioView."13" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."13" := '';
                                    Col := Count;
                                    break;
                                end;
                            14:
                                if AssorColorSizeRatioView."14" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."14" := '';
                                    Col := Count;
                                    break;
                                end;
                            15:
                                if AssorColorSizeRatioView."15" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."15" := '';
                                    Col := Count;
                                    break;
                                end;
                            16:
                                if AssorColorSizeRatioView."16" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."16" := '';
                                    Col := Count;
                                    break;
                                end;
                            17:
                                if AssorColorSizeRatioView."17" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."17" := '';
                                    Col := Count;
                                    break;
                                end;
                            18:
                                if AssorColorSizeRatioView."18" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."18" := '';
                                    Col := Count;
                                    break;
                                end;
                            19:
                                if AssorColorSizeRatioView."19" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."19" := '';
                                    Col := Count;
                                    break;
                                end;
                            20:
                                if AssorColorSizeRatioView."20" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."20" := '';
                                    Col := Count;
                                    break;
                                end;
                            21:
                                if AssorColorSizeRatioView."21" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."21" := '';
                                    Col := Count;
                                    break;
                                end;
                            22:
                                if AssorColorSizeRatioView."22" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."22" := '';
                                    Col := Count;
                                    break;
                                end;
                            23:
                                if AssorColorSizeRatioView."23" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."23" := '';
                                    Col := Count;
                                    break;
                                end;
                            24:
                                if AssorColorSizeRatioView."24" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."24" := '';
                                    Col := Count;
                                    break;
                                end;
                            25:
                                if AssorColorSizeRatioView."25" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."25" := '';
                                    Col := Count;
                                    break;
                                end;
                            26:
                                if AssorColorSizeRatioView."26" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."26" := '';
                                    Col := Count;
                                    break;
                                end;
                            27:
                                if AssorColorSizeRatioView."27" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."27" := '';
                                    Col := Count;
                                    break;
                                end;
                            28:
                                if AssorColorSizeRatioView."28" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."28" := '';
                                    Col := Count;
                                    break;
                                end;
                            29:
                                if AssorColorSizeRatioView."29" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."29" := '';
                                    Col := Count;
                                    break;
                                end;
                            30:
                                if AssorColorSizeRatioView."30" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."30" := '';
                                    Col := Count;
                                    break;
                                end;
                            31:
                                if AssorColorSizeRatioView."31" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."31" := '';
                                    Col := Count;
                                    break;
                                end;
                            32:
                                if AssorColorSizeRatioView."32" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."32" := '';
                                    Col := Count;
                                    break;
                                end;
                            33:
                                if AssorColorSizeRatioView."33" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."33" := '';
                                    Col := Count;
                                    break;
                                end;
                            34:
                                if AssorColorSizeRatioView."34" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."34" := '';
                                    Col := Count;
                                    break;
                                end;
                            35:
                                if AssorColorSizeRatioView."35" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."35" := '';
                                    Col := Count;
                                    break;
                                end;
                            36:
                                if AssorColorSizeRatioView."36" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."36" := '';
                                    Col := Count;
                                    break;
                                end;
                            37:
                                if AssorColorSizeRatioView."37" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."37" := '';
                                    Col := Count;
                                    break;
                                end;
                            38:
                                if AssorColorSizeRatioView."38" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."38" := '';
                                    Col := Count;
                                    break;
                                end;
                            39:
                                if AssorColorSizeRatioView."39" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."39" := '';
                                    Col := Count;
                                    break;
                                end;
                            40:
                                if AssorColorSizeRatioView."40" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."40" := '';
                                    Col := Count;
                                    break;
                                end;
                            41:
                                if AssorColorSizeRatioView."41" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."41" := '';
                                    Col := Count;
                                    break;
                                end;
                            42:
                                if AssorColorSizeRatioView."42" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."42" := '';
                                    Col := Count;
                                    break;
                                end;
                            43:
                                if AssorColorSizeRatioView."43" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."43" := '';
                                    Col := Count;
                                    break;
                                end;
                            44:
                                if AssorColorSizeRatioView."44" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."44" := '';
                                    Col := Count;
                                    break;
                                end;
                            45:
                                if AssorColorSizeRatioView."45" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."45" := '';
                                    Col := Count;
                                    break;
                                end;
                            46:
                                if AssorColorSizeRatioView."46" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."46" := '';
                                    Col := Count;
                                    break;
                                end;
                            47:
                                if AssorColorSizeRatioView."47" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."47" := '';
                                    Col := Count;
                                    break;
                                end;
                            48:
                                if AssorColorSizeRatioView."48" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."48" := '';
                                    Col := Count;
                                    break;
                                end;
                            49:
                                if AssorColorSizeRatioView."49" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."49" := '';
                                    Col := Count;
                                    break;
                                end;
                            50:
                                if AssorColorSizeRatioView."50" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."50" := '';
                                    Col := Count;
                                    break;
                                end;
                            51:
                                if AssorColorSizeRatioView."51" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."51" := '';
                                    Col := Count;
                                    break;
                                end;
                            52:
                                if AssorColorSizeRatioView."52" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."52" := '';
                                    Col := Count;
                                    break;
                                end;
                            53:
                                if AssorColorSizeRatioView."53" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."53" := '';
                                    Col := Count;
                                    break;
                                end;
                            54:
                                if AssorColorSizeRatioView."54" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."54" := '';
                                    Col := Count;
                                    break;
                                end;
                            55:
                                if AssorColorSizeRatioView."55" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."55" := '';
                                    Col := Count;
                                    break;
                                end;
                            56:
                                if AssorColorSizeRatioView."56" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."56" := '';
                                    Col := Count;
                                    break;
                                end;
                            57:
                                if AssorColorSizeRatioView."57" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."57" := '';
                                    Col := Count;
                                    break;
                                end;
                            58:
                                if AssorColorSizeRatioView."58" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."58" := '';
                                    Col := Count;
                                    break;
                                end;
                            59:
                                if AssorColorSizeRatioView."59" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."59" := '';
                                    Col := Count;
                                    break;
                                end;
                            60:
                                if AssorColorSizeRatioView."60" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."60" := '';
                                    Col := Count;
                                    break;
                                end;
                            61:
                                if AssorColorSizeRatioView."61" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."61" := '';
                                    Col := Count;
                                    break;
                                end;
                            62:
                                if AssorColorSizeRatioView."62" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."62" := '';
                                    Col := Count;
                                    break;
                                end;
                            63:
                                if AssorColorSizeRatioView."63" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."63" := '';
                                    Col := Count;
                                    break;
                                end;
                            64:
                                if AssorColorSizeRatioView."64" = rec."GMT Size" then begin
                                    AssorColorSizeRatioView."64" := '';
                                    Col := Count;
                                    break;
                                end;
                        end;

                        if Col <> 0 then
                            break;
                    end;

                    //Color rows
                    AssorColorSizeRatio1View.Reset();
                    AssorColorSizeRatio1View.SetRange("Style No.", rec."Style No.");
                    AssorColorSizeRatio1View.SetFilter("Colour Name", '<>%1', '*');
                    AssorColorSizeRatio1View.SetRange("lot No.", AssorColorSizeRatioView."Lot No.");
                    if AssorColorSizeRatio1View.FindSet() then begin

                        repeat
                            FOR Count1 := 1 TO 64 DO begin
                                case Count1 of
                                    1:
                                        if Count1 = Col then begin
                                            AssorColorSizeRatio1View."1" := '0';
                                            break;
                                        end;
                                    2:
                                        if Count1 = Col then begin
                                            AssorColorSizeRatio1View."2" := '0';
                                            break;
                                        end;
                                    3:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."3" := '0';
                                            break;
                                        end;
                                    4:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."4" := '0';
                                            break;
                                        end;
                                    5:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."5" := '0';
                                            break;
                                        end;
                                    6:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."6" := '0';
                                            break;
                                        end;
                                    7:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."7" := '0';
                                            break;
                                        end;
                                    8:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."8" := '0';
                                            break;
                                        end;
                                    9:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."9" := '0';
                                            break;
                                        end;
                                    10:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."10" := '0';
                                            break;
                                        end;
                                    11:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."11" := '0';
                                            break;
                                        end;
                                    12:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."12" := '0';
                                            break;
                                        end;
                                    13:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."13" := '0';
                                            break;
                                        end;
                                    14:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."14" := '0';
                                            break;
                                        end;
                                    15:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."15" := '0';
                                            break;
                                        end;
                                    16:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."16" := '0';
                                            break;
                                        end;
                                    17:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."17" := '0';
                                            break;
                                        end;
                                    18:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."18" := '0';
                                            break;
                                        end;
                                    19:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."19" := '0';
                                            break;
                                        end;
                                    20:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."20" := '0';
                                            break;
                                        end;
                                    21:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."21" := '0';
                                            break;
                                        end;
                                    22:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."22" := '0';
                                            break;
                                        end;
                                    23:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."23" := '0';
                                            break;
                                        end;
                                    24:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."24" := '0';
                                            break;
                                        end;
                                    25:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."25" := '0';
                                            break;
                                        end;
                                    26:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."26" := '0';
                                            break;
                                        end;
                                    27:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."27" := '0';
                                            break;
                                        end;
                                    28:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."28" := '0';
                                            break;
                                        end;
                                    29:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."29" := '0';
                                            break;
                                        end;
                                    30:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."30" := '0';
                                            break;
                                        end;
                                    31:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."31" := '0';
                                            break;
                                        end;
                                    32:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."32" := '0';
                                            break;
                                        end;
                                    33:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."33" := '0';
                                            break;
                                        end;
                                    34:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."34" := '0';
                                            break;
                                        end;
                                    35:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."35" := '0';
                                            break;
                                        end;
                                    36:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."36" := '0';
                                            break;
                                        end;
                                    37:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."37" := '0';
                                            break;
                                        end;
                                    38:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."38" := '0';
                                            break;
                                        end;
                                    39:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."39" := '0';
                                            break;
                                        end;
                                    40:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."40" := '0';
                                            break;
                                        end;
                                    41:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."41" := '0';
                                            break;
                                        end;
                                    42:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."42" := '0';
                                            break;
                                        end;
                                    43:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."43" := '0';
                                            break;
                                        end;
                                    44:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."44" := '0';
                                            break;
                                        end;
                                    45:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."45" := '0';
                                            break;
                                        end;
                                    46:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."46" := '0';
                                            break;
                                        end;
                                    47:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."47" := '0';
                                            break;
                                        end;
                                    48:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."48" := '0';
                                            break;
                                        end;
                                    49:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."49" := '0';
                                            break;
                                        end;
                                    50:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."50" := '0';
                                            break;
                                        end;
                                    51:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."51" := '0';
                                            break;
                                        end;
                                    52:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."52" := '0';
                                            break;
                                        end;
                                    53:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."53" := '0';
                                            break;
                                        end;
                                    54:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."54" := '0';
                                            break;
                                        end;
                                    55:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."55" := '0';
                                            break;
                                        end;
                                    56:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."56" := '0';
                                            break;
                                        end;
                                    57:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."57" := '0';
                                            break;
                                        end;
                                    58:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."58" := '0';
                                            break;
                                        end;
                                    59:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."59" := '0';
                                            break;
                                        end;
                                    60:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."60" := '0';
                                            break;
                                        end;
                                    61:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."61" := '0';
                                            break;
                                        end;
                                    62:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."62" := '0';
                                            break;
                                        end;
                                    63:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."63" := '0';
                                            break;
                                        end;
                                    64:
                                        if Count1 = Count then begin
                                            AssorColorSizeRatio1View."64" := '0';
                                            break;
                                        end;
                                end;
                            end;
                            AssorColorSizeRatio1View.Modify();

                            //Calculate Total
                            AssorColorSizeRatio1View.Total := CalTotal(AssorColorSizeRatio1View."Colour Name");
                            AssorColorSizeRatio1View.Modify();

                        until AssorColorSizeRatio1View.Next() = 0;

                    end;

                    AssorColorSizeRatioView.Modify();
                until AssorColorSizeRatioView.Next() = 0;
            end;



            ///////////////Delete size from wise price TAB
            AssorColorSizeRatioPriceRec.Reset();
            AssorColorSizeRatioPriceRec.SetRange("Style No.", rec."Style No.");
            AssorColorSizeRatioPriceRec.SetFilter("Colour Name", '=%1', '*');

            if Confirm = false then
                AssorColorSizeRatioPriceRec.SetRange("lot No.", rec."Lot No.");

            if AssorColorSizeRatioPriceRec.FindSet() then begin
                repeat
                    FOR Count := 1 TO 64 DO begin
                        case Count of
                            1:
                                if AssorColorSizeRatioPriceRec."1" = rec."GMT Size" then begin
                                    AssorColorSizeRatioPriceRec."1" := '';
                                    break;
                                end;
                            2:
                                if AssorColorSizeRatioPriceRec."2" = rec."GMT Size" then begin
                                    AssorColorSizeRatioPriceRec."2" := '';
                                    break;
                                end;
                            3:
                                if AssorColorSizeRatioPriceRec."3" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."3" := '';
                                    break;
                                end;
                            4:
                                if AssorColorSizeRatioPriceRec."4" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."4" := '';
                                    break;
                                end;
                            5:
                                if AssorColorSizeRatioPriceRec."5" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."5" := '';
                                    break;
                                end;
                            6:
                                if AssorColorSizeRatioPriceRec."6" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."6" := '';
                                    break;
                                end;
                            7:
                                if AssorColorSizeRatioPriceRec."7" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."7" := '';
                                    break;
                                end;
                            8:
                                if AssorColorSizeRatioPriceRec."8" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."8" := '';
                                    break;
                                end;
                            9:
                                if AssorColorSizeRatioPriceRec."9" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."9" := '';
                                    break;
                                end;
                            10:
                                if AssorColorSizeRatioPriceRec."10" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."10" := '';
                                    break;
                                end;
                            11:
                                if AssorColorSizeRatioPriceRec."11" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."11" := '';
                                    break;
                                end;
                            12:
                                if AssorColorSizeRatioPriceRec."12" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."12" := '';
                                    break;
                                end;
                            13:
                                if AssorColorSizeRatioPriceRec."13" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."13" := '';
                                    break;
                                end;
                            14:
                                if AssorColorSizeRatioPriceRec."14" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."14" := '';
                                    break;
                                end;
                            15:
                                if AssorColorSizeRatioPriceRec."15" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."15" := '';
                                    break;
                                end;
                            16:
                                if AssorColorSizeRatioPriceRec."16" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."16" := '';
                                    break;
                                end;
                            17:
                                if AssorColorSizeRatioPriceRec."17" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."17" := '';
                                    break;
                                end;
                            18:
                                if AssorColorSizeRatioPriceRec."18" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."18" := '';
                                    break;
                                end;
                            19:
                                if AssorColorSizeRatioPriceRec."19" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."19" := '';
                                    break;
                                end;
                            20:
                                if AssorColorSizeRatioPriceRec."20" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."20" := '';
                                    break;
                                end;
                            21:
                                if AssorColorSizeRatioPriceRec."21" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."21" := '';
                                    break;
                                end;
                            22:
                                if AssorColorSizeRatioPriceRec."22" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."22" := '';
                                    break;
                                end;
                            23:
                                if AssorColorSizeRatioPriceRec."23" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."23" := '';
                                    break;
                                end;
                            24:
                                if AssorColorSizeRatioPriceRec."24" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."24" := '';
                                    break;
                                end;
                            25:
                                if AssorColorSizeRatioPriceRec."25" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."25" := '';
                                    break;
                                end;
                            26:
                                if AssorColorSizeRatioPriceRec."26" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."26" := '';
                                    break;
                                end;
                            27:
                                if AssorColorSizeRatioPriceRec."27" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."27" := '';
                                    break;
                                end;
                            28:
                                if AssorColorSizeRatioPriceRec."28" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."28" := '';
                                    break;
                                end;
                            29:
                                if AssorColorSizeRatioPriceRec."29" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."29" := '';
                                    break;
                                end;
                            30:
                                if AssorColorSizeRatioPriceRec."30" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."30" := '';
                                    break;
                                end;
                            31:
                                if AssorColorSizeRatioPriceRec."31" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."31" := '';
                                    break;
                                end;
                            32:
                                if AssorColorSizeRatioPriceRec."32" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."32" := '';
                                    break;
                                end;
                            33:
                                if AssorColorSizeRatioPriceRec."33" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."33" := '';
                                    break;
                                end;
                            34:
                                if AssorColorSizeRatioPriceRec."34" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."34" := '';
                                    break;
                                end;
                            35:
                                if AssorColorSizeRatioPriceRec."35" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."35" := '';
                                    break;
                                end;
                            36:
                                if AssorColorSizeRatioPriceRec."36" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."36" := '';
                                    break;
                                end;
                            37:
                                if AssorColorSizeRatioPriceRec."37" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."37" := '';
                                    break;
                                end;
                            38:
                                if AssorColorSizeRatioPriceRec."38" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."38" := '';
                                    break;
                                end;
                            39:
                                if AssorColorSizeRatioPriceRec."39" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."39" := '';
                                    break;
                                end;
                            40:
                                if AssorColorSizeRatioPriceRec."40" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."40" := '';
                                    break;
                                end;
                            41:
                                if AssorColorSizeRatioPriceRec."41" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."41" := '';
                                    break;
                                end;
                            42:
                                if AssorColorSizeRatioPriceRec."42" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."42" := '';
                                    break;
                                end;
                            43:
                                if AssorColorSizeRatioPriceRec."43" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."43" := '';
                                    break;
                                end;
                            44:
                                if AssorColorSizeRatioPriceRec."44" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."44" := '';
                                    break;
                                end;
                            45:
                                if AssorColorSizeRatioPriceRec."45" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."45" := '';
                                    break;
                                end;
                            46:
                                if AssorColorSizeRatioPriceRec."46" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."46" := '';
                                    break;
                                end;
                            47:
                                if AssorColorSizeRatioPriceRec."47" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."47" := '';
                                    break;
                                end;
                            48:
                                if AssorColorSizeRatioPriceRec."48" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."48" := '';
                                    break;
                                end;
                            49:
                                if AssorColorSizeRatioPriceRec."49" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."49" := '';
                                    break;
                                end;
                            50:
                                if AssorColorSizeRatioPriceRec."50" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."50" := '';
                                    break;
                                end;
                            51:
                                if AssorColorSizeRatioPriceRec."51" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."51" := '';
                                    break;
                                end;
                            52:
                                if AssorColorSizeRatioPriceRec."52" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."52" := '';
                                    break;
                                end;
                            53:
                                if AssorColorSizeRatioPriceRec."53" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."53" := '';
                                    break;
                                end;
                            54:
                                if AssorColorSizeRatioPriceRec."54" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."54" := '';
                                    break;
                                end;
                            55:
                                if AssorColorSizeRatioPriceRec."55" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."55" := '';
                                    break;
                                end;
                            56:
                                if AssorColorSizeRatioPriceRec."56" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."56" := '';
                                    break;
                                end;
                            57:
                                if AssorColorSizeRatioPriceRec."57" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."57" := '';
                                    break;
                                end;
                            58:
                                if AssorColorSizeRatioPriceRec."58" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."58" := '';
                                    break;
                                end;
                            59:
                                if AssorColorSizeRatioPriceRec."59" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."59" := '';
                                    break;
                                end;
                            60:
                                if AssorColorSizeRatioPriceRec."60" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."60" := '';
                                    break;
                                end;
                            61:
                                if AssorColorSizeRatioPriceRec."61" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."61" := '';
                                    break;
                                end;
                            62:
                                if AssorColorSizeRatioPriceRec."62" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."62" := '';
                                    break;
                                end;
                            63:
                                if AssorColorSizeRatioPriceRec."63" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."63" := '';
                                    break;
                                end;
                            64:
                                if AssorColorSizeRatioPriceRec."64" = rec."GMT Size" then begin

                                    AssorColorSizeRatioPriceRec."64" := '';
                                    break;
                                end;
                        end;
                    end;

                    AssorColorSizeRatioPriceRec.Modify();
                until AssorColorSizeRatioPriceRec.Next() = 0;
            end;

            //CurrPage.Update();
            //AssorCardPage.xxx();
            exit(true);
        end;
    end;

    procedure CalTotal(ColourName: Text[50]): BigInteger
    var
        Count: Integer;
        Number: Integer;
        Total: BigInteger;
        Tot: Integer;
        TotalLine: Integer;
        TotalLine1: Integer;
        StyleMasterPORec: Record "Style Master PO";
        AssoRec: Record AssorColorSizeRatio;
    begin

        CurrPage.Update();
        AssoRec.Reset();
        AssoRec.SetRange("Style No.", rec."Style No.");
        AssoRec.SetRange("lot No.", rec."lot No.");
        AssoRec.SetFilter("Colour Name", '<>%1', '*');
        if AssoRec.FindSet() then begin
            repeat
                //if AssoRec."Colour Name" <> '*' then begin
                TotalLine := 0;
                for Count := 1 To 64 do begin
                    case Count of
                        1:
                            if AssoRec."1" <> '' then
                                Evaluate(Number, AssoRec."1")
                            else
                                Number := 0;
                        2:
                            if AssoRec."2" <> '' then
                                Evaluate(Number, AssoRec."2")
                            else
                                Number := 0;
                        3:
                            if AssoRec."3" <> '' then
                                Evaluate(Number, AssoRec."3")
                            else
                                Number := 0;
                        4:
                            if AssoRec."4" <> '' then
                                Evaluate(Number, AssoRec."4")
                            else
                                Number := 0;
                        5:
                            if AssoRec."5" <> '' then
                                Evaluate(Number, AssoRec."5")
                            else
                                Number := 0;
                        6:
                            if AssoRec."6" <> '' then
                                Evaluate(Number, AssoRec."6")
                            else
                                Number := 0;
                        7:
                            if AssoRec."7" <> '' then
                                Evaluate(Number, AssoRec."7")
                            else
                                Number := 0;
                        8:
                            if AssoRec."8" <> '' then
                                Evaluate(Number, AssoRec."8")
                            else
                                Number := 0;
                        9:
                            if AssoRec."9" <> '' then
                                Evaluate(Number, AssoRec."9")
                            else
                                Number := 0;
                        10:
                            if AssoRec."10" <> '' then
                                Evaluate(Number, AssoRec."10")
                            else
                                Number := 0;
                        11:
                            if AssoRec."11" <> '' then
                                Evaluate(Number, AssoRec."11")
                            else
                                Number := 0;
                        12:
                            if AssoRec."12" <> '' then
                                Evaluate(Number, AssoRec."12")
                            else
                                Number := 0;
                        13:
                            if AssoRec."13" <> '' then
                                Evaluate(Number, AssoRec."13")
                            else
                                Number := 0;
                        14:
                            if AssoRec."14" <> '' then
                                Evaluate(Number, AssoRec."14")
                            else
                                Number := 0;
                        15:
                            if AssoRec."15" <> '' then
                                Evaluate(Number, AssoRec."15")
                            else
                                Number := 0;
                        16:
                            if AssoRec."16" <> '' then
                                Evaluate(Number, AssoRec."16")
                            else
                                Number := 0;
                        17:
                            if AssoRec."17" <> '' then
                                Evaluate(Number, AssoRec."17")
                            else
                                Number := 0;
                        18:
                            if AssoRec."18" <> '' then
                                Evaluate(Number, AssoRec."18")
                            else
                                Number := 0;
                        19:
                            if AssoRec."19" <> '' then
                                Evaluate(Number, AssoRec."19")
                            else
                                Number := 0;
                        20:
                            if AssoRec."20" <> '' then
                                Evaluate(Number, AssoRec."20")
                            else
                                Number := 0;
                        21:
                            if AssoRec."21" <> '' then
                                Evaluate(Number, AssoRec."21")
                            else
                                Number := 0;
                        22:
                            if AssoRec."22" <> '' then
                                Evaluate(Number, AssoRec."22")
                            else
                                Number := 0;
                        23:
                            if AssoRec."23" <> '' then
                                Evaluate(Number, AssoRec."23")
                            else
                                Number := 0;
                        24:
                            if AssoRec."24" <> '' then
                                Evaluate(Number, AssoRec."24")
                            else
                                Number := 0;
                        25:
                            if AssoRec."25" <> '' then
                                Evaluate(Number, AssoRec."25")
                            else
                                Number := 0;
                        26:
                            if AssoRec."26" <> '' then
                                Evaluate(Number, AssoRec."26")
                            else
                                Number := 0;
                        27:
                            if AssoRec."27" <> '' then
                                Evaluate(Number, AssoRec."27")
                            else
                                Number := 0;
                        28:
                            if AssoRec."28" <> '' then
                                Evaluate(Number, AssoRec."28")
                            else
                                Number := 0;
                        29:
                            if AssoRec."29" <> '' then
                                Evaluate(Number, AssoRec."29")
                            else
                                Number := 0;
                        30:
                            if AssoRec."30" <> '' then
                                Evaluate(Number, AssoRec."30")
                            else
                                Number := 0;
                        31:
                            if AssoRec."31" <> '' then
                                Evaluate(Number, AssoRec."31")
                            else
                                Number := 0;
                        32:
                            if AssoRec."32" <> '' then
                                Evaluate(Number, AssoRec."32")
                            else
                                Number := 0;
                        33:
                            if AssoRec."33" <> '' then
                                Evaluate(Number, AssoRec."33")
                            else
                                Number := 0;
                        34:
                            if AssoRec."34" <> '' then
                                Evaluate(Number, AssoRec."34")
                            else
                                Number := 0;
                        35:
                            if AssoRec."35" <> '' then
                                Evaluate(Number, AssoRec."35")
                            else
                                Number := 0;
                        36:
                            if AssoRec."36" <> '' then
                                Evaluate(Number, AssoRec."36")
                            else
                                Number := 0;
                        37:
                            if AssoRec."37" <> '' then
                                Evaluate(Number, AssoRec."37")
                            else
                                Number := 0;
                        38:
                            if AssoRec."38" <> '' then
                                Evaluate(Number, AssoRec."38")
                            else
                                Number := 0;
                        39:
                            if AssoRec."39" <> '' then
                                Evaluate(Number, AssoRec."39")
                            else
                                Number := 0;
                        40:
                            if AssoRec."40" <> '' then
                                Evaluate(Number, AssoRec."40")
                            else
                                Number := 0;
                        41:
                            if AssoRec."41" <> '' then
                                Evaluate(Number, AssoRec."41")
                            else
                                Number := 0;
                        42:
                            if AssoRec."42" <> '' then
                                Evaluate(Number, AssoRec."42")
                            else
                                Number := 0;
                        43:
                            if AssoRec."43" <> '' then
                                Evaluate(Number, AssoRec."43")
                            else
                                Number := 0;
                        44:
                            if AssoRec."44" <> '' then
                                Evaluate(Number, AssoRec."44")
                            else
                                Number := 0;
                        45:
                            if AssoRec."45" <> '' then
                                Evaluate(Number, AssoRec."45")
                            else
                                Number := 0;
                        46:
                            if AssoRec."46" <> '' then
                                Evaluate(Number, AssoRec."46")
                            else
                                Number := 0;
                        47:
                            if AssoRec."47" <> '' then
                                Evaluate(Number, AssoRec."47")
                            else
                                Number := 0;
                        48:
                            if AssoRec."48" <> '' then
                                Evaluate(Number, AssoRec."48")
                            else
                                Number := 0;
                        49:
                            if AssoRec."49" <> '' then
                                Evaluate(Number, AssoRec."49")
                            else
                                Number := 0;
                        50:
                            if AssoRec."50" <> '' then
                                Evaluate(Number, AssoRec."50")
                            else
                                Number := 0;
                        51:
                            if AssoRec."51" <> '' then
                                Evaluate(Number, AssoRec."51")
                            else
                                Number := 0;
                        52:
                            if AssoRec."52" <> '' then
                                Evaluate(Number, AssoRec."52")
                            else
                                Number := 0;
                        53:
                            if AssoRec."53" <> '' then
                                Evaluate(Number, AssoRec."53")
                            else
                                Number := 0;
                        54:
                            if AssoRec."54" <> '' then
                                Evaluate(Number, AssoRec."54")
                            else
                                Number := 0;
                        55:
                            if AssoRec."55" <> '' then
                                Evaluate(Number, AssoRec."55")
                            else
                                Number := 0;
                        56:
                            if AssoRec."56" <> '' then
                                Evaluate(Number, AssoRec."56")
                            else
                                Number := 0;
                        57:
                            if AssoRec."57" <> '' then
                                Evaluate(Number, AssoRec."57")
                            else
                                Number := 0;
                        58:
                            if AssoRec."58" <> '' then
                                Evaluate(Number, AssoRec."58")
                            else
                                Number := 0;
                        59:
                            if AssoRec."59" <> '' then
                                Evaluate(Number, AssoRec."59")
                            else
                                Number := 0;
                        60:
                            if AssoRec."60" <> '' then
                                Evaluate(Number, AssoRec."60")
                            else
                                Number := 0;
                        61:
                            if AssoRec."61" <> '' then
                                Evaluate(Number, AssoRec."61")
                            else
                                Number := 0;
                        62:
                            if AssoRec."62" <> '' then
                                Evaluate(Number, AssoRec."62")
                            else
                                Number := 0;
                        63:
                            if AssoRec."63" <> '' then
                                Evaluate(Number, AssoRec."63")
                            else
                                Number := 0;
                        64:
                            if AssoRec."64" <> '' then
                                Evaluate(Number, AssoRec."64")
                            else
                                Number := 0;
                    end;

                    TotalLine += Number;
                end;

                if AssoRec."Colour Name" = "ColourName" then
                    TotalLine1 := TotalLine;

                Tot := Tot + TotalLine;
            //end;

            until AssoRec.Next() = 0;
        end;

        StyleMasterPORec.Reset();
        StyleMasterPORec.SetRange("Style No.", rec."Style No.");
        StyleMasterPORec.SetRange("lot No.", rec."lot No.");

        if StyleMasterPORec.FindSet() then begin
            if StyleMasterPORec.Qty < Tot then begin
                Total := 0;
                Message('Total quantity %1 is greater than the PO quantity %2', Tot, StyleMasterPORec.Qty);
            end
            else
                Total := TotalLine1;
        end;

        exit(Total);
    end;
}