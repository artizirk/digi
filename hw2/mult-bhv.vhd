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
    type state_type is (S_wait, S_start, S_shift, S_add, S_ready);
    signal state, next_state: state_type;

    signal x, y: signed(10 downto 0);
    signal o: signed(10 downto 0);
    signal current_bit_counter: unsigned(4 downto 0);

    signal xy_ena, shift_ena, set_ready, bit_val: bit;
begin
    process begin
        wait on clk until clk='1';


        --next_state <= state;
        xy_ena <= '0';
        shift_ena <= '0';
        set_ready <= '0';

        case state is
        when S_wait =>
            if rst='0' then
                state <= S_start;
                x(10 downto 1) <= xi; x(0) <= '0';
                y(10 downto 1) <= yi; y(0) <= '0';
                rdy <= '0';
                current_bit_counter <= to_unsigned(xi'length, current_bit_counter'length);
            end if;

        when S_start =>
            if current_bit_counter = to_unsigned(0, current_bit_counter'length) then
                state <= S_ready;
            else
                state <= S_shift;
            end if;

        when S_shift =>
            current_bit_counter <= current_bit_counter - 1;
            --x <= shift_right(x, 1);
            y <= shift_left(y, 1);
            if y(y'length-1) = '1' then
                state <= S_add;
            else
                state <= S_start;
            end if;

        when S_add =>
            state <= S_start;
            x <= x+x;

        when S_ready =>
            state <= S_wait;
            rdy <= '1';

        end case;

    end process;
end experiments;
