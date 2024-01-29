library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath is
    generic(
            WORDSIZE : positive :=32; --ARCHITECTURE WORDLENGTH
            RAM_SIZE : positive :=5;   --2**RAM_SIZE     
            ROM_SIZE : positive := 6;   --2**ROM_SIZE
            RF_SIZE : positive := 4); --number of registers, 2**REGSIZE
    Port ( PCWrite : in STD_LOGIC;
           PCSrc : in STD_LOGIC;
           RegSrc : in STD_LOGIC_VECTOR (2 downto 0);
           RegWrite : in STD_LOGIC;
           ImmSrc : in STD_LOGIC;
           ALUSrc : in STD_LOGIC;
           ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
           MemtoReg : in STD_LOGIC;
           FlagsWrite : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           IRWrite : in STD_LOGIC;
           MAWrite : in STD_LOGIC; 
           CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           Flags : out STD_LOGIC_VECTOR (3 downto 0);
           PC : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0);
           Instr : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0); 
           ALUResult : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0); 
           WriteData : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0); 
           Result : out STD_LOGIC_VECTOR (WORDSIZE-1 downto 0)
           );
end Datapath;

architecture Behavioral of Datapath is

--Declaration of components
component ALU_top is
    generic(WIDTH : positive :=32);
    Port ( SrcA : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           SrcB : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           ALUControl : in STD_LOGIC_VECTOR (2 downto 0);
           shamt5 : in STD_LOGIC_VECTOR (4 downto 0);
           ALUResult : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           N : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           V : out STD_LOGIC);
end component;

component InstrMemory is
    generic(N : positive := 6;  --address length
            M :positive := 32); --dataword length
    Port ( Addr : in STD_LOGIC_VECTOR (N-1 downto 0);
           RD : out STD_LOGIC_VECTOR (M-1 downto 0));
end component;

component DataMemory is
    generic(
    N : positive :=5; --address length
    M : positive := 32); --data word length
    Port ( 
    CLK : in std_logic;
    WE : in std_logic;
    ADDR: in std_logic_vector(N-1 downto 0);
    DATA_IN : in std_logic_vector(M-1 downto 0);
    DATA_OUT : out std_logic_vector(M-1 downto 0));
end component;

component RegisterFile is
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
end component;

