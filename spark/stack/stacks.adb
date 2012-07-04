package body Stacks
--# own State is Stack, Stack_Pointer;
is
    Stack_Size: constant := 100;
    subtype Stack_Index_Type is Natural range 1 .. Stack_Size;
    subtype Pointer_Index_Type is Natural range 0 .. Stack_Size;
    type Stack_Type is array(Stack_Index_Type) of Integer;

    Stack: Stack_Type;
    Stack_Pointer: Pointer_Index_Type;

    procedure Push(Add_Me: in Integer)
    --# global in out Stack; in out Stack_Pointer;
    --# derives Stack from Add_Me, Stack_Pointer, Stack &
    --#         Stack_Pointer from Stack_Pointer;
    is
    begin
        if Stack_Pointer < Pointer_Index_Type'Last then
            Stack_Pointer := Stack_Pointer + 1;
            Stack(Stack_Pointer) := Add_Me;
        end if;
    end Push;

    procedure Pop(Popped_Value: out Integer)
    --# global in Stack; in out Stack_Pointer;
    --# derives Stack_Pointer from Stack_Pointer &
    --#         Popped_Value from Stack, Stack_Pointer;
    is
    begin
        if Stack_Pointer > Pointer_Index_Type'First then
            Popped_Value := Stack(Stack_Pointer);
            Stack_Pointer := Stack_Pointer - 1;
        else
            Popped_Value := 0;
        end if;
    end Pop;

    function Get_Size return Natural
    --# global in Stack_Pointer;
    is
    begin
        return Stack_Pointer;
    end Get_Size;
begin
    Stack_Pointer := Pointer_Index_Type'First;
    Stack := Stack_Type'(Stack_Index_Type => 0);
end Stacks;
