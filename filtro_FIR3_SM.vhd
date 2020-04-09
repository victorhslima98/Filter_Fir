LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY somador16bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
s : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END somador16bits;

ARCHITECTURE dataflow OF somador16bits IS

BEGIN 

s <= a + b;

END dataflow;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY mult8bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
       s : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END mult8bits;

ARCHITECTURE dataflow1 OF mult8bits IS

BEGIN 

s <= a * b;

END dataflow1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg16b IS
PORT ( clk : IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END reg16b;

ARCHITECTURE comportamento OF reg16b IS
BEGIN
PROCESS (clk)
BEGIN
IF clk'EVENT AND clk = '1' THEN
Q <= D;
END IF;
END PROCESS;
END comportamento;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux8para3 IS
PORT ( sel: IN STD_LOGIC_VECTOR (2 downto 0);
       a, b, c, d, e, f, g, h : IN STD_LOGIC_VECTOR (7 downto 0);
       Y : OUT STD_LOGIC_VECTOR (7 downto 0)
       );
END mux8para3;

ARCHITECTURE dataflow OF mux8para3 IS
BEGIN
PROCESS (sel) -- lista de sensibilização
BEGIN
CASE sel IS
WHEN "000" => Y <= a;
WHEN "001" => Y <= b;
WHEN "010" => Y <= c;
WHEN "011" => Y <= d;
WHEN "100" => Y <= e;
WHEN "101" => Y <= f;
WHEN "110" => Y <= g;
WHEN OTHERS => Y <= h;
END CASE;
END PROCESS;
END dataflow;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY regdesl8b IS
PORT ( clk, ld : IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
Q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END regdesl8b;

ARCHITECTURE comportamento OF regdesl8b IS
BEGIN
PROCESS (ld, clk)
BEGIN

IF clk'EVENT AND clk = '1' THEN

  IF ld = '1' THEN

Q <= D;

 END IF;

END IF;

END PROCESS;

END comportamento;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY rom IS
GENERIC ( bits: INTEGER := 8; -- # of bits per word
          words: INTEGER := 8); -- # of words in the memory
PORT ( addr: IN INTEGER RANGE 0 TO words-1;
       data: OUT STD_LOGIC_VECTOR (bits-1 DOWNTO 0));
END rom;

ARCHITECTURE rom OF rom IS
 TYPE vector_array IS ARRAY (0 TO words-1) OF
 STD_LOGIC_VECTOR (bits-1 DOWNTO 0);
CONSTANT memory: vector_array := (  "00000001",
									"00000010",
									"00000100",
									"00001000",
									"00010000",
									"00100000",
									"01000000",
									"10000000");
BEGIN
  data <= memory(addr);

END rom;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY state_machine IS
PORT (clk,clr: IN STD_LOGIC;
      ld: OUT STD_LOGIC;
      C: OUT STD_LOGIC_VECTOR (2 downto 0);
      app: OUT INTEGER RANGE 0 TO 7
      );
END state_machine;

ARCHITECTURE state_machine OF state_machine IS
TYPE estados is (n0, n1, n2, n3, n4, n5, n6, n7);
SIGNAL estado:estados;

BEGIN

PROCESS(clk,clr)
BEGIN

IF clr ='0'then
estado <= n0;

ELSE
IF (clk 'EVENT AND clk = '1') then

CASE estado is
  WHEN n0 =>
       estado<=n1;
       ld <= '1';
       C<= ("000");
       app <= 0;
  WHEN n1 =>
       estado<=n2;
       ld <= '0';
       C<= ("001");
       app <= 1;
  WHEN n2 =>
       estado<=n3;
       ld <= '0';
       C<= ("010");
       app <= 2;
  WHEN n3 =>
       estado<=n4;  
       ld <= '0';
       C<= ("011");
       app <= 3;
  WHEN n4 =>
       estado<=n5;
       ld <= '0';
       C<= ("100");
       app <= 4;
  WHEN n5 =>
       estado<=n6;
       ld <= '0';
       C<= ("101");
       app <= 5;
  WHEN n6 =>
       estado<=n7;
       ld <= '0';
       C<= ("110");
       app <= 6;
  WHEN n7 =>
       estado<=n0;
       ld <= '0';
       C<= ("111");
       app <= 7;

END CASE;
END IF;
END IF;
END PROCESS;
END state_machine;

----- File my_components.vhd: ---------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT somador16bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
s : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END  COMPONENT;

COMPONENT mult8bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
       s : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END COMPONENT;

COMPONENT reg16b IS
PORT ( clk : IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
Q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END COMPONENT;

COMPONENT mux8para3 IS
PORT ( sel: IN STD_LOGIC_VECTOR (2 downto 0);
       a, b, c, d, e, f, g, h : IN STD_LOGIC_VECTOR (7 downto 0);
       Y : OUT STD_LOGIC_VECTOR (7 downto 0)
       );
END COMPONENT;

COMPONENT regdesl8b IS
PORT ( clk, ld : IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
Q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END COMPONENT;

COMPONENT state_machine IS
PORT (clk, clr: IN STD_LOGIC;
      ld: OUT STD_LOGIC;
      C: OUT STD_LOGIC_VECTOR (2 downto 0);
      app: OUT INTEGER RANGE 0 TO 7
      );
END COMPONENT;

COMPONENT rom IS
 GENERIC ( bits: INTEGER := 8; -- # of bits per word
 words: INTEGER := 8); -- # of words in the memory
 PORT ( addr: IN INTEGER RANGE 0 TO words-1;
 data: OUT STD_LOGIC_VECTOR (bits-1 DOWNTO 0));
END COMPONENT;

END my_components;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;

ENTITY registradordeslocamento IS
	PORT (clk, load: IN STD_LOGIC;
	      X: STD_LOGIC_VECTOR (7 downto 0);
		  Sa, Sb, Sc, Sd, Se, Sf, Sg, Sh: OUT STD_LOGIC_VECTOR (7 downto 0) 
	);
END registradordeslocamento;

ARCHITECTURE comportamento OF registradordeslocamento IS


SIGNAL Ta, Tb, Tc, Td, Te, Tf, Tg: STD_LOGIC_VECTOR (7 downto 0);   

BEGIN

	stage_0: regdesl8b port map (clk, load, X, Ta);
	stage_1: regdesl8b port map (clk, load, Ta, Tb);
	stage_2: regdesl8b port map (clk, load, Tb, Tc);
	stage_3: regdesl8b port map (clk, load, Tc, Td);
	stage_4: regdesl8b port map (clk, load, Td, Te);
	stage_5: regdesl8b port map (clk, load, Te, Tf);
	stage_6: regdesl8b port map (clk, load, Tf, Tg);
	stage_7: regdesl8b port map (clk, load, Tg, Sh);

Sa <= Ta;
Sb <= Tb;
Sc <= Tc;
Sd <= Td;
Se <= Te;
Sf <= Tf;
Sg <= Tg;

END comportamento;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

----- File my_components.vhd: ---------------
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 PACKAGE my_components1 IS

COMPONENT registradordeslocamento IS
	PORT (clk, load: IN STD_LOGIC;
	      X: STD_LOGIC_VECTOR (7 downto 0);
		  Sa, Sb, Sc, Sd, Se, Sf, Sg, Sh: OUT STD_LOGIC_VECTOR (7 downto 0) 
	);
END COMPONENT;

end my_components1;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;
USE work.my_components1.all;

ENTITY filtro_FIR3 IS
	PORT (clk, limpa: IN STD_LOGIC;
	      X: IN STD_LOGIC_VECTOR (7 downto 0);
	      S: OUT STD_LOGIC_VECTOR (15 downto 0);
	      S1: OUT STD_LOGIC 
	);
END filtro_FIR3;

ARCHITECTURE comportamento OF filtro_FIR3 IS

SIGNAL RP00, RP01, RP02, RP05: STD_LOGIC_VECTOR (15 downto 0); 
SIGNAL RP03, RP04, A, B, C, D ,E, F, G, H: STD_LOGIC_VECTOR (7 downto 0); 
SIGNAL apontador: INTEGER RANGE 0 TO 7;
SIGNAL selecao: STD_LOGIC_VECTOR (2 downto 0);
SIGNAL carga: STD_LOGIC;


BEGIN
	stage_0: registradordeslocamento port map (clk, carga, X, A, B, C, D, E, F, G, H);
	stage_1: mux8para3 port map (selecao, A, B, C, D, E ,F, G, H, RP04);
	stage_2: rom port map (apontador, RP03);
    stage_3: mult8bits port map (RP04, RP03, RP00);
	stage_4: somador16bits port map (RP00, RP01, RP02);
	stage_5: reg16b port map (clk, RP02, RP01);
	stage_6: state_machine port map (clk, limpa, carga, selecao, apontador);
	
S <= RP01;
S1 <= carga;

END comportamento;
