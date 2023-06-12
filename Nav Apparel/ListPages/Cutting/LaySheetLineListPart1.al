page 50661 "Lay Sheet Line1"
{
    PageType = ListPart;
    SourceTable = LaySheetLine1;
    SourceTableView = sorting("LaySheetNo.", "Line No") order(ascending);
    InsertAllowed = false;
    DeleteAllowed = false;
    //ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Record Type"; Rec."Record Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'strongaccent';
                    Caption = 'Type';
                }

                field("1"; Rec."1")
                {
                    ApplicationArea = All;

                }

                field("2"; Rec."2")
                {
                    ApplicationArea = All;

                }

                field("3"; Rec."3")
                {
                    ApplicationArea = All;

                }

                field("4"; Rec."4")
                {
                    ApplicationArea = All;

                }

                field("5"; Rec."5")
                {
                    ApplicationArea = All;

                }

                field("6"; Rec."6")
                {
                    ApplicationArea = All;

                }

                field("7"; Rec."7")
                {
                    ApplicationArea = All;

                }

                field("8"; Rec."8")
                {
                    ApplicationArea = All;

                }

                field("9"; Rec."9")
                {
                    ApplicationArea = All;

                }

                field("10"; Rec."10")
                {
                    ApplicationArea = All;

                }

                field("11"; Rec."11")
                {
                    ApplicationArea = All;

                }

                field("12"; Rec."12")
                {
                    ApplicationArea = All;

                }

                field("13"; Rec."13")
                {
                    ApplicationArea = All;

                }

                field("14"; Rec."14")
                {
                    ApplicationArea = All;

                }

                field("15"; Rec."15")
                {
                    ApplicationArea = All;

                }

                field("16"; Rec."16")
                {
                    ApplicationArea = All;

                }
                field("17"; Rec."17")
                {
                    ApplicationArea = All;

                }

                field("18"; Rec."18")
                {
                    ApplicationArea = All;

                }

                field("19"; Rec."19")
                {
                    ApplicationArea = All;

                }

                field("20"; Rec."20")
                {
                    ApplicationArea = All;

                }

                field("21"; Rec."21")
                {
                    ApplicationArea = All;

                }

                field("22"; Rec."22")
                {
                    ApplicationArea = All;

                }

                field("23"; Rec."23")
                {
                    ApplicationArea = All;

                }

                field("24"; Rec."24")
                {
                    ApplicationArea = All;

                }

                field("25"; Rec."25")
                {
                    ApplicationArea = All;

                }

                field("26"; Rec."26")
                {
                    ApplicationArea = All;

                }

                field("27"; Rec."27")
                {
                    ApplicationArea = All;

                }

                field("28"; Rec."28")
                {
                    ApplicationArea = All;

                }

                field("29"; Rec."29")
                {
                    ApplicationArea = All;

                }

                field("30"; Rec."30")
                {
                    ApplicationArea = All;

                }

                field("31"; Rec."31")
                {
                    ApplicationArea = All;

                }

                field("32"; Rec."32")
                {
                    ApplicationArea = All;

                }

                field("33"; Rec."33")
                {
                    ApplicationArea = All;

                }

                field("34"; Rec."34")
                {
                    ApplicationArea = All;

                }

                field("35"; Rec."35")
                {
                    ApplicationArea = All;

                }

                field("36"; Rec."36")
                {
                    ApplicationArea = All;

                }

                field("37"; Rec."37")
                {
                    ApplicationArea = All;

                }

                field("38"; Rec."38")
                {
                    ApplicationArea = All;

                }

                field("39"; Rec."39")
                {
                    ApplicationArea = All;

                }

                field("40"; Rec."40")
                {
                    ApplicationArea = All;

                }

                field("41"; Rec."41")
                {
                    ApplicationArea = All;

                }

                field("42"; Rec."42")
                {
                    ApplicationArea = All;

                }

                field("43"; Rec."43")
                {
                    ApplicationArea = All;

                }

                field("44"; Rec."44")
                {
                    ApplicationArea = All;

                }

                field("45"; Rec."45")
                {
                    ApplicationArea = All;

                }


                field("46"; Rec."46")
                {
                    ApplicationArea = All;

                }

                field("47"; Rec."47")
                {
                    ApplicationArea = All;

                }

                field("48"; Rec."48")
                {
                    ApplicationArea = All;

                }

                field("49"; Rec."49")
                {
                    ApplicationArea = All;

                }
                field("50"; Rec."50")
                {
                    ApplicationArea = All;

                }

                field("51"; Rec."51")
                {
                    ApplicationArea = All;

                }

                field("52"; Rec."52")
                {
                    ApplicationArea = All;

                }

                field("53"; Rec."53")
                {
                    ApplicationArea = All;

                }

                field("54"; Rec."54")
                {
                    ApplicationArea = All;

                }

                field("55"; Rec."55")
                {
                    ApplicationArea = All;

                }

                field("56"; Rec."56")
                {
                    ApplicationArea = All;

                }

                field("57"; Rec."57")
                {
                    ApplicationArea = All;

                }

                field("58"; Rec."58")
                {
                    ApplicationArea = All;

                }

                field("59"; Rec."59")
                {
                    ApplicationArea = All;

                }

                field("60"; Rec."60")
                {
                    ApplicationArea = All;

                }

                field("61"; Rec."61")
                {
                    ApplicationArea = All;

                }

                field("62"; Rec."62")
                {
                    ApplicationArea = All;

                }

                field("63"; Rec."63")
                {
                    ApplicationArea = All;

                }

                field("64"; Rec."64")
                {
                    ApplicationArea = All;

                }

                field("Color Total"; Rec."Color Total")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }


    // trigger OnAfterGetRecord()
    // var
    // begin
    //     StyleExprTxt := ChangeColor.ChangeColorCutCreation(Rec);

    //     // if ("Record Type" = 'R') then begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := true;
    //     // end
    //     // ELSE begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := false;
    //     // end;
    // end;


    // trigger OnAfterGetCurrRecord()
    // var
    // begin
    //     StyleExprTxt := ChangeColor.ChangeColorCutCreation(Rec);

    //     // if ("Record Type" = 'R') then begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := true;
    //     // end
    //     // ELSE begin
    //     //     Clear(SetEdit1);
    //     //     SetEdit1 := false;
    //     // end;
    // end;


    // var
    //     StyleExprTxt: Text[50];
    //     ChangeColor: Codeunit NavAppCodeUnit;
    //     SetEdit1: Boolean;

}