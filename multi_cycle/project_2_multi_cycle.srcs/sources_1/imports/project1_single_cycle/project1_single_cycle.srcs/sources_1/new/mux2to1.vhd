library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1 is
    generic (WIDTH : positive :=32);
    Port ( S : in STD_LOGIC;
           A0 : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           A1 : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           Y : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end mux2to1;

architecture Behavioral of mux2to1 is
begin
    process(A0,A1,S)
    begin
        if(S='0') then
            Y <= A0;
        else
            if(S='1')then
                Y <= A1;
            else
                Y <= (others=>'0');
            end if;
        end if;  
    end process;
end Behavioral;