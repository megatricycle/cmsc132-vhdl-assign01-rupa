library IEEE; use IEEE.std_logic_1164.all;

entity alarm is
    -- declare ports
    port(
        input: in std_logic_vector(5 downto 0);
        output: out std_logic
    );
end entity alarm;

architecture alarm_arch of alarm is
begin
    process (input(5), input(4), input(3), input(2), input(1), input(0)) is
    begin
        if(((input(5) = '1') or (input(4) = '1') or (input(3) = '1')) and ((input(2) = '1') or (input(1) = '1') or (input(0) = '1'))) then
            output <= '1';
        else
            output <= '0';
        end if;
    end process;
end architecture alarm_arch;
