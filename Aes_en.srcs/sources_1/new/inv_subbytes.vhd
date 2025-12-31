----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/21/2025 01:34:05 AM
-- Design Name: 
-- Module Name: inv_subbytes - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.aes_sbox_pkg.all;   

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity inv_subbytes is
    port (
        state_in  : in  std_logic_vector(15 downto 0);
        state_out : out std_logic_vector(15 downto 0)
    );
end entity inv_subbytes;

architecture rtl of inv_subbytes is
begin

    state_out(15 downto 12) <= inv_sbox(state_in(15 downto 12));
    state_out(11 downto 8)  <= inv_sbox(state_in(11 downto 8));
    state_out(7 downto 4)   <= inv_sbox(state_in(7 downto 4));
    state_out(3 downto 0)   <= inv_sbox(state_in(3 downto 0));

end architecture rtl;

