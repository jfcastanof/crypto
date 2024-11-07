library ieee;
use ieee.std_logic_1164.all;

entity simon_tb is
end entity;

architecture test of simon_tb is
    signal   r_key        : std_logic_vector(127 downto 0);
    signal   r_plaintext_in,r_plaintext_out  : std_logic_vector(63 downto 0);

    signal   r_ciphertext_in,r_ciphertext_out : std_logic_vector(63 downto 0);

    component simon is
        port (
        key        : in  std_logic_vector(127 downto 0);
        plaintext_in  : in  std_logic_vector(63 downto 0);
		  plaintext_out  : out  std_logic_vector(63 downto 0);
		  ciphertext_in : in std_logic_vector(63 downto 0);
        ciphertext_out : out std_logic_vector(63 downto 0)
    );
    end component simon;
begin
    dut : simon
        port map (
            key        => r_key,
            plaintext_in  => r_plaintext_in,
				plaintext_out => r_plaintext_out,
				ciphertext_in => r_ciphertext_in,
            ciphertext_out => r_ciphertext_out
        );

    process
    begin
	 
        r_key       <= x"1b1a1918131211100b0a090803020100";
        r_plaintext_in <= x"656b696c20646e75";
		  r_ciphertext_in <= x"44c8fc20b9dfa07a";
		  
		  wait 10 ns
		   
			r_key       <= x"1b1a1918131211100b0a090803020100";
        r_plaintext_in <= x"656b696c20646e75";
		  r_ciphertext_in <= x"44c8fc20b9dfa07a";
		  
		  
				  
        wait;
    end process;
end architecture;
