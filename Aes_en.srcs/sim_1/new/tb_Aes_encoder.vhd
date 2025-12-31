----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2025 08:30:08 AM
-- Design Name: 
-- Module Name: tb_Aes_encoder - Behavioral
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


entity tb_Aes_encoder is
end tb_Aes_encoder;

architecture sim of tb_Aes_encoder is

    signal data_in     : std_logic_vector(15 downto 0);
    signal round_key   : std_logic_vector(15 downto 0);

    signal data_out_SB : std_logic_vector(15 downto 0);
    signal data_out_SR : std_logic_vector(15 downto 0);
    signal data_out_MC : std_logic_vector(15 downto 0);
    signal data_out_AK : std_logic_vector(15 downto 0);
    signal data_out_SB2 : std_logic_vector(15 downto 0);
    signal data_out_SR2 : std_logic_vector(15 downto 0);
    signal data_out_MC2 : std_logic_vector(15 downto 0);
    signal data_out_AK2 : std_logic_vector(15 downto 0);

begin


    uut : entity work.Aes_encoder
        port map (
            data_in     => data_in,
            round_key   => round_key,
            data_out_SB => data_out_SB,
            data_out_SR => data_out_SR,
            data_out_MC => data_out_MC,
            data_out_AK => data_out_AK,
            data_out_SB2 => data_out_SB2,
            data_out_SR2 => data_out_SR2,
            data_out_MC2 => data_out_MC2,
            data_out_AK2 => data_out_AK2
        );


    stim_proc : process
    begin
    
        data_in   <= "0000000000001100"; 
        round_key <= "0000000000001010"; 

        wait for 20 ns;


        wait;
    end process;

end architecture;


