page 51453 WashProductionCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = WashingProductionHeader;
    Caption = 'Washing Production';

    layout
    {
        area(Content)
        {
            group(General)
            {

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;

                }

                field("Production Date"; Rec."Production Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        UserRec: Record "User Setup";
                        LocationRec: Record Location;
                    begin

                        if Rec."Production Date" < WorkDate() then
                            Error('Invalid production date');

                        UserRec.Reset();
                        UserRec.Get(UserId);

                        if Rec."Washing Plant Code" = '' then begin

                            if UserRec."Factory Code" <> '' then begin

                                Rec."Washing Plant Code" := UserRec."Factory Code";

                                LocationRec.Reset();
                                LocationRec.SetRange(Code, UserRec."Factory Code");

                                if LocationRec.FindSet() then
                                    Rec."Washing Plant" := LocationRec.Name;
                            end;

                        end;

                    end;
                }

                field("Washing Plant"; Rec."Washing Plant")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Buyer Name"; Rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        UserRec: Record "User Setup";
                        LocationRec: Record Location;
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

                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, Rec."Buyer Name");

                        if CustomerRec.FindSet() then
                            Rec."Buyer Code" := CustomerRec."No.";

                    end;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StylemasterRec: Record "Style Master";
                    begin

                        StylemasterRec.Reset();
                        StylemasterRec.SetRange("Style No.", Rec."Style Name");

                        if StylemasterRec.FindSet() then
                            Rec."Style No." := StylemasterRec."No.";
                    end;
                }

                field("Lot No"; Rec."Lot No")
                {
                    ApplicationArea = All;
                    Caption = 'Lot';

                    trigger OnValidate()
                    var
                        StyleMsterRec: Record "Style Master PO";

                    begin
                        StyleMsterRec.Reset();
                        StyleMsterRec.SetRange("Style No.", Rec."Style No.");
                        StyleMsterRec.SetRange("Lot No.", Rec."Lot No");

                        if StyleMsterRec.FindSet() then
                            Rec."PO No" := StyleMsterRec."PO No.";
                    end;
                }

                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                    Caption = 'PO';
                    Editable = False;
                }

                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Process Code"; Rec."Process Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: text): Boolean
                    var
                        WashProdLineSeqRec: Record WashSequenceSMVLine;
                        WashProdHeaderSeqRec: Record WashSequenceSMVHeader;
                    begin

                        WashProdHeaderSeqRec.Reset();
                        WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                        WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                        WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                        WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                        if WashProdHeaderSeqRec.FindSet() then begin

                            WashProdLineSeqRec.Reset();
                            WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                            WashProdLineSeqRec.SetCurrentKey(Seq);
                            WashProdLineSeqRec.Ascending(true);

                            if WashProdLineSeqRec.FindFirst() then begin
                                repeat

                                    if WashProdLineSeqRec.Seq <> 0 then
                                        WashProdLineSeqRec.Mark(true);

                                until WashProdLineSeqRec.Next() = 0;
                                WashProdLineSeqRec.MarkedOnly(true);

                                if page.RunModal(51456, WashProdLineSeqRec) = Action::LookupOK then begin
                                    Rec."Process Code" := WashProdLineSeqRec."Processing Code";
                                    Rec."Process Name" := WashProdLineSeqRec."Processing Name";
                                    Rec."Process Seq No" := WashProdLineSeqRec.Seq;
                                end;
                            end;
                        end
                        else
                            Error('Not sequence allocated');
                    end;
                }

                field("Day Production Qty"; Rec."Day Production Qty")
                {
                    ApplicationArea = All;
                }

                field(PostingStatus; Rec.PostingStatus)
                {
                    ApplicationArea = All;
                }
            }

            group(Production)
            {
                part(WashingProductionLine; WashingProductionLine)
                {
                    ApplicationArea = all;
                    Caption = '  ';
                    SubPageLink = No = field(No);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Image = Allocate;

                trigger OnAction()
                var
                    WashinPorLine: Record WashinProductionLine;
                    WashingMasterRec: Record WashingMaster;
                    WashProdLineSeqRec: Record WashSequenceSMVLine;
                    WashProdLineSeq2Rec: Record WashSequenceSMVLine;
                    WashProdHeaderSeqRec: Record WashSequenceSMVHeader;
                    PreProdQty: BigInteger;
                    PreSeq: Integer;
                    ProcessCode: Code[200];
                begin

                    if Rec.PostingStatus = false then begin

                        if Rec."Day Production Qty" <> 0 then begin

                            WashinPorLine.Reset();
                            WashinPorLine.SetRange(No, Rec.No);

                            if WashinPorLine.FindSet() then
                                WashinPorLine.Delete();

                            WashinPorLine.Init();
                            WashinPorLine.No := Rec.No;
                            WashinPorLine."Line No" := 1;
                            WashinPorLine."Buyer Code" := Rec."Buyer Code";
                            WashinPorLine."Buyer Name" := Rec."Buyer Name";
                            WashinPorLine."Style Name" := Rec."Style Name";
                            WashinPorLine."Style No." := Rec."Style No.";
                            WashinPorLine."Lot No" := Rec."Lot No";
                            WashinPorLine."PO No" := Rec."PO No";
                            WashinPorLine."Color Code" := Rec."Color Code";
                            WashinPorLine."Color Name" := rec."Color Name";
                            WashinPorLine."Production Date" := Rec."Production Date";

                            if Rec."Process Code" = 'WHISKERS' then begin
                                WashinPorLine."Production WHISKERS" := Rec."Day Production Qty";
                            end;
                            if Rec."Process Code" = 'ACID/ RANDOM WASH' then begin
                                WashinPorLine."Production ACID/ RANDOM WASH" := Rec."Day Production Qty";
                            end;
                            if Rec."Process Code" = 'BASE WASH' then begin
                                WashinPorLine."Production BASE WASH" := Rec."Day Production Qty";
                            end;
                            if Rec."Process Code" = 'BRUSH' then begin
                                WashinPorLine."Production BRUSH" := Rec."Day Production Qty";
                            end;

                            if Rec."Process Code" = 'DESTROY' then begin
                                WashinPorLine."Production DESTROY" := Rec."Day Production Qty";
                            end;

                            if Rec."Process Code" = 'FINAL WASH' then begin
                                WashinPorLine."Production FINAL WASH" := Rec."Day Production Qty";
                            end;

                            if Rec."Process Code" = 'LASER BRUSH' then begin
                                WashinPorLine."Production LASER BRUSH" := Rec."Day Production Qty";
                            end;

                            if Rec."Process Code" = 'LASER DESTROY' then begin
                                WashinPorLine."Production LASER DESTROY" := Rec."Day Production Qty";
                            end;

                            if Rec."Process Code" = 'LASER WHISKERS' then begin
                                WashinPorLine."Production LASER WHISKERS" := Rec."Day Production Qty";
                            end;

                            if Rec."Process Code" = 'PP SPRAY' then begin
                                WashinPorLine."Production PP SPRAY" := Rec."Day Production Qty";
                            end;


                            WashinPorLine.Insert();

                            WashingMasterRec.Reset();
                            WashingMasterRec.SetRange("Style No", Rec."Style No.");
                            WashingMasterRec.SetRange(Lot, Rec."Lot No");
                            WashingMasterRec.SetRange("PO No", Rec."PO No");
                            WashingMasterRec.SetRange("Color Name", Rec."Color Name");

                            if WashingMasterRec.FindSet() then begin


                                if Rec."Process Code" = 'WHISKERS' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin
                                            // repeat

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production BASE WASH";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production BASE WASH" then
                                                            WashinPorLine."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BASE WASH");
                                                    end;

                                                    if ProcessCode = 'ACID/ RANDOM WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production ACID/ RANDOM WASH";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production ACID/ RANDOM WASH" then
                                                            WashinPorLine."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production ACID/ RANDOM WASH");
                                                    end;

                                                    if ProcessCode = 'BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production BRUSH";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production BRUSH" then
                                                            WashinPorLine."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BRUSH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production FINAL WASH" then
                                                            WashinPorLine."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production DESTROY" then
                                                            WashinPorLine."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production LASER BRUSH" then
                                                            WashinPorLine."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production LASER DESTROY" then
                                                            WashinPorLine."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production LASER WHISKERS" then
                                                            WashinPorLine."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;

                                                    if ProcessCode = 'PP SPRAY' then begin
                                                        PreProdQty := WashingMasterRec."Production PP SPRAY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production PP SPRAY" then
                                                            WashinPorLine."Production WHISKERS" := WashingMasterRec."Production WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production PP SPRAY");
                                                    end;

                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                if Rec."Process Code" = 'ACID/ RANDOM WASH' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin
                                            // repea

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production WHISKERS";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production WHISKERS" then
                                                            WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty Qty %1 greater than BASE WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production WHISKERS");
                                                    end;

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production BASE WASH";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production BASE WASH" then
                                                            WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty Qty %1 greater than BASE WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BASE WASH");
                                                    end;


                                                    if ProcessCode = 'BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production BRUSH";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production BRUSH" then
                                                            WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty %1 greater than BRUSH Qty Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BRUSH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production FINAL WASH" then
                                                            WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty Qty %1 greater than FINAL WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production DESTROY" then
                                                            WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty Qty %1 greater than DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production LASER BRUSH" then
                                                            WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty Qty %1 greater than LASER BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty %1 greater than LASER DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" < WashingMasterRec."Production LASER WHISKERS" then
                                                            WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty Qty %1 greater than LASER WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;

                                                    if ProcessCode = 'PP SPRAY' then begin
                                                        PreProdQty := WashingMasterRec."Production PP SPRAY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production PP SPRAY" then
                                                            WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('ACID/ RANDOM WASH Qty Qty %1 greater than PP SPRAY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production PP SPRAY");
                                                    end;

                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                if Rec."Process Code" = 'BASE WASH' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production WHISKERS" then
                                                            WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production WHISKERS");
                                                    end;

                                                    if ProcessCode = 'ACID/ RANDOM WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production ACID/ RANDOM WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production ACID/ RANDOM WASH" then
                                                            WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than ACID/ RANDOM WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production ACID/ RANDOM WASH");
                                                    end;

                                                    if ProcessCode = 'BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BRUSH" then
                                                            WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BRUSH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production FINAL WASH" then
                                                            WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than FINAL WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production DESTROY" then
                                                            WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER BRUSH" then
                                                            WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than LASER BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than LASER DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER WHISKERS" then
                                                            WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than LASER WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;

                                                    if ProcessCode = 'PP SPRAY' then begin
                                                        PreProdQty := WashingMasterRec."Production PP SPRAY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production PP SPRAY" then
                                                            WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BASE WASH Qty %1 greater than PP SPRAY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production PP SPRAY");
                                                    end;

                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                if Rec."Process Code" = 'BRUSH' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin
                                            // repeat

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production WHISKERS" then
                                                            WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production WHISKERS");
                                                    end;

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production BASE WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BASE WASH" then
                                                            WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than BASE WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BASE WASH");
                                                    end;

                                                    if ProcessCode = 'ACID/ RANDOM WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production ACID/ RANDOM WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production ACID/ RANDOM WASH" then
                                                            WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than ACID/ RANDOM WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production ACID/ RANDOM WASH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production FINAL WASH" then
                                                            WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than FINAL WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production DESTROY" then
                                                            WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER BRUSH" then
                                                            WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than LASER BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than LASER DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER WHISKERS" then
                                                            WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than LASER WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;

                                                    if ProcessCode = 'PP SPRAY' then begin
                                                        PreProdQty := WashingMasterRec."Production PP SPRAY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('BRUSH Qty %1 greater than PP SPRAY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production PP SPRAY");
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                if Rec."Process Code" = 'LASER WHISKERS' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin
                                            // repeat

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production LASER WHISKERS" := Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production WHISKERS" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production WHISKERS");
                                                    end;

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production BASE WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BASE WASH" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than BASE WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BASE WASH");
                                                    end;

                                                    if ProcessCode = 'ACID/ RANDOM WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production ACID/ RANDOM WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production ACID/ RANDOM WASH" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than ACID/ RANDOM WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production ACID/ RANDOM WASH");
                                                    end;

                                                    if ProcessCode = 'BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BRUSH" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BRUSH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production FINAL WASH" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than FINAL WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production DESTROY" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER BRUSH" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than LASER BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than LASER DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER WHISKERS" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than LASER WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;

                                                    if ProcessCode = 'PP SPRAY' then begin
                                                        PreProdQty := WashingMasterRec."Production PP SPRAY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER WHISKERS Qty %1 greater than PP SPRAY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production PP SPRAY");
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                if Rec."Process Code" = 'LASER BRUSH' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin
                                            // repeat

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production WHISKERS" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production WHISKERS");
                                                    end;

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production BASE WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BASE WASH" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than BASE WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BASE WASH");
                                                    end;

                                                    if ProcessCode = 'ACID/ RANDOM WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production ACID/ RANDOM WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production ACID/ RANDOM WASH" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than ACID/ RANDOM WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production ACID/ RANDOM WASH");
                                                    end;

                                                    if ProcessCode = 'BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BRUSH" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BRUSH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production FINAL WASH" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than FINAL WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production DESTROY" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER BRUSH" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than LASER BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than LASER DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER WHISKERS" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than LASER WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;

                                                    if ProcessCode = 'PP SPRAY' then begin
                                                        PreProdQty := WashingMasterRec."Production PP SPRAY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER BRUSH Qty %1 greater than PP SPRAY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production PP SPRAY");
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                if Rec."Process Code" = 'FINAL WASH' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production FINAL WASH" := Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production WHISKERS" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production WHISKERS");
                                                    end;

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production BASE WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BASE WASH" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than BASE WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BASE WASH");
                                                    end;

                                                    if ProcessCode = 'ACID/ RANDOM WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production ACID/ RANDOM WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production ACID/ RANDOM WASH" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than ACID/ RANDOM WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production ACID/ RANDOM WASH");
                                                    end;

                                                    if ProcessCode = 'BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BRUSH" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BRUSH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production FINAL WASH" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than FINAL WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production DESTROY" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER BRUSH" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than LASER BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than LASER DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER WHISKERS" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than LASER WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;

                                                    if ProcessCode = 'PP SPRAY' then begin
                                                        PreProdQty := WashingMasterRec."Production PP SPRAY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" + Rec."Day Production Qty"
                                                        else
                                                            Error('FINAL WASH Qty %1 greater than PP SPRAY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production PP SPRAY");
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                if Rec."Process Code" = 'DESTROY' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin
                                            // repeat

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production DESTROY" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production WHISKERS" then
                                                            WashinPorLine."Production BRUSH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production WHISKERS");
                                                    end;

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production BASE WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BASE WASH" then
                                                            WashinPorLine."Production BRUSH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than BASE WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BASE WASH");
                                                    end;

                                                    if ProcessCode = 'ACID/ RANDOM WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production ACID/ RANDOM WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production ACID/ RANDOM WASH" then
                                                            WashinPorLine."Production BRUSH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than ACID/ RANDOM WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production ACID/ RANDOM WASH");
                                                    end;

                                                    if ProcessCode = 'BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BRUSH" then
                                                            WashinPorLine."Production BRUSH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BRUSH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production FINAL WASH" then
                                                            WashinPorLine."Production BRUSH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than FINAL WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production DESTROY" then
                                                            WashinPorLine."Production BRUSH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER BRUSH" then
                                                            WashinPorLine."Production BASE WASH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than LASER BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashinPorLine."Production BRUSH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than LASER DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER WHISKERS" then
                                                            WashinPorLine."Production BRUSH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than LASER WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;

                                                    if ProcessCode = 'PP SPRAY' then begin
                                                        PreProdQty := WashingMasterRec."Production PP SPRAY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashinPorLine."Production BRUSH" := WashingMasterRec."Production DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('DESTROY Qty %1 greater than PP SPRAY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production PP SPRAY");
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                if Rec."Process Code" = 'LASER DESTROY' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production WHISKERS" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production WHISKERS");
                                                    end;

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production BASE WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BASE WASH" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than BASE WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BASE WASH");
                                                    end;

                                                    if ProcessCode = 'ACID/ RANDOM WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production ACID/ RANDOM WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production ACID/ RANDOM WASH" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than ACID/ RANDOM WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production ACID/ RANDOM WASH");
                                                    end;

                                                    if ProcessCode = 'BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BRUSH" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BRUSH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production FINAL WASH" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than FINAL WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production DESTROY" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER BRUSH" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than LASER BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than LASER DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER WHISKERS" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than LASER WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;

                                                    if ProcessCode = 'PP SPRAY' then begin
                                                        PreProdQty := WashingMasterRec."Production PP SPRAY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" + Rec."Day Production Qty"
                                                        else
                                                            Error('LASER DESTROY Qty %1 greater than PP SPRAY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production PP SPRAY");
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                if Rec."Process Code" = 'PP SPRAY' then begin

                                    WashProdHeaderSeqRec.Reset();
                                    WashProdHeaderSeqRec.SetRange("Style No.", Rec."Style No.");
                                    WashProdHeaderSeqRec.SetRange("Lot No", Rec."Lot No");
                                    WashProdHeaderSeqRec.SetRange("PO No", Rec."PO No");
                                    WashProdHeaderSeqRec.SetRange("Color Name", Rec."Color Name");

                                    if WashProdHeaderSeqRec.FindSet() then begin

                                        WashProdLineSeqRec.Reset();
                                        WashProdLineSeqRec.SetRange(No, WashProdHeaderSeqRec.No);
                                        WashProdLineSeqRec.SetCurrentKey(Seq);
                                        WashProdLineSeqRec.Ascending(true);

                                        if WashProdLineSeqRec.FindSet() then begin

                                            if Rec."Process Seq No" = 1 then begin
                                                WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty";
                                            end
                                            else begin

                                                PreSeq := Rec."Process Seq No" - 1;

                                                WashProdLineSeq2Rec.Reset();
                                                WashProdLineSeq2Rec.SetRange(No, WashProdHeaderSeqRec.No);
                                                WashProdLineSeq2Rec.SetRange(Seq, PreSeq);

                                                if WashProdLineSeq2Rec.FindSet() then begin

                                                    ProcessCode := WashProdLineSeq2Rec."Processing Code";

                                                    if ProcessCode = 'WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production WHISKERS" then
                                                            WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production WHISKERS");
                                                    end;

                                                    if ProcessCode = 'BASE WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production BASE WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BASE WASH" then
                                                            WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than BASE WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BASE WASH");
                                                    end;

                                                    if ProcessCode = 'ACID/ RANDOM WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production ACID/ RANDOM WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production ACID/ RANDOM WASH" then
                                                            WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than ACID/ RANDOM WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production ACID/ RANDOM WASH");
                                                    end;

                                                    if ProcessCode = 'BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production BRUSH" then
                                                            WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production BRUSH");
                                                    end;

                                                    if ProcessCode = 'FINAL WASH' then begin
                                                        PreProdQty := WashingMasterRec."Production FINAL WASH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production FINAL WASH" then
                                                            WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than FINAL WASH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production FINAL WASH");
                                                    end;

                                                    if ProcessCode = 'DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production DESTROY" then
                                                            WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER BRUSH' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER BRUSH";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER BRUSH" then
                                                            WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than LASER BRUSH Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER BRUSH");
                                                    end;

                                                    if ProcessCode = 'LASER DESTROY' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER DESTROY";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER DESTROY" then
                                                            WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than LASER DESTROY Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER DESTROY");
                                                    end;

                                                    if ProcessCode = 'LASER WHISKERS' then begin
                                                        PreProdQty := WashingMasterRec."Production LASER WHISKERS";

                                                        if Rec."Day Production Qty" <= WashingMasterRec."Production LASER WHISKERS" then
                                                            WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" + Rec."Day Production Qty"
                                                        else
                                                            Error('PP SPRAY Qty %1 greater than LASER WHISKERS Qty %2', Rec."Day Production Qty", WashingMasterRec."Production LASER WHISKERS");
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;

                                WashingMasterRec.Modify(true);

                                Rec.PostingStatus := true;
                                Rec."Posting Date" := WorkDate();
                                Rec.Modify(true);

                                Message('Production updated');

                            end
                            else
                                Error('Color not in washing allocated list');
                        end
                        else
                            Error('Production Qty should be greater than 0')

                    end
                    else
                        Error('Record already posted');
                end;
            }

            action("Add New")
            {
                ApplicationArea = All;
                Image = Add;
                trigger OnAction()
                var
                    WashProdCard: Page WashProductionCard;
                    NavAppSetupRec: Record "NavApp Setup";
                    WashProHerTabl: Record WashingProductionHeader;
                    NoSeriesManagementCode: Codeunit NoSeriesManagement;
                    No: Code[20];
                begin

                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    No := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."Wash Production Nos.", Today(), true);

                    WashProHerTabl.Init();
                    WashProHerTabl.No := No;
                    WashProHerTabl."Production Date" := Rec."Production Date";
                    WashProHerTabl."Washing Plant" := Rec."Washing Plant";
                    WashProHerTabl."Washing Plant Code" := Rec."Washing Plant Code";
                    WashProHerTabl."Buyer Code" := Rec."Buyer Code";
                    WashProHerTabl."Buyer Name" := Rec."Buyer Name";
                    WashProHerTabl."Style No." := Rec."Style No.";
                    WashProHerTabl."Style Name" := Rec."Style Name";
                    WashProHerTabl.Insert();
                    Commit();

                    CurrPage.Close();

                    Clear(WashProdCard);
                    WashProdCard.LookupMode(true);
                    WashProdCard.Editable(true);
                    WashProdCard.PassParameters(No);
                    WashProdCard.Run();

                end;
            }
        }
    }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Wash Production Nos.", xRec.No, rec.No) THEN BEGIN
            NoSeriesMngment.SetSeries(rec.No);
            EXIT(TRUE);
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        WashingMasterRec: Record WashingMaster;
        WashProductionLine: Record WashinProductionLine;
    begin

        if Rec.PostingStatus = true then begin

            WashingMasterRec.Reset();
            WashingMasterRec.SetRange("Style No", Rec."Style No.");
            WashingMasterRec.SetRange(Lot, Rec."Lot No");
            WashingMasterRec.SetRange("PO No", Rec."PO No");
            WashingMasterRec.SetRange("Color Name", Rec."Color Name");

            if WashingMasterRec.FindSet() then begin

                if Rec."Process Code" = 'WHISKERS' then begin
                    WashingMasterRec."Production WHISKERS" := WashingMasterRec."Production WHISKERS" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'ACID/ RANDOM WASH' then begin
                    WashingMasterRec."Production ACID/ RANDOM WASH" := WashingMasterRec."Production ACID/ RANDOM WASH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'BASE WASH' then begin
                    WashingMasterRec."Production BASE WASH" := WashingMasterRec."Production BASE WASH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'BRUSH' then begin
                    WashingMasterRec."Production BRUSH" := WashingMasterRec."Production BRUSH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'DESTROY' then begin
                    WashingMasterRec."Production DESTROY" := WashingMasterRec."Production DESTROY" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'FINAL WASH' then begin
                    WashingMasterRec."Production FINAL WASH" := WashingMasterRec."Production FINAL WASH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'LASER BRUSH' then begin
                    WashingMasterRec."Production LASER BRUSH" := WashingMasterRec."Production LASER BRUSH" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'LASER DESTROY' then begin
                    WashingMasterRec."Production LASER DESTROY" := WashingMasterRec."Production LASER DESTROY" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'LASER WHISKERS' then begin
                    WashingMasterRec."Production LASER WHISKERS" := WashingMasterRec."Production LASER WHISKERS" - Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;

                if Rec."Process Code" = 'PP SPRAY' then begin
                    WashingMasterRec."Production PP SPRAY" := WashingMasterRec."Production PP SPRAY" - Rec."Day Production Qty" + Rec."Day Production Qty";
                    WashingMasterRec.Modify(true);
                end;
            end;
        end;

        WashProductionLine.Reset();
        WashProductionLine.SetRange(No, Rec.No);

        if WashProductionLine.FindSet() then
            WashProductionLine.Delete(true);

    end;

    procedure PassParameters(CardNo: Code[20]);
    begin
        NoGb := CardNo;
    end;

    trigger OnOpenPage()
    var
    begin
        if NoGb <> '' then begin
            rec."No" := NoGb;
        end;
    end;

    var
        NoGb: Code[20];
}