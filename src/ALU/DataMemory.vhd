library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity dataMem is
Generic (n: integer := 32);        
port(
    clk:                IN std_logic;
    rst :               IN std_logic;
    readAddress :    	IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    readEnable :        IN std_logic;
    writeAddress :    	IN std_logic_vector(9 DOWNTO 0);        -- 10 bit address
    writeEnable :       IN std_logic;
    writeData :         IN std_logic_vector(n-1 DOWNTO 0);
    readData :          OUT std_logic_vector(n-1 DOWNTO 0)
);
end entity;



architecture dataMemDesign of dataMem is
TYPE ram_type IS ARRAY(0 TO 2**12-1) of std_logic_vector(n-1 DOWNTO 0);			
    signal ram : ram_type;

begin

    PROCESS (clk,rst)
    BEGIN
        IF rst = '1' THEN            
            ram <= (others=>(others=>'0'));
            
        ELSIF falling_edge(clk) and writeEnable = '1' THEN
                ram(to_integer(unsigned(writeAddress))) <= writeData;
            ELSE
            -- END IF;
        END IF;
    END PROCESS;

    readData <= ram(to_integer(unsigned((readAddress)))) WHEN readEnable = '1'  
    ELSE (OTHERS => '0');
    
end dataMemDesign;

