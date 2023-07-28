page 51365 StyleWiseMachineReqLine2
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FactoryAndLineMachineLine;
    Editable = false;


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
                field("1"; Rec."1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("2"; Rec."2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("3"; Rec."3")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("4"; Rec."4")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("5"; Rec."5")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("6"; Rec."6")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("7"; Rec."7")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("8"; Rec."8")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("9"; rec."9")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("10"; Rec."10")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("11"; Rec."11")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("12"; rec."12")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("13"; Rec."13")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("14"; rec."14")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("15"; Rec."15")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("16"; Rec."16")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("17"; Rec."17")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("18"; Rec."18")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("19"; Rec."19")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("20"; Rec."20")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("21"; Rec."21")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("22"; Rec."22")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("23"; Rec."23")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("24"; Rec."24")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("25"; Rec."25")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("26"; Rec."26")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("27"; Rec."27")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("28"; Rec."28")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("29"; Rec."29")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("30"; Rec."30")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field("31"; Rec."31")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
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