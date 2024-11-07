library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity present is
    port (
        key             : in  std_logic_vector(79 downto 0);
        plaintext_in    : in  std_logic_vector(63 downto 0);
        ciphertext_in   : in  std_logic_vector(63 downto 0);
        ciphertext_out  : out std_logic_vector(63 downto 0);
        plaintext_out    : out std_logic_vector(63 downto 0)
    );
end entity present;

architecture rtl of present is
    type key_array is array (0 to 31) of std_logic_vector(79 downto 0);
    type ct_array is array (0 to 31) of std_logic_vector(63 downto 0);

    signal keys   : key_array;
    signal cts_enc : ct_array;
    signal cts_dec : ct_array;

begin
    -- Generación de claves
    key_generate : for i in 0 to 30 generate
        key0 : present_key
            generic map (
                round_ctr => i + 1
            )
            port map (
                keyi => keys(i),
                keyo => keys(i + 1)
            );
    end generate;
-------------------------------------------------------------------------------------------------------------
        keys(0) <= key;
        cts_enc(0) <= plaintext_in; -- Asignación de entrada
-----------------------------------------------------------------------------------------
	-- Proceso de cifrado
    enc_generate : for i in 0 to 30 generate
        enc0 : present_enc
            port map (
                key   => keys(i),
                datai => cts_enc(i),
                datao => cts_enc(i + 1)
            );
    end generate;

   
------------------------------------------------------------------------------------------------------
    -- Inicializa el primer valor de cts_dec

        cts_dec(31) <= ciphertext_in; -- Inicialización
----------------------------------------------------------------------------------------------
	 	 -- Proceso de descifrado
    dec_generate : for i in 31 downto 1 generate
       dec0 : present_dec
            port map (
                key   => keys(i),
                datai => cts_dec(i),
                datao => cts_dec(i-1)
            );
    end generate;  
	 
	 -- Proceso de descifrado

----------------------------------------------------------------------------------------
    -- Salida del cifrado
    ciphertext_out <= cts_enc(31) xor keys(31)(79 downto 16);

    -- Salida del descifrado
    plaintext_out <= cts_dec(0) xor keys(0)(79 downto 16);

end architecture rtl;
