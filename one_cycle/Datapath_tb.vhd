library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.env.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Datapath_tb is
--  Port ( );
constant WORDSIZE : positive :=32; --ARCHITECTURE WORDLENGTH
constant RAM_SIZE : positive :=5;   --2**RAM_SIZE     
constant ROM_SIZE : positive := 6;   --2**ROM_SIZE
constant RF_SIZE : positive := 4; --number of registers, 2**REGSIZE
end Datapath_tb;

architecture Behavioral of Datapath_tb is

component Datapath
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

signal PCWrite :  STD_LOGIC;
signal PCSrc :  STD_LOGIC;
signal RegSrc :  STD_LOGIC_VECTOR (2 downto 0);
signal RegWrite :  STD_LOGIC;
signal ImmSrc :  STD_LOGIC;
signal ALUSrc :  STD_LOGIC;
signal ALUControl :  STD_LOGIC_VECTOR (2 downto 0);
signal MemtoReg :  STD_LOGIC;
signal FlagsWrite :  STD_LOGIC;
signal MemWrite :  STD_LOGIC;
signal CLK :  STD_LOGIC := '0';
signal RESET :  STD_LOGIC :='1';
signal Flags :  STD_LOGIC_VECTOR (3 downto 0);
signal PC :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
signal Instr :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0); 
signal ALUResult :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0); 
signal WriteData :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0); 
signal Result :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);

constant CLK_period : time := 50 ns;


begin

uut: Datapath
generic map(
        WORDSIZE => 32, --ARCHITECTURE WORDLENGTH
        RAM_SIZE => 5,   --2**RAM_SIZE     
        ROM_SIZE => 6,   --2**ROM_SIZE
        RF_SIZE => 4)--number of registers, 2**REGSIZE
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
           CLK => CLK,
           RESET => RESET,
           Flags => Flags,
           PC => PC,
           Instr => Instr,
           ALUResult =>ALUResult ,
           WriteData =>WriteData ,
           Result => Result
           );

-- Clock process definition
CLK_process : process
    begin
		CLK <= '0';
		wait for clk_period/2;
		CLK <= '1';
		wait for clk_period/2;
end process CLK_process;

test: process is

begin

    -- 	Synchronous RESET is deasserted on CLK falling edge 
    -- after GSR signal disable (it remains enabled for 100 ns)
    RESET <= '1';
    wait for 100 ns;
    wait until (CLK = '0' and CLK'event);   --dinw times sthn katerxomenh akmh
    RESET <= '0';

    PCWrite <= '1'; --mov immediate pedio
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '1';
    ALUControl <= "100";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period;
    
    PCWrite <= '1'; --mvn immediate pedio
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '1';
    ALUControl <= "101";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period;
    
    PCWrite <= '1';     --add
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '0';
    ALUControl <= "000";
    MemtoReg <= '0';
    FlagsWrite <= '1';
    MemWrite <= '0';
    
    wait for clk_period;

    PCWrite <= '1';     --sub
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '1';
    ALUControl <= "001";
    MemtoReg <= '0';
    FlagsWrite <= '1';
    MemWrite <= '0';
    
    wait for clk_period;
    
    PCWrite <= '1';     --and
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '0';
    ALUControl <= "010";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period;

    PCWrite <= '1';     --xor
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '0';
    ALUControl <= "011";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period;

    PCWrite <= '1';     --LSL
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '0';
    ALUControl <= "110";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period;

    PCWrite <= '1';     --ASR
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '0';
    ALUControl <= "111";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period;

    PCWrite <= '1';     --STR
    PCSrc <= '0';
    RegSrc <= "010";
    RegWrite <= '0';
    ImmSrc <= '0';
    ALUSrc <= '1';
    ALUControl <= "000";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '1';
    
    wait for clk_period;
    
    PCWrite <= '1';     --STR
    PCSrc <= '0';
    RegSrc <= "010";
    RegWrite <= '0';
    ImmSrc <= '0';
    ALUSrc <= '1';
    ALUControl <= "000";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '1';
    
    wait for clk_period;
    
    PCWrite <= '1';     --LDR
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '1';
    ALUControl <= "000";
    MemtoReg <= '1';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period;

    PCWrite <= '1';     --CMP
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '0';
    ImmSrc <= '0';
    ALUSrc <= '0';
    ALUControl <= "001";
    MemtoReg <= '0';
    FlagsWrite <= '1';
    MemWrite <= '0';
    
    wait for clk_period;
        
    PCWrite <= '1'; --mov
    PCSrc <= '0';
    RegSrc <= "000";
    RegWrite <= '1';
    ImmSrc <= '0';
    ALUSrc <= '0';      --prosoxh, einai register pedio
    ALUControl <= "100";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period; 
    
    PCWrite <= '1'; --BL
    PCSrc <= '0';
    RegSrc <= "101";
    RegWrite <= '1'; --grafoume to PC prosoxh!!!
    ImmSrc <= '1';
    ALUSrc <= '1';      --prosoxh, einai register pedio
    ALUControl <= "000"; --diabasma tou PC sto A1
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period;        
  
    PCWrite <= '1'; --branch teleutaio B MAIN PROGRAM;
    PCSrc <= '1';
    RegSrc <= "001";
    RegWrite <= '0';
    ImmSrc <= '1';
    ALUSrc <= '1';
    ALUControl <= "000";
    MemtoReg <= '0';
    FlagsWrite <= '0';
    MemWrite <= '0';
    
    wait for clk_period; 
    
          
    
    STOP(2);
    end process;
    
    end Behavioral;
