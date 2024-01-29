library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity INC4 is
    generic (WIDTH : positive :=32 );
    Port ( A : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           S : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end INC4;

architecture Behavioral of INC4 is

begin
process(A)
    variable A_u,S_u : UNSIGNED (WIDTH-1 downto 0); --antimetwpizw thn eisodo ws unsigned kathws einai o PC
    begin
    A_u := unsigned(A);
    S_u := A_u + 4;--to_unsigned(4,WIDTH-1);
    S <= std_logic_vector(S_u);
    end process;

end Behavioral;
