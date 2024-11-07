library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;


entity present_dec is
    port (
        key   : in  std_logic_vector(79 downto 0);
        datai : in  std_logic_vector(63 downto 0);
        datao : out std_logic_vector(63 downto 0)
    );
end entity;

architecture rtl of present_dec is
    signal pboxi : std_logic_vector(63 downto 0);
    signal pboxo : std_logic_vector(63 downto 0);
    signal sboxi : std_logic_vector(63 downto 0);
	 
    component present_sbox_inv
        port (
            datai : in  std_logic_vector(3 downto 0);
            datao : out std_logic_vector(3 downto 0)
        );
    end component present_sbox_inv;

    component present_p_inv
        port (
            datai : in  std_logic_vector(63 downto 0);
            datao : out std_logic_vector(63 downto 0)
        );
    end component present_p_inv;

begin
    

 ----------------------------------------------------------------- 
	 pboxi <= datai xor key(79 downto 16);--addroundkey
-------------------------------------------------------	 
    -- Aplicar P-Layer inversa --Pbox
    p0 : present_p_inv
        port map (
            datai => pboxi,
            datao => sboxi
        );
--------------------------------------------------------
-- Generación de S-Box inversa
    sbox_generate : for i in 0 to 15 generate
        sbox0 : present_sbox_inv
            port map (
                datai => sboxi(4*i+3 downto 4*i),
                datao => datao(4*i+3 downto 4*i)
            );
    end generate;

end architecture rtl;
