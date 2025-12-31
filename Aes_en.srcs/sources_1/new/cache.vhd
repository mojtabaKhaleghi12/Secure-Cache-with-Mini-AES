library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SecureCache is
    Port(
        clk      : in  std_logic;
        rst      : in  std_logic;

        addr     : in  std_logic_vector(7 downto 0);
        data_in  : in  std_logic_vector(15 downto 0);
        read_en  : in  std_logic;
        write_en : in  std_logic;

        data_out : out std_logic_vector(15 downto 0);
        hit      : out std_logic;
        miss      : out std_logic;

        -- Debug outputs
        enc_out_dbg : out std_logic_vector(15 downto 0);
        dec_out_dbg : out std_logic_vector(15 downto 0);
        round_key : in std_logic_vector(15 downto 0);  
        
        tag_dbg     : out std_logic_vector(3 downto 0);
        valid_dbg   : out std_logic
    );
end SecureCache;

architecture Behavioral of SecureCache is

    type cache_line is record
        valid : std_logic;
        tag   : std_logic_vector(3 downto 0);
        data  : std_logic_vector(15 downto 0);
    end record;

    type cache_array is array(15 downto 0) of cache_line;
    signal cache : cache_array;

    signal index  : integer range 0 to 15;
    signal tag_in : std_logic_vector(3 downto 0);

    signal enc_out : std_logic_vector(15 downto 0);
    signal dec_out : std_logic_vector(15 downto 0);

    signal selected_cache_data : std_logic_vector(15 downto 0);
    signal enc_out_reg : std_logic_vector(15 downto 0);


   -- constant KEY : std_logic_vector(15 downto 0) := x"000A";

begin

    index  <= to_integer(unsigned(addr(3 downto 0)));
    tag_in <= addr(7 downto 4);


    -- AES encoder instance
    AES_ENC : entity work.Aes_encoder
        port map(
            data_in      => data_in,
            round_key    =>  round_key,
            data_out_SB  => open,
            data_out_SR  => open,
            data_out_MC  => open,
            data_out_AK  => open,
            data_out_SB2 => open,
            data_out_SR2 => open,
            data_out_MC2 => open,
            data_out_AK2 => enc_out
        );

    -- AES decoder instance
    AES_DEC : entity work.Aes_decoder
        port map(
            data_in       => selected_cache_data,
            round_key     =>  round_key,
            data_out      => dec_out,
            data_out_iSB  => open,
            data_out_iSR  => open,
            data_out_iMC  => open,
            data_out_AK   => open,
            data_out_iSB2 => open,
            data_out_iSR2 => open,
            data_out_iMC2 => open,
            data_out_AK2  => open
        );

    selected_cache_data <= cache(index).data;

    -- Expose debug signals
    enc_out_reg <= enc_out_reg;
    dec_out_dbg <= dec_out;
    tag_dbg     <= cache(index).tag;
    valid_dbg   <= cache(index).valid;

    -- Cache process
    process(clk,rst)
    begin
        if rst = '1' then
            for i in 0 to 15 loop
                cache(i).valid <= '0';
                cache(i).tag   <= (others => '0');
                cache(i).data  <= (others => '0');
                
            end loop;

            hit <= '0';
            miss <= '0';
            data_out <= (others => '0');
            enc_out_reg <= (others => '0');

        elsif rising_edge(clk) then

            -- READ operation
            if read_en = '1' then
                if cache(index).valid = '1' and cache(index).tag = tag_in then
                    hit <= '1';
                    miss <= '0';
                    data_out <= dec_out;
                else
                    hit <= '0';
                    miss <= '1';
                    data_out <= (others => '0');
                end if;
            end if;

            -- WRITE operation
            if write_en = '1' then
                enc_out_reg <= enc_out; 
                cache(index).valid <= '1';
                cache(index).tag   <= tag_in;
                cache(index).data  <= enc_out;
                
            end if;

        end if;
        
    end process;
    enc_out_dbg <= enc_out;

end Behavioral;
