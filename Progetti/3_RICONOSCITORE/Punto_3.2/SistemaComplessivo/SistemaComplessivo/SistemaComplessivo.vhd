


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SistemaComplessivo is
  Port ( 
        Clk: in std_logic;
        Rst: in std_logic;
        Btn_Ingresso: in std_logic;
        Ingresso: in std_logic;
        Modo: in std_logic;
        Btn_Modo: in std_logic;
        Uscita: out std_logic
    );
end SistemaComplessivo;

architecture Structural of SistemaComplessivo is
    
    signal Btn_Modo_cl: std_logic;
    signal Btn_Ingresso_cl: std_logic;
    
    component ButtonDebouncer is
        generic (                       
            CLK_period:   integer := 10;  -- periodo del clock della board 10 nanosecondi
            btn_noise_time:   integer := 6500000 --intervallo di tempo in cui si ha l'oscillazione del bottone
        );
        Port ( 
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            BTN : in STD_LOGIC;
            CLEARED_BTN : out STD_LOGIC
        );
    end  component;

    component Riconoscitore
        Port ( 
            Clock : in std_logic;
            Reset : in std_logic;
            Btn_InDato: in std_logic;
            InDato : in std_logic;
            Btn_Modo: in std_logic;
            Modo : in std_logic;
            Y: out std_logic
        );
    end component;
    
    begin
    ModoClear: ButtonDebouncer
        generic map (
                CLK_period => 10,
                btn_noise_time => 550000000
        )
        Port map (
                RST => Rst,
                CLK => Clk,
                BTN => Btn_Modo,
                CLEARED_BTN => Btn_Modo_cl
        );
        IngressoClear: ButtonDebouncer
            generic map (
                    CLK_period => 10,
                    btn_noise_time => 550000000
            )
            Port map (
                    RST => Rst,
                    CLK => Clk,
                    BTN => Btn_Ingresso,
                    CLEARED_BTN => Btn_Ingresso_cl
            );
            RiconoscitoreSeq: Riconoscitore
                port map(
                    Clock => Clk,
                    Reset => Rst,
                    InDato => Ingresso,
                    Btn_InDato => Btn_Ingresso_cl,
                    Modo => Modo,
                    Btn_Modo => Btn_Modo_cl,
                    Y => Uscita
                );

end Structural;
