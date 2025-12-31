library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SecureCache_tb is
end SecureCache_tb;

architecture tb of SecureCache_tb is

    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';

    signal addr     : std_logic_vector(7 downto 0);
    signal data_in  : std_logic_vector(15 downto 0);
    signal read_en  : std_logic := '0';
    signal write_en : std_logic := '0';

    signal data_out     : std_logic_vector(15 downto 0);
    signal hit          : std_logic;
    signal miss          : std_logic;

    -- Debug signals
    signal enc_out_dbg  : std_logic_vector(15 downto 0);
    signal dec_out_dbg  : std_logic_vector(15 downto 0);
    signal round_key : std_logic_vector(15 downto 0);

    signal tag_dbg      : std_logic_vector(3 downto 0);
    signal valid_dbg    : std_logic;

begin

    -- Instantiate SecureCache
    DUT: entity work.SecureCache
        port map(
            clk         => clk,
            rst         => rst,
            addr        => addr,
            data_in     => data_in,
            read_en     => read_en,
            write_en    => write_en,
            data_out    => data_out,
            hit         => hit,
            miss         => miss,
            enc_out_dbg => enc_out_dbg,
            dec_out_dbg => dec_out_dbg,
            round_key => round_key,
            tag_dbg     => tag_dbg,
            valid_dbg   => valid_dbg
        );

    -- Clock generation
    clk_process : process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        round_key <= (others => '0');  
        wait for 1 ns;
        wait until rising_edge(clk);
        -- Print header

        addr     <= x"12";
        data_in <= "0000000000001100";

        round_key <= x"000A";
        write_en <= '1';
    
        wait until rising_edge(clk);

        -- Read 0x12
        write_en <= '0';
        wait until rising_edge(clk);
        addr    <= x"12";
        read_en <= '1';
    
        wait until rising_edge(clk);
    
        read_en <= '0';
        wait for 20 ns;
        


        wait;
    end process;

   

end tb;
