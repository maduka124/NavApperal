page 51365 StyleWiseMachineReqLine2
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FactoryAndLineMachineLine;
    Editable = false;
    SourceTableView = sorting(Year, Month) order(ascending);


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field(Factory; Rec.Factory)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Machine type"; rec."Machine type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("Machine Description"; Rec."Machine Description")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("1 New"; Rec."1 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '1';
                }
                field("2 New"; Rec."2 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '2';
                }
                field("3 New"; Rec."3 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '3';
                }
                field("4 New"; Rec."4 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '4';
                }
                field("5 New"; Rec."5 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '5';
                }
                field("6 New"; Rec."6 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '6';
                }
                field("7 New"; Rec."7 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '7';
                }
                field("8 New"; Rec."8 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '8';
                }
                field("9 New"; rec."9 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '9';
                }
                field("10 New"; Rec."10 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '10';
                }
                field("11 New"; Rec."11 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '11';
                }
                field("12 New"; rec."12 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '12';
                }

                field("13 New"; Rec."13 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '13';
                }
                field("14 New"; rec."14 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '14';
                }

                field("15 New"; Rec."15 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '15';
                }
                field("16 New"; Rec."16 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '16';
                }
                field("17 New"; Rec."17 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '17';
                }
                field("18 New"; Rec."18 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '18';
                }
                field("19 New"; Rec."19 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '19';
                }
                field("20 New "; Rec."20 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '20';
                }
                field("21 New"; Rec."21 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '21';
                }
                field("22 New"; Rec."22 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '22';
                }
                field("23 New"; Rec."23 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '23';
                }
                field("24 New"; Rec."24 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '24';
                }
                field("25 New"; Rec."25 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '25';
                }
                field("26"; Rec."26 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '26';
                }
                field("27 New"; Rec."27 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '27';
                }
                field("28 New"; Rec."28 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '28';
                }
                field("29 New"; Rec."29 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '27';
                }
                field("30 New"; Rec."30 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '30';
                }
                field("31 New"; Rec."31 New")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = '31';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorMachineReq(Rec);
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}