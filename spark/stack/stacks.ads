-- Note that the name "Stacks" is a little misleading, as this package really
-- describes a single stack of integers. Ideally, the name of this package
-- should be changed.

package Stacks
--# own State;
--# initializes State;
is
    procedure Push(Add_Me: in Integer);
    --# global in out State;
    --# derives State from Add_Me, State;

    procedure Pop(Popped_Value: out Integer);
    --# global in out State;
    --# derives State from State &
    --#         Popped_Value from State;

    function Get_Size return Natural;
    --# global in State;
end Stacks;
