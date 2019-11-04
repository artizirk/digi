------------------------------------------------------------------------
-- IAY0150 - Homework #1. Test bench for the example task.
------------------------------------------------------------------------
-- (C) Peeter Ellervee - 2016 - Tallinn
------------------------------------------------------------------------
library IEEE; use IEEE.std_logic_1164.all;
entity test is
end entity test;

library IEEE; use IEEE.std_logic_1164.all;
architecture bench of test is
  signal x1, x2, x3, x4: std_logic;
  signal y1a, y1b, y1c, y2a, y2b, y2c: std_logic;
  signal y3a, y3b, y3c, y4a, y4b, y4c: std_logic;
  signal y1x, y2x, y3x, y4x: std_logic;
  component f_system
    port ( x1, x2, x3, x4: in std_logic;
           y1, y2, y3, y4: out std_logic );
  end component;
  for U1: f_system use entity work.f_system(tabel);
  for U2: f_system use entity work.f_system(espresso);
  for U3: f_system use entity work.f_system(opti);

  function compare_signals (s1, s2, s3: std_logic) return std_logic is
  begin
    if  s1='-'  then
      if  s2/=s3  then  return 'X';  end if;
    else
      if  s1/=s2 or s1/=s3  then  return 'X';  end if;
    end if;
    return '0';
  end function compare_signals;
begin
  -- Input signals (after every 10 ns)
  x1 <= '0' after 0 ns, '1' after 80 ns, '0' after 160 ns;
  x2 <= '0' after 0 ns, '1' after 40 ns, '0' after 80 ns, '1' after 120 ns;
  x3 <= '0' after 0 ns, '1' after 20 ns, '0' after 40 ns, '1' after 60 ns,
        '0' after 80 ns, '1' after 100 ns, '0' after 120 ns, '1' after 140 ns;
  x4 <= '0' after 0 ns, '1' after 10 ns, '0' after 20 ns, '1' after 30 ns,
        '0' after 40 ns, '1' after 50 ns, '0' after 60 ns, '1' after 70 ns,
        '0' after 80 ns, '1' after 90 ns, '0' after 100 ns, '1' after 110 ns,
        '0' after 120 ns, '1' after 130 ns, '0' after 140 ns, '1' after 150 ns;

  -- System of Boolean functions
  U1: f_system port map (x1, x2, x3, x4, y1a, y2a, y3a, y4a);
  U2: f_system port map (x1, x2, x3, x4, y1b, y2b, y3b, y4b);
  U3: f_system port map (x1, x2, x3, x4, y1c, y2c, y3c, y4c);
  --y1c<=y1b;  y2c<=y2b;  y3c<=y3b;  y4c<=y4b;
  y1x <= compare_signals (y1a, y1b, y1c);
  y2x <= compare_signals (y2a, y2b, y2c);
  y3x <= compare_signals (y3a, y3b, y3c);
  y4x <= compare_signals (y4a, y4b, y4c);
end architecture bench;
