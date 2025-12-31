----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2025 01:23:32 AM
-- Design Name: 
-- Module Name: Aes_decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Aes_decoder is
    Port (  
        data_in         : in  std_logic_vector(15 downto 0);
        round_key       : in  std_logic_vector(15 downto 0);
        data_out        : out std_logic_vector(15 downto 0);
        data_out_iSB    : out std_logic_vector(15 downto 0);
        data_out_iSR    : out std_logic_vector(15 downto 0);
        data_out_iMC    : out std_logic_vector(15 downto 0);
        data_out_AK     : out std_logic_vector(15 downto 0);
        data_out_iSB2   : out std_logic_vector(15 downto 0);
        data_out_iSR2   : out std_logic_vector(15 downto 0);
        data_out_iMC2   : out std_logic_vector(15 downto 0);
        data_out_AK2   : out std_logic_vector(15 downto 0)
    );
end Aes_decoder;

architecture Behavioral of Aes_decoder is

    
    signal r1_isb    : std_logic_vector(15 downto 0);
    signal r1_isr    : std_logic_vector(15 downto 0);
    signal r1_imc    : std_logic_vector(15 downto 0);
    signal r1_ak     : std_logic_vector(15 downto 0);
    signal r2_isb    : std_logic_vector(15 downto 0);
    signal r2_isr    : std_logic_vector(15 downto 0);
    signal r2_ak     : std_logic_vector(15 downto 0);
begin

    -- Round 2 inverse
    
    -- AddRoundKey
    addroundkey_blk2 : entity work.addroundkey
        port map(
            state_in  => data_in,
            round_key => round_key,
            state_out => r2_ak       
        );
        
    -- ShiftRows
    shiftrows_blk2 : entity work.shiftrows
        port map(
            state_in  => r2_ak,
            state_out => r2_isr       
        );
        
     inv_subbytes_blk2 : entity work.inv_subbytes
        port map(
            state_in  => r2_isr,
            state_out => r2_isb       
        );  
             
    -- Round 1 inverse
    -- AddRoundKey
    addroundkey_blk1 : entity work.addroundkey
        port map(
            state_in  => r2_isb,
            round_key => round_key,
            state_out => r1_ak       
        );
    -- MixColumns
    inv_mixcolumns_blk1 : entity work.inv_mixcolumns
        port map(
            state_in  => r1_ak,
            state_out => r1_imc       
        );
    
    -- ShiftRows
    shiftrows_blk1 : entity work.shiftrows
        port map(
            state_in  => r1_imc ,
            state_out => r1_isr       
        );
    
    -- SubBytes
    inv_subbytes_blk1 : entity work.inv_subbytes
        port map(
            state_in  => r1_isr,
            state_out => r1_isb       
        );

    --Round2 output
    data_out_iSB2 <= r2_isb;
    data_out_iSR2 <= r2_isr;
    data_out_iMC2 <= r1_imc;   
    data_out_AK2 <= r2_ak;  
    --Round1
    data_out_iSB <= r1_isb;
    data_out_iSR <= r1_isr;
    data_out_iMC <= r1_imc;   
    data_out_AK <= r1_ak;  
   
    data_out <= r1_isb;

end Behavioral;

