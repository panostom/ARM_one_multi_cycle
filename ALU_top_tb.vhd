library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity ALU_top_tb is
--  Port ( );
constant WIDTH : positive :=32;
end ALU_top_tb;

architecture Behavioral of ALU_top_tb is

component ALU_top is
    generic(WIDTH : positive :=32);
    Port ( SrcA : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
           shamt5 : in STD_LOGIC_VECTOR (4 downto 0);
           ALUResult : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           N : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           V : out STD_LOGIC);
end component;

signal SrcA :  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal SrcB :  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal ALUControl :  STD_LOGIC_VECTOR (2 downto 0);
signal shamt5 :  STD_LOGIC_VECTOR (4 downto 0);
signal ALUResult :  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal N :  STD_LOGIC;
signal Z :  STD_LOGIC;
signal C :  STD_LOGIC;
signal V :  STD_LOGIC;

begin

uut: ALU_top
    Port map ( SrcA => SrcA,
           SrcB => SrcB,
           ALUControl => ALUControl,
           shamt5 => shamt5,
           ALUResult => ALUResult,
           N => N,
           Z => Z,
           C => C,
           V => V);
           
test: process
begin
    wait for 100ns;
    SrcA <= "00000000000000000000000000000000"; --ADD
    SrcB <= "00000000000000000000000000000000";
    ALUControl <= "XXX"; 
    shamt5 <= "00000";
    wait for 100ns;
    SrcA <= "00000000000000000000000000000011"; --ADD
    SrcB <= "00000000000000000000000000000001";
    ALUControl <= "000"; 
    shamt5 <= "00000";
    wait for 100ns;
    SrcA <= "01111111111111111111111111111111"; --ADD overflow
    SrcB <= "00000000000000000000000000000001";
    ALUControl <= "000";
    shamt5 <= "01111";
    wait for 100ns;
    SrcA <= "00000000000000000000000000000011"; --SUB
    SrcB <= "00000000000000000000000000000001";
    ALUControl <= "001";
    shamt5 <= "00000";
    wait for 100ns;
    SrcA <= "00000000000000000000000000000010"; --SUB
    SrcB <= "00000000000000000000000000000001";
    ALUControl <= "001";
    shamt5 <= "00000";
    wait for 100ns;
    SrcA <= "10000000000000000000000000000000"; --SUB
    SrcB <= "00000000000000000000000000000001";
    ALUControl <= "001";
    shamt5 <= "00000";
    wait for 100ns;
    SrcA <= "11111111111111111111111111111111"; --AND
    SrcB <= "00000000000000000000000000000000";
    ALUControl <= "010";
    shamt5 <= "00000";
    wait for 100ns;      
    SrcA <= "11111111111111111111111111111111"; --XOR
    SrcB <= "00000000000000000000000000000000";
    ALUControl <= "011";
    shamt5 <= "00000";
    wait for 100ns;
    SrcA <= "00000000000000000000000000000001"; --XOR
    SrcB <= "00000000000000000000000000000000";
    ALUControl <= "011";
    shamt5 <= "00000";
    wait for 100ns;
    SrcA <= "00000000000000001110000000000001";    --LSL
    SrcB <= "00000000000000000000000000000001";
    shamt5 <= "00001";
    ALUControl <= "110";
    wait for 100ns;
    SrcA <= "00000000000000000000000000011001";    --LSL
    SrcB <= "00000000000000000000000000000001";
    shamt5 <= "00011";
    ALUControl <= "110";
    wait for 100ns;
    SrcA <= "00000000000000000000000000000001";    --LSL
    SrcB <= "10000000000000000000000000000000";
    ALUControl <= "110";
    shamt5 <= "00001";
    wait for 100ns;
    SrcA <= "00000000000000000000000000000001";    --ASR
    SrcB <= "10000000000000000000000000000000";
    ALUControl <= "111";
    shamt5 <= "00111";
    wait for 100ns;
    SrcA <= "00000000000000000000000000000001";    --ASR
    SrcB <= "00000000000000000000000000000001";
    ALUControl <= "111";
    shamt5 <= "00001";
    wait for 100ns;
    SrcA <= "00000000000000000000000000000001";    --MOV
    SrcB <= "00000000000000000000000000000001";
    ALUControl <= "100";
    shamt5 <= "00001";
    wait for 100ns;
    SrcA <= "00000000000000000000000000000001";    --MVN
    SrcB <= "00000000000000000000000000000001";
    ALUControl <= "101";
    shamt5 <= "00001";
    wait for 100ns;




    wait for 100ns;
    stop(2);
end process;
end Behavioral;
