library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity NOR_tree is
    generic (WIDTH: positive:=32);
    Port ( Din : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           Z : out STD_LOGIC);
end NOR_tree;

architecture Behavioral of NOR_tree is

begin           --kanw NOR ola ta bit
    process(Din)
        variable A : std_logic; --:=0 ekana edw arxikopoihsh kai den ebgaine swsto to apotelesma
    begin
        A := '0';   --arxikopoihsh panta entos process!!!
        for I in 0 to WIDTH-1 loop
            A := Din(I) or A;
	   end loop;
	   Z <= not A; --exodos nor
    end process;

end Behavioral;
