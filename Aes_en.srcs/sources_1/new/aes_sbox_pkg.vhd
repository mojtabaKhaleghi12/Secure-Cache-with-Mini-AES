----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2025 12:57:24 AM
-- Design Name: 
-- Module Name: aes_sbox_pkg - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



package aes_sbox_pkg is
  function sbox(in_nibble : std_logic_vector(3 downto 0))
    return std_logic_vector;

  function inv_sbox(in_nibble : std_logic_vector(3 downto 0))
    return std_logic_vector;
end package;

package body aes_sbox_pkg is

  function sbox(in_nibble : std_logic_vector(3 downto 0))
    return std_logic_vector is
    variable out_nibble : std_logic_vector(3 downto 0);
  begin
    case in_nibble is
      when "0000" => out_nibble := "1001";
      when "0001" => out_nibble := "0100";
      when "0010" => out_nibble := "1010";
      when "0011" => out_nibble := "1011";
      when "0100" => out_nibble := "1101";
      when "0101" => out_nibble := "0001";
      when "0110" => out_nibble := "1000";
      when "0111" => out_nibble := "0101";
      when "1000" => out_nibble := "0110";
      when "1001" => out_nibble := "0010";
      when "1010" => out_nibble := "0000";
      when "1011" => out_nibble := "0011";
      when "1100" => out_nibble := "1100";
      when "1101" => out_nibble := "1110";
      when "1110" => out_nibble := "1111";
      when others => out_nibble := "0111";
    end case;
    return out_nibble;
  end function;

  function inv_sbox(in_nibble : std_logic_vector(3 downto 0))
    return std_logic_vector is
    variable out_nibble : std_logic_vector(3 downto 0);
  begin
    case in_nibble is
      when "1001" => out_nibble := "0000";
      when "0100" => out_nibble := "0001";
      when "1010" => out_nibble := "0010";
      when "1011" => out_nibble := "0011";
      when "1101" => out_nibble := "0100";
      when "0001" => out_nibble := "0101";
      when "1000" => out_nibble := "0110";
      when "0101" => out_nibble := "0111";
      when "0110" => out_nibble := "1000";
      when "0010" => out_nibble := "1001";
      when "0000" => out_nibble := "1010";
      when "0011" => out_nibble := "1011";
      when "1100" => out_nibble := "1100";
      when "1110" => out_nibble := "1101";
      when "1111" => out_nibble := "1110";
      when others => out_nibble := "0111";
    end case;
    return out_nibble;
  end function;

end package body;

