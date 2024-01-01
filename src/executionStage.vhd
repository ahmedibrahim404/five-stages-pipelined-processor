LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ExecutionStage IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        isOneOp : IN STD_LOGIC;
        isImmediate : IN STD_LOGIC;
        RS1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RS2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RDst : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ImmVal : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        willBranch : OUT STD_LOGIC;
        outFlag : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Alu_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        memReadSig_in : IN STD_LOGIC;
        memReadSig_out : OUT STD_LOGIC;
        instruction_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        Rdst_sel_in : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rdst_sel_out : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        MemAdr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        MemAdr_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

        regWriteSig_in : IN STD_LOGIC;
        regWriteSig_out : OUT STD_LOGIC;
        Z, N, C : OUT STD_LOGIC;
        spIncIn, spDecIn : IN STD_LOGIC;
        spIncOut, spDecOut : OUT STD_LOGIC;

        Fwrd_sel1, Fwrd_sel2 : IN STD_LOGIC;
        Fwrd_data1, Fwrd_data2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PcSelect : OUT STD_LOGIC;
        PcData : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        z_in: in std_logic;
        cjFlush : out std_logic;
        dataToWriteInMemory: out std_logic_vector(31 downto 0);
        dataToWriteInMemoryEnable: out std_logic

    );
END ENTITY ExecutionStage;

ARCHITECTURE execution OF ExecutionStage IS

    SIGNAL A : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL F_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL outFlag_temp : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
    SIGNAL inFlag_temp : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";


BEGIN

    A <=
        Fwrd_data1 WHEN Fwrd_sel1 = '1' ELSE
        RS1 WHEN isOneOp = '0' ELSE
        RDst;

    B <=
        Fwrd_data2 WHEN Fwrd_sel2 = '1' ELSE
        RS2 WHEN isImmediate = '0' ELSE
        ImmVal;

    ALUInstance : ENTITY work.AluEnt PORT MAP(A, B, instruction(15 DOWNTO 11), inFlag_temp, outFlag_temp, F_out);

    Alu_Out <= ImmVal when instruction(15 DOWNTO 11) = "11001"
    ELSE F_out;

    outFlag <= outFlag_temp;

    memReadSig_out <= memReadSig_in;
    instruction_out <= instruction;

    Rdst_sel_out <= Rdst_sel_in;

    MemAdr_out <= ImmVal when instruction(15 DOWNTO 11) = "11011"
    ELSE A when instruction(15 DOWNTO 11) = "00111" or instruction(15 DOWNTO 11) = "01000"
    ELSE MemAdr;

    dataToWriteInMemory <= A;
    dataToWriteInMemoryEnable <= '1' when instruction(15 DOWNTO 11) = "11011"
    ELSE '0';

    regWriteSig_out <= regWriteSig_in;

    Z <= outFlag_temp(0);
    N <= outFlag_temp(1);
    C <= outFlag_temp(2);

    spDecOut <= spDecIn;
    spIncOut <= spIncIn;

    PcSelect <= '1' when instruction(15 downto 11) = "01001" and z_in = '1' else '0';
    PcData <= RDst(15 DOWNTO 0);
    
    cjFlush <= '1' when instruction(15 downto 11) = "01001" and z_in = '1' else '0';

    -- inFlag_temp <= outFlag_temp;

    -- PROCESS (clk, rst)
    -- BEGIN
    --     inFlag_temp <= outFlag_temp;
    -- END PROCESS;

    

END execution;
