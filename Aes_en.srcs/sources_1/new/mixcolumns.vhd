----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2025 01:07:20 AM
-- Design Name: 
-- Module Name: mixcolumns - Behavioral
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

entity mixcolumns is
  port (
    state_in  : in  std_logic_vector(15 downto 0);
    state_out : out std_logic_vector(15 downto 0)
  );
end entity;

architecture rtl of mixcolumns is

    function mul2(a : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable res : std_logic_vector(3 downto 0);
    begin
        if a(3) = '0' then
            res := a(2 downto 0) & '0';
        else
            res := (a(2 downto 0) & '0') xor "0011";
        end if;
        return res;
    end function;

    signal s0, s1, s2, s3 : std_logic_vector(3 downto 0);
    signal t0, t1, t2, t3 : std_logic_vector(3 downto 0);

begin

    s0 <= state_in(15 downto 12);
    s1 <= state_in(11 downto 8);
    s2 <= state_in(7 downto 4);
    s3 <= state_in(3 downto 0);

    -- column 0
    t0 <= s0 xor s2;
    t2 <= s0 xor mul2(s2);

    -- column 1
    t1 <= s1 xor s3;
    t3 <= s1 xor mul2(s3);

    state_out <= t0 & t1 & t2 & t3;

end architecture;
