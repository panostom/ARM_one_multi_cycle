library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InstrDec is
    Port ( op : in STD_LOGIC_VECTOR (1 downto 0);
           funct : in STD_LOGIC_VECTOR (5 downto 0);
           sh : in STD_LOGIC_VECTOR(1 downto 0);
           RegSrc : out STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           ALUControl : out STD_LOGIC_VECTOR (2 downto 0);
           ImmSrc : out STD_LOGIC;
           NoWrite_in : out STD_LOGIC);
end InstrDec;

architecture Behavioral of InstrDec is

begin

    process(op, funct,sh)
    begin
    
        if(op="00") then
            if(funct="010101")then    --CMP, registers
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '0';
                MemtoReg <= '0';
                ALUControl <= "001";
                ImmSrc <= '0';
                NoWrite_in <= '1'; --prosoxh!     
            elsif(funct="110101")then   --CMP, immediate
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "001";
                ImmSrc <= '0';
                NoWrite_in <= '1'; --prosoxh! 
            elsif(funct="111010")then    --MOV, immediate
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "100";
                ImmSrc <= '0';
                NoWrite_in <= '0'; 
            elsif(funct="011010")then    --MOV, registers OR LSL / ASR
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '0';
                MemtoReg <= '0';
                ImmSrc <= '0';
                NoWrite_in <= '0';
                if(sh="00")then --LSL, h mov me shamt5=00000 ara tha meinei idio to apotelesma san mov
                    ALUControl <= "110";
                elsif(sh="10")then  --ASR
                    ALUControl <= "111";
                else
                    ALUControl <= "100";
                end if;
            elsif(funct="111110")then    --MVN, immediate
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "101";
                ImmSrc <= '0';
                NoWrite_in <= '0'; 
            elsif(funct="011110")then    --MVN, registers
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '0';
                MemtoReg <= '0';
                ALUControl <= "101";
                ImmSrc <= '0';
                NoWrite_in <= '0';
            elsif(funct="101000" or funct="101001")then   --ADD, immediate (de mas noiazei to S=0/1)
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "000";
                ImmSrc <= '0';
                NoWrite_in <= '0';
            elsif(funct="001000" or funct="001001")then   --ADD, registers (de mas noiazei to S=0/1)
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '0';
                MemtoReg <= '0';
                ALUControl <= "000";
                ImmSrc <= '0';
                NoWrite_in <= '0';
            elsif(funct="100100" or funct="100101")then   --SUB, immediate (de mas noiazei to S=0/1)
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "001";
                ImmSrc <= '0';
                NoWrite_in <= '0';
            elsif(funct="000100" or funct="000101")then   --SUB, registers (de mas noiazei to S=0/1)
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '0';
                MemtoReg <= '0';
                ALUControl <= "001";
                ImmSrc <= '0';
                NoWrite_in <= '0';
             elsif(funct="100000" or funct="100001")then   --AND, immediate (de mas noiazei to S=0/1)
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "010";
                ImmSrc <= '0';
                NoWrite_in <= '0';
            elsif(funct="000000" or funct="000001")then   --AND, registers (de mas noiazei to S=0/1)
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '0';
                MemtoReg <= '0';
                ALUControl <= "010";
                ImmSrc <= '0';
                NoWrite_in <= '0';
           elsif(funct="100010" or funct="100011")then   --XOR, immediate (de mas noiazei to S=0/1)
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "011";
                ImmSrc <= '0';
                NoWrite_in <= '0';
            elsif(funct="000010" or funct="000011")then   --XOR, registers (de mas noiazei to S=0/1)
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '0';
                MemtoReg <= '0';
                ALUControl <= "011";
                ImmSrc <= '0';
                NoWrite_in <= '0';   
            else
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '0';
                MemtoReg <= '0';
                ALUControl <= "000";
                ImmSrc <= '0';
                NoWrite_in <= '1';
            end if;
        elsif(op="01") then --data memory instructions
            if(funct="010001")then  --LDR, sub
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '1';
                ALUControl <= "001";
                ImmSrc <= '0';
                NoWrite_in <= '0'; 
            elsif(funct="011001")then   --LDR, add
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '1';
                ALUControl <= "000";
                ImmSrc <= '0';
                NoWrite_in <= '0';
            elsif(funct="011000")then   --STR, add
                RegSrc <= "010";    --diabasma tou Rd sto A2, RD2
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "000";
                ImmSrc <= '0';
                NoWrite_in <= '0';
            elsif(funct="010000")then   --STR, sub
                RegSrc <= "010";    --diabasma tou Rd sto A2, RD2
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "001";
                ImmSrc <= '0';
                NoWrite_in <= '0';
            else
                RegSrc <= "000";    
                ALUSrc <= '0';
                MemtoReg <= '0';
                ALUControl <= "000";
                ImmSrc <= '0';
                NoWrite_in <= '1';
            end if;
        elsif(op="10") then --branches
            if(funct(4)='0') then --branch, 1L, Instr(24) L=0
                RegSrc <= "001";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "000";
                ImmSrc <= '1';
                NoWrite_in <= '1';
            elsif(funct(4)='1') then --branch and link, L=1 Instr(4)
                RegSrc <= "101";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '1';
                MemtoReg <= '0';
                ALUControl <= "000";
                ImmSrc <= '1';
                NoWrite_in <= '0';
            else
                RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
                ALUSrc <= '0';
                MemtoReg <= '0';
                ALUControl <= "000";
                ImmSrc <= '0';
                NoWrite_in <= '1';
            end if;
        else
            RegSrc <= "000";    --panta plhrhs anathesi se ola shmata
            ALUSrc <= '0';
            MemtoReg <= '0';
            ALUControl <= "000";
            ImmSrc <= '0';
            NoWrite_in <= '1';
        end if;
    
    
    end process;

end Behavioral;
