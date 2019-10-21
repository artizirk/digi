------------------------------------------------------------------------
-- IAY0150 - Homework #1. Example task - #1, gates, optimized.
------------------------------------------------------------------------
-- (C) Peeter Ellervee - 2016 - Tallinn
------------------------------------------------------------------------
--library IEEE; use IEEE.std_logic_1164.all;
--entity f_system is
--  port ( x1, x2, x3, x4: in std_logic;
--         y1, y2, y3, y4: out std_logic );
--end entity f_system;

library IEEE; use IEEE.std_logic_1164.all;
architecture opti of f_system is
  signal x1i, x2i, x3i, x4i, y3a, y3a1, y3b, y3b1, y3b2: std_logic;
  signal y4a, y4b, t8, t68i, t9i, t19, t197i: std_logic;
begin
  x1i <= not x1;
  x2i <= not x2;
  x3i <= not x3;
  x4i <= not x4;
  
  y1 <= (x1 and x2i) nand ((x3i and x4) nand
        (x1i and x2));

  y2 <= (x2i and x4) or (x1i and x2);

  y3a <= (x1i and x3 and x4i) or
       (x1 and x2 and x3) or
       (x2 or x3 or x4);

  y3a1 <= (x1 nand x4) and x3;
  y3a <= y3a1 nand
       ((x1 and x2 and x3) or
       (x2 nand (x3 nand x4)));
  y3b1 <= x1 nand x3;
  y3b <= y3b1 and x2 and x4;
  y3 <= y3a nand y3b;

  y4a <= x3 nand x4;
  y4 <= (x1 and x2 and y4a) or 
        (x1i and x3) or (x2i and x4); 
end architecture opti;
