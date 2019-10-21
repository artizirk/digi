------------------------------------------------------------------------
-- IAY0150 - Homework #1. Example task - #1, gates, optimized.
------------------------------------------------------------------------
-- (C) Peeter Ellervee - 2016 - Tallinn
------------------------------------------------------------------------
library IEEE; use IEEE.std_logic_1164.all;
entity f_system is
  port ( x1, x2, x3, x4: in std_logic;
         y1, y2, y3, y4: out std_logic );
end entity f_system;

library IEEE; use IEEE.std_logic_1164.all;
architecture opti of f_system is
  signal x1i, x2i, x3i, x4i, t3x, t3i, t4i, t5i, t6: std_logic;
  signal t7, t8x, t8, t68i, t9i, t19, t197i: std_logic;
begin
  x1i <= not x1;
  x2i <= not x2;
  x3i <= not x3;
  x4i <= not x4;
  y1 <= not ((x1 and x2i) or (x3i and x4) or
        (x1i and x2));

  y2 <= (x2i and x4) or (x1i and x2);

  y3 <= not ((x1i and x2 and x3i and x4) or 
       (x1i and x3 and x4i) or
       (x1 and x2 and x3) or
       (x2i and x3i and x4i));

  y4 <= (x1 and x2 and x3i and x4i) or
        (x1i and x3) or (x2i and x4);
end architecture opti;
