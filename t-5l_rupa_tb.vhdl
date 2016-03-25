library IEEE; use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alarm_tb is
    -- constants
    constant DELAY: time := 10 ns;
end entity alarm_tb;

architecture tb of alarm_tb is
    signal input: std_logic_vector(5 downto 0);
    signal output: std_logic;

    component alarm is
        -- ports
        port(
            input: in std_logic_vector(5 downto 0);
            output: out std_logic
        );

    end component alarm;

begin
    UUT: component alarm port map(input, output);

    main: process is
        variable temp: unsigned(5 downto 0);
        variable expected_output: std_logic;
        variable error_count: integer := 0;

    begin
        report "Start simulation.";

        for count in 0 to 63 loop
            temp := TO_UNSIGNED(count, 6);
            -- set input values from temp
            input(5) <= std_logic(temp(5));
            input(4) <= std_logic(temp(4));
            input(3) <= std_logic(temp(3));
            input(2) <= std_logic(temp(2));
            input(1) <= std_logic(temp(1));
            input(0) <= std_logic(temp(0));

            if(count <= 8 or count mod 8 = 0) then
                expected_output := '0';
            else
                expected_output := '1';
            end if;

            wait for DELAY;

            -- assert the test case
            assert(expected_output = output)
                report "ERROR: Expected output " & std_logic'image(expected_output) & " at time " & time'image(now);

            -- increment error_count on error
            if(expected_output /= output) then
                error_count := error_count + 1;
            end if;
        end loop;

        wait for DELAY;

        -- display errors if any
        assert(error_count = 0)
            report "ERROR: There were " & integer'image(error_count) & " errors!";

        -- display no errors if none
        if(error_count = 0) then
            report "Simulation completed with NO errors.";
        end if;

        wait;
    end process;
end architecture tb;
