report 71012754 SizeColourwiseQuantity
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Size Colour wise Quantity Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/SizeColourwiseQuantity.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");
            column(Buyer_Name; "Buyer Name")
            { }
            column(Style_No_; "Style No.")
            { }
            column(Order_Qty; "Order Qty")
            { }
            column(Garment_Type_Name; "Garment Type Name")
            { }
            column(Brand_Name; "Brand Name")
            { }
            column(Season_Name; "Season Name")
            { }
            column(Ship_Date; "Ship Date")
            { }
            column(CompLogo; comRec.Picture)
            { }
            dataitem(AssorColorSizeRatioView; AssorColorSizeRatioView)
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Style No.");
                // RequestFilterFields = "PO No.";

                column(PO_No_; "PO No.")
                { }
                column(Lot_No_; "Lot No.")
                { }
                column(Line_No_; "Line No.")
                { }
                column(Pack_No; "Pack No")
                { }
                column(SHID_LOT; "SHID/LOT")
                { }
                column(Country_Name; "Country Name")
                { }
                column(Colour_Name; "Colour Name")
                { }
                column(Total; Total)
                { }
                column("One"; oneDecimal)
                { }
                // column("Onepo"; oneDecimal)
                // { }
                column("OneTXT"; "1")
                { }
                column("Two"; twoDecimal)
                { }
                // column("Twopo"; twoDecimal)
                // { }
                column("TwoTxt"; "2")
                { }
                column("ThreeTxt"; "3")
                { }
                column("Three"; threeDecimal)
                { }
                // column("Threepo"; threeDecimal)
                // { }
                column("FourTxt"; "4")
                { }
                column("four"; fourDecimal)
                { }
                // column("fourpo"; fourDecimal)
                // { }
                column("FiveTxt"; "5")
                { }
                column("five"; fiveDecimal)
                { }
                // column("fivepo"; fiveDecimal)
                // { }
                column("SixTxt"; "6")
                { }
                column("six"; sixDecimal)
                { }
                // column("sixpo"; sixDecimal)
                // { }
                column("SevenTxt"; "7")
                { }
                column("seven"; sevenDecimal)
                { }
                // column("sevenpo"; sevenDecimal)
                // { }
                column("EightTxt"; "8")
                { }
                column("Eight"; eightDecimal)
                { }
                // column("Eightpo"; eightDecimal)
                // { }
                column("NineTxt"; "9")
                { }
                column("Nine"; nineDecimal)
                { }
                // column("Ninepo"; nineDecimal)
                // { }
                column("TenTxt"; "10")
                { }
                column("Ten"; tenDecimal)
                { }
                // column("Tenpo"; tenDecimal)
                // { }
                column("ElevenTxt"; "11")
                { }
                column("Eleven"; elevenDecimal)
                { }
                // column("Elevenpo"; elevenDecimal)
                // { }
                column("TwelveTxt"; "12")
                { }
                column("Twelve"; twelveDecimal)
                { }
                // column("Twelvepo"; twelveDecimal)
                // { }
                column("ThirteenTxt"; "13")
                { }
                column("Thirteen"; thirteenDecimal)
                { }
                // column("Thirteenpo"; thirteenDecimal)
                // { }
                column("FourteenTxt"; "14")
                { }
                column("Fourteen"; fourteenDecimal)
                { }
                // column("Fourteenpo"; fourteenDecimal)
                // { }
                column("FiftenTxt"; "15")
                { }
                column("Fifteen"; fifteenDecimal)
                { }
                // column("Fifteenpo"; fifteenDecimal)
                // { }
                column("SixteenTxt"; "16")
                { }
                column("Sixteen"; sixteenDecimal)
                { }
                // column("Sixteenpo"; sixteenDecimal)
                // { }
                column("Seventeen"; "17")
                { }
                column("Eighteen"; "18")
                { }
                column("Nineteen"; "19")
                { }
                column("Twenty"; "20")
                { }
                column("TwentyOne"; "21")
                { }
                column("TwentyTwo"; "22")
                { }
                column("TwentyThree"; "23")
                { }
                column("TwentyFour"; "23")
                { }
                column("TwentyFive"; "25")
                { }
                column("TwentySix"; "26")
                { }
                column("TwentySeven"; "27")
                { }
                column("TwentyEight"; "28")
                { }
                column("TwentyNine"; "29")
                { }
                column("Thirty"; "30")
                { }
                column("ThirtyOne"; "31")
                { }
                column("ThirtyTwo"; "32")
                { }
                column("ThirtyThree"; "33")
                { }
                column("ThirtyFour"; "34")
                { }
                column("ThirtyFive"; "35")
                { }
                column("ThirtySix"; "36")
                { }
                column("ThirtySeven"; "37")
                { }
                column("ThirtyEight"; "38")
                { }
                column("ThirtyNine"; "39")
                { }
                column("Forty"; "40")
                { }
                column("FortyOne"; "41")
                { }
                column("FortyTwo"; "42")
                { }
                column("FortyThree"; "43")
                { }
                column("FortyFour"; "44")
                { }
                column("FortyFive"; "45")
                { }
                column("FortySix"; "46")
                { }
                column("FortySeven"; "47")
                { }
                column("FortyEight"; "48")
                { }
                column("FortyNine"; "49")
                { }
                column("Fifty"; "50")
                { }
                column("FiftyOne"; "51")
                { }
                column("FiftyTwo"; "52")
                { }
                column("FiftyThree"; "53")
                { }
                column("FiftyFour"; "54")
                { }
                column("FiftyFive"; "55")
                { }
                column("FiftySix"; "56")
                { }
                column("FiftySeven"; "57")
                { }
                column("FiftyEight"; "58")
                { }
                column("FiftyNine"; "59")
                { }
                column("Sixty"; "60")
                { }
                column("SixtyOne"; "61")
                { }
                column("SixtyTwo"; "62")
                { }
                column("SixtyThree"; "63")
                { }
                column("SixtyFour"; "64")
                { }
                column(tot; tot)
                { }

                trigger OnAfterGetRecord()
                var
                begin
                    oneDecimal := 0;
                    twoDecimal := 0;
                    threeDecimal := 0;
                    fourDecimal := 0;
                    fiveDecimal := 0;
                    sixDecimal := 0;
                    sevenDecimal := 0;
                    eightDecimal := 0;
                    nineDecimal := 0;
                    tenDecimal := 0;
                    elevenDecimal := 0;
                    twelveDecimal := 0;
                    thirteenDecimal := 0;
                    fourteenDecimal := 0;
                    fifteenDecimal := 0;
                    sixteenDecimal := 0;

                    // Evaluate(one, CopyStr(Format(varIntiger), 1));
                    // SizeRec.reset();
                    // Evaluate(oneDecimal, SizeRec."1");

                    // if "1" <> '*' then begin
                    //     for myInt := 1 To 64 do begin
                    //         case Count of

                    //             1:
                    // tot := 0;

                    if (("1" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(oneDecimal, "1");

                    if (("2" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(twoDecimal, "2");
                    if (("2" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(twoDecimal, "2");

                    if (("3" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(threeDecimal, "3");

                    if (("4" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(fourDecimal, "4");

                    if (("5" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(fiveDecimal, "5");

                    if (("6" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(sixDecimal, "6");

                    if (("7" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(sevenDecimal, "7");

                    if (("8" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(eightDecimal, "8");

                    if (("9" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(nineDecimal, "9");

                    if (("10" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(tenDecimal, "10");

                    if (("11" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(elevenDecimal, "11");

                    if (("12" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(twelveDecimal, "12");

                    if (("13" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(thirteenDecimal, "13");
                    if (("14" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(fourteenDecimal, "14");
                    if (("15" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(fifteenDecimal, "15");
                    if (("16" <> '') and ("Colour Name" <> '*')) then
                        Evaluate(sixteenDecimal, "16");

                    oneDes := oneDecimal;
                    tot += oneDes;
                end;

            }
            trigger OnPreDataItem()
            begin
                SetRange("No.", StyleNum);
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StyleNum; StyleNum)
                    {
                        ApplicationArea = All;
                        Caption = 'Style Number';
                        TableRelation = "Style Master"."No.";

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }

            }
        }
    }


    var

        buyername: Text[50];
        StyleNum: Code[20];
        oneDecimal: Decimal;
        twoDecimal: Decimal;
        threeDecimal: Decimal;
        fourDecimal: Decimal;
        fiveDecimal: Decimal;
        sixDecimal: Decimal;
        sevenDecimal: Decimal;
        eightDecimal: Decimal;
        nineDecimal: Decimal;
        tenDecimal: Decimal;
        elevenDecimal: Decimal;
        twelveDecimal: Decimal;
        thirteenDecimal: Decimal;
        fourteenDecimal: Decimal;
        fifteenDecimal: Decimal;
        sixteenDecimal: Decimal;
        tot: Decimal;
        oneDes: Decimal;
        comRec: Record "Company Information";


}