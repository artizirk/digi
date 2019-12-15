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
    type state_type is (S_wait, S_start, S_shift, S_add, S_correct, S_ready);
    signal state, next_state: state_type;

    signal x, y, xza, yza, xzn, yzn: signed(9 downto 0) := (others=>'0');
    signal o: signed(10 downto 0);
    signal bit_count: unsigned(3 downto 0);

    signal xy_ena, shift_ena, set_ready, bit_val: bit;

    signal pre_overflow, overflow: std_logic := '0';
begin

    --remove sign bit
    xyz_abs: for i in 9 downto 0 generate
        xza(i) <= xi(i) xnor xi(xi'length-1);
        yza(i) <= yi(i) xnor yi(xi'length-1);
    end generate xyz_abs;

    --count msb zeros
    xzn(xzn'length-1) <= xza(xza'length-1);
    yzn(yzn'length-1) <= yza(yzn'length-1);
    xyza_and: for i in 1 to 8 generate
        xzn(i) <= xzn(i+1) and xza(i);
        yzn(i) <= yzn(i+1) and yza(i);
    end generate xyza_and;

    --calculate
    pre_overflow <= (xzn(9) nor yzn(0)) or
                (xzn(8) nor yzn(1)) or
                (xzn(7) nor yzn(2)) or
                (xzn(6) nor yzn(3)) or
                (xzn(5) nor yzn(4)) or
                (xzn(4) nor yzn(5)) or
                (xzn(3) nor yzn(6)) or
                (xzn(2) nor yzn(7)) or
                (xzn(1) nor yzn(8)) or
                (xzn(0) nor yzn(9));

    process begin
        wait on clk until clk='1';

        case state is
        when S_wait =>
            if rst='0' then
                state <= S_start;
                x <= xi;
                y <= yi;
                o <= (others=>'0');
                rdy <= '0';
                bit_count <= x"a";  -- start from 10
            end if;

        when S_start =>
            if bit_count = x"0" then
                state <= S_correct;
            else
                state <= S_add;
            end if;

        when S_shift =>
            bit_count <= bit_count - 1; -- count down
            x <= shift_left(x, 1);
            y <= shift_right(y, 1);
            state <= S_start;

        when S_add =>
            state <= s_shift;
            if y(0) = '1' then
                o <= o + x;
            end if;

        when S_correct =>
            if y(0) = '1' then
                o <= o - x;
            end if;
            state <= S_ready;

        when S_ready =>
            state <= S_wait;

            xo <= o(o'length-2 downto 0);
            -- adder calculates 11th bit wrong
            overflow <= pre_overflow;-- or (o(o'length-2) xor o(o'length-1));
            rdy <= '1';

        end case;

    end process;
end experiments;
