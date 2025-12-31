----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2025 12:06:43 AM
-- Design Name: 
-- Module Name: Aes_encoder - Behavioral
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
use work.aes_sbox_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Aes_encoder is
    Port (  
        data_in        : in  std_logic_vector(15 downto 0);
        round_key      : in  std_logic_vector(15 downto 0);

        data_out_SB    : out std_logic_vector(15 downto 0);
        data_out_SR    : out std_logic_vector(15 downto 0);
        data_out_MC    : out std_logic_vector(15 downto 0);
        data_out_AK    : out std_logic_vector(15 downto 0);
        data_out_SB2   : out std_logic_vector(15 downto 0);
        data_out_SR2   : out std_logic_vector(15 downto 0);
        data_out_MC2   : out std_logic_vector(15 downto 0);
        data_out_AK2   : out std_logic_vector(15 downto 0)
    );
end Aes_encoder;
architecture Behavioral of Aes_encoder is


    signal r1_sb    : std_logic_vector(15 downto 0);
    signal r1_sr    : std_logic_vector(15 downto 0);
    signal r1_mc    : std_logic_vector(15 downto 0);
    signal r1_ak    : std_logic_vector(15 downto 0);
    signal r2_sb    : std_logic_vector(15 downto 0);
    signal r2_sr    : std_logic_vector(15 downto 0);
    signal r2_ak    : std_logic_vector(15 downto 0);
begin
    --Round1
    
    -- SubBytes
    subbytes_blk1 : entity work.subbytes
        port map(
            state_in  => data_in,
            state_out => r1_sb       
        );

    -- ShiftRows
    shiftrows_blk1 : entity work.shiftrows
        port map(
            state_in  => r1_sb,
            state_out => r1_sr       
        );

    -- MixColumns
    mixcolumns_blk1 : entity work.mixcolumns
        port map(
            state_in  => r1_sr,
            state_out => r1_mc       
        );
    
    -- AddRoundKey
    addroundkey_blk1 : entity work.addroundkey
        port map(
            state_in  => r1_mc,
            round_key => round_key,
            state_out => r1_ak       
        );
        
    --Round2
    subbytes_blk2 : entity work.subbytes
        port map(
            state_in  => r1_ak,
            state_out => r2_sb       
        );

    -- ShiftRows
    shiftrows_blk2 : entity work.shiftrows
        port map(
            state_in  => r2_sb,
            state_out => r2_sr       
        );
        
    -- AddRoundKey
    addroundkey_blk2 : entity work.addroundkey
        port map(
            state_in  => r2_sr,
            round_key => round_key,
            state_out => r2_ak       
        );

    --Round1 output
    data_out_SB <= r1_sb;
    data_out_SR <= r1_sr;
    data_out_MC <= r1_mc;   
    data_out_AK <= r1_ak;  
    
    --Round2 output
    data_out_SB2 <= r2_sb;
    data_out_SR2 <= r2_sr;
    data_out_MC2 <= r1_mc;   
    data_out_AK2 <= r2_ak;  
    
end Behavioral;


