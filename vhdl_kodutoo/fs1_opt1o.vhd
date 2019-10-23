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
  signal x1i, x2i, x3i, x4i, y31, y4i, t1, t2, t3, t4, t5, l1: std_logic;
  signal t6, t7, t8, t9, t10, t11, t12, t13, t61, t62, t71: std_logic;
begin
  x1i <= not x1;
  x2i <= not x2;
  x3i <= not x3;
  x4i <= not x4;

  l1 <= x1 and x2;

  t1 <= x1 nand x2i;
  t2 <= x3i nand x4;
  t3 <= x1i nand x2;
  y1 <= t1 and t2 and t3;

  t4 <= x2i nand x4;
  t5 <= x1i nand x2;
  y2 <= t4 nand t5;

  t61 <= x1 nor x3;
  t62 <= x2 and x4;
  t6  <= t61 nand t62;
  t71 <= x1 nor x4;
  t7 <= t71 nand x3;
  t8 <= l1 nand x3;
  t9 <= x2 or x3 or x4;
  y31 <= t6 and t7 and t8;
  y3 <= y31 and t9;

  t13 <= x3 nor x4;
  t10 <= l1 nand t13;
  t11 <= x1i nand x3;
  t12 <= x2i nand x4;
  y4i <= t10 and t11 and t12;
  y4 <= not y4i;
end architecture opti;
