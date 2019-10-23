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
  signal x1i, x2i, x3i, x4i, t1, t2, t3, t4, t5: std_logic;
  signal t6, t7, t8, t9, t10, t11, t12: std_logic;
begin
  x1i <= not x1;
  x2i <= not x2;
  x3i <= not x3;
  x4i <= not x4;

  t1 <= x1 and x2i;
  t2 <= x3i and x4;
  t3 <= x1i and x2;
  y1 <= not (t1 or t2 or t3);

  t4 <= x2i and x4;
  t5 <= x1i and x2;
  y2 <= t4 or t5;

  t6 <= x1i and x2 and x3i and x4;
  t7 <= x1i and x3 and x4i;
  t8 <= x1 and x2 and x3;
  t9 <= x2i and x3i and x4i;
  y3 <= not (t6 or t7 or t8 or t9);

  t10 <= x1 and x2 and x3i and x4i;
  t11 <= x1i and x3;
  t12 <= x2i and x4;
  y4 <= t10 or t11 or t12;
end architecture opti;
