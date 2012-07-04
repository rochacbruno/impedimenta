package body Bubblesort
is
    procedure Sort(Sort_Me: in out Array_Record) is
        Temp: Integer;
    begin
        -- Walk through Sort_Me.The_Array (Sort_Me.Sort_Limit - 1) times.
        -- This loop does not touch any numbers.
        for I in Array_Index loop
            -- Walk through Sort_Me.The_Array once. This loop compares and
            -- swaps individual array elements at each step.
            for J in Array_Index loop
                exit when J = Sort_Me.Sort_Limit;

                if (Sort_Me.The_Array (J) > Sort_Me.The_Array (J + 1)) then
                    Temp := Sort_Me.The_Array (J);
                    Sort_Me.The_Array (J) := Sort_Me.The_Array (J + 1);
                    Sort_Me.The_Array (J + 1) := Temp;
                end if;
            end loop;

            -- Has Sort_Me.The_Array been walked through/sorted enough times
            -- yet?
            exit when I = (Sort_Me.Sort_Limit - 1);
        end loop;
    end Sort;

    procedure Initialize(Init_Me: out Array_Record) is
    begin
        for I in Array_Index loop
            Init_Me.The_Array(I) := 0;
        end loop;
        Init_Me.Sort_Limit := Array_Index'Last;
    end Initialize;
end Bubblesort;