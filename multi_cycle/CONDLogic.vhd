library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONDLogic is
    Port ( cond : in STD_LOGIC_VECTOR (3 downto 0);
           flags : in STD_LOGIC_VECTOR (3 downto 0);
           CondEx_in : out STD_LOGIC);
end CONDLogic;

architecture Behavioral of CONDLogic is

begin

    process(cond, flags)
    begin
        case cond is
            when "0000" => CondEx_in <= flags(2);    --EQ equal
            when "0001" => CondEx_in <= not flags(2);    --NE not equal
            when "0010" => CondEx_in <= flags(1);    --CS/HS carry set/unsigned higher or same
            when "0011" => CondEx_in <= not flags(1);    --CC/LO carry clear/unsigned lower
            when "0100" => CondEx_in <= flags(3);    --MI minus/negative
            when "0101" => CondEx_in <= not flags(3);    --PL plus/positive
            when "0110" => CondEx_in <= flags(0);    --VS overflow
            when "0111" => CondEx_in <= not flags(0);    --VC no overflow
            when "1000" => CondEx_in <= flags(1) and (not flags(2));    --HI unsigned higher
            when "1001" => CondEx_in <= flags(2) or (not flags(1));    --LS unsigned lower or same
            when "1010" => CondEx_in <= not (flags(3) xor flags(0));    --GE signed greater or equal
            when "1011" => CondEx_in <= flags(3) xor flags(0);    --LT signed less
            when "1100" => CondEx_in <= (not flags(2)) and (not (flags(3) xor flags(0)));    --GT signed greater
            when "1101" => CondEx_in <= flags(2) or (flags(3) xor flags(0));    --LE signed less or equal
            when "1110" => CondEx_in <= '1';    --AL always/ unconditional
            when "1111" => CondEx_in <= '1';    --unconditional
            when others => CondEx_in <= '0'; --nomizw swsto
        end case;

    end process;

end Behavioral;
