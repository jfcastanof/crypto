library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package constants is
    type key_array is array(31 downto 0) of std_logic_vector(79 downto 0);
    type ct_array is array(31 downto 0) of std_logic_vector(63 downto 0);


component present_key is
        generic (
            round_ctr : integer
        );
        port (
            keyi : in  std_logic_vector(79 downto 0);
            keyo : out std_logic_vector(79 downto 0)
        );
end component present_key;

component present_enc is
       port (
            key   : in  std_logic_vector(79 downto 0);
            datai : in  std_logic_vector(63 downto 0);

            datao : out std_logic_vector(63 downto 0)
        );
end component present_enc;

component present_dec is
       port (
            key   : in  std_logic_vector(79 downto 0);
            datai : in  std_logic_vector(63 downto 0);

            datao : out std_logic_vector(63 downto 0)
        );
end component present_dec;

end package constants;

