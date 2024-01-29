library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port ( instr : in STD_LOGIC_VECTOR (31 downto 0);
           Flags : in STD_LOGIC_VECTOR (3 downto 0);
           PCSrc : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           ALUControl : out STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : out STD_LOGIC;
           ImmSrc : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           FlagsWrite : out STD_LOGIC;
           RegSrc : out STD_LOGIC_VECTOR (2 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is

component WELogic 
    Port ( op : in STD_LOGIC_VECTOR (1 downto 0);
           NoWrite_in : in STD_LOGIC;
           S_L : in STD_LOGIC;
           RegWrite_in : out STD_LOGIC;
           FlagsWrite_in : out STD_LOGIC;
           MemWrite_in : out STD_LOGIC);
end component;

component InstrDec 
    Port ( op : in STD_LOGIC_VECTOR (1 downto 0);
           funct : in STD_LOGIC_VECTOR (5 downto 0);
           sh : in STD_LOGIC_VECTOR(1 downto 0);
           RegSrc : out STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           ALUControl : out STD_LOGIC_VECTOR (2 downto 0);
           ImmSrc : out STD_LOGIC;
           NoWrite_in : out STD_LOGIC);
end component;

component CONDLogic 
    Port ( cond : in STD_LOGIC_VECTOR (3 downto 0);
           flags : in STD_LOGIC_VECTOR (3 downto 0);
           CondEx_in : out STD_LOGIC);
end component;

component PCLogic 
    Port ( Rd : in STD_LOGIC_VECTOR (3 downto 0);
           op_1 : in STD_LOGIC;
           RegWrite_in : in STD_LOGIC;
           PCSrc_in : out STD_LOGIC);
end component;

signal RegWrite_in :  STD_LOGIC;
signal PCSrc_in :  STD_LOGIC;
signal NoWrite_in :  STD_LOGIC;
signal FlagsWrite_in :  STD_LOGIC;
signal MemWrite_in :  STD_LOGIC;
signal CondEx_in : STD_LOGIC;

begin

Instruction_Decoder : InstrDec 
    Port map( op => instr(27 downto 26),
           funct => instr(25 downto 20),
           sh => instr(6 downto 5),
           RegSrc => RegSrc,
           ALUSrc => ALUSrc,
           MemtoReg => MemtoReg,
           ALUControl => ALUControl,
           ImmSrc => ImmSrc,
           NoWrite_in => NoWrite_in);
           
WE_Logic:  WELogic 
    Port map( op => instr(27 downto 26),
           NoWrite_in => NoWrite_in,
           S_L => instr(20),
           RegWrite_in => RegWrite_in,
           FlagsWrite_in => FlagsWrite_in,
           MemWrite_in => MemWrite_in);
 
PC_Logic: PCLogic 
    Port map( Rd => instr(15 downto 12),
           op_1 => instr(27),
           RegWrite_in => RegWrite_in,
           PCSrc_in => PCSrc_in);          

Conditional_Logic: CONDLogic 
    Port map( cond => instr(31 downto 28),
           flags => Flags,
           CondEx_in => CondEx_in);

MemWrite <= MemWrite_in and CondEx_in;
FlagsWrite <= FlagsWrite_in and CondEx_in; 
RegWrite <= RegWrite_in and CondEx_in;
PCSrc <= PCSrc_in and CondEx_in;

end Behavioral;
