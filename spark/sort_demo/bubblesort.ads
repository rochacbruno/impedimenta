package Bubblesort
is
    -- What kind of array can be worked on in the Sort procedure?
    Array_Max_Size: constant := 100;
    subtype Array_Index is Natural range 1 .. Array_Max_Size;
    type Array_Template is array(Array_Index) of Integer;
    -- This record holds both an array of integers, and a number telling how
    -- many many elements in that array should be sorted. ex. Sort_Limit = 6 if
    -- elements 1-6 in Jumbled_Array should be sorted.
    type Array_Record is record
        The_Array: Array_Template;
        Sort_Limit: Array_Index;
    end record;

    procedure Sort(Sort_Me: in out Array_Record);
    --# derives Sort_Me from Sort_Me;
    --# pre (Sort_Me.Sort_Limit >= 2);

    procedure Initialize(Init_Me: out Array_Record);
    --# derives Init_Me from ;
end Bubblesort;