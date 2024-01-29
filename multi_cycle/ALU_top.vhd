library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_top is
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
end ALU_top;

architecture Behavioral of ALU_top is

component ALU_woFlags is
    generic(WIDTH : positive :=32);
    Port ( A : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           B : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
           shamt5 : in STD_LOGIC_VECTOR (4 downto 0);
           S : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           C : out STD_LOGIC;
           V : out STD_LOGIC);
end component;

component NOR_tree is
    generic (WIDTH: positive:=32);
    Port ( Din : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           Z : out STD_LOGIC);
end component;

signal ALUResult_top :  STD_LOGIC_VECTOR (WIDTH-1 downto 0);   
           
begin

ALU_insert: ALU_woFlags
    generic map(WIDTH => 32)
    port map( A => SrcA,
           B => SrcB,
           ALUControl => ALUControl,
           shamt5 => shamt5 ,
           S => ALUResult_top,
           C => C,
           V => V);
           
NOR_tree_insert: NOR_tree
    generic map(WIDTH => 32)
    Port map ( Din => ALUResult_top,
           Z => Z);
           
ALUResult <= ALUResult_top;
N <= ALUResult_top(WIDTH-1);

end Behavioral;
