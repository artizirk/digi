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

    signal x, y: signed(9 downto 0);
    signal o: signed(10 downto 0);
    signal current_bit_counter: unsigned(3 downto 0);

    signal xy_ena, shift_ena, set_ready, bit_val: bit;
begin
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
                current_bit_counter <= x"a";  -- start from 10
            end if;

        when S_start =>
            if current_bit_counter = x"0" then
                state <= S_correct;
            else
                state <= S_add;
            end if;

        when S_shift =>
            current_bit_counter <= current_bit_counter - 1; -- count down
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
            rdy <= '1';

        end case;

    end process;
end experiments;
