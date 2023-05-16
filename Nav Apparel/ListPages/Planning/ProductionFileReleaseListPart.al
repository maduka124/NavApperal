page 51215 ProductionFileReleaseListPart
{
    PageType = ListPart;
    SourceTable = ProductionFileReleaseLine;
    SourceTableView = sorting("Style Name", "Sew Factory") where(Status = filter(false));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Select; rec.Select)
                {
                    ApplicationArea = All;
                    Caption = 'Select';

                    trigger OnValidate()
                    var
                        ProduFileRelLineRec: Record ProductionFileReleaseLine;
                        CountRec: Integer;
                    begin
                        CurrPage.Update();
                        CountRec := 0;
                        ProduFileRelLineRec.Reset();
                        ProduFileRelLineRec.SetFilter(Select, '=%1', true);

                        if ProduFileRelLineRec.FindSet() then
                            CountRec := ProduFileRelLineRec.Count;

                        if CountRec > 1 then
                            Error('You can select only one record.');
                    end;
                }

                field("LCFactory Name"; rec."LCFactory Name")
                {
                    ApplicationArea = All;
                    Caption = 'LC Factory';
                    Editable = false;
                }

                field("Sew Factory No"; Rec."Sew Factory No")
                {
                    ApplicationArea = All;
                    Caption = 'Sew. Factory';
                    Editable = false;
                }

                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
                    Editable = false;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                    Editable = false;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field("Order Qty"; rec."Order Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Plan Qty"; rec."Plan Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Input Date"; rec."Input Date")
                {
                    ApplicationArea = All;
                    Caption = 'Plan Input Date';
                    Editable = false;
                }

                field("Days After"; rec."Days After")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Merchandiser; rec.Merchandiser)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }

                //Done by sachith on 21/04/23
                field("Secondary UserID"; Rec."Secondary UserID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Secondary User';
                }

                field(BPCD; rec.BPCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Ship Date"; rec."Ship Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Merchandizer Group Name"; rec."Merchandizer Group Name")
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
            action("Release Production File")
            {
                ApplicationArea = All;
                Image = Confirm;

                trigger OnAction()
                var
                    ProdFileRelLineRec: Record ProductionFileReleaseLine;
                    ProdFileRelLineHisRec: Record ProductnFileReleaseLineHistory;
                    StyleMasterRec: Record "Style Master";
                    StyleMasterPORec: Record "Style Master PO";
                    NavAppPlanLineRec: Record "NavApp Planning Lines";
                    SeqNo: BigInteger;
                begin
                    //Update Status to true (Prod File Released)
                    ProdFileRelLineRec.Reset();
                    ProdFileRelLineRec.SetFilter(Select, '=%1', true);
                    if ProdFileRelLineRec.FindSet() then begin

                        if Confirm('Do you want to release the production file?', true) then begin

                            //Update style master status
                            StyleMasterRec.Reset();
                            StyleMasterRec.SetRange("No.", ProdFileRelLineRec."Style No.");
                            if StyleMasterRec.FindSet() then begin
                                StyleMasterRec."Prod File Handover Status" := true;
                                StyleMasterRec."Production File Handover Date" := WorkDate();
                                StyleMasterRec.Modify();
                            end;

                            //Get Max line no
                            ProdFileRelLineHisRec.Reset();
                            ProdFileRelLineHisRec.Ascending(true);

                            if ProdFileRelLineHisRec.FindLast() then
                                SeqNo := ProdFileRelLineHisRec."Seq No";

                            //Move to the History table
                            ProdFileRelLineHisRec.Init();
                            ProdFileRelLineHisRec.BPCD := ProdFileRelLineRec.BPCD;
                            ProdFileRelLineHisRec."Buyer Name" := ProdFileRelLineRec."Buyer Name";
                            ProdFileRelLineHisRec."Buyer No" := ProdFileRelLineRec."Buyer No";
                            ProdFileRelLineHisRec."Created Date" := WorkDate();
                            ProdFileRelLineHisRec."Created User" := UserId;
                            ProdFileRelLineHisRec."Days After" := ProdFileRelLineRec."Days After";
                            ProdFileRelLineHisRec."Input Date" := ProdFileRelLineRec."Input Date";
                            ProdFileRelLineHisRec."LCFactory Name" := ProdFileRelLineRec."LCFactory Name";
                            ProdFileRelLineHisRec."LCFactory No" := ProdFileRelLineRec."LCFactory No";
                            ProdFileRelLineHisRec.Merchandiser := ProdFileRelLineRec.Merchandiser;
                            ProdFileRelLineHisRec."Merchandizer Group Name" := ProdFileRelLineRec."Merchandizer Group Name";
                            ProdFileRelLineHisRec."Order Qty" := ProdFileRelLineRec."Order Qty";
                            ProdFileRelLineHisRec."Plan Qty" := ProdFileRelLineRec."Plan Qty";
                            ProdFileRelLineHisRec."Resource Name" := ProdFileRelLineRec."Resource Name";
                            ProdFileRelLineHisRec."Resource No." := ProdFileRelLineRec."Resource No.";
                            ProdFileRelLineHisRec."Secondary UserID" := ProdFileRelLineRec."Secondary UserID";
                            ProdFileRelLineHisRec.Select := true;
                            ProdFileRelLineHisRec."Seq No" := SeqNo + 1;
                            ProdFileRelLineHisRec."Sew Factory" := ProdFileRelLineRec."Sew Factory";
                            ProdFileRelLineHisRec."Sew Factory No" := ProdFileRelLineRec."Sew Factory No";
                            ProdFileRelLineHisRec."Ship Date" := ProdFileRelLineRec."Ship Date";
                            ProdFileRelLineHisRec.Status := true;
                            ProdFileRelLineHisRec."Style Name" := ProdFileRelLineRec."Style Name";
                            ProdFileRelLineHisRec."Style No." := ProdFileRelLineRec."Style No.";
                            ProdFileRelLineHisRec.Insert();


                            //Get Po for the Factory and Style
                            NavAppPlanLineRec.Reset();
                            NavAppPlanLineRec.SetRange("Style No.", ProdFileRelLineRec."Style No.");
                            NavAppPlanLineRec.SetRange(Factory, ProdFileRelLineRec."Sew Factory No");
                            if NavAppPlanLineRec.FindSet() then begin
                                repeat
                                    //Change sewing factory of PO
                                    StyleMasterPORec.Reset();
                                    StyleMasterPORec.SetRange("Style No.", NavAppPlanLineRec."Style No.");
                                    StyleMasterPORec.SetRange("PO No.", NavAppPlanLineRec."PO No.");
                                    if StyleMasterPORec.FindSet() then begin
                                        StyleMasterPORec."Sew Factory No" := ProdFileRelLineRec."Sew Factory No";
                                        StyleMasterPORec."Sew Factory Name" := ProdFileRelLineRec."Sew Factory";
                                        StyleMasterPORec.Modify();

                                        //Get Sales Order for the style/buyer po

                                    end;
                                until NavAppPlanLineRec.Next() = 0;
                            end;

                            //Delete from original list
                            ProdFileRelLineRec.Delete();
                            Message('Completed');

                        end
                    end
                    else
                        Error('No line selected.');
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        NavAppPlanLineRec: Record "NavApp Planning Lines";
        NavAppPlanLineRec1: Record "NavApp Planning Lines";
        NavAppPlanDetRec: Record "NavApp Prod Plans Details";
        ProdFileRelLineRec: Record ProductionFileReleaseLine;
        StyleMasPoRec: Record "Style Master PO";
        LocationRec: Record Location;
        StyleMasRec: Record "Style Master";
        StyleName: Text[50];
        Factory: Text[50];
        SeqNo: BigInteger;
    begin

        //Delete all records before insert
        ProdFileRelLineRec.Reset();
        if ProdFileRelLineRec.FindSet() then
            ProdFileRelLineRec.DeleteAll();

        //Get Max line no
        ProdFileRelLineRec.Reset();
        ProdFileRelLineRec.Ascending(true);

        if ProdFileRelLineRec.FindLast() then
            SeqNo := ProdFileRelLineRec."Seq No";

        SeqNo += 1;

        //Get all planning records
        NavAppPlanLineRec.Reset();
        NavAppPlanLineRec.SetCurrentKey("Style Name", Factory);
        NavAppPlanLineRec.Ascending(true);

        if NavAppPlanLineRec.FindSet() then begin

            StyleName := NavAppPlanLineRec."Style Name";
            Factory := NavAppPlanLineRec.Factory;

            //Check the style master status
            StyleMasRec.Reset();
            StyleMasRec.SetRange("No.", NavAppPlanLineRec."Style No.");
            StyleMasRec.FindSet();

            if StyleMasRec."Prod File Handover Status" = false then begin

                //Get Po details
                StyleMasPoRec.Reset();
                StyleMasPoRec.SetCurrentKey(BPCD);
                StyleMasPoRec.Ascending(true);
                StyleMasPoRec.SetRange("Style No.", NavAppPlanLineRec."Style No.");
                StyleMasPoRec.FindFirst();

                //get style details
                StyleMasRec.Reset();
                StyleMasRec.SetRange("No.", NavAppPlanLineRec."Style No.");
                StyleMasRec.FindSet();


                ProdFileRelLineRec.Init();
                ProdFileRelLineRec.BPCD := StyleMasPoRec.BPCD;
                ProdFileRelLineRec."Buyer Name" := StyleMasRec."Buyer Name";
                ProdFileRelLineRec."Buyer No" := StyleMasRec."Buyer No.";
                ProdFileRelLineRec."Created Date" := WorkDate();
                ProdFileRelLineRec."Created User" := UserId;

                //Get min input date
                NavAppPlanLineRec1.Reset();
                NavAppPlanLineRec1.SetRange("Style Name", NavAppPlanLineRec."Style Name");
                NavAppPlanLineRec1.SetRange("Factory", NavAppPlanLineRec."Factory");
                NavAppPlanLineRec1.SetCurrentKey("Start Date");
                NavAppPlanLineRec1.Ascending(true);
                NavAppPlanLineRec1.FindFirst();
                ProdFileRelLineRec."Input Date" := NavAppPlanLineRec1."Start Date" - 2;

                ProdFileRelLineRec."Days After" := WorkDate() - (NavAppPlanLineRec1."Start Date" - 2);
                ProdFileRelLineRec."LCFactory No" := NavAppPlanLineRec."Factory";

                //get Factory name
                LocationRec.Reset();
                LocationRec.SetRange(code, StyleMasRec."Factory Code");
                if LocationRec.FindSet() then
                    ProdFileRelLineRec."LCFactory Name" := LocationRec."Name";

                ProdFileRelLineRec.Merchandiser := StyleMasRec."Merchandiser Name";
                ProdFileRelLineRec."Merchandizer Group Name" := StyleMasRec."Merchandizer Group Name";
                ProdFileRelLineRec."Order Qty" := StyleMasRec."Order Qty";

                //Get total plan qty
                NavAppPlanLineRec1.Reset();
                NavAppPlanLineRec1.SetRange("Style Name", NavAppPlanLineRec."Style Name");
                NavAppPlanLineRec1.SetRange("Factory", NavAppPlanLineRec."Factory");
                NavAppPlanLineRec1.FindSet();
                repeat
                    ProdFileRelLineRec."Plan Qty" += NavAppPlanLineRec1."Qty";
                until NavAppPlanLineRec1.Next() = 0;

                ProdFileRelLineRec."Resource Name" := NavAppPlanLineRec."Resource Name";
                ProdFileRelLineRec."Resource No." := NavAppPlanLineRec."Resource No.";
                //ProdFileRelLineRec."Secondary UserID" := ProdFileRelLineRec."Secondary UserID";
                ProdFileRelLineRec.Select := false;
                ProdFileRelLineRec."Seq No" := SeqNo;
                ProdFileRelLineRec."Sew Factory No" := NavAppPlanLineRec."Factory";

                //get Factory name
                LocationRec.Reset();
                LocationRec.SetRange(code, NavAppPlanLineRec."Factory");
                if LocationRec.FindSet() then
                    ProdFileRelLineRec."Sew Factory" := LocationRec.Name;

                //Get Po details
                StyleMasPoRec.Reset();
                StyleMasPoRec.SetCurrentKey("Ship Date");
                StyleMasPoRec.Ascending(true);
                StyleMasPoRec.SetRange("Style No.", NavAppPlanLineRec."Style No.");
                StyleMasPoRec.FindFirst();
                ProdFileRelLineRec."Ship Date" := StyleMasPoRec."Ship Date";

                ProdFileRelLineRec.Status := false;
                ProdFileRelLineRec."Style Name" := NavAppPlanLineRec."Style Name";
                ProdFileRelLineRec."Style No." := NavAppPlanLineRec."Style No.";

                //Done by sachith on 21/04/23
                ProdFileRelLineRec."Secondary UserID" := StyleMasRec."Secondary UserID";

                ProdFileRelLineRec.Insert();

            end;

            repeat

                if (StyleName = NavAppPlanLineRec."Style Name") and (Factory = NavAppPlanLineRec."Factory") then begin
                end
                else begin

                    //Check the style master status
                    StyleMasRec.Reset();
                    StyleMasRec.SetRange("No.", NavAppPlanLineRec."Style No.");
                    if StyleMasRec.FindSet() then
                        if StyleMasRec."Prod File Handover Status" = false then begin

                            SeqNo += 1;

                            //Get Po details
                            StyleMasPoRec.Reset();
                            StyleMasPoRec.SetCurrentKey(BPCD);
                            StyleMasPoRec.Ascending(true);
                            StyleMasPoRec.SetRange("Style No.", NavAppPlanLineRec."Style No.");
                            StyleMasPoRec.FindFirst();

                            //get style details
                            StyleMasRec.Reset();
                            StyleMasRec.SetRange("No.", NavAppPlanLineRec."Style No.");
                            StyleMasRec.FindSet();

                            ProdFileRelLineRec.Init();
                            ProdFileRelLineRec.BPCD := StyleMasPoRec.BPCD;
                            ProdFileRelLineRec."Buyer Name" := StyleMasRec."Buyer Name";
                            ProdFileRelLineRec."Buyer No" := StyleMasRec."Buyer No.";
                            ProdFileRelLineRec."Created Date" := WorkDate();
                            ProdFileRelLineRec."Created User" := UserId;

                            //Get min input date
                            NavAppPlanLineRec1.Reset();
                            NavAppPlanLineRec1.SetRange("Style Name", NavAppPlanLineRec."Style Name");
                            NavAppPlanLineRec1.SetRange("Factory", NavAppPlanLineRec."Factory");
                            NavAppPlanLineRec1.SetCurrentKey("Start Date");
                            NavAppPlanLineRec1.Ascending(true);
                            NavAppPlanLineRec1.FindFirst();
                            ProdFileRelLineRec."Input Date" := NavAppPlanLineRec1."Start Date" - 2;

                            ProdFileRelLineRec."Days After" := WorkDate() - (NavAppPlanLineRec1."Start Date" - 2);
                            ProdFileRelLineRec."LCFactory No" := NavAppPlanLineRec."Factory";

                            //get Factory name
                            LocationRec.Reset();
                            LocationRec.SetRange(code, StyleMasRec."Factory Code");
                            if LocationRec.FindSet() then
                                ProdFileRelLineRec."LCFactory Name" := LocationRec."Name";

                            ProdFileRelLineRec.Merchandiser := StyleMasRec."Merchandiser Name";

                            //Done by sachith on 21/04/23
                            ProdFileRelLineRec."Secondary UserID" := StyleMasRec."Secondary UserID";

                            ProdFileRelLineRec."Merchandizer Group Name" := StyleMasRec."Merchandizer Group Name";
                            ProdFileRelLineRec."Order Qty" := StyleMasRec."Order Qty";

                            //Get total plan qty
                            NavAppPlanLineRec1.Reset();
                            NavAppPlanLineRec1.SetRange("Style Name", NavAppPlanLineRec."Style Name");
                            NavAppPlanLineRec1.SetRange("Factory", NavAppPlanLineRec."Factory");
                            NavAppPlanLineRec1.FindSet();
                            repeat
                                ProdFileRelLineRec."Plan Qty" += NavAppPlanLineRec1."Qty";
                            until NavAppPlanLineRec1.Next() = 0;

                            ProdFileRelLineRec."Resource Name" := NavAppPlanLineRec."Resource Name";
                            ProdFileRelLineRec."Resource No." := NavAppPlanLineRec."Resource No.";
                            //ProdFileRelLineRec."Secondary UserID" := ProdFileRelLineRec."Secondary UserID";
                            ProdFileRelLineRec.Select := false;
                            ProdFileRelLineRec."Seq No" := SeqNo;
                            ProdFileRelLineRec."Sew Factory No" := NavAppPlanLineRec."Factory";

                            //get Factory name
                            LocationRec.Reset();
                            LocationRec.SetRange(code, NavAppPlanLineRec."Factory");
                            if LocationRec.FindSet() then
                                ProdFileRelLineRec."Sew Factory" := LocationRec.Name;

                            //Get Po details
                            StyleMasPoRec.Reset();
                            StyleMasPoRec.SetCurrentKey("Ship Date");
                            StyleMasPoRec.Ascending(true);
                            StyleMasPoRec.SetRange("Style No.", NavAppPlanLineRec."Style No.");
                            StyleMasPoRec.FindFirst();
                            ProdFileRelLineRec."Ship Date" := StyleMasPoRec."Ship Date";

                            ProdFileRelLineRec.Status := false;
                            ProdFileRelLineRec."Style Name" := NavAppPlanLineRec."Style Name";
                            ProdFileRelLineRec."Style No." := NavAppPlanLineRec."Style No.";
                            ProdFileRelLineRec.Insert();

                        end;

                    StyleName := NavAppPlanLineRec."Style Name";
                    Factory := NavAppPlanLineRec.Factory;

                end;

            until NavAppPlanLineRec.Next() = 0;

        end;

        CurrPage.Update();

    end;
}
