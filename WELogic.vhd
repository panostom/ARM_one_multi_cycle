library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WELogic is
    Port ( op : in STD_LOGIC_VECTOR (1 downto 0);
           NoWrite_in : in STD_LOGIC;
           S_L : in STD_LOGIC;
           RegWrite_in : out STD_LOGIC;
           FlagsWrite_in : out STD_LOGIC;
           MemWrite_in : out STD_LOGIC);
end WELogic;

architecture Behavioral of WELogic is

begin

    process(op, NoWrite_in, S_L)
    begin
        if(op="10")then --Branches
            if(NoWrite_in='0')then --Branch and link, RF write to R14
                RegWrite_in <= '1';
            elsif(NoWrite_in='1')then   --branch
                RegWrite_in <= '0';
            else
                RegWrite_in <= '0';
            end if;
            FlagsWrite_in <= '0';
            MemWrite_in <= '0';
        elsif(op="01")then  --data memory
            if(S_L='0')then --STR
                RegWrite_in <= '0';
                FlagsWrite_in <= '0';
                MemWrite_in <= '1';    
            elsif(S_L='1')then  --LDR
                RegWrite_in <= '1';
                FlagsWrite_in <= '0';
                MemWrite_in <= '0';
            else
                RegWrite_in <= '0';
                FlagsWrite_in <= '0';
                MemWrite_in <= '0';
            end if;
        elsif(op="00")then  --Data processing
            MemWrite_in <= '0'; --always false
            if(NoWrite_in = '1')then
                RegWrite_in <= '0';
            elsif(NoWrite_in = '0') then
                RegWrite_in <= '1';
            else
                RegWrite_in <= '0';
            end if;
            if(S_L='1')then
                FlagsWrite_in<='1';
            elsif(S_L='0')then
                FlagsWrite_in<='0';
            else
                FlagsWrite_in<='0';  
            end if;
        else
            RegWrite_in <= '0';
            FlagsWrite_in <= '0';
            MemWrite_in <= '0'; 
        end if;
end process;

end Behavioral;
