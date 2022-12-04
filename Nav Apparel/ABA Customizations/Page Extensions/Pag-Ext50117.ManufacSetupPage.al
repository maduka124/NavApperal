pageextension 50117 Manufac_Setup_Page extends "Manufacturing Setup"
{
    layout
    {
        addlast(Numbering)
        {
            field("Daily Consumption Nos."; rec."Daily Consumption Nos.")
            {
                ApplicationArea = All;
            }
            field("Style Transfer Nos."; rec."Style Transfer Nos.")
            {
                ApplicationArea = All;
            }
        }
    }
}
