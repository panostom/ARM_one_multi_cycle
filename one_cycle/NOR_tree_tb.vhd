library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.all;

entity NOR_tree_tb is
--  Port ( );
constant WIDTH: positive:=32;
end NOR_tree_tb;

architecture Behavioral of NOR_tree_tb is
component NOR_tree is
    generic (WIDTH: positive:=32);
    Port ( Din : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           Z : out STD_LOGIC);
end component;
signal Din : STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal Z :  STD_LOGIC;

begin
uut: NOR_tree port map(Din,Z);
test :process
begin
    wait for 10ns;
    Din <= "00000000000000000000000000000000";
    wait for 10ns;
    Din <= "00000100000000000000000000000000";
    wait for 10ns;
    Din <= "00000000000000000001000000000000";
    wait for 10ns;
    Din <= "00000000000000000000000000000000";
    wait for 10ns;
    stop(2);
end process;
end Behavioral;
