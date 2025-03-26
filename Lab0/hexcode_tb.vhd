-- 1. Por se tratar de um test bench, a entidade hexcode_tb apenas gera sinais automaticos para testar o funcionamento do circuito hexcode original.
-- 2. A instanciacao eh feita a partir do comando uut que busca a entidade hexcode que sera testada. Nao eh necessario utilizar pacotes pois hexcode ja 
-- 	esta na mesma biblioteca "work", onde ele foi compilado.
-- 3. A incricao uut significa "Unit Under Test" e serve para que indicar a unidade que sera indiciada e testada.
-- 4. Work eh uma biblioteca que consegue acessar outras entidades criadas pelo usuario mesmo que localizados em arquivos diferentes
-- 5. O pacote "std_logic_unsigned" permite tratar os vetores (sequencia de bits) como numeros naturais e o pacote "numeric_std" permite realizar operacoes
--    aritmeticas.
-- 6. range: permite referenciar o intervalo total de indices do vetor de bits. Usado pois queremos checar quando todos os bits de sw e keys sao 1.
--    length: retorna o numero de elementos do vetor. Usado pois queremos garantir que o vetor resultante tenha o mesmo numero de bits de sw original. 
--    event: serve para indicar se houve transicao no sinal. Usado para detectar a borda de subida do clock, ou seja, quando passar de 0 para 1.
-- 7. O comando "(others=>'0')" dado para sw e keys, indica que todos os switches comecam desligados e todos os botoes pressionados,
--    ou seja, todos com valor inicial 0.
-- 8. as saídas esperadas para o testes se dao a partir dos valores de SW e KEY
-- 	ambos começam com valores iniciais 0 e são incrementados pelo clock em cada ciclo, mudando assim as saídas dos LEDRs e do display.
-- 	Assim, com o test bench é esperado que as saídas LEDS e HEX5 sejam correspondentes aos valores de entrada dados pela entidade hexcode 

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity hexcode_tb is
end entity hexcode_tb;

architecture tb of hexcode_tb is
  signal leds: std_logic_vector(9 downto 0);
  signal sw: std_logic_vector(9 downto 0) := (others => '0');
  signal hex: std_logic_vector(0 to 6);
  signal keys: std_logic_vector(3 downto 0) := (others => '0');
  
  signal clock: std_logic := '0';
  signal stop: std_logic;
begin

  uut: entity work.hexcode port map(LEDR => leds, SW => sw, HEX5 => hex, KEY => keys);
  
  clock <= not clock after 5 ns when stop = '0' else '0';
  stop <= '1' when sw = (sw'range => '1') and keys = (keys'range => '1') else '0';
  
  process(clock)
  begin
    if clock'event and clock = '1' and stop = '0' then
      sw <= std_logic_vector(to_unsigned(to_integer(unsigned(sw)) + 1, sw'length));
      keys <= std_logic_vector(to_unsigned(to_integer(unsigned(keys)) + 1, keys'length));
    end if;
  end process;
end architecture tb;
