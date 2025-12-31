----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2025 01:17:20 AM
-- Design Name: 
-- Module Name: inv_mixcolumns - Behavioral
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


entity inv_mixcolumns is
    port (
        state_in  : in  std_logic_vector(15 downto 0);
        state_out : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of inv_mixcolumns is

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

    function mul3(a : std_logic_vector(3 downto 0)) return std_logic_vector is
    begin
        return mul2(a) xor a;
    end function;

    function mulE(a : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable r : std_logic_vector(3 downto 0);
    begin
        r := mul2(mul2(mul2(a))) xor mul2(mul2(a)) xor mul2(a);
        return r;
    end function;

    signal y0, y1, y2, y3 : std_logic_vector(3 downto 0);
    signal s0, s1, s2, s3 : std_logic_vector(3 downto 0);

begin

    y0 <= state_in(15 downto 12);
    y1 <= state_in(11 downto 8);
    y2 <= state_in(7 downto 4);
    y3 <= state_in(3 downto 0);

    -- column 0
    s2 <= mulE(y0 xor y2);
    s0 <= y0 xor s2;

    -- column 1
    s3 <= mulE(y1 xor y3);
    s1 <= y1 xor s3;

    state_out <= s0 & s1 & s2 & s3;

end architecture;
