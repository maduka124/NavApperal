page 71012823 "YY Requsition ListPart"
{
    PageType = ListPart;
    SourceTable = "YY Requsition Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                    Editable = false;
                }

                field("YY Type"; rec."YY Type")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        YYTypeRec: Record "YY Type";
                    begin
                        YYTypeRec.Reset();
                        YYTypeRec.SetRange("YY Type Desc", rec."YY Type");
                        if YYTypeRec.FindSet() then
                            rec."YY Type No." := YYTypeRec."No.";
                    end;
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", rec."Main Category Name");
                        if MainCategoryRec.FindSet() then
                            rec."Main Category No." := MainCategoryRec."No.";
                    end;
                }

                field("Fabric/Time Desc"; rec."Fabric/Time Desc")
                {
                    ApplicationArea = All;
                    Caption = 'Fabric/Item Description';
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, rec."Fabric/Time Desc");
                        if ItemRec.FindSet() then
                            rec."Fabric/Time Desc No" := ItemRec."No.";
                    end;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", rec."Color Name");
                        if ColourRec.FindSet() then
                            rec."Color No" := ColourRec."No.";
                    end;
                }

                field("Wash Type Name"; rec."Wash Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        WashTypeRec: Record "Wash Type";
                    begin
                        WashTypeRec.Reset();
                        WashTypeRec.SetRange("Wash Type Name", rec."Wash Type Name");
                        if WashTypeRec.FindSet() then
                            rec."Wash Type No" := WashTypeRec."No.";
                    end;
                }

                field(Width; rec.Width)
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("Skincage (L)"; rec."Skincage (L)")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("Width( W)"; rec."Width( W)")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("TARGET YY"; rec."TARGET YY")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("Acutal YY"; rec."Acutal YY")
                {
                    ApplicationArea = All;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("1"; rec."1")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }
                field("2"; rec."2")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("3"; rec."3")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("4"; rec."4")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("5"; rec."5")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("6"; rec."6")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("7"; rec."7")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("8"; rec."8")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("9"; rec."9")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("10"; rec."10")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("11"; rec."11")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("12"; rec."12")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("13"; rec."13")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("14"; rec."14")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("15"; rec."15")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("16"; rec."16")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("17"; rec."17")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("18"; rec."18")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("19"; rec."19")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("20"; rec."20")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("21"; rec."21")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("22"; rec."22")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("23"; rec."23")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("24"; rec."24")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("25"; rec."25")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("26"; rec."26")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("27"; rec."27")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("28"; rec."28")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("29"; rec."29")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("30"; rec."30")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("31"; rec."31")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("32"; rec."32")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("33"; rec."33")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("34"; rec."34")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("35"; rec."35")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("36"; rec."36")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("37"; rec."37")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("38"; rec."38")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("39"; rec."39")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("40"; rec."40")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("41"; rec."41")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("42"; rec."42")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("43"; rec."43")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("44"; rec."44")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("45"; rec."45")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("46"; rec."46")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("47"; rec."47")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("48"; rec."48")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("49"; rec."49")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("50"; rec."50")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("51"; rec."51")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("52"; rec."52")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("53"; rec."53")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("54"; rec."54")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("55"; rec."55")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("56"; rec."56")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("57"; rec."57")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("58"; rec."58")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("59"; rec."59")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("60"; rec."60")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("61"; rec."61")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("62"; rec."62")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("63"; rec."63")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }

                field("64"; rec."64")
                {
                    ApplicationArea = All;
                    Editable = SetEdit1;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then
            UserRole := UserRec.UserRole;

        if UserRole = 'CAD' then
            SetEdit1 := false
        else
            SetEdit1 := true;
    end;

    var
        SetEdit1: Boolean;
        UserRole: Text[50];
}