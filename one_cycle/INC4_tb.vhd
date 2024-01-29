----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/24/2021 04:13:04 PM
-- Design Name: 
-- Module Name: INC4_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity INC4_tb is
--  Port ( );
end INC4_tb;

architecture Behavioral of INC4_tb is
--unit under test (uut)
component INC4 is
    generic (WIDTH : positive :=32 );
    Port ( A : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           S : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end component;

constant WIDTH: positive:=32;


signal A : STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal S : STD_LOGIC_VECTOR (WIDTH-1 downto 0);

begin

uut: INC4 port map(A=>A, S=>S);

test: process 
begin
wait for 100ns;
A<="00000000000000000000000000000001";
wait for 100ns;
A<="00000000000000000000000000000010";
wait for 100ns;
A<="00000000000000000000000000000011";
wait for 100ns;

end process;
end Behavioral;
