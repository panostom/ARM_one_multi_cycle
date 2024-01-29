library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
use std.env.all;
library UNISIM;
use UNISIM.VComponents.all;

entity ADDorSUB_tb is
constant N : positive :=32;
--  Port ( );
end ADDorSUB_tb;

architecture Behavioral of ADDorSUB_tb is
component ADDSUB is
    generic(N : positive :=32);
    Port ( A : in STD_LOGIC_VECTOR (N-1 downto 0);
           B : in STD_LOGIC_VECTOR (N-1 downto 0);
           S : out STD_LOGIC_VECTOR (N-1 downto 0);
           C : out STD_LOGIC;
           V   : out STD_LOGIC;
           ADDorSUB : in STD_LOGIC);
end component;

signal A :  STD_LOGIC_VECTOR (N-1 downto 0);
signal B :  STD_LOGIC_VECTOR (N-1 downto 0);
signal S :  STD_LOGIC_VECTOR (N-1 downto 0);
signal C :  STD_LOGIC;
signal V   :  STD_LOGIC;
signal ADDorSUB :  STD_LOGIC;

begin
uut: ADDSUB port map (A,B,S,C,V,ADDorSUB);

test: process is
begin
wait for 10ns;

A <= "00000000000000000000000000000000";
B <= "00000000000000000000000000000000";
ADDorSUB <= 'X';
wait for 10ns;
A <= "00000000000000000000000000000001";
B <= "00000000000000000000000000000001";
ADDorSUB <= '0';
wait for 10ns;
A <= "00000000000000000000000000000011";
B <= "00000000000000000000000000000001";
ADDorSUB <= '0';
wait for 10ns;
A <= "01111111111111111111111111111111"; --overflow
B <= "00000000000000000000000000000001";
ADDorSUB <= '0';
wait for 10ns;
A <= "00000000000000000000000000000011";
B <= "00000000000000000000000000000001";
ADDorSUB <= '1';
wait for 10ns;
A <= "00000000000000000000000000000010";
B <= "00000000000000000000000000000001";
ADDorSUB <= '1';
wait for 10ns;
A <= "00000000000000000000000000000010";
B <= "00000000000000000000000000000000";
ADDorSUB <= '1';
wait for 10ns;
A <= "10000000000000000000000000000000";
B <= "00000000000000000000000000000001";
ADDorSUB <= '1';
wait for 10ns;
A <= "11111111111111111111111111111111";
B <= "00000000000000000000000000000000";
ADDorSUB <= "010";
wait for 10ns;
stop(2);
end process;
end Behavioral;
