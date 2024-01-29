library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity ALU_woFlags is
    generic(WIDTH : positive :=32);
    Port ( A : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           B : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
           shamt5 : in STD_LOGIC_VECTOR (4 downto 0);
           S : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           C : out STD_LOGIC;
           V : out STD_LOGIC);
end ALU_woFlags;

architecture Behavioral of ALU_woFlags is

begin
process(A,B,ALUControl,shamt5)
    variable A_s,B_s,S_s : signed (WIDTH+1 downto 0);
    variable shamt5_n : NATURAL range 0 to WIDTH-1;
    variable B_shift_u : unsigned(WIDTH-1 downto 0);
    variable B_shift_s : signed(WIDTH-1 downto 0);    
    begin
        
        shamt5_n := to_integer(unsigned(shamt5));
        B_shift_u := unsigned(B);
        B_shift_s := signed(B);
        
        if(ALUControl="000")then --ADD
            A_s := signed('0'&A(WIDTH-1)&A);
            B_s := signed('0'&B(WIDTH-1)&B);
            S_s := A_s + B_s;
            S <= std_logic_vector(S_s(WIDTH-1 downto 0));
            C <= S_s(WIDTH+1);
            V <= S_s(WIDTH) xor S_s(WIDTH-1);
        elsif(ALUControl="001")then     --SUB
            A_s := signed('0'&A(WIDTH-1)&A);
            B_s := signed('1'&B(WIDTH-1)&B); --etsi bgainei swsto to carry exodou otan exoume afairesh, anti gia '0' bazoume '1'
            S_s := A_s - B_s;              --to opoio antistrefetai kata thn afairesh kai dinei to 0 poy tha deixei an exoume carry out     
            S <= std_logic_vector(S_s(WIDTH-1 downto 0));
            C <= S_s(WIDTH+1);
            V <= S_s(WIDTH) xor S_s(WIDTH-1);
        elsif(ALUControl="010")then     --AND
            S <= A and B;
            C <='0';    --gia na mh ginei elleiphs anathesi
            V <= '0';   --mono oi arithimitikes praxeis kanoun set to C,V
        elsif(ALUControl="011")then     --XOR
            S <= A xor B;
            C <='0';    --gia na mh ginei elleiphs anathesi
            V <= '0';
        elsif(ALUControl="100")then     --MOV
            S <= B;     --pollh prosoxh, to SrcB bgainei pros ta exw
            C <='0';    --gia na mh ginei elleiphs anathesi
            V <= '0';
        elsif(ALUControl="101")then     --MVN
            S <= not B;
            C <='0';    --gia na mh ginei elleiphs anathesi
            V <= '0';
        elsif(ALUControl="110")then     --LSL
            S <= std_logic_vector(shift_left(B_shift_u,shamt5_n)); --pollh prosoxh, kanw shift panta to SrcB!!!!
            C <='0';    --gia na mh ginei elleiphs anathesi
            V <= '0';
        elsif(ALUControl="111")then     --ASR
            S <= std_logic_vector(shift_right(B_shift_s,shamt5_n));
            C <='0';    --gia na mh ginei elleiphs anathesi
            V <= '0';
        else
            S <= (others=>'0');
            C <='0';    --gia na mh ginei elleiphs anathesi
            V <= '0';
        end if;

    end process;
end Behavioral;