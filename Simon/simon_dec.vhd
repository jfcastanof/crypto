--------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity simon_dec is
    port (
        key : in  std_logic_vector(31 downto 0);
        xy  : in  std_logic_vector(63 downto 0);
        yx  : out std_logic_vector(63 downto 0)
    );
end entity;

architecture rtl of simon_dec is
    function rotl(value: std_logic_vector(31 downto 0); places: integer) return std_logic_vector is
    begin
        return value(31-places downto 0) & value(31 downto 31-(places-1));
    end function rotl;
begin
    decrypt_process : process (key, xy) is
    begin
        yx(31 downto 0)  <= xy(63 downto 32);
        yx(63 downto 32) <= xy(31 downto 0) xor (rotl(xy(63 downto 32), 1) and rotl(xy(63 downto 32), 8)) xor rotl(xy(63 downto 32), 2) xor key;
    end process decrypt_process;
end architecture rtl;

