library ieee;
use ieee.std_logic_1164.all;

entity tb_Aes_decoder is
end tb_Aes_decoder;

architecture sim of tb_Aes_decoder is

    signal data_in  : std_logic_vector(15 downto 0);
    signal round_key : std_logic_vector(15 downto 0);
    signal data_out : std_logic_vector(15 downto 0);
    
    signal data_out_iSB : std_logic_vector(15 downto 0);
    signal data_out_iSR : std_logic_vector(15 downto 0);
    signal data_out_iMC : std_logic_vector(15 downto 0);
    signal data_out_AK : std_logic_vector(15 downto 0);
    signal data_out_iSB2 : std_logic_vector(15 downto 0);
    signal data_out_iSR2 : std_logic_vector(15 downto 0);
    signal data_out_iMC2 : std_logic_vector(15 downto 0);
    signal data_out_AK2 : std_logic_vector(15 downto 0);

begin


    uut : entity work.Aes_decoder
        port map (
            data_in   => data_in,
            round_key => round_key,
            data_out  => data_out,
            data_out_iSB => data_out_iSB,
            data_out_iSR => data_out_iSR,
            data_out_iMC => data_out_iMC,
            data_out_AK => data_out_AK,
            data_out_iSB2 => data_out_iSB2,
            data_out_iSR2 => data_out_iSR2,
            data_out_iMC2 => data_out_iMC2,
            data_out_AK2 => data_out_AK2
        );


    stim_proc : process
    begin
        data_in   <= x"19A0";  
        round_key <= "0000000000001010"; 

        wait for 20 ns;



        wait;
    end process;

end architecture;
