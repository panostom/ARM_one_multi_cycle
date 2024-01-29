library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;


entity FSM is
    Port ( NoWrite_in : in STD_LOGIC;
           op : in STD_LOGIC_VECTOR (1 downto 0);
           S_L : in STD_LOGIC;
           Rd : in STD_LOGIC_VECTOR (3 downto 0);
           CondEx_in : in STD_LOGIC;
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           IRWrite : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           FlagsWrite : out STD_LOGIC;
           MAWrite : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           PCSrc : out STD_LOGIC;
           PCWrite : out STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

type FSM_STATES is (S0,S1,S2a, S2b, S2c, S3, S4a, S4b, S4c, S4d, S4e, S4f, S4g, S4h, S4i);

signal current_state, next_state : FSM_STATES;

begin

SYNC: process(CLK)
    begin
    if(CLK'event and CLK='1')then
        if(RESET='1')then
            current_state <= S0;
        else
            current_state <= next_state;
        end if;
    end if;   
    end process;

ASYNC: process(current_state, op, S_L, Rd, CondEx_in, NoWrite_in)
    begin
        next_state <= S0;   --arxikopoihsh panta
        IRWrite <= '0';
        RegWrite <= '0';
        FlagsWrite <= '0';
        MAWrite <= '0';
        MemWrite <= '0';
        PCSrc <= '0';
        PCWrite <= '0';

        case current_state is
            when S0 =>  --arxiko stadio gia oles tis entoles
                next_state <= S1;
                IRWrite <= '1';
            when S1 =>
                if(CondEx_in='0')then   --ID, elegxos conditions
                    next_state <= S4c;
                elsif(CondEx_in='1')then
                    if(op="00" and NoWrite_in='0')then  --DP ektos CMP
                        next_state <= S2b;
                    elsif(op="01")then
                        next_state <= S2a;
                    elsif(op="10")then
                        next_state <= S2c;
                    elsif(op="00" and NoWrite_in='1')then   --CMP
                        next_state <= S4g;
                    end if;
                end if;    
            when S2a => --LDR/STR
                if(S_L='1')then --LDR
                    next_state <= S3;
                    MAWrite <= '1';
                elsif(S_L='0')then  --STR
                    next_state <= S4d;
                    MAWrite <= '1';
                end if;
            when S2b => --DP
                if(S_L='0' and Rd /= "1111")then    --S=0, RD != 15
                    next_state <= S4a;
                 elsif(S_L='0' and Rd = "1111")then --S=0, RD = 15
                    next_state <= S4b;
                elsif(S_L='1' and Rd /= "1111")then --S=1, RD != 15
                    next_state <= S4e;
                elsif(S_L='1' and Rd = "1111")then  --S=1, RD = 15
                    next_state <= S4f;
                end if;
            when S2c => --BRANCHES
                if(S_L='0')then --BRANCH
                    next_state <= S4h;
                elsif(S_L='1')then  --BRANCH AND LINK
                    next_state <= S4i;
                end if;
            when S3 =>
                if(Rd /= "1111")then
                    next_state <= S4a;
                elsif(Rd = "1111")then
                    next_state <= S4b;
                end if;    
            when S4a =>
                next_state <= S0;
                PCWrite <= '1';
                RegWrite <= '1';
            when S4b=>
                next_state <= S0;
                PCWrite <= '1';
                PCSrc <= '1';
            when S4c =>
                next_state <= S0;
                PCWrite <= '1';
            when S4d => --STR
                next_state <= S0;
                PCWrite <= '1';
                MemWrite <= '1';
            when S4e => --S=1, RD!=15
                next_state <= S0;
                RegWrite <= '1';
                PCWrite <= '1';
                FlagsWrite <= '1';    
            when S4f => --S=1,RD=15
                next_state <= S0;
                PCWrite <= '1';
                FlagsWrite <= '1';
                PCSrc <= '1';
            when S4g => --CMP
                next_state <= S0;
                PCWrite <= '1';
                FlagsWrite <= '1';
            when S4h => --BRANCH
                next_state <= S0;
                PCWrite <= '1';
                PCSrc <= '1';
            when S4i => --BRANCH AND LINK
                next_state <= S0;
                PCWrite <= '1';
                PCSrc <= '1';
                RegWrite <= '1';
            when others => next_state <= S0;
        end case;
    end process;

end Behavioral;
