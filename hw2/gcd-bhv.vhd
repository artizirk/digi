------------------------------------------------------------------------
-- Yet another GCD implementation targeting different synthesizable codes
-- Style - behavioral with fixed i/o timing (for HLS tools)
-- Synthesis results:
--  Synopsys Design Vision - not synthesizable
--  Xilinx ISE - not synthesizable
------------------------------------------------------------------------
-- L(R)V 2011
------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity gcd is 
  port (xi, yi : in unsigned(15 downto 0);
        rst    : in bit;
        xo     : out unsigned(15 downto 0);
        rdy    : out bit := '1';
        clk    : in bit);
end gcd;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

architecture experiments of gcd is 
begin 

  process
    variable x, y: unsigned(15 downto 0);
  begin
    -- Wait for the new input data
    wait on clk until clk='1' and rst='0';

    x := xi;    y := yi;    rdy <= '0';
    wait on clk until clk='1';

    -- Calculate
    while  x /= y  loop
      if  x < y  then y := y - x;
      else            x := x - y;    end if;
    end loop;

    -- Ready
    xo <= x;    rdy <= '1';
    wait on clk until clk='1';
  end process;

end experiments;
