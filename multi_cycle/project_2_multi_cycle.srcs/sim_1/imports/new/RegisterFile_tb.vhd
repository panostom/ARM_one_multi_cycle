library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;
use std.env.all;

entity RegisterFile_tb is
--  Port ( );
constant N:positive:=4;
constant M:positive:=32;
end RegisterFile_tb;

architecture Behavioral of RegisterFile_tb is

component RegisterFile is
    Port ( CLK : in STD_LOGIC;
           WE : in STD_LOGIC;
           A1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           A2 : in STD_LOGIC_VECTOR (N-1 downto 0);
           A3 : in STD_LOGIC_VECTOR (N-1 downto 0);
           R15 : in STD_LOGIC_VECTOR (M-1 downto 0);
           WD3 : in STD_LOGIC_VECTOR (M-1 downto 0);
           RD1 : out STD_LOGIC_VECTOR (M-1 downto 0);
           RD2 : out STD_LOGIC_VECTOR (M-1 downto 0));
end component;

signal CLK :  STD_LOGIC := '0';
signal WE :  STD_LOGIC;
signal A1 :  STD_LOGIC_VECTOR (N-1 downto 0);
signal A2 :  STD_LOGIC_VECTOR (N-1 downto 0);
signal A3 :  STD_LOGIC_VECTOR (N-1 downto 0);
signal R15 :  STD_LOGIC_VECTOR (M-1 downto 0);
signal WD3 :  STD_LOGIC_VECTOR (M-1 downto 0);
signal RD1 :  STD_LOGIC_VECTOR (M-1 downto 0);
signal RD2 :  STD_LOGIC_VECTOR (M-1 downto 0);

constant CLK_period : time := 10.000 ns;

begin

uut: RegisterFile port map (CLK => CLK,
           WE =>WE,
           A1 =>A1,
           A2 =>A2,
           A3 =>A3,
           R15 =>R15,
           WD3 => WD3,
           RD1 =>RD1,
           RD2 => RD2
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
    wait for 100 ns;
    wait until (CLK = '0' and CLK'event);
    
--    WE<='1';A3<=std_logic_vector(to_unsigned(15,A3'length));WD3<=std_logic_vector(to_unsigned(200,WD3'length));
--    wait for clk_period;
--    WE<='1';A3<=std_logic_vector(to_unsigned(1,A3'length));WD3<=std_logic_vector(to_unsigned(5,WD3'length));
--    wait for clk_period;
--    WE<='1';A3<=std_logic_vector(to_unsigned(2,A3'length));WD3<=std_logic_vector(to_unsigned(10,WD3'length));R15<=std_logic_vector(to_unsigned(150,WD3'length));
--    wait for clk_period;
--    WE<='0';A1<=std_logic_vector(to_unsigned(15,A3'length));
--    wait for clk_period;
--    WE<='0';A1<=std_logic_vector(to_unsigned(1,A3'length));A2<=std_logic_vector(to_unsigned(2,A3'length));
--    wait for clk_period;
--    WE<='1';A3<=std_logic_vector(to_unsigned(3,A3'length));WD3<=std_logic_vector(to_unsigned(6,WD3'length));
--    wait for clk_period;
--    wait until (CLK = '0' and CLK'event);
--    WE<='1';A3<=std_logic_vector(to_unsigned(4,A3'length));WD3<=std_logic_vector(to_unsigned(8,WD3'length));R15<=std_logic_vector(to_unsigned(55,WD3'length));
--    wait for clk_period;
--    WE<='0';A1<=std_logic_vector(to_unsigned(3,A3'length));A2<=std_logic_vector(to_unsigned(4,A3'length));
--    wait for clk_period;
--    WE<='0';A1<=std_logic_vector(to_unsigned(15,A3'length));
--    wait for clk_period;
    
--    R15<=std_logic_vector(to_unsigned(250,WD3'length));
--    wait for clk_period;
    
    for i in 0 to 14 loop
        WE<='1';A3<=std_logic_vector(to_unsigned(i,A3'length)); WD3<=std_logic_vector(to_unsigned(i,WD3'length));
        wait for clk_period;
    END LOOP;
    
    for i in 0 to 14 loop
        WE<='0';A1<=std_logic_vector(to_unsigned(i,A1'length)); A2<=std_logic_vector(to_unsigned(i+1,A2'length));
        wait for clk_period;
    END LOOP;
    
    WE<='0';A1<=std_logic_vector(to_unsigned(15,A3'length)); R15<=std_logic_vector(to_unsigned(250,WD3'length));
    wait for clk_period;
    
    
    stop(2);
end process;
end Behavioral;
