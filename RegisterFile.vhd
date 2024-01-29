library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity RegisterFile is
    generic(
    N : positive :=4; --address length
    M : positive := 32); --register length
    Port ( CLK : in STD_LOGIC;
           WE : in STD_LOGIC;
           A1 : in STD_LOGIC_VECTOR (N-1 downto 0);
           A2 : in STD_LOGIC_VECTOR (N-1 downto 0);
           A3 : in STD_LOGIC_VECTOR (N-1 downto 0);
           R15 : in STD_LOGIC_VECTOR (M-1 downto 0);
           WD3 : in STD_LOGIC_VECTOR (M-1 downto 0);
           RD1 : out STD_LOGIC_VECTOR (M-1 downto 0);
           RD2 : out STD_LOGIC_VECTOR (M-1 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is
type RF_array is array (2**N-1 downto 0) of std_logic_vector(M-1 downto 0);
signal RF : RF_array;
begin
    REG_FILE: process(CLK)
    begin
        if(CLK='1' and CLK'event) then
            if(WE='1')then
                RF(to_integer(unsigned(A3))) <= WD3;
            end if;
        end if;
    end process;
    --RD1 <= RF(to_integer(unsigned(A1))) when A1/= std_logic_vector(to_unsigned(15,A1'length)) else R15 when A1=std_logic_vector(to_unsigned(15,A1'length));
    --RD2 <= RF(to_integer(unsigned(A2)));
    process(A1,A2,R15) begin
        if (to_integer(unsigned(A1)) = 15) then RD1 <= R15; --eite diabasma tou PC+8 eite enos kataxwrhth
            else RD1 <= RF(to_integer(unsigned(A1)));
        end if;
        if (to_integer(unsigned(A2)) = 15) then RD2 <= R15;
            else RD2 <= RF(to_integer(unsigned(A2)));
        end if;
    end process;
end Behavioral;
