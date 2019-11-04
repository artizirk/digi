------------------------------------------------------------------------
-- Testbench for yet another GCD implementation targeting different
-- synthesizable codes
------------------------------------------------------------------------
-- L(R)V 2011
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity test is
end test;

architecture bench of test is
  signal clk, rst, rdy, hlt: bit := '1';
  signal x, y, res: unsigned(15 downto 0);

  component gcd
    port (xi, yi : in unsigned(15 downto 0);
          rst    : in bit;
          xo     : out unsigned(15 downto 0);
          rdy    : out bit;
          clk    : in bit);
  end component;
begin
  clk <= not clk after 10 ns when hlt='1';

  U1: gcd port map (x, y, rst, res, rdy, clk);

  process
    type int_array is array (0 to 7) of integer;
    constant a: int_array := (27, 33, 245, 121, 52, 333, 125, 422);
    constant b: int_array := (18, 256, 45, 11, 452, 121, 625, 312);
    -- expected results (GCD)  9,  1,  5,  11,  4,   1,  125,   2  
  begin
    wait on clk until clk='0';
    for  i in a'range  loop
      x <= conv_unsigned(a(i),16);
      y <= conv_unsigned(b(i),16);
      rst <= '0';
      wait on clk until clk='0';
      rst <= '1';
      --wait on clk until clk='0';
      while  rdy = '0'  loop
        wait on clk until clk='0';
      end loop;
      wait on clk until clk='0';
    end loop;
    wait on clk until clk='0';
    hlt <= '0';    wait;
  end process;
end bench;
