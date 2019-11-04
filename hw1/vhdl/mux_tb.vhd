------------------------------------------------------------------------------
--  File: mux_tb.vhd
------------------------------------------------------------------------------
--Multiplexor testbench
library IEEE;
use IEEE.std_logic_1164.all;

--Testbench entity is always empty
entity MuxTestBench is
end MuxTestbench;

architecture Bench of MuxTestBench is

  --Component declaration for MUX
  component Mux is
  port ( A_IN     : in std_logic_vector( 7 downto 0 );
         B_IN     : in std_logic_vector( 7 downto 0 );
         CONT_SIG : in  std_logic;
         OUT_SIG  : out std_logic_vector( 7 downto 0 ) );
  end component;

  --Local signal declarations
  signal AIn, BIn, OutSig : std_logic_vector( 7 downto 0 );
  signal ContSig : std_logic;  

begin

--Component instantiation of MUX
Mux_comp: MUX port map (AIn, BIn, ContSig, OutSig);
 
--Stimulus process
Stimulus: process
   begin
      AIn     <= "11100000"; 
      BIn     <= "11111111";
      ContSig <= '0';
      wait for 10 ns;

      ContSig <= '1';
      wait for 10 ns;

      Ain  <= "00001111"; 
      BIn  <= "11110000";
      ContSig  <= '0';
      wait for 10 ns;
      
      ContSig <= '1';
      wait for 10 ns;

      wait;  --Suspend
   end process Stimulus;

end Bench;
