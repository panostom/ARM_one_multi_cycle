library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstrMemory is
    generic(N : positive := 6;  --address length
            M :positive := 32); --dataword length
    Port ( Addr : in STD_LOGIC_VECTOR (N-1 downto 0);
           RD : out STD_LOGIC_VECTOR (M-1 downto 0));
end InstrMemory;

architecture Behavioral of InstrMemory is

type Instr_array is array (2**N-1 downto 0) of STD_LOGIC_VECTOR(M-1 downto 0);
constant Instr : Instr_array := (
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",
    X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"00000000",X"EAFFFFF6",
    X"E1A00000",X"6A000000",X"7A000000",X"E2513001",X"E2512001",X"E1A01F81",X"E3A01001",X"E3A00000"
    );
begin
    RD <= Instr(to_integer(unsigned(Addr)));
end Behavioral;
