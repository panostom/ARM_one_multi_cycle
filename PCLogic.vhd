library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCLogic is
    Port ( Rd : in STD_LOGIC_VECTOR (3 downto 0);
           op_1 : in STD_LOGIC;
           RegWrite_in : in STD_LOGIC;
           PCSrc_in : out STD_LOGIC);
end PCLogic;

architecture Behavioral of PCLogic is

begin

    process(Rd, op_1, RegWrite_in)
    begin
        if((Rd="1111") and (RegWrite_in='1')) then --eggrafh stoc R15 PC
            PCSrc_in <= '1';
        elsif (op_1='1') then --entolh branch
            PCSrc_in <= '1';
        else
            PCSrc_in <= '0';
        end if;
    end process;

end Behavioral;
