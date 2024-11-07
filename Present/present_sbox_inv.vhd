library ieee;
use ieee.std_logic_1164.all;
use work.constants.all;

entity present_sbox_inv is
    port (
        datai : in  std_logic_vector(3 downto 0);
        datao : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of present_sbox_inv is
begin
    lookup_process : process (datai) is
    begin
        lookup_case : case datai is
            when x"C"   => datao <= x"0";
            when x"5"   => datao <= x"1";
            when x"6"   => datao <= x"2";
            when x"B"   => datao <= x"3";
            when x"9"   => datao <= x"4";
            when x"0"   => datao <= x"5";
            when x"A"   => datao <= x"6";
            when x"D"   => datao <= x"7";
            when x"3"   => datao <= x"8";
            when x"E"   => datao <= x"9";
            when x"F"   => datao <= x"A";
            when x"8"   => datao <= x"B";
            when x"4"   => datao <= x"C";
            when x"7"   => datao <= x"D";
            when x"1"   => datao <= x"E";
            when x"2"   => datao <= x"F";

            when others => datao <= (others => 'X');
        end case lookup_case;
    end process lookup_process;
end architecture rtl;