component INC4 is
    generic (WIDTH : positive :=32 );
    Port ( A : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           S : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end component;

component Extend is
    Port ( ImmSrc : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (23 downto 0);
           ExtImm : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component REGrwe_n is
    generic (WIDTH : positive := 32); 
    port ( 
        CLK   :  in STD_LOGIC;
        RESET :  in STD_LOGIC;
        WE    :  in STD_LOGIC;
        Din   :  in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        Dout  : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end component;

component mux2to1 is
    generic (WIDTH : positive :=32);
    Port ( S : in STD_LOGIC;
           A0 : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           A1 : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           Y : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end component;

--Declaration of signals
signal PC_curr : std_logic_vector(WORDSIZE-1 downto 0);
signal PC_next : std_logic_vector(WORDSIZE-1 downto 0);
signal Instruction_next : std_logic_vector(WORDSIZE-1 downto 0);
signal Instruction_curr : std_logic_vector(WORDSIZE-1 downto 0);
signal Addr_RA1 : std_logic_vector(RF_SIZE-1 downto 0);
signal Addr_RA2 : std_logic_vector(RF_SIZE-1 downto 0);
signal Addr_WA : std_logic_vector(RF_SIZE-1 downto 0);
signal PCPlus4_curr : std_logic_vector(WORDSIZE-1 downto 0);
signal PCPlus4_next : std_logic_vector(WORDSIZE-1 downto 0);
signal PCPlus8 : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_WD3 : std_logic_vector(WORDSIZE-1 downto 0);
signal ExtImm_next : std_logic_vector(WORDSIZE-1 downto 0);
signal ExtImm_curr : std_logic_vector(WORDSIZE-1 downto 0);
--signal SrcA : std_logic_vector(WORDSIZE-1 downto 0);
signal SrcB : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_RD1_next : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_RD1_curr : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_RD2_next : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_RD2_curr : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_ALUResult_next : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_ALUResult_curr : std_logic_vector(WORDSIZE-1 downto 0);
signal ALUFlags : std_logic_vector(3 downto 0); --flags output of ALU, insert to SR
signal Data_MA_Memory_curr : std_logic_vector(RAM_SIZE-1 downto 0); 
signal Data_WD_Memory_curr : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_RD_Memory_next : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_RD_Memory_curr : std_logic_vector(WORDSIZE-1 downto 0);
signal Data_Result : std_logic_vector(WORDSIZE-1 downto 0);

----
begin

PC_register : REGrwe_n
    generic map(WIDTH => WORDSIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => PCWrite,
        Din   => PC_next,
        Dout  => PC_curr);
        
Instruction_memory: InstrMemory
    generic map(N => ROM_SIZE,
                M => WORDSIZE)
    Port map( Addr => PC_curr(ROM_SIZE+1 downto 2),
           RD => Instruction_next);         
        
INC4_Plus4 : INC4
    generic map (WIDTH => WORDSIZE)
    Port map ( A => PC_curr,
           S => PCPlus4_next);        

IR_Register : REGrwe_n
    generic map(WIDTH => WORDSIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => IRWrite,
        Din   => Instruction_next,
        Dout  => Instruction_curr);
        
 PCp4_Register : REGrwe_n
    generic map(WIDTH => WORDSIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => '1',
        Din   => PCPlus4_next,
        Dout  => PCPlus4_curr);       
        
INC4_Plus8 : INC4
    generic map (WIDTH => WORDSIZE)
    Port map ( A => PCPlus4_curr,
           S => PCPlus8);
           
MUX_RegSrc_0: mux2to1       
    generic map (WIDTH => RF_SIZE) --prosoxh!!!! address rf_size
    Port map( S => RegSrc(0),
           A0 => Instruction_curr(19 downto 16),
           A1 => std_logic_vector(to_unsigned(15,RF_SIZE)), --auto demou aresei polu, kapws alliws tha ginetai
           Y => Addr_RA1);
           
MUX_RegSrc_1: mux2to1
    generic map (WIDTH => RF_SIZE)
    Port map ( S => RegSrc(1),
           A0 => Instruction_curr(3 downto 0),
           A1 => Instruction_curr(15 downto 12),
           Y => Addr_RA2);         
        
MUX_RegSrc_2: mux2to1
    generic map (WIDTH => RF_SIZE)
    Port map ( S => RegSrc(2),
           A0 => Instruction_curr(15 downto 12),
           A1 => std_logic_vector(to_unsigned(14,RF_SIZE)), --na to xanadw
           Y => Addr_WA); 
           
Register_File: RegisterFile 
    generic map(
    N => RF_SIZE, --address length
    M => WORDSIZE) --register length
    Port map ( CLK => CLK,
           WE => RegWrite,
           A1 => Addr_RA1,
           A2 => Addr_RA2,
           A3 => ADDR_WA,
           R15 => PCPlus8,
           WD3 => Data_WD3,
           RD1 => Data_RD1_next,
           RD2 => Data_RD2_next);           

 A_Register : REGrwe_n
    generic map(WIDTH => WORDSIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => '1',
        Din   => Data_RD1_next,
        Dout  => Data_RD1_curr);  
  
 B_Register : REGrwe_n
    generic map(WIDTH => WORDSIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => '1',
        Din   => Data_RD2_next,
        Dout  => Data_RD2_curr);  
           
 MUX_Result_or_PCPlus4: mux2to1 
    generic map(WIDTH => WORDSIZE)
    Port map( S => RegSrc(2),
           A0 => Data_Result,
           A1 => PCPlus4_curr,
           Y => Data_WD3);          
           
Extend_Zero_Sign:  Extend 
    Port map ( ImmSrc => ImmSrc,
           Instr => Instruction_curr(23 downto 0),
           ExtImm => ExtImm_next);

 I_Register : REGrwe_n
    generic map(WIDTH => WORDSIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => '1',
        Din   => ExtImm_next,
        Dout  => ExtImm_curr);
           
MUX_ALU_input_RF_or_Extend: mux2to1 
generic map(WIDTH => WORDSIZE)
Port map( S => ALUSrc,
       A0 => Data_RD2_curr,
       A1 => ExtImm_curr,
       Y => SrcB);          

ALU: ALU_top 
    generic map(WIDTH => WORDSIZE)
    Port map( SrcA => Data_RD1_curr,
           SrcB => SrcB,
           ALUControl => ALUControl,
           shamt5 => Instruction_curr(11 downto 7),
           ALUResult => Data_ALUResult_next,
           N => ALUFlags(3),    --ta bgazw ola mazi se ena vector
           Z => ALUFlags(2),
           C => ALUFlags(1),
           V => ALUFlags(0));

SR_register: REGrwe_n 
    generic map (WIDTH => 4) 
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => FlagsWrite,
        Din   => ALUFlags,
        Dout  => Flags);


 MA_Register : REGrwe_n
    generic map(WIDTH => RAM_SIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => MAWrite,
        Din   => Data_ALUResult_next(RAM_SIZE+1 downto 2),
        Dout  => Data_MA_Memory_curr);
        
 WD_Register : REGrwe_n
    generic map(WIDTH => WORDSIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => '1',
        Din   => Data_RD2_curr,
        Dout  => Data_WD_Memory_curr);
        
 S_Register : REGrwe_n
    generic map(WIDTH => WORDSIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => '1',
        Din   => Data_ALUResult_next,
        Dout  => Data_ALUResult_curr);        
        
Data_Memory: DataMemory
    generic map(
    N => RAM_SIZE, --address length
    M => WORDSIZE) --data word length
    Port map( 
    CLK => CLK,
    WE => MemWrite,
    ADDR => Data_MA_Memory_curr,
    DATA_IN => Data_WD_Memory_curr,
    DATA_OUT => Data_RD_Memory_next);

 RD_Register : REGrwe_n
    generic map(WIDTH => WORDSIZE)
    port map( 
        CLK   => CLK,
        RESET => RESET,
        WE    => '1',
        Din   => Data_RD_Memory_next,
        Dout  => Data_RD_Memory_curr);

MUX_Memory_or_ALUResult: mux2to1
    generic map(WIDTH => WORDSIZE)
    Port map( S => MemtoReg,
           A0 => Data_ALUResult_curr,
           A1 => Data_RD_Memory_curr,
           Y => Data_Result);  
           
MUX_PC_next_4_or_Branch: mux2to1
    generic map(WIDTH => WORDSIZE)
    Port map( S => PCSrc,
           A0 => PCPlus4_curr,
           A1 => Data_Result,
           Y => PC_next);

--Declaration of Datapath outputs, connect signals           
PC <= PC_curr;
Instr <= Instruction_curr; --auto paei gia apokwdikopoihsh
ALUResult <= Data_ALUResult_next;  
WriteData <= Data_WD_Memory_curr; 
Result <= Data_Result;

end Behavioral;
