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
    process (state, rst, current_bit_counter) begin
        next_state <= state;
        xy_ena <= '0';
        shift_ena <= '0';
        set_ready <= '0';

        case state is
        when S_wait =>
            if rst='0' then
                next_state <= S_start;
                xy_ena <= '1';
                current_bit_counter <= to_unsigned(x'length, current_bit_counter'length);
            end if;

        when S_start =>
            if current_bit_counter = to_unsigned(0, current_bit_counter'length) then
                next_state <= S_ready;
            else
                next_state <= S_shift;
            end if;

        when S_shift =>
            if bit_val = '1' then
                next_state <= S_add;
            else
                next_state <= S_start;
                shift_ena <= '1';
            end if;

        when S_add =>
            next_state <= S_start;

        when S_ready =>
            next_state <= S_wait;
            set_ready <= '1';

        end case;

    end process;

    process (shift_ena) begin
    if shift_ena='1' then
        current_bit_counter <= current_bit_counter - 1;
        x <= shift_right(x, 1);
        y <= shift_left(y, 1);
    end if;
    end process;

    process begin
        wait on xy_ena until xy_ena='1';
        x(10 downto 1) <= xi;
        y(10 downto 1) <= yi;
    end process;



  -- Registers
  process begin
    wait on clk until clk='1';
    state <= next_state;
    rdy <= set_ready;
  end process;
end experiments;
