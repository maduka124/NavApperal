// tableextension 50107 ProdBOMLine extends "Production BOM Line"
// {
//     fields
//     {
//         modify("No.")
//         {
//             trigger OnAfterValidate()
//             var
//                 MainCatRec: Record "Main Category";
//             begin
//                 if Type = Type::Item then begin
//                     if "Main Category Code" <> '' then begin
//                         MainCatRec.Get("Main Category Code");
//                         MainCatRec.TestField("Routing Link Code");
//                         Validate("Routing Link Code", MainCatRec."Routing Link Code");
//                     end;
//                 end;
//             end;
//         }
//     }
// }
