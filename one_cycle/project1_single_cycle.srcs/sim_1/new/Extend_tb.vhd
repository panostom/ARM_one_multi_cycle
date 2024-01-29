library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Extend_tb is
--  Port ( );
end Extend_tb;

architecture Behavioral of Extend_tb is
component Extend is
    Port ( ImmSrc : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (23 downto 0);
           ExtImm : out STD_LOGIC_VECTOR (31 downto 0));
end component;
signal ImmSrc :  STD_LOGIC;
signal Instr :  STD_LOGIC_VECTOR (23 downto 0);
signal ExtImm :  STD_LOGIC_VECTOR (31 downto 0);

begin

uut: Extend port map(ImmSrc=>ImmSrc,Instr=>Instr,ExtImm=>ExtImm);
test: process is
begin
    ImmSrc<='0';Instr<="000000000000000000000111";
    wait for 50ns;
    ImmSrc<='0';Instr<="000000000001100000000111";
    wait for 50ns;
    ImmSrc<='1';Instr<="000000000000000000000111";
    wait for 50ns;
    ImmSrc<='1';Instr<="010000000000000000000111";
    wait for 50ns;
    ImmSrc<='1';Instr<="110000000000000000000111";
    wait for 50ns;
end process;
end Behavioral;
