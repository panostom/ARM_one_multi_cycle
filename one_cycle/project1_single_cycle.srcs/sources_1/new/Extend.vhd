library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Extend is
    Port ( ImmSrc : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (23 downto 0);
           ExtImm : out STD_LOGIC_VECTOR (31 downto 0));
end Extend;

architecture Behavioral of Extend is

begin
    process(ImmSrc,Instr)
    begin
        if(ImmSrc='0')then --apo 12bit sta 32 bit epektash zero
            ExtImm(31 downto 12) <= (others=>'0'); 
            ExtImm(11 downto 0) <= Instr(11 downto 0);
        else
            if(ImmSrc='1')then  --apo 24 bit+"00" epektash proshmou
                ExtImm <= Instr(23)&Instr(23)&Instr(23)&Instr(23)&Instr(23)&Instr(23)&Instr(23 downto 0)&"00";
            else
                ExtImm <= (others=>'0');
            end if;
        end if;
    end process;
end Behavioral;
