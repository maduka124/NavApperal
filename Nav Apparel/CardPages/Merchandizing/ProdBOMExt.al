// pageextension 51158 ProdBOMCardExt extends "Production BOM"
// {
//     layout
//     {
//         modify(Description)
//         {
//             trigger OnAfterValidate()
//             var
//                 LoginSessionsRec: Record LoginSessions;
//                 LoginRec: Page "Login Card";
//             begin
//                 //Check whether user logged in or not
//                 LoginSessionsRec.Reset();
//                 LoginSessionsRec.SetRange(SessionID, SessionId());

//                 if not LoginSessionsRec.FindSet() then begin  //not logged in
//                     Clear(LoginRec);
//                     LoginRec.LookupMode(true);
//                     LoginRec.RunModal();

//                     LoginSessionsRec.Reset();
//                     LoginSessionsRec.SetRange(SessionID, SessionId());
//                     LoginSessionsRec.FindSet();
//                     rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
//                 end
//                 else begin   //logged in
//                     rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
//                 end;
//             end;
//         }
//     }
