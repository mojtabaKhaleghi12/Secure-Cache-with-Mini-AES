----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2025 01:01:54 AM
-- Design Name: 
-- Module Name: shiftrows - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity shiftrows is
  port (
    state_in  : in  std_logic_vector(15 downto 0);
    state_out : out std_logic_vector(15 downto 0)
  );
end entity;

architecture rtl of shiftrows is
begin
  -- Row 0: no shift
  state_out(15 downto 12) <= state_in(15 downto 12); -- N0
  state_out(11 downto 8)  <= state_in(11 downto 8);  -- N1

  -- Row 1: left shift by 1
  state_out(7 downto 4)   <= state_in(3 downto 0);   -- N3
  state_out(3 downto 0)   <= state_in(7 downto 4);   -- N2
end architecture;

