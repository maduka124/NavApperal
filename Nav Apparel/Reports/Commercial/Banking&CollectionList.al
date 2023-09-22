// report 50643 BankingAndCollectionList
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     Caption = 'Banking and Collection List';
//     RDLCLayout = 'Report_Layouts/Commercial/BankingAndCollectionListReport.rdl';
//     DefaultLayout = RDLC;


//     dataset
//     {
//         dataitem("Contract/LCMaster"; "Contract/LCMaster")
//         {
//             DataItemTableView = sorting("No.");

//             column(No_; "No.")
//             { }
//             dataitem("Contract/LCStyle"; "Contract/LCStyle")
//             {
//                 DataItemLinkReference = "Contract/LCMaster";
//                 DataItemLink = "No." = field("No.");
//                 DataItemTableView = sorting("No.");
//                 column(ShipQty; ShipQty)
//                 { }
//                 column(STNo; STNo)
//                 { }

//                 dataitem("Sales Invoice Header"; "Sales Invoice Header")
//                 {
//                     DataItemLinkReference = "Contract/LCStyle";
//                     DataItemLink = "Style No" = field("Style No.");
//                     DataItemTableView = sorting("No.");

//                     dataitem(BankReferenceInvoice; BankReferenceInvoice)
//                     {
//                         DataItemLinkReference = "Sales Invoice Header";
//                         // DataItemLink = BankRefNo = field(BankRefNo);
//                         DataItemTableView = sorting("No.");
//                         column(Ship_Value; "Ship Value")
//                         { }
//                         column(BankRefNo_; Bank_RefNo)
//                         { }
//                         column(Reference_Date; RefDate)
//                         { }
//                         column(Release_Amount; ReleseAmount)
//                         { }
//                         column(Release_Date; ReleaseDate)
//                         { }
//                         column(Margin_A_C_Amount; MarginAcAmount)
//                         { }
//                         column(FC_A_C_Amount; FCAmount)
//                         { }
//                         column(Current_A_C_Amount; CurrentAcAmount)
//                         { }
//                         column(InvoiceDate; InvoiceDate)
//                         { }
//                         column(InvoiceNo; InvoiceNo)
//                         { }
//                         column(CompLogo; comRec.Picture)
//                         { }

//                         trigger OnAfterGetRecord()
//                         begin
//                             BankRefCollRec.SetRange("Invoice No", "Invoice No");
//                             if BankRefCollRec.FindFirst() then begin
//                                 ReleseAmount := BankRefCollRec."Release Amount";
//                                 ReleaseDate := BankRefCollRec."Release Date";
//                                 MarginAcAmount := BankRefCollRec."Margin A/C Amount";
//                                 FCAmount := BankRefCollRec."FC A/C Amount";
//                                 CurrentAcAmount := BankRefCollRec."Current A/C Amount";
//                                 InvoiceNo := BankRefCollRec."Invoice No";
//                                 InvoiceDate := BankRefCollRec."Invoice Date";
//                                 Bank_RefNo := BankRefCollRec."BankRefNo.";
//                                 RefDate := BankRefCollRec."Reference Date";
//                             end;
//                             comRec.Get;
//                             comRec.CalcFields(Picture);
//                         end;


//                     }
//                 }
//                 trigger OnAfterGetRecord()

//                 begin
//                     styleRec.SetRange("Style No.", "Style No.");
//                     if styleRec.FindFirst() then begin
//                         ShipQty := styleRec."Shipped Qty";
//                         STNo := styleRec."Style No.";
//                     end;
//                 end;
//             }
//             trigger OnPreDataItem()
//             begin
//                 SetRange("No.", LcNo);
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     Caption = 'Group By';
//                     field(LcNo; LcNo)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Contract LC No';
//                         TableRelation = "Contract/LCMaster"."No.";

//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//     }



//     var

//         BankRefCollRec: Record BankRefCollectionLine;
//         ReleseAmount: Decimal;
//         ReleaseDate: date;
//         MarginAcAmount: Decimal;
//         CurrentAcAmount: Decimal;
//         FCAmount: Decimal;
//         comRec: Record "Company Information";
//         InvoiceNo: code[50];
//         InvoiceDate: Date;
//         Bank_RefNo: Code[50];
//         RefDate: date;
//         LcNo: Code[20];
//         styleRec: Record "Style Master PO";
//         ShipQty: Integer;
//         STNo: Code[20];
// }