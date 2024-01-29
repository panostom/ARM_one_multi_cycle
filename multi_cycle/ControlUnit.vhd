library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
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
           IRWrite : out STD_LOGIC;
           MAWrite : out STD_LOGIC;
           PCWrite : out STD_LOGIC;
           RegSrc : out STD_LOGIC_VECTOR (2 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is

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

component FSM is
    Port ( NoWrite_in : in STD_LOGIC;
           op : in STD_LOGIC_VECTOR (1 downto 0);
           S_L : in STD_LOGIC;
           Rd : in STD_LOGIC_VECTOR (3 downto 0);
           CondEx_in : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           IRWrite : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           FlagsWrite : out STD_LOGIC;
           MAWrite : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           PCSrc : out STD_LOGIC;
           PCWrite : out STD_LOGIC);
end component;

signal NoWrite_in : std_logic;
signal CondEx_in : std_logic;

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

Conditional_Logic: CONDLogic 
    Port map( cond => instr(31 downto 28),
           flags => Flags,
           CondEx_in => CondEx_in);

FSM_cu: FSM
    Port map( NoWrite_in => NoWrite_in,
           op => instr(27 downto 26),
           S_L => instr(20),
           Rd => instr(15 downto 12),
           CondEx_in => CondEx_in,
           IRWrite => IRWrite,
           CLK => CLK,
           RESET => RESET,
           RegWrite => RegWrite,
           FlagsWrite => FlagsWrite,
           MAWrite => MAWrite,
           MemWrite => MemWrite,
           PCSrc => PCSrc,
           PCWrite => PCWrite);

end Behavioral;
