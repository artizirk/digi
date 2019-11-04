------------------------------------------------------------------------------
--  File: mux.vhd
------------------------------------------------------------------------------
--Multiplexer design
--Control signal is CONT_SIG
--The output is chosen from 2 signals with length 8 bits
--If control signal is '1' then input A_in is chosen 
--If '0' then input B_IN is chosen to the output OUT_SIG


library IEEE;
use IEEE.std_logic_1164.all;

--Multiplexer entity
entity Mux is
  port ( A_IN     : in std_logic_vector( 7 downto 0 );
         B_IN     : in std_logic_vector( 7 downto 0 );
         CONT_SIG : in  std_logic;
         OUT_SIG  : out std_logic_vector( 7 downto 0 ) );
end Mux;

--Architecture of the multiplexer
architecture RTL of Mux is
  --Declaration of component inner signals, if needed
  --signal help : std_logic_vector (2 downto 0) := "111";

  --Declaration of components, if needed

  --component nand_gate is
  --  port ( A     : in std_logic;
  --         B     : in std_logic;
  --         O  : out std_logic );
  --end component;
  begin

  --Multiplexor pseudocode, DATAFLOW description
  --out <= (a and c) or (b and not (c));
   
   
  --Multiplexor process, BEHAVIOURAL description
  DISP_MUX: process ( A_IN, B_IN, CONT_SIG )
  --Declaration of process inner variables, if needed
  --variable help2 : std_logic := '0';
  begin
    if CONT_SIG = '1' then
      OUT_SIG <= A_IN;
    elsif CONT_SIG = '0' then
      OUT_SIG <= B_IN;
    else
      OUT_SIG <= (7 => 'U', others => 'X');
    end if;
  end process DISP_MUX;
    
  --Multiplexor STRUCTURAL description
  --INV: nand_gate port map (CONT_SIG, CONT_SIG, help(0));
  --A_SELECT: nand_gate port map (A_IN(0), CONT_SIG, help(1));
  --B_SELECT: nand_gate port map (B_IN(0), help(0), help(2));
  --OUTPUT: nand_gate port map (help(1), help(2), OUT_SIG(0));
               
end RTL;

library IEEE;
use IEEE.std_logic_1164.all;
--Entity of NAND gate
entity nand_gate is
  port ( A     : in std_logic;
         B     : in std_logic;
         O  : out std_logic );
end nand_gate;

--Architecture of NAND gate
architecture dataflow of nand_gate is 
begin

--The NAND gate is described in dataflow model
O <= A nand B;

end dataflow;

