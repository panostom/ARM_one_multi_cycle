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
    X"EAFFFFDF",X"E082F00F",X"E1A00000",X"E28FF000",X"93A03008",X"83A03007",X"33A03006",X"23A03005",
    X"D3A03004",X"C3A03003",X"B3A03002",X"A3A03001",X"E1510002",X"E3E0200C",X"E3E01008",X"93A03008",
    X"83A03007",X"33A03006",X"23A03005",X"D3A03004",X"C3A03003",X"B3A03002",X"A3A03001",X"E1520001",
    X"E1510002",X"E3A02003",X"E3A01005",X"71A03001",X"61A03000",X"E2912001",X"E3E01000",X"E3A00000"
    );
begin
    RD <= Instr(to_integer(unsigned(Addr)));
end Behavioral;