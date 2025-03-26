
-- 1. HEX5 (Segmentos do digito 5 do display de 7 segmentos), LEDR(Conjunto de 10 LEDS), SW(10 Slides Switches), KEY(4 Push-buttons)
-- 2. Foi declarada dessa forma pois a ordem de 0 a 6 segue a ordem de disposicao dos 7 segmentos do display como indicado no manual. Caso contrario, 
--ao chamar o segmento 0, na verdade estariamos utilizando o 6 e assim por diante.
-- 3. Os valores atribuidos significam os numeros que aparecerao no display
-- 4. As saidas LEDRs dependem diretamente das entradas SW, ou seja os leds serao acesos de acordo com os SW correspondentes. As 
--saidas HEX5 irao representar os segmentos que estarao acesos a depender dos bits de KEY.
-- 5. Apos o begin, LEDR <= SW; indica a correlacao entre switchs e leds, ja que ambos tem 10 bits. Por exemplo, todos os bits altos de SW ativam todos os leds. 
-- Para cada combinaçao de 4 bits de KEY, o display representara um numero em hexadecimal de 0 a 15. No caso do when others, ele apaga o display.


library ieee;
use ieee.std_logic_1164.all;

entity hexcode is
port (
  LEDR: out std_logic_vector(9 downto 0);
  SW: in std_logic_vector(9 downto 0);
  HEX5: out std_logic_vector(0 to 6);
  KEY: in std_logic_vector(3 downto 0)
  );
end entity hexcode;

architecture bhv of hexcode is
begin

  LEDR <= SW;
  
  with KEY select
  HEX5 <= "0000001" when "0000",
      "1001111" when "0001",
      "0010010" when "0010",
      "0000110" when "0011",
      "1001100" when "0100",
      "0100100" when "0101",
      "0100000" when "0110",
      "0001111" when "0111",
      "0000000" when "1000",
      "0000100" when "1001",
      "0001000" when "1010",
      "1100000" when "1011",
      "0110001" when "1100",
      "1000010" when "1101",
      "0110000" when "1110",
      "0111000" when "1111",
      "1111111" when others;

end architecture bhv;