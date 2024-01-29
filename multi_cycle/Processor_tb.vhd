library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.all;

entity Processor_tb is
--  Port ( );
constant WORDSIZE : positive :=32; --ARCHITECTURE WORDLENGTH
end Processor_tb;

architecture Behavioral of Processor_tb is

component Processor is
    generic(WORDSIZE : positive :=32); --ARCHITECTURE WORDLENGTH
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           PC : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           Instr : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           ALUResult : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           WriteData : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           Result : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0));
end component;

signal CLK :  STD_LOGIC;
signal RESET :  STD_LOGIC;
signal PC :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
signal Instr :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
signal ALUResult :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
signal WriteData :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
signal Result :  STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
   
constant CLK_period : time := 50 ns;
   
begin

uut: Processor 
    generic map(WORDSIZE => 32) --ARCHITECTURE WORDLENGTH
    Port map( CLK => CLK,
           RESET => RESET,
           PC => PC,
           Instr => Instr,
           ALUResult => ALUResult,
           WriteData => WriteData,
           Result => Result);

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

    wait for 100*clk_period;

    STOP(2);
    
end process;
end Behavioral;
