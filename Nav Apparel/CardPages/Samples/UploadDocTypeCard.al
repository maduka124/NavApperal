page 50417 "Upload Document Type Card"
{
    PageType = Card;
    SourceTable = "Upload Document Type";
    Caption = 'Upload Document Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Doc No."; rec."Doc No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type No';
                }

                field("Doc Name"; rec."Doc Name")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                }
            }
        }
    }
}