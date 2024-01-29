library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity DataMemory is
    generic(
    N : positive :=5; --address length
    M : positive := 32); --data word length
    Port ( 
    CLK : in std_logic;
    WE : in std_logic;
    ADDR: in std_logic_vector(N-1 downto 0);
    DATA_IN : in std_logic_vector(M-1 downto 0);
    DATA_OUT : out std_logic_vector(M-1 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
    type DM is array (2**N-1 downto 0) of STD_LOGIC_VECTOR(M-1 downto 0); --exponentiation **
    signal RAM : DM;
begin
BLOCK_RAM : process(CLK)
    begin
        if (CLK='1' and CLK'event) then
            if (WE='1')then
                RAM(to_integer(unsigned(ADDR))) <= DATA_IN;
            end if;
        end if;
    end process;
--    process(ADDR)
--    begin
--        DATA_OUT <= RAM(to_integer(unsigned(ADDR)));
--    end process;
    DATA_OUT <= RAM(to_integer(unsigned(ADDR))); --asugxrono diabasma, to bgazw ektos process
end Behavioral;                                  --afou ekteleitai panta!