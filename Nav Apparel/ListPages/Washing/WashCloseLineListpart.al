page 51461 WashCloseLine
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashCloseLine;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                    Editable = false;
                }

                field(Reject; Rec.Reject)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashinMasterRec: Record WashingMaster;
                    begin

                        WashinMasterRec.Reset();
                        WashinMasterRec.SetRange("Style No", Rec."Style No");
                        WashinMasterRec.SetRange("PO No", Rec."PO No");
                        WashinMasterRec.SetRange(Lot, Rec.Lot);
                        WashinMasterRec.SetRange("Color Name", Rec."Color Name");

                        if WashinMasterRec.FindSet() then begin

                            if WashinMasterRec."Cut Qty" <> 0 then begin
                                Rec."CST%" := ((Rec.Reject + Rec.Sample + Rec."Left Over" + Rec."Production Loss") / WashinMasterRec."Cut Qty") / 100;
                                WashinMasterRec."Close Reject" := Rec.Reject;
                                WashinMasterRec."Close Sample" := Rec.Sample;
                                WashinMasterRec."Close Left Over" := Rec."Left Over";
                                WashinMasterRec."Close Production Loss" := Rec."Production Loss";
                                WashinMasterRec."Close CST%" := Rec."CST%";
                                WashinMasterRec.Modify(true);
                            end
                            else
                                Error('Cut Qty is 0,can not divide');
                        end;
                    end;
                }

                field(Sample; Rec.Sample)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        WashinMasterRec: Record WashingMaster;
                    begin

                        WashinMasterRec.Reset();
                        WashinMasterRec.SetRange("Style No", Rec."Style No");
                        WashinMasterRec.SetRange("PO No", Rec."PO No");
                        WashinMasterRec.SetRange(Lot, Rec.Lot);
                        WashinMasterRec.SetRange("Color Name", Rec."Color Name");

                        if WashinMasterRec.FindSet() then begin

                            if WashinMasterRec."Cut Qty" <> 0 then begin
                                Rec."CST%" := ((Rec.Reject + Rec.Sample + Rec."Left Over" + Rec."Production Loss") / WashinMasterRec."Cut Qty") / 100;
                                WashinMasterRec."Close Reject" := Rec.Reject;
                                WashinMasterRec."Close Sample" := Rec.Sample;
                                WashinMasterRec."Close Left Over" := Rec."Left Over";
                                WashinMasterRec."Close Production Loss" := Rec."Production Loss";
                                WashinMasterRec."Close CST%" := Rec."CST%";
                                WashinMasterRec.Modify(true);
                            end
                            else
                                Error('Cut Qty is 0,can not divide');
                        end;
                    end;
                }

                field("Left Over"; Rec."Left Over")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        WashinMasterRec: Record WashingMaster;
                    begin

                        WashinMasterRec.Reset();
                        WashinMasterRec.SetRange("Style No", Rec."Style No");
                        WashinMasterRec.SetRange("PO No", Rec."PO No");
                        WashinMasterRec.SetRange(Lot, Rec.Lot);
                        WashinMasterRec.SetRange("Color Name", Rec."Color Name");

                        if WashinMasterRec.FindSet() then begin

                            if WashinMasterRec."Cut Qty" <> 0 then begin
                                Rec."CST%" := ((Rec.Reject + Rec.Sample + Rec."Left Over" + Rec."Production Loss") / WashinMasterRec."Cut Qty") / 100;
                                WashinMasterRec."Close Reject" := Rec.Reject;
                                WashinMasterRec."Close Sample" := Rec.Sample;
                                WashinMasterRec."Close Left Over" := Rec."Left Over";
                                WashinMasterRec."Close Production Loss" := Rec."Production Loss";
                                WashinMasterRec."Close CST%" := Rec."CST%";
                                WashinMasterRec.Modify(true);
                            end
                            else
                                Error('Cut Qty is 0,can not divide');
                        end;
                    end;
                }

                field("Production Loss"; Rec."Production Loss")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        WashinMasterRec: Record WashingMaster;
                    begin

                        WashinMasterRec.Reset();
                        WashinMasterRec.SetRange("Style No", Rec."Style No");
                        WashinMasterRec.SetRange("PO No", Rec."PO No");
                        WashinMasterRec.SetRange(Lot, Rec.Lot);
                        WashinMasterRec.SetRange("Color Name", Rec."Color Name");

                        if WashinMasterRec.FindSet() then begin

                            if WashinMasterRec."Cut Qty" <> 0 then begin
                                Rec."CST%" := ((Rec.Reject + Rec.Sample + Rec."Left Over" + Rec."Production Loss") / WashinMasterRec."Cut Qty") / 100;
                                WashinMasterRec."Close Reject" := Rec.Reject;
                                WashinMasterRec."Close Sample" := Rec.Sample;
                                WashinMasterRec."Close Left Over" := Rec."Left Over";
                                WashinMasterRec."Close Production Loss" := Rec."Production Loss";
                                WashinMasterRec."Close CST%" := Rec."CST%";
                                WashinMasterRec.Modify(true);
                            end
                            else
                                Error('Cut Qty is 0,can not divide');
                        end;
                    end;
                }

                field("CST%"; Rec."CST%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Closing Status"; Rec."Closing Status")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashinMasterRec: Record WashingMaster;
                    begin

                        WashinMasterRec.Reset();
                        WashinMasterRec.SetRange("Style No", Rec."Style No");
                        WashinMasterRec.SetRange("PO No", Rec."PO No");
                        WashinMasterRec.SetRange(Lot, Rec.Lot);
                        WashinMasterRec.SetRange("Color Name", Rec."Color Name");

                        if WashinMasterRec.FindFirst() then begin
                            WashinMasterRec."Closing Status" := Rec."Closing Status";

                            if rec."Closing Status" = rec."Closing Status"::Open then
                                WashinMasterRec."Wash Close/Open" := true
                            else
                                WashinMasterRec."Wash Close/Open" := false;

                            WashinMasterRec.Modify(true);
                        end;

                    end;
                }
            }
        }
    }
}