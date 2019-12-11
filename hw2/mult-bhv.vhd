library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mult is
  port (xi, yi : in signed(9 downto 0);
        rst    : in bit;
        xo     : out signed(9 downto 0);
        rdy    : out bit := '1';
        clk    : in bit);
end mult;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture experiments of mult is
begin
    process
        variable x, y: signed(9 downto 0);
        variable o: signed(19 downto 0);
    begin
        wait on clk until clk='1' and rst='0';

        x := xi;    y := yi;    rdy <= '0';
        wait on clk until clk='1';

        o := x * y;

        xo <= o(9 downto 0);
        rdy <= '1';

        wait on clk until clk='1';
    end process;
end experiments;
