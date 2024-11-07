library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity present_tb is
end entity;

architecture test of present_tb is
    signal   r_key        : std_logic_vector(79 downto 0);
    signal   r_plaintext_in  : std_logic_vector(63 downto 0);
    signal   r_plaintext_out  : std_logic_vector(63 downto 0);
    signal   r_ciphertext_in : std_logic_vector(63 downto 0);
    signal   r_ciphertext_out: std_logic_vector(63 downto 0);
	 
    component present is
    port (
        key            : in  std_logic_vector(79 downto 0);
        plaintext_in   : in  std_logic_vector(63 downto 0);
        ciphertext_in  : in  std_logic_vector(63 downto 0);
        plaintext_out  : out std_logic_vector(63 downto 0);
        ciphertext_out : out std_logic_vector(63 downto 0)
    );
end component;

begin
    dut : present
        port map (
            key        => r_key,
            plaintext_in  => r_plaintext_in,
				plaintext_out  => r_plaintext_out,
            ciphertext_in => r_ciphertext_in,
				ciphertext_out => r_ciphertext_out
        );

    process
    begin
	 --5579c1387b228445
        r_key       <= x"00000000000000000000";
        r_plaintext_in <= x"0000000000000000";
        r_ciphertext_in <= x"5579c1387b228445";
        wait;
    end process;
end architecture;
