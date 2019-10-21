------------------------------------------------------------------------
-- IAY0150 - Homework #1. Espresso result of the example task.
------------------------------------------------------------------------
-- (C) Peeter Ellervee - 2016 - Tallinn
------------------------------------------------------------------------
--library IEEE; use IEEE.std_logic_1164.all;
--entity f_system is
--  port ( x1, x2, x3, x4: in std_logic;
--         y1, y2, y3, y4: out std_logic );
--end entity f_system;

library IEEE; use IEEE.std_logic_1164.all;
architecture espresso of f_system is
begin
  y1 <= not ((x1 and not x2) or (not x3 and x4) or
        (not x1 and x2));

  y2 <= (not x2 and x4) or  (not x1 and x2);

  y3 <= not ((not x1 and x2 and not x3 and x4) or 
       (not x1 and x3 and not x4) or
       (x1 and x2 and x3) or
       (not x2 and not x3 and not x4));

  y4 <= (x1 and x2 and not x3 and not x4) or
        (not x1 and x3) or (not x2 and x4);
end architecture espresso;
