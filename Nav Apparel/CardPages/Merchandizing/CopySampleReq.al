page 51303 "Copy Sample Requisition Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Copy Sample Requisition';


    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(SourceStyle; SourceStyle)
                {
                    ApplicationArea = All;
                    Caption = 'Source Style No';
                    ShowMandatory = true;

                    trigger OnLookup(var text: Text): Boolean
                    var
                        UserRec: Record "User Setup";
                        SampleReqHeaderRec: Record "Sample Requsition Header";
                        SampleNo: Code[20];
                        StyleNo: Code[20];
                    begin

                        UserRec.Reset();
                        UserRec.Get(UserId);

                        if UserRec."Merchandizer All Group" = false then begin

                            if UserRec."Merchandizer Group Name" <> '' then begin

                                SampleReqHeaderRec.Reset();
                                SampleReqHeaderRec.SetRange("Merchandizer Group Name", UserRec."Merchandizer Group Name");

                                if SampleReqHeaderRec.FindFirst() then begin
                                    repeat
                                        if SampleNo <> SampleReqHeaderRec."No." then begin
                                            SampleNo := SampleReqHeaderRec."No.";
                                            SampleReqHeaderRec.Mark(true);
                                        end;
                                    until SampleReqHeaderRec.Next() = 0;
                                    SampleReqHeaderRec.MarkedOnly(true);

                                    if Page.RunModal(51063, SampleReqHeaderRec) = Action::LookupOK then begin
                                        SampleReqNo := SampleReqHeaderRec."No.";
                                        SourceStyle := SampleReqHeaderRec."Style No.";
                                        SourceStyleName := SampleReqHeaderRec."Style Name";
                                    end;
                                end;
                            end
                            else
                                Error('Merchandizer Group not assigned for the user.');
                        end
                        else begin
                            if Page.RunModal(51063, SampleReqHeaderRec) = Action::LookupOK then begin
                                SampleReqNo := SampleReqHeaderRec."No.";
                                SourceStyle := SampleReqHeaderRec."Style No.";
                                SourceStyleName := SampleReqHeaderRec."Style Name";
                            end;
                        end;
                    end;
                }

                field(SourceStyleName; SourceStyleName)
                {
                    ApplicationArea = All;
                    Caption = 'Source Style Name';
                    Editable = false;
                }

                field(SampleReqNo; SampleReqNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sample Requisition No';
                    Editable = false;
                }

                field(DestinationStyle; DestinationStyle)
                {
                    ApplicationArea = All;
                    Caption = 'Target Style No';
                    ShowMandatory = true;

                    trigger OnLookup(var text: Text): Boolean
                    var
                        UserRec: Record "User Setup";
                        StyleMasterRec: Record "Style Master";
                        StyleNo: Code[20];
                    begin

                        UserRec.Reset();
                        UserRec.Get(UserId);

                        if SampleReqNo <> '' then begin
                            if UserRec."Merchandizer All Group" = false then begin

                                if UserRec."Merchandizer Group Name" <> '' then begin

                                    StyleMasterRec.Reset();
                                    StyleMasterRec.SetRange("Merchandizer Group Name", UserRec."Merchandizer Group Name");

                                    if StyleMasterRec.FindFirst() then begin
                                        repeat

                                            if StyleNo <> StyleMasterRec."No." then begin
                                                StyleNo := StyleMasterRec."No.";
                                                StyleMasterRec.Mark(true)
                                            end;

                                        until StyleMasterRec.Next() = 0;
                                        StyleMasterRec.MarkedOnly(true);

                                        if Page.RunModal(51066, StyleMasterRec) = Action::LookupOK then begin

                                            DestinationStyle := StyleMasterRec."No.";
                                            DestinationStyleName := StyleMasterRec."Style No.";

                                        end;
                                    end;
                                end
                                else
                                    Error('Merchandizer Group not assigned for the user.');
                            end
                            else begin

                                StyleMasterRec.Reset();
                                if StyleMasterRec.FindFirst() then begin
                                    repeat
                                        if StyleNo <> StyleMasterRec."No." then begin

                                            if SourceStyle <> StyleMasterRec."No." then begin
                                                StyleNo := StyleMasterRec."No.";
                                                StyleMasterRec.Mark(true)
                                            end;

                                        end;
                                    until StyleMasterRec.Next() = 0;
                                    StyleMasterRec.MarkedOnly(true);

                                    if Page.RunModal(51066, StyleMasterRec) = Action::LookupOK then begin
                                        DestinationStyle := StyleMasterRec."No.";
                                        DestinationStyleName := StyleMasterRec."Style No.";
                                    end;
                                end;
                            end;
                        end
                        else
                            Error('Invalid sample requisition');
                    end;
                }

                field(DestinationStyleName; DestinationStyleName)
                {
                    ApplicationArea = All;
                    Caption = 'Target Style Name';
                    Editable = false;
                }

                field("Sample Details"; "Sample Details")
                {
                    ApplicationArea = All;
                }

                field("Related Documents"; "Related Documents")
                {
                    ApplicationArea = All;
                }

                field("Accessories/BOM"; "Accessories/BOM")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("CopySampleRequisition")
            {
                ApplicationArea = All;
                Caption = 'Copy Sample Requisition';
                Image = CopyGLtoCostBudget;

                trigger OnAction()
                var
                    SampleReqHeaderNewRec: Record "Sample Requsition Header";
                    SampleReqHeaderRec: Record "Sample Requsition Header";
                    SampleReqLineNewRec: Record "Sample Requsition Line";
                    SampleReqAccNewRec: Record "Sample Requsition Acce";
                    NoSeriesManagementCode: Codeunit NoSeriesManagement;
                    SampleReqDocNewRec: Record "Sample Requsition Doc";
                    SampleReqLineRec: Record "Sample Requsition Line";
                    SampleReqAccRec: Record "Sample Requsition Acce";
                    SampleReqDocRec: Record "Sample Requsition Doc";
                    LoginSessionsRec: Record LoginSessions;
                    NavAppSetupRec: Record "NavApp Setup";
                    UserRec: Record "User Setup";
                    LoginRec: Page "Login Card";
                    NextReqNo: Code[20];

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
                        LoginSessionsRec.FindSet();
                    end;

                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    //Get User Details
                    UserRec.Reset();
                    UserRec.Get(UserId);

                    if SampleReqNo <> '' then begin

                        if DestinationStyle <> '' then begin

                            SampleReqHeaderRec.Reset();
                            SampleReqHeaderRec.SetRange("No.", SampleReqNo);

                            if SampleReqHeaderRec.FindFirst() then begin

                                NextReqNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."SAMPLE Nos.", Today(), true);

                                SampleReqHeaderNewRec.Init();
                                SampleReqHeaderNewRec."No." := NextReqNo;
                                SampleReqHeaderNewRec."Buyer No." := SampleReqHeaderRec."Buyer No.";
                                SampleReqHeaderNewRec."Buyer Name" := SampleReqHeaderRec."Buyer Name";
                                SampleReqHeaderNewRec."Style No." := DestinationStyle;
                                SampleReqHeaderNewRec."Style Name" := DestinationStyleName;
                                SampleReqHeaderNewRec."Garment Type Name" := SampleReqHeaderRec."Garment Type Name";
                                SampleReqHeaderNewRec."Garment Type No" := SampleReqHeaderRec."Garment Type No";
                                SampleReqHeaderNewRec."Wash Type Name" := SampleReqHeaderRec."Wash Type Name";
                                SampleReqHeaderNewRec."Wash Type No." := SampleReqHeaderRec."Wash Type No.";
                                SampleReqHeaderNewRec."Wash Plant Name" := SampleReqHeaderRec."Wash Plant Name";
                                SampleReqHeaderNewRec."Wash Plant No." := SampleReqHeaderRec."Wash Plant No.";
                                SampleReqHeaderNewRec."Sample Room Name" := SampleReqHeaderRec."Sample Room Name";
                                SampleReqHeaderNewRec."Sample Room No." := SampleReqHeaderRec."Sample Room No.";
                                SampleReqHeaderNewRec.Remarks := SampleReqHeaderRec.Remarks;
                                SampleReqHeaderNewRec.Status := SampleReqHeaderRec.Status;
                                SampleReqHeaderNewRec."Global Dimension Code" := SampleReqHeaderRec."Global Dimension Code";
                                SampleReqHeaderNewRec.Type := SampleReqHeaderRec.Type;
                                SampleReqHeaderNewRec.Qty := SampleReqHeaderRec.Qty;
                                SampleReqHeaderNewRec."Group HD" := SampleReqHeaderRec."Group HD";
                                SampleReqHeaderNewRec.WriteToMRPStatus := SampleReqHeaderRec.WriteToMRPStatus;
                                SampleReqHeaderNewRec."Brand No" := SampleReqHeaderRec."Brand No";
                                SampleReqHeaderNewRec."Brand Name" := SampleReqHeaderRec."Brand Name";
                                SampleReqHeaderNewRec."Sample Type" := SampleReqHeaderRec."Sample Type";

                                SampleReqHeaderNewRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                SampleReqHeaderNewRec."Merchandizer Group Name" := UserRec."Merchandizer Group Name";
                                SampleReqHeaderNewRec."Created Date" := Today;
                                SampleReqHeaderNewRec."Created User" := UserId;
                                SampleReqHeaderNewRec.Insert();

                                if "Sample Details" = true then begin

                                    SampleReqLineRec.Reset();
                                    SampleReqLineRec.SetRange("No.", SampleReqNo);

                                    if SampleReqLineRec.FindFirst() then begin
                                        repeat
                                            SampleReqLineNewRec.Init();
                                            SampleReqLineNewRec."No." := NextReqNo;
                                            SampleReqLineNewRec."Line No." := SampleReqLineRec."Line No.";
                                            SampleReqLineNewRec."Sample No." := SampleReqLineRec."Sample No.";
                                            SampleReqLineNewRec."Sample Name" := SampleReqLineRec."Sample Name";
                                            SampleReqLineNewRec."Fabrication Name" := SampleReqLineRec."Fabrication Name";
                                            SampleReqLineNewRec."Fabrication No." := SampleReqLineRec."Fabrication No.";
                                            SampleReqLineNewRec."Color No" := SampleReqLineRec."Color No";
                                            SampleReqLineNewRec."Color Name" := SampleReqLineRec."Color Name";
                                            SampleReqLineNewRec.Qty := SampleReqLineRec.Qty;
                                            SampleReqLineNewRec.Size := SampleReqLineRec.Size;
                                            SampleReqLineNewRec."Req Date" := SampleReqLineRec."Req Date";
                                            SampleReqLineNewRec.Comment := SampleReqLineRec.Comment;
                                            SampleReqLineNewRec."Plan Start Date" := SampleReqLineRec."Plan Start Date";
                                            SampleReqLineNewRec."Plan End Date" := SampleReqLineRec."Plan End Date";
                                            SampleReqLineNewRec.Status := SampleReqLineRec.Status;
                                            SampleReqLineNewRec."Complete Qty" := SampleReqLineRec."Complete Qty";
                                            SampleReqLineNewRec."Reject Qty" := SampleReqLineRec."Reject Qty";
                                            SampleReqLineNewRec."Reject Comment" := SampleReqLineRec."Reject Comment";
                                            SampleReqLineNewRec."Buyer No." := SampleReqLineRec."Buyer No.";
                                            SampleReqLineNewRec."Buyer Name" := SampleReqLineRec."Buyer Name";
                                            SampleReqLineNewRec."Pattern Date" := SampleReqLineRec."Pattern Date";
                                            SampleReqLineNewRec."Pattern/Cutting Date" := SampleReqLineRec."Pattern/Cutting Date";
                                            SampleReqLineNewRec."Cutting Date" := SampleReqLineRec."Cutting Date";
                                            SampleReqLineNewRec."Sewing Date" := SampleReqLineRec."Sewing Date";
                                            SampleReqLineNewRec."Send Wash Date" := SampleReqLineRec."Send Wash Date";
                                            SampleReqLineNewRec."Received Wash Date" := SampleReqLineRec."Received Wash Date";
                                            SampleReqLineNewRec."Group Head" := SampleReqLineRec."Group Head";
                                            SampleReqLineNewRec."Style Name" := DestinationStyleName;
                                            SampleReqLineNewRec."Style No." := DestinationStyle;
                                            SampleReqLineNewRec."SalesOrder No." := SampleReqLineRec."SalesOrder No.";
                                            SampleReqLineNewRec."Pattern Hours" := SampleReqLineRec."Pattern Hours";
                                            SampleReqLineNewRec."Pattern Maker" := SampleReqLineRec."Pattern Maker";
                                            SampleReqLineNewRec."Pattern Work center Code" := SampleReqLineRec."Pattern Work center Code";
                                            SampleReqLineNewRec."Pattern Work center Name" := SampleReqLineRec."Pattern Work center Name";
                                            SampleReqLineNewRec."Cuting Hours" := SampleReqLineRec."Cuting Hours";
                                            SampleReqLineNewRec.Cutter := SampleReqLineRec.Cutter;
                                            SampleReqLineNewRec."Cut Work center Code" := SampleReqLineRec."Cut Work center Code";
                                            SampleReqLineNewRec."Cut Work center Name" := SampleReqLineRec."Cut Work center Name";
                                            SampleReqLineNewRec."Sewing Hours" := SampleReqLineRec."Sewing Hours";
                                            SampleReqLineNewRec."Sewing Operator" := SampleReqLineRec."Sewing Operator";
                                            SampleReqLineNewRec."Sew Work center Code" := SampleReqLineRec."Sew Work center Code";
                                            SampleReqLineNewRec."Sew Work center Name" := SampleReqLineRec."Sew Work center Name";
                                            SampleReqLineNewRec."Wash Sender" := SampleReqLineRec."Wash Sender";
                                            SampleReqLineNewRec."FG Code" := SampleReqLineRec."FG Code";
                                            SampleReqLineNewRec."Routing Code" := SampleReqLineRec."Routing Code";
                                            SampleReqLineNewRec."Finishing Date" := SampleReqLineRec."Finishing Date";
                                            SampleReqLineNewRec."Finishing Hours" := SampleReqLineRec."Finishing Hours";
                                            SampleReqLineNewRec."Finishing Operator" := SampleReqLineRec."Finishing Operator";
                                            SampleReqLineNewRec."Finishing Work center Code" := SampleReqLineRec."Finishing Work center Code";
                                            SampleReqLineNewRec."Finishing Work center Name" := SampleReqLineRec."Finishing Work center Name";
                                            SampleReqLineNewRec."QC Date" := SampleReqLineRec."QC Date";
                                            SampleReqLineNewRec."QC/Finishing Date" := SampleReqLineRec."QC/Finishing Date";
                                            SampleReqLineNewRec."Pattern Cuting Hours" := SampleReqLineRec."Pattern Cuting Hours";
                                            SampleReqLineNewRec."Pattern Cutter" := SampleReqLineRec."Pattern Cutter";
                                            SampleReqLineNewRec."QC Hours" := SampleReqLineRec."QC Hours";
                                            SampleReqLineNewRec."Quality Checker" := SampleReqLineRec."Quality Checker";
                                            SampleReqLineNewRec."QC Finish Hours" := SampleReqLineRec."QC Finish Hours";
                                            SampleReqLineNewRec."Quality Finish Checker" := SampleReqLineRec."Quality Finish Checker";
                                            SampleReqLineNewRec."Garment Type" := SampleReqLineRec."Garment Type";
                                            SampleReqLineNewRec."Garment Type No" := SampleReqLineRec."Garment Type No";
                                            SampleReqLineNewRec."Brand Name" := SampleReqLineRec."Brand Name";
                                            SampleReqLineNewRec."Brand No" := SampleReqLineRec."Brand No";
                                            SampleReqLineNewRec."Wash Receiver" := SampleReqLineRec."Wash Receiver";

                                            SampleReqLineNewRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                            SampleReqLineNewRec."Merchandizer Group Name" := UserRec."Merchandizer Group Name";
                                            SampleReqLineNewRec."Created Date" := Today;
                                            SampleReqLineNewRec."Created User" := UserId;
                                            SampleReqLineNewRec.Insert();

                                        until SampleReqLineRec.Next() = 0;
                                    end;

                                end;

                                if "Related Documents" = true then begin

                                    SampleReqDocRec.Reset();
                                    SampleReqDocRec.SetRange("No.", SampleReqNo);

                                    if SampleReqDocRec.FindSet() then begin
                                        repeat
                                            SampleReqDocNewRec.Init();
                                            SampleReqDocNewRec."No." := NextReqNo;
                                            SampleReqDocNewRec."Line No." := SampleReqDocRec."Line No.";
                                            SampleReqDocNewRec."Doc Type No." := SampleReqDocRec."Doc Type No.";
                                            SampleReqDocNewRec."Doc Type Name" := SampleReqDocRec."Doc Type Name";
                                            SampleReqDocNewRec.Path := SampleReqDocRec.Path;
                                            SampleReqDocNewRec.FileType := SampleReqDocRec.FileType;
                                            SampleReqDocNewRec.View := SampleReqDocRec.View;

                                            SampleReqDocNewRec."Created Date" := Today;
                                            SampleReqDocNewRec."Created User" := UserId;
                                            SampleReqDocNewRec.Insert()

                                        until SampleReqDocRec.Next() = 0;
                                    end;
                                end;

                                if "Accessories/BOM" = true then begin
                                    SampleReqAccRec.Reset();
                                    SampleReqAccRec.SetRange("No.", SampleReqNo);

                                    if SampleReqAccRec.FindFirst() then begin
                                        repeat

                                            SampleReqAccNewRec.Init();
                                            SampleReqAccNewRec."No." := NextReqNo;
                                            SampleReqAccNewRec."Line No." := SampleReqAccRec."Line No.";
                                            SampleReqAccNewRec."Item No." := SampleReqAccRec."Item No.";
                                            SampleReqAccNewRec."Item Name" := SampleReqAccRec."Item Name";
                                            SampleReqAccNewRec."Main Category No." := SampleReqAccRec."Main Category No.";
                                            SampleReqAccNewRec."Main Category Name" := SampleReqAccRec."Main Category Name";
                                            SampleReqAccNewRec."Article No." := SampleReqAccRec."Article No.";
                                            SampleReqAccNewRec."Article Name." := SampleReqAccRec."Article Name.";
                                            SampleReqAccNewRec."Dimension No." := SampleReqAccRec."Dimension No.";
                                            SampleReqAccNewRec."Dimension Name." := SampleReqAccRec."Dimension Name.";
                                            SampleReqAccNewRec."Unit N0." := SampleReqAccRec."Unit N0.";
                                            SampleReqAccNewRec.Type := SampleReqAccRec.Type;
                                            SampleReqAccNewRec.Consumption := SampleReqAccRec.Consumption;
                                            SampleReqAccNewRec.WST := SampleReqAccRec.WST;
                                            SampleReqAccNewRec.Rate := SampleReqAccRec.Rate;
                                            SampleReqAccNewRec.Value := SampleReqAccRec.Value;
                                            SampleReqAccNewRec."Supplier No." := SampleReqAccRec."Supplier No.";
                                            SampleReqAccNewRec."Supplier Name." := SampleReqAccRec."Supplier Name.";
                                            SampleReqAccNewRec."Sub Category No." := SampleReqAccRec."Sub Category No.";
                                            SampleReqAccNewRec."Sub Category Name" := SampleReqAccRec."Sub Category Name";
                                            SampleReqAccNewRec.Requirment := SampleReqAccRec.Requirment;
                                            SampleReqAccNewRec.AjstReq := SampleReqAccRec.AjstReq;
                                            SampleReqAccNewRec.Qty := SampleReqAccRec.Qty;
                                            SampleReqAccNewRec."Placement of GMT" := SampleReqAccRec."Placement of GMT";
                                            SampleReqAccNewRec."GMT Color No." := SampleReqAccRec."GMT Color No.";
                                            SampleReqAccNewRec."GMT Color Name" := SampleReqAccRec."GMT Color Name";
                                            SampleReqAccNewRec."GMT Size Name" := SampleReqAccRec."GMT Size Name";
                                            SampleReqAccNewRec."Item Color No." := SampleReqAccRec."Item Color No.";
                                            SampleReqAccNewRec."Item Color Name" := SampleReqAccRec."Item Color Name";
                                            SampleReqAccNewRec."Production BOM No." := SampleReqAccRec."Production BOM No.";
                                            SampleReqAccNewRec."Sub Category No." := SampleReqAccRec."Sub Category No.";
                                            SampleReqAccNewRec."Sub Category Name" := SampleReqAccRec."Sub Category Name";
                                            SampleReqAccNewRec.Remarks := SampleReqAccRec.Remarks;
                                            SampleReqAccNewRec.Si := SampleReqAccRec.Si;

                                            SampleReqAccNewRec."Created Date" := Today;
                                            SampleReqAccNewRec."Created User" := UserId;

                                            SampleReqAccNewRec.Insert()
                                        until SampleReqAccRec.Next() = 0;
                                    end;
                                end;
                                Message('Sample Requisition No %1 Created.', NextReqNo);
                            end;
                        end
                        else
                            Error('Invalid target style');
                    end
                    else
                        Error('Invalid sample requisition');
                end;
            }
        }
    }

    var
        SourceStyle: Code[20];
        SourceStyleName: Text[50];
        DestinationStyle: Code[20];
        DestinationStyleName: Text[50];
        "Sample Details": Boolean;
        "Related Documents": Boolean;
        "Accessories/BOM": Boolean;
        SampleReqNo: Code[20];
}