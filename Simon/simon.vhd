library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity simon is
    port (
        key        : in  std_logic_vector(127 downto 0);
        plaintext_in  : in  std_logic_vector(63 downto 0);
		  plaintext_out  : out  std_logic_vector(63 downto 0);
		  ciphertext_in : in std_logic_vector(63 downto 0);
        ciphertext_out : out std_logic_vector(63 downto 0)
    );
end entity;

architecture rtl of simon is
    signal keys: key_array;
    signal cts  : ct_array; 
	 signal dts  : ct_array;
	 signal plaintext_out_temp : std_logic_vector(63 downto 0);
---------------------------------------------------------declaración de componentes	 
    component simon_key is
        generic (
            round_ctr     :  integer
        );
        port (
            k_0, k_1, k_3 : in  std_logic_vector(31 downto 0);
            key           : out std_logic_vector(31 downto 0)
        );
    end component simon_key;

    component simon_enc is
        port (
            key : in  std_logic_vector(31 downto 0);
            xy  : in  std_logic_vector(63 downto 0);

            yx  : out std_logic_vector(63 downto 0)
        );
    end component simon_enc;
	 
	 component simon_dec is
        port (
            key : in  std_logic_vector(31 downto 0);
            xy  : in  std_logic_vector(63 downto 0);

            yx  : out std_logic_vector(63 downto 0)
        );
    end component simon_dec;
-----------------------------------------------------------------	 
	 
begin

        keys(0) <= key(31 downto 0);--generación de las 4 primeras subclaves de ronda
        keys(1) <= key(63 downto 32);
        keys(2) <= key(95 downto 64);
        keys(3) <= key(127 downto 96);
---------------------------------------------------------------------------		  
		  
    enc_generate : for i in 0 to 43 generate--genera las 44 rondas de cifrado
        enc0 : simon_enc
            port map (
                xy  => cts(i),
                key => keys(i),
                
                yx  => cts(i+1)
            );
    end generate;
	 
------------------------------
 dec_generate : for i in 44 downto 1 generate--genera las 44 rondas de descifrado
        dec0 : simon_dec
            port map (
                xy  => dts(i),
                key => keys(i-1),
                
                yx  => dts(i-1)
            );
    end generate; 
-------------------------------------------------------

    key_generate : for i in 4 to 43 generate--genera las claves de ronda
        key0 : simon_key
            generic map (
                round_ctr => i-4
            )
            port map (
                k_0       => keys(i-4),
                k_1       => keys(i-3),
                k_3       => keys(i-1),

                key       => keys(i)
            );
    end generate;

 ------------------------------------------------------------------------  
	 enc_process : process(plaintext_in) is--proceso de cifrado
    begin	 
        cts(0)  <= plaintext_in;	  
    end process enc_process;

    ciphertext_out <= cts(44);
---------------------------------------------------------------------------	 
 dec_process : process(ciphertext_in) is--proceso de descifrado
    begin	 
        dts(44)  <= ciphertext_in(31 downto 0) & ciphertext_in(63 downto 32);	  
    end process dec_process;
	 
	 plaintext_out_temp <= dts(0); 
	 plaintext_out(63 downto 32) <= plaintext_out_temp(31 downto 0);
	 plaintext_out(31 downto 0) <= plaintext_out_temp(63 downto 32);
---------------------------	 
	 
end architecture rtl;
