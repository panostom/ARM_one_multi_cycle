library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity REGrwe_n is
    generic (WIDTH : positive := 32); 
    port ( 
        CLK   :  in STD_LOGIC;
        RESET :  in STD_LOGIC;
        WE    :  in STD_LOGIC;
        Din   :  in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        Dout  : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end REGrwe_n;

architecture Behavioral of REGrwe_n is

begin
    process (CLK)
    begin
        if (CLK = '1' and CLK'event) then
            if (RESET = '1') then Dout <= (others => '0'); 
            elsif (WE = '1') then Dout <= Din; 
            end if; 
        end if; 
    end process; 
end Behavioral;
