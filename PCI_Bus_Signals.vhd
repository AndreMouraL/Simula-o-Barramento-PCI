library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PCI_Bus_Signals is
    Port (
        clock : in std_logic;  -- Clock do sistema
        reset : in std_logic;  -- Sinal de reset
        -- Sinais de barramento
        req_signal : out std_logic;
        gnt_signal : out std_logic;
        frame_signal : out std_logic;
        ad_signal : out std_logic;
        irdy_signal : out std_logic;
        trdy_signal : out std_logic
    );
end PCI_Bus_Signals;

architecture Behavioral of PCI_Bus_Signals is
    constant PERIODO_CLOCK : time := 8 ns;  -- Período do clock em nanosegundos
    constant NUM_CICLOS : integer := 75;   -- Número de ciclos do clock

    signal clock_internal : std_logic := '0';  -- Sinal de clock interno

    -- Vetores de transições dos sinais
    type transition_array is array(1 to NUM_CICLOS) of integer;
    constant TRANSICOES_REQ : transition_array := (10, 20, 50);
    constant TRANSICOES_GNT : transition_array := (30, 40);
    constant TRANSICOES_FRAME : transition_array := (15, 35, 55);
    constant TRANSICOES_AD : transition_array := (20, 45, 70);
    constant TRANSICOES_IRDY : transition_array := (25, 60);
    constant TRANSICOES_TRDY : transition_array := (35, 65);

    signal req_signal_internal : std_logic := '0';   -- Sinal de requisição
    signal gnt_signal_internal : std_logic := '0';   -- Sinal de concessão
    signal frame_signal_internal : std_logic := '0'; -- Sinal de quadro
    signal ad_signal_internal : std_logic := '0';    -- Sinal de endereço/dados
    signal irdy_signal_internal : std_logic := '0';  -- Sinal de iniciador pronto
    signal trdy_signal_internal : std_logic := '0';  -- Sinal de alvo pronto

begin
    -- Processo para gerar sinais baseados no clock
    process (clock)
        variable contador : integer range 0 to NUM_CICLOS * 2 := 0;
    begin
        if rising_edge(clock) then
            contador := contador + 1;
            
            -- Lógica para gerar sinais com base nos vetores de transições
            req_signal_internal <= req_signal_internal;
            gnt_signal_internal <= gnt_signal_internal;
            frame_signal_internal <= frame_signal_internal;
            ad_signal_internal <= ad_signal_internal;
            irdy_signal_internal <= irdy_signal_internal;
            trdy_signal_internal <= trdy_signal_internal;

            if contador = 2 * NUM_CICLOS then
                contador := 0;
            end if;
        end if;
    end process;

    -- Saídas dos sinais
    req_signal <= req_signal_internal;
    gnt_signal <= gnt_signal_internal;
    frame_signal <= frame_signal_internal;
    ad_signal <= ad_signal_internal;
    irdy_signal <= irdy_signal_internal;
    trdy_signal <= trdy_signal_internal;

end Behavioral;
