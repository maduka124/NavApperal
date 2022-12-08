// pageextension 50121 PurchaseOrderExt extends "Purchase Order List"
// {
//     trigger OnOpenPage()
//     var
//         UserSetup: Record "User Setup";
//     begin
//         UserSetup.Get(UserId);
//         if UserSetup."Global Dimension Code" <> '' then
//             rec.SetRange("Shortcut Dimension 1 Code", UserSetup."Global Dimension Code");
//     end;

// }
