pageextension 50806 "Output Jrnl List Ext" extends "Output Journal"
{
    actions
    {
        modify("Explode &Routing")
        {
            trigger OnBeforeAction()
            var
                RPORec: Record "Production Order";
            begin

                RPONOGB := '';
                if Rec."Order No." <> '' then
                    RPONOGB := Rec."Order No.";

            end;

            trigger OnAfterAction()
            var
                ItemJrnlLineRec: Record "Item Journal Line";
                RouterLineRec: Record "Routing Line";
                SORec: Record "Sales Header";
                RPORec: Record "Production Order";
                ProdOutHeaderRec: Record ProductionOutHeader;
                ProdOutLine1Rec: Record ProductionOutLine;
                ProdOutLine2Rec: Record ProductionOutLine;
                ItemRec: Record Item;
                Style: code[100];
                PONo: code[100];
                Color: code[100];
                size: code[100];
                Qty: BigInteger;
                QtyTemp: BigInteger;
                i: Integer;
                NewBrDownHeaderRec: Record "New Breakdown";
                NewBrDownLineRec: Record "New Breakdown Op Line2";
                RouterRec: Record "Routing Header";
                NewBrNo: Code[20];
                TotalSMV: Decimal;
                LoginRec: Page "Login Card";
                LoginSessionsRec: Record LoginSessions;
                SecondaryUserId: Code[20];
                SOLineRec: Record "Sales Line";
                ItemJrnlLine2Rec: Record "Item Journal Line";
                SONo: code[20];
            begin

                //Get Bulk Router
                RouterRec.Reset();
                RouterRec.SetFilter("Bulk Router", '=%1', true);
                if not RouterRec.FindSet() then
                    Error('cannot find a Router for the Bulk Process.');

                //Delete Pattern lines
                ItemJrnlLineRec.Reset();
                ItemJrnlLineRec.SetRange("Journal Template Name", 'OUTPUT');
                ItemJrnlLineRec.SetRange("Journal Batch Name", 'DEFAULT');
                ItemJrnlLineRec.SetFilter(Description, '=%1', 'PATTERN');
                if ItemJrnlLineRec.FindSet() then
                    ItemJrnlLineRec.DeleteAll();

                //get records in the output journal screen
                ItemJrnlLineRec.Reset();
                ItemJrnlLineRec.SetRange("Journal Template Name", 'OUTPUT');
                ItemJrnlLineRec.SetRange("Journal Batch Name", 'DEFAULT');
                ItemJrnlLineRec.SetCurrentKey("Item No.", Type);
                ItemJrnlLineRec.Ascending(true);

                if ItemJrnlLineRec.FindSet() then begin

                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());

                    if LoginSessionsRec.FindSet() then
                        SecondaryUserId := LoginSessionsRec."Secondary UserID";

                    //Get Sales Order No for RPO
                    RPORec.Reset();
                    RPORec.SetRange("No.", ItemJrnlLineRec."Order No.");
                    RPORec.SetFilter(Status, '%1', RPORec.Status::Released);
                    if RPORec.FindSet() then begin

                        if RPORec."Source No." = '' then
                            Error('Source No. in RPO : %1 is blank.', ItemJrnlLineRec."Order No.");

                        //Get Stye/Po for the SO
                        SORec.Reset();
                        SORec.SetRange("No.", RPORec."Source No.");
                        SORec.SetFilter("Document Type", '%1', SORec."Document Type"::Order);
                        if SORec.FindSet() then begin
                            Style := SORec."Style No";
                            PONo := SORec."PO No";

                            //Get New BR No
                            NewBrDownHeaderRec.Reset();
                            NewBrDownHeaderRec.SetRange("Style No.", Style);
                            if NewBrDownHeaderRec.FindSet() then
                                NewBrNo := NewBrDownHeaderRec."No."
                            else
                                Error('cannot find new breakdown details.');

                        end
                        else
                            Error('Cannot find Sales Order details for No : %1', RPORec."Source No.");
                    end
                    else
                        Error('Cannot find RPO details for RPO : %1', ItemJrnlLineRec."Order No.");

                    repeat
                        Qty := 0;
                        //get Color/Size for the FG
                        ItemRec.Reset();
                        ItemRec.SetRange("No.", ItemJrnlLineRec."Item No.");
                        if ItemRec.FindSet() then begin

                            Color := ItemRec."Color No.";
                            size := ItemRec."Size Range No.";

                            //Get total SMV for the department
                            TotalSMV := 0;
                            NewBrDownLineRec.Reset();
                            NewBrDownLineRec.SetRange("No.", NewBrNo);
                            NewBrDownLineRec.SetRange("Department Name", ItemJrnlLineRec.Description);
                            if NewBrDownLineRec.FindSet() then
                                repeat
                                    TotalSMV += NewBrDownLineRec.SMV;
                                until NewBrDownLineRec.Next() = 0;

                            // if TotalSMV = 0 then
                            //     Error('Total SMV for Department : %1 is zero.', ItemJrnlLineRec.Description);


                            ProdOutHeaderRec.Reset();
                            ProdOutHeaderRec.SetRange("Prod Date", ItemJrnlLineRec."Posting Date");

                            case ItemJrnlLineRec.Description of
                                'CUTTING':
                                    begin
                                        ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Cut);
                                        ProdOutHeaderRec.SetRange("Style No.", Style);
                                        ProdOutHeaderRec.SetRange("Po No", PONo);
                                    end;
                                'SEWING':
                                    begin
                                        ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Saw);
                                        ProdOutHeaderRec.SetRange("Out Style No.", Style);
                                        ProdOutHeaderRec.SetRange("Out Po No", PONo);
                                    end;
                                'WASHING':
                                    begin
                                        ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Wash);
                                        ProdOutHeaderRec.SetRange("Style No.", Style);
                                        ProdOutHeaderRec.SetRange("Po No", PONo);
                                    end;
                                'FINISHING':
                                    begin
                                        ProdOutHeaderRec.SetFilter(Type, '=%1', ProdOutHeaderRec.Type::Fin);
                                        ProdOutHeaderRec.SetRange("Style No.", Style);
                                        ProdOutHeaderRec.SetRange("Po No", PONo);
                                    end;
                                else
                                    Error('Invalid Work center description in the Output Journal lines.');
                            end;

                            if ProdOutHeaderRec.Findset() then begin
                                repeat

                                    QtyTemp := 0;
                                    ProdOutLine1Rec.Reset();
                                    ProdOutLine1Rec.SetRange("No.", ProdOutHeaderRec."No.");
                                    ProdOutLine1Rec.SetFilter("Colour Name", '=%1', '*');
                                    ProdOutLine1Rec.FindSet();

                                    ProdOutLine2Rec.Reset();
                                    ProdOutLine2Rec.SetRange("No.", ProdOutHeaderRec."No.");
                                    ProdOutLine2Rec.SetRange("Colour No", Color);
                                    if ProdOutLine2Rec.FindSet() then begin

                                        i := 1;
                                        for i := 1 To 64 do begin
                                            case i of
                                                1:
                                                    if ProdOutLine1Rec."1" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."1");
                                                2:
                                                    if ProdOutLine1Rec."2" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."2");
                                                3:
                                                    if ProdOutLine1Rec."3" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."3");
                                                4:
                                                    if ProdOutLine1Rec."4" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."4");
                                                5:
                                                    if ProdOutLine1Rec."5" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."5");
                                                6:
                                                    if ProdOutLine1Rec."6" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."6");
                                                7:
                                                    if ProdOutLine1Rec."7" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."7");
                                                8:
                                                    if ProdOutLine1Rec."8" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."8");
                                                9:
                                                    if ProdOutLine1Rec."9" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."9");
                                                10:
                                                    if ProdOutLine1Rec."10" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."10");
                                                11:
                                                    if ProdOutLine1Rec."11" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."11");
                                                12:
                                                    if ProdOutLine1Rec."12" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."12");
                                                13:
                                                    if ProdOutLine1Rec."13" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."13");
                                                14:
                                                    if ProdOutLine1Rec."14" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."14");
                                                15:
                                                    if ProdOutLine1Rec."15" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."15");
                                                16:
                                                    if ProdOutLine1Rec."16" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."16");
                                                17:
                                                    if ProdOutLine1Rec."17" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."17");
                                                18:
                                                    if ProdOutLine1Rec."18" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."18");
                                                19:
                                                    if ProdOutLine1Rec."19" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."19");
                                                20:
                                                    if ProdOutLine1Rec."20" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."20");
                                                21:
                                                    if ProdOutLine1Rec."21" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."21");
                                                22:
                                                    if ProdOutLine1Rec."22" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."22");
                                                23:
                                                    if ProdOutLine1Rec."23" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."23");
                                                24:
                                                    if ProdOutLine1Rec."24" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."24");
                                                25:
                                                    if ProdOutLine1Rec."25" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."25");
                                                26:
                                                    if ProdOutLine1Rec."26" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."26");
                                                27:
                                                    if ProdOutLine1Rec."27" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."27");
                                                28:
                                                    if ProdOutLine1Rec."28" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."28");
                                                29:
                                                    if ProdOutLine1Rec."29" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."29");
                                                30:
                                                    if ProdOutLine1Rec."30" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."30");
                                                31:
                                                    if ProdOutLine1Rec."31" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."31");
                                                32:
                                                    if ProdOutLine1Rec."32" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."32");
                                                33:
                                                    if ProdOutLine1Rec."33" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."33");
                                                34:
                                                    if ProdOutLine1Rec."34" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."34");
                                                35:
                                                    if ProdOutLine1Rec."35" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."35");
                                                36:
                                                    if ProdOutLine1Rec."36" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."36");
                                                37:
                                                    if ProdOutLine1Rec."37" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."37");
                                                38:
                                                    if ProdOutLine1Rec."38" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."38");
                                                39:
                                                    if ProdOutLine1Rec."39" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."39");
                                                40:
                                                    if ProdOutLine1Rec."40" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."40");
                                                41:
                                                    if ProdOutLine1Rec."41" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."41");
                                                42:
                                                    if ProdOutLine1Rec."42" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."42");
                                                43:
                                                    if ProdOutLine1Rec."43" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."43");
                                                44:
                                                    if ProdOutLine1Rec."44" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."44");
                                                45:
                                                    if ProdOutLine1Rec."45" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."45");
                                                46:
                                                    if ProdOutLine1Rec."46" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."46");
                                                47:
                                                    if ProdOutLine1Rec."47" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."47");
                                                48:
                                                    if ProdOutLine1Rec."48" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."48");
                                                49:
                                                    if ProdOutLine1Rec."49" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."49");
                                                50:
                                                    if ProdOutLine1Rec."50" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."50");
                                                51:
                                                    if ProdOutLine1Rec."51" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."51");
                                                52:
                                                    if ProdOutLine1Rec."52" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."52");
                                                53:
                                                    if ProdOutLine1Rec."53" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."53");
                                                54:
                                                    if ProdOutLine1Rec."54" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."54");
                                                55:
                                                    if ProdOutLine1Rec."55" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."55");
                                                56:
                                                    if ProdOutLine1Rec."56" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."56");
                                                57:
                                                    if ProdOutLine1Rec."57" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."57");
                                                58:
                                                    if ProdOutLine1Rec."58" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."58");
                                                59:
                                                    if ProdOutLine1Rec."59" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."59");
                                                60:
                                                    if ProdOutLine1Rec."60" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."60");
                                                61:
                                                    if ProdOutLine1Rec."61" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."61");
                                                62:
                                                    if ProdOutLine1Rec."62" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."62");
                                                63:
                                                    if ProdOutLine1Rec."63" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."63");
                                                64:
                                                    if ProdOutLine1Rec."64" = size then
                                                        Evaluate(QtyTemp, ProdOutLine2Rec."64");
                                            end;

                                            Qty := Qty + QtyTemp;
                                            QtyTemp := 0;

                                        end;
                                    end;
                                until ProdOutHeaderRec.Next() = 0;
                            end;

                            //Update Journal line                            
                            ItemJrnlLineRec."Run Time" := Qty * TotalSMV;
                            ItemJrnlLineRec."Output Quantity" := Qty;
                            ItemJrnlLineRec.Finished := true;

                            if ItemJrnlLineRec."Document No." = RPONOGB then
                                ItemJrnlLineRec."Secondary UserID" := SecondaryUserId;

                            //For existing Records
                            SOLineRec.Reset();
                            SOLineRec.SetRange("Document No.", RPORec."Source No.");
                            SOLineRec.SetFilter("Document Type", '=%1', SOLineRec."Document Type"::Order);
                            SOLineRec.SetCurrentKey("No.");
                            SOLineRec.Ascending(true);

                            if SOLineRec.FindSet() then begin
                                repeat

                                    if ItemJrnlLineRec."Item No." = SOLineRec."No." then
                                        ItemJrnlLineRec."Output Quantity" := SOLineRec.Quantity;

                                until SOLineRec.Next() = 0;
                            end;

                            ItemJrnlLineRec.Modify();

                        end
                        else
                            Error('Cannot find Item No : %1 in Item master.', ItemJrnlLineRec."Item No.");

                    until ItemJrnlLineRec.Next() = 0;

                    //For New Record
                    ItemJrnlLine2Rec.Reset();
                    ItemJrnlLine2Rec.SetRange("Order No.", RPONOGB);
                    ItemJrnlLine2Rec.SetRange("Journal Template Name", 'OUTPUT');
                    ItemJrnlLine2Rec.SetRange("Journal Batch Name", 'DEFAULT');

                    if ItemJrnlLine2Rec.FindSet() then begin
                        RPORec.Reset();
                        RPORec.SetRange("No.", ItemJrnlLine2Rec."Order No.");
                        RPORec.SetFilter(Status, '%1', RPORec.Status::Released);
                        if RPORec.FindSet() then
                            SONo := RPORec."Source No.";
                        repeat
                            SOLineRec.Reset();
                            SOLineRec.SetRange("Document No.", SONo);
                            SOLineRec.SetFilter("Document Type", '=%1', SOLineRec."Document Type"::Order);
                            SOLineRec.SetCurrentKey("No.");
                            SOLineRec.Ascending(true);

                            if SOLineRec.FindSet() then begin
                                repeat

                                    if ItemJrnlLine2Rec."Item No." = SOLineRec."No." then
                                        ItemJrnlLine2Rec."Output Quantity" := SOLineRec.Quantity;

                                until SOLineRec.Next() = 0;
                            end;

                            ItemJrnlLine2Rec.Modify();
                        until ItemJrnlLine2Rec.Next() = 0;


                    end;

                end;

            end;
        }

        addafter("&Print")
        {
            action("Filter for the User")
            {
                ApplicationArea = All;
                Image = UseFilters;

                trigger OnAction()
                var
                    LoginRec: Page "Login Card";
                    LoginSessionsRec: Record LoginSessions;
                begin

                    //Check whether user logged in or not
                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());
                    if not LoginSessionsRec.FindSet() then begin  //not logged in
                        Clear(LoginRec);
                        LoginRec.LookupMode(true);
                        LoginRec.RunModal();

                        // LoginSessionsRec.Reset();
                        // LoginSessionsRec.SetRange(SessionID, SessionId());
                        // if LoginSessionsRec.FindSet() then
                        //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
                    end;

                    // ItemJrnlLineRec.Reset();
                    // ItemJrnlLineRec.SetRange("Journal Template Name", 'OUTPUT');
                    // ItemJrnlLineRec.SetRange("Journal Batch Name", 'DEFAULT');
                    // ItemJrnlLineRec.FindSet();

                    Rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");

                end;
            }
        }

    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());
        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;

    var
        RPONOGB: Code[200];

}