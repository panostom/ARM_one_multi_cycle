library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor is
    generic(WORDSIZE : positive :=32); --ARCHITECTURE WORDLENGTH
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           PC : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           Instr : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           ALUResult : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           WriteData : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           Result : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0));
end Processor;

architecture Behavioral of Processor is

component ControlUnit is
    Port ( instr : in STD_LOGIC_VECTOR (31 downto 0);
           Flags : in STD_LOGIC_VECTOR (3 downto 0);
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           PCSrc : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           ALUControl : out STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : out STD_LOGIC;
           ImmSrc : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           FlagsWrite : out STD_LOGIC;
           PCWrite : out STD_LOGIC;
           IRWrite : out STD_LOGIC;
           MAWrite : out STD_LOGIC; 
           RegSrc : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Datapath is
    generic(
            WORDSIZE : positive :=32; --ARCHITECTURE WORDLENGTH
            RAM_SIZE : positive :=5;   --2**RAM_SIZE     
            ROM_SIZE : positive := 6;   --2**ROM_SIZE
            RF_SIZE : positive := 4); --number of registers, 2**REGSIZE
    Port ( PCWrite : in STD_LOGIC;
           PCSrc : in STD_LOGIC;
           RegSrc : in STD_LOGIC_VECTOR (2 downto 0);
           RegWrite : in STD_LOGIC;
           ImmSrc : in STD_LOGIC;
           ALUSrc : in STD_LOGIC;
           ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
           MemtoReg : in STD_LOGIC;
           FlagsWrite : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           IRWrite : in STD_LOGIC;
           MAWrite : in STD_LOGIC; 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           Flags : out STD_LOGIC_VECTOR (3 downto 0);
           PC : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           Instr : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0); 
           ALUResult : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0); 
           WriteData : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0); 
           Result : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0)
           );
end component;

signal Flags :  STD_LOGIC_VECTOR (3 downto 0);
signal Instruction : STD_LOGIC_VECTOR(WORDSIZE-1 downto 0);
signal PCSrc :  STD_LOGIC;
signal MemtoReg :  STD_LOGIC;
signal MemWrite :  STD_LOGIC;
signal ALUControl :  STD_LOGIC_VECTOR (2 downto 0);
signal ALUSrc :  STD_LOGIC;
signal ImmSrc :  STD_LOGIC;
signal RegWrite :  STD_LOGIC;
signal FlagsWrite :  STD_LOGIC;
signal RegSrc :  STD_LOGIC_VECTOR (2 downto 0);
signal IRWrite :  STD_LOGIC;
signal MAWrite :  STD_LOGIC; 
signal PCWrite :  STD_LOGIC;

----for implementation only

--signal Instr :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
--signal ALUResult :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
--signal WriteData :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
--signal Result :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);

begin

Control_unit: ControlUnit 
    Port map( instr => Instruction,
           Flags => Flags,
           CLK => CLK,
           RESET => RESET,
           PCSrc => PCSrc,
           MemtoReg => MemtoReg,
           MemWrite => MemWrite,
           ALUControl => ALUControl,
           ALUSrc => ALUSrc,
           ImmSrc => ImmSrc,
           RegWrite => RegWrite,
           FlagsWrite => FlagsWrite,
           PCWrite => PCWrite,
           IRWrite => IRWrite,
           MAWrite => MAWrite,
           RegSrc => RegSrc);


Datapath_unit: Datapath 
    generic map(
            WORDSIZE => 32, --ARCHITECTURE WORDLENGTH
            RAM_SIZE => 5,   --2**RAM_SIZE     
            ROM_SIZE => 6,   --2**ROM_SIZE
            RF_SIZE => 4) --number of registers, 2**REGSIZE
    Port map( PCWrite => PCWrite,
           PCSrc => PCSrc,
           RegSrc => RegSrc,
           RegWrite => RegWrite,
           ImmSrc => ImmSrc,
           ALUSrc => ALUSrc,
           ALUControl => ALUControl,
           MemtoReg => MemtoReg,
           FlagsWrite => FlagsWrite,
           MemWrite => MemWrite,
           IRWrite => IRWrite,
           MAWrite => MAWrite,
           CLK => CLK,
           RESET => RESET,
           Flags => Flags,
           PC => PC,
           Instr => Instruction,
           ALUResult => ALUResult,
           WriteData => WriteData,
           Result => Result);
 
 Instr <= Instruction;  
end Behavioral;