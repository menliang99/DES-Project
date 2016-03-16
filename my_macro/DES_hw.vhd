
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity DES_hw is
    port (clk		:in std_logic;
          reset		:in std_logic;
          key	:in std_logic_vector (63 downto 0);
          din		:in std_logic_vector (63 downto 0);
          dinvld     :in std_logic;
          dout		:out std_logic_vector (63 downto 0);
          doutvld	:out std_logic
         );
end DES_hw;

architecture mainbody of DES_hw is

component key_change port(
                keyin		:in std_logic_vector (63 downto 0);
                keyout		:out std_logic_vector (55 downto 0)
              );
end component;

 component IP_change port(
              din		:in std_logic_vector (63 downto 0);
              data_after_IP		:out std_logic_vector (63 downto 0)
             );
  end component;
  
component data_generate port(
          clk		:in std_logic;
          reset		:in std_logic;
          counter: in std_logic_vector(3 downto 0);  -- keyin and counter determine the key used 
          key_in	:in std_logic_vector (55 downto 0);
          din		:in std_logic_vector (63 downto 0);
          dinvld     :in std_logic;	
          dout		:out std_logic_vector (63 downto 0);
          doutvld	:out std_logic;
          key_out: out std_logic_vector(55 downto 0)
                        );
end component;

component LP_change port(              
               din		:in std_logic_vector (63 downto 0);
              dout		:out std_logic_vector (63 downto 0)
              );
end component;

  signal data_after_IP	:std_logic_vector (63 downto 0) := x"0000000000000000";
  
  signal dout1	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout2	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout3	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout4	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout5	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout6	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout7	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout8	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout9	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout10	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout11	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout12	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout13	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout14	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout15	:std_logic_vector (63 downto 0) := x"0000000000000000";
  signal dout16	:std_logic_vector (63 downto 0) := x"0000000000000000";
    signal dout17	:std_logic_vector (63 downto 0) := x"0000000000000000";
    
signal key0	:std_logic_vector (55 downto 0) := x"00000000000000";
 signal key1	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key2	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key3	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key4	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key5	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key6	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key7	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key8	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key9	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key10	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key11	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key12	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key13	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key14	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key15	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key16	:std_logic_vector (55 downto 0) := x"00000000000000";
   -- signal key17	:std_logic_vector (55 downto 0) := x"00000000000000";

  signal doutvld1 :std_logic := '0';
  signal doutvld2 :std_logic := '0';
  signal doutvld3 :std_logic := '0';
  signal doutvld4 :std_logic := '0';
  signal doutvld5 :std_logic := '0';
  signal doutvld6 :std_logic := '0';
  signal doutvld7 :std_logic := '0';
  signal doutvld8 :std_logic := '0';
  signal doutvld9 :std_logic := '0';
  signal doutvld10 :std_logic := '0';
  signal doutvld11 :std_logic := '0';
  signal doutvld12 :std_logic := '0';
  signal doutvld13 :std_logic := '0';
  signal doutvld14 :std_logic := '0';
  signal doutvld15 :std_logic := '0';
  signal doutvld16 :std_logic := '0';

   signal doutvld17 :std_logic := '0';

  signal counter1 :std_logic_vector (3 downto 0) := "0000";
  signal counter2 :std_logic_vector (3 downto 0) := "0000";
  signal counter3 :std_logic_vector (3 downto 0) := "0000";
  signal counter4 :std_logic_vector (3 downto 0) := "0000";
  signal counter5 :std_logic_vector (3 downto 0) := "0000";
  signal counter6 :std_logic_vector (3 downto 0) := "0000";
  signal counter7 :std_logic_vector (3 downto 0) := "0000";
  signal counter8 :std_logic_vector (3 downto 0) := "0000";
  signal counter9 :std_logic_vector (3 downto 0) := "0000";
  signal counter10 :std_logic_vector (3 downto 0) := "0000";
  signal counter11 :std_logic_vector (3 downto 0) := "0000";
  signal counter12 :std_logic_vector (3 downto 0) := "0000";
  signal counter13 :std_logic_vector (3 downto 0) := "0000";
  signal counter14 :std_logic_vector (3 downto 0) := "0000";
  signal counter15 :std_logic_vector (3 downto 0) := "0000";
  signal counter16 :std_logic_vector (3 downto 0) := "0000";
  
begin
  -- Register the inputs
  process (reset, clk)
  begin
    if reset='1' then
     
      dout  <= x"0000000000000000";
      doutvld <= '0';
  
    elsif clk'event and clk='1' then
       -- doutvld17 <= doutvld16;
       doutvld <= doutvld16;
       dout <= dout17;
    end if;
    
    end process;  

  counter1  <= "0001"; 
  counter2  <= "0010"; 
  counter3  <= "0011"; 
  counter4  <= "0100"; 
  counter5  <= "0101"; 
  counter6  <= "0110"; 
  counter7  <= "0111"; 
  counter8  <= "1000"; 
  counter9  <= "1001"; 
  counter10 <= "1010"; 
  counter11 <= "1011"; 
  counter12 <= "1100"; 
  counter13 <= "1101"; 
  counter14 <= "1110"; 
  counter15 <= "1111"; 
  counter16 <= "0000"; --1bit
  
  entitykeychange: key_change port map (key, key0);
  entity0:  IP_change port map (din, data_after_IP);  
   
  ENTITY1:  data_generate port map (clk,reset,counter1,key0,data_after_IP,dinvld,dout1,doutvld1,key1);                     
  ENTITY2:  data_generate port map (clk,reset,counter2,key1,dout1,doutvld1,dout2,doutvld2,key2);
  ENTITY3:  data_generate port map (clk,reset,counter3,key2,dout2,doutvld2,dout3,doutvld3,key3);                   
  ENTITY4:  data_generate port map (clk,reset,counter4,key3,dout3,doutvld3,dout4,doutvld4,key4); 
  ENTITY5:  data_generate port map (clk,reset,counter5,key4,dout4,doutvld4,dout5,doutvld5,key5);                 
  ENTITY6:  data_generate port map (clk,reset,counter6,key5,dout5,doutvld5,dout6,doutvld6,key6);
  ENTITY7:  data_generate port map (clk,reset,counter7,key6,dout6,doutvld6,dout7,doutvld7,key7);                     
  ENTITY8:  data_generate port map (clk,reset,counter8,key7,dout7,doutvld7,dout8,doutvld8,key8);  
  ENTITY9:  data_generate port map (clk,reset,counter9,key8,dout8,doutvld8,dout9,doutvld9,key9);               
  ENTITY10:  data_generate port map (clk,reset,counter10,key9,dout9,doutvld9,dout10,doutvld10,key10);
  ENTITY11:  data_generate port map (clk,reset,counter11,key10,dout10,doutvld10,dout11,doutvld11,key11);                    
  ENTITY12:  data_generate port map (clk,reset,counter12,key11,dout11,doutvld11,dout12,doutvld12,key12); 
  ENTITY13:  data_generate port map (clk,reset,counter13,key12,dout12,doutvld12,dout13,doutvld13,key13);             
  ENTITY14:  data_generate port map (clk,reset,counter14,key13,dout13,doutvld13,dout14,doutvld14,key14);
  ENTITY15:  data_generate port map (clk,reset,counter15,key14,dout14,doutvld14,dout15,doutvld15,key15);                    
  ENTITY16:  data_generate port map (clk,reset,counter16,key15,dout15,doutvld15,dout16,doutvld16,key16);
   
  ENTITY17: LP_change port map (dout16,dout17); 

  --dout <= dout17;

end mainbody;



    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

    
    entity P_change is
        port (
              din		:in std_logic_vector (31 downto 0);
              dout		:out std_logic_vector (31 downto 0)
 
             );
    end P_change;
    
    

    
    architecture mainbody of P_change is
    begin
    
   process(din)
   
   
   
     begin
  dout  <= din(25-1) & din(4-1) & din(11-1) & din(22-1) & 
           din(6-1) & din(30-1) & din(13-1) & din(19-1) &
           din(9-1) & din(3-1) & din(27-1) & din(32-1) & 
           din(14-1) & din(24-1) & din(8-1) & din(2-1) &
           din(10-1) & din(31-1) & din(18-1) & din(5-1) & 
           din(26-1) & din(23-1) & din(15-1) & din(0) &
           din(17-1) & din(28-1) & din(12-1) & din(29-1) &
            din(21-1) & din(20-1) & din(7-1) & din(16-1);
  
  
end process;   
  end mainbody;


     
  
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

    
    entity LP_change is
        port (
              din		:in std_logic_vector (63 downto 0);
              dout		:out std_logic_vector (63 downto 0)
 
             );
    end LP_change;
    
    
    architecture mainbody of LP_change is
    begin
    
   process(din)
   
   
   
     begin
    dout<= din(64-40) & din(64- 8) & din(64-48) & din(64-16) & din(64-56) & din(64-24) & din(64-64) & din(64-32) &
           din(64-39) & din(64- 7) & din(64-47) & din(64-15) & din(64-55) & din(64-23) & din(64-63) & din(64-31) &
           din(64-38) & din(64- 6) & din(64-46) & din(64-14) & din(64-54) & din(64-22) & din(64-62) & din(64-30) &
           din(64-37) & din(64- 5) & din(64-45) & din(64-13) & din(64-53) & din(64-21) & din(64-61) & din(64-29) &           
           din(64-36) & din(64- 4) & din(64-44) & din(64-12) & din(64-52) & din(64-20) & din(64-60) & din(64-28) &
           din(64-35) & din(64- 3) & din(64-43) & din(64-11) & din(64-51) & din(64-19) & din(64-59) & din(64-27) &           
           din(64-34) & din(64- 2) & din(64-42) & din(64-10) & din(64-50) & din(64-18) & din(64-58) & din(64-26) &
           din(64-33) & din(64- 1) & din(64-41) & din(64- 9) & din(64-49) & din(64-17) & din(64-57) & din(64-25);
    
  
end process;   
  end mainbody;


    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

    
    entity IP_change is
        port (
              din		:in std_logic_vector (63 downto 0);
              data_after_IP		:out std_logic_vector (63 downto 0)
 
             );
    end IP_change;
    
    
    architecture mainbody of IP_change is
    begin
    
   process(din)
   
  -- singal temp : std_logic_vector(0 to 63);
   
     begin
 data_after_IP <= din(64-58) & din(64-50) & din(64-42) & din(64-34) & din(64-26) & din(64-18) & din(64-10) & din(64- 2) &
           din(64-60) & din(64-52) & din(64-44) & din(64-36) & din(64-28) & din(64-20) & din(64-12) & din(64- 4) &
           din(64-62) & din(64-54) & din(64-46) & din(64-38) & din(64-30) & din(64-22) & din(64-14) & din(64- 6) &
           din(64-64) & din(64-56) & din(64-48) & din(64-40) & din(64-32) & din(64-24) & din(64-16) & din(64- 8) &
           
           din(64-57) & din(64-49) & din(64-41) & din(64-33) & din(64-25) & din(64-17) & din(64- 9) & din(64- 1) &
           din(64-59) & din(64-51) & din(64-43) & din(64-35) & din(64-27) & din(64-19) & din(64-11) & din(64- 3) &
           din(64-61) & din(64-53) & din(64-45) & din(64-37) & din(64-29) & din(64-21) & din(64-13) & din(64- 5) &
           din(64-63) & din(64-55) & din(64-47) & din(64-39) & din(64-31) & din(64-23) & din(64-15) & din(64- 7);
   
    
  
end process;   
  end mainbody;

 
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

    
    entity keychange2 is
        port (
              keyin		:in std_logic_vector (55 downto 0);
              keyout		:out std_logic_vector (47 downto 0)
 
             );
    end keychange2;
    
    
    architecture mainbody of keychange2 is
    begin
    
   process(keyin)
   
  -- variable key2 	:std_logic_vector (47 downto 0-1); 
   
     begin
 
  keyout<= keyin(32-1) & keyin(29-1) & keyin(36-1) & keyin(50-1) & keyin(42-1) & keyin(46-1) &
           keyin(53-1) & keyin(34-1) & keyin(56-1) & keyin(39-1) & keyin(49-1) & keyin(44-1) &
           keyin(48-1) & keyin(33-1) & keyin(45-1) & keyin(51-1) & keyin(40-1) & keyin(30-1) &
           keyin(55-1) & keyin(47-1) & keyin(37-1) & keyin(31-1) & keyin(52-1) & keyin(41-1) &
           keyin(2-1) & keyin(13-1) & keyin(20-1) & keyin(27-1) & keyin(7-1) & keyin(16-1) &
           keyin(8-1) & keyin(26-1) & keyin(4-1) & keyin(12-1) & keyin(19-1) & keyin(23-1) &
           keyin(10-1) & keyin(21-1) & keyin(6-1) & keyin(15-1) & keyin(28-1) & keyin(3-1) &
           keyin(5-1) & keyin(1-1) & keyin(24-1) & keyin(11-1) & keyin(17-1) & keyin(14-1);

end process;
end mainbody;

  
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

    
    entity key_change is
        port (
              keyin		:in std_logic_vector (63 downto 0);
              keyout		:out std_logic_vector (55 downto 0)
 
             );
    end key_change;
    
    
    architecture mainbody of key_change is
    begin
    
   process(keyin)
   
  -- variable key1 	:std_logic_vector (55 downto 0); 
   
     begin


    keyout<= keyin(4-1) & keyin(12-1) & keyin(20-1) & keyin(28-1) & keyin(5-1) & keyin(13-1) & keyin(21-1) & 
           keyin(29-1) &keyin(37-1) & keyin(45-1) & keyin(53-1) & keyin(61-1) & keyin(6-1) & keyin(14-1) & 
           keyin(22-1) & keyin(30-1) & keyin(38-1) & keyin(46-1) & keyin(54-1) & keyin(62-1) & keyin(7-1) & 
           keyin(15-1) & keyin(23-1) & keyin(31-1) &keyin(39-1) & keyin(47-1) & keyin(55-1) & keyin(63-1) &

           keyin(36-1) & keyin(44-1) & keyin(52-1) & keyin(60-1) & keyin(3-1) & keyin(11-1) & keyin(19-1) & 
           keyin(27-1) & keyin(35-1) & keyin(43-1) & keyin(51-1) & keyin(59-1) & keyin(2-1) & keyin(10-1) & 
           keyin(18-1) & keyin(26-1) & keyin(34-1) & keyin(42-1) & keyin(50-1) & keyin(58-1) & keyin(1-1) &
           keyin(9-1) & keyin(17-1) & keyin(25-1) & keyin(33-1) & keyin(41-1) & keyin(49-1) & keyin(57-1);
   


end process;
end mainbody;

 
  
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

    
    entity S_change is
        port (
              din		:in std_logic_vector (47 downto 0);
              dout		:out std_logic_vector (31 downto 0)
 
             );
    end S_change;
    
    
    architecture mainbody of S_change is
    begin
    
   process(din)
   
--  variable dout  :std_logic_vector (31 downto 0);
    
   begin
    case din( 47 downto  42) is
      when "000000" =>  dout(31 downto 28) <= "1101";      when "000001" =>  dout(31 downto 28) <= "0001";
      when "000010" =>  dout(31 downto 28) <= "0010";      when "000011" =>  dout(31 downto 28) <= "1111";
      when "000100" =>  dout(31 downto 28) <= "1000";      when "000101" =>  dout(31 downto 28) <= "1101";
      when "000110" =>  dout(31 downto 28) <= "0100";      when "000111" =>  dout(31 downto 28) <= "1000";
      when "001000" =>  dout(31 downto 28) <= "0110";      when "001001" =>  dout(31 downto 28) <= "1010";
      when "001010" =>  dout(31 downto 28) <= "1111";      when "001011" =>  dout(31 downto 28) <= "0011";
      when "001100" =>  dout(31 downto 28) <= "1011";      when "001101" =>  dout(31 downto 28) <= "0111";
      when "001110" =>  dout(31 downto 28) <= "0001";      when "001111" =>  dout(31 downto 28) <= "0100";
      when "010000" =>  dout(31 downto 28) <= "1010";      when "010001" =>  dout(31 downto 28) <= "1100";
      when "010010" =>  dout(31 downto 28) <= "1001";      when "010011" =>  dout(31 downto 28) <= "0101";
      when "010100" =>  dout(31 downto 28) <= "0011";      when "010101" =>  dout(31 downto 28) <= "0110";
      when "010110" =>  dout(31 downto 28) <= "1110";      when "010111" =>  dout(31 downto 28) <= "1011";
      when "011000" =>  dout(31 downto 28) <= "0101";      when "011001" =>  dout(31 downto 28) <= "0000";
      when "011010" =>  dout(31 downto 28) <= "0000";      when "011011" =>  dout(31 downto 28) <= "1110";
      when "011100" =>  dout(31 downto 28) <= "1100";      when "011101" =>  dout(31 downto 28) <= "1001";
      when "011110" =>  dout(31 downto 28) <= "0111";      when "011111" =>  dout(31 downto 28) <= "0010";
      when "100000" =>  dout(31 downto 28) <= "0111";      when "100001" =>  dout(31 downto 28) <= "0010";
      when "100010" =>  dout(31 downto 28) <= "1011";      when "100011" =>  dout(31 downto 28) <= "0001";
      when "100100" =>  dout(31 downto 28) <= "0100";      when "100101" =>  dout(31 downto 28) <= "1110";
      when "100110" =>  dout(31 downto 28) <= "0001";      when "100111" =>  dout(31 downto 28) <= "0111";
      when "101000" =>  dout(31 downto 28) <= "1001";      when "101001" =>  dout(31 downto 28) <= "0100";
      when "101010" =>  dout(31 downto 28) <= "1100";      when "101011" =>  dout(31 downto 28) <= "1010";
      when "101100" =>  dout(31 downto 28) <= "1110";      when "101101" =>  dout(31 downto 28) <= "1000";
      when "101110" =>  dout(31 downto 28) <= "0010";      when "101111" =>  dout(31 downto 28) <= "1101";
      when "110000" =>  dout(31 downto 28) <= "0000";      when "110001" =>  dout(31 downto 28) <= "1111";
      when "110010" =>  dout(31 downto 28) <= "0110";      when "110011" =>  dout(31 downto 28) <= "1100";
      when "110100" =>  dout(31 downto 28) <= "1010";      when "110101" =>  dout(31 downto 28) <= "1001";
      when "110110" =>  dout(31 downto 28) <= "1101";      when "110111" =>  dout(31 downto 28) <= "0000";
      when "111000" =>  dout(31 downto 28) <= "1111";      when "111001" =>  dout(31 downto 28) <= "0011";
      when "111010" =>  dout(31 downto 28) <= "0011";      when "111011" =>  dout(31 downto 28) <= "0101";
      when "111100" =>  dout(31 downto 28) <= "0101";      when "111101" =>  dout(31 downto 28) <= "0110";
      when "111110" =>  dout(31 downto 28) <= "1000";      when "111111" =>  dout(31 downto 28) <= "1011";
      when others   =>  dout(31 downto 28) <= "1011";
    end case;

 
    case din(41 downto  36) is
      when "000000" =>  dout(27 downto 24) <= "0100";      when "000001" =>  dout(27 downto 24) <= "1101";
      when "000010" =>  dout(27 downto 24) <= "1011";      when "000011" =>  dout(27 downto 24) <= "0000";
      when "000100" =>  dout(27 downto 24) <= "0010";      when "000101" =>  dout(27 downto 24) <= "1011";
      when "000110" =>  dout(27 downto 24) <= "1110";      when "000111" =>  dout(27 downto 24) <= "0111";
      when "001000" =>  dout(27 downto 24) <= "1111";      when "001001" =>  dout(27 downto 24) <= "0100";
      when "001010" =>  dout(27 downto 24) <= "0000";      when "001011" =>  dout(27 downto 24) <= "1001";
      when "001100" =>  dout(27 downto 24) <= "1000";      when "001101" =>  dout(27 downto 24) <= "0001";
      when "001110" =>  dout(27 downto 24) <= "1101";      when "001111" =>  dout(27 downto 24) <= "1010";
      when "010000" =>  dout(27 downto 24) <= "0011";      when "010001" =>  dout(27 downto 24) <= "1110";
      when "010010" =>  dout(27 downto 24) <= "1100";      when "010011" =>  dout(27 downto 24) <= "0011";
      when "010100" =>  dout(27 downto 24) <= "1001";      when "010101" =>  dout(27 downto 24) <= "0101";
      when "010110" =>  dout(27 downto 24) <= "0111";      when "010111" =>  dout(27 downto 24) <= "1100";
      when "011000" =>  dout(27 downto 24) <= "0101";      when "011001" =>  dout(27 downto 24) <= "0010";
      when "011010" =>  dout(27 downto 24) <= "1010";      when "011011" =>  dout(27 downto 24) <= "1111";
      when "011100" =>  dout(27 downto 24) <= "0110";      when "011101" =>  dout(27 downto 24) <= "1000";
      when "011110" =>  dout(27 downto 24) <= "0001";      when "011111" =>  dout(27 downto 24) <= "0110";
      when "100000" =>  dout(27 downto 24) <= "0001";      when "100001" =>  dout(27 downto 24) <= "0110";
      when "100010" =>  dout(27 downto 24) <= "0100";      when "100011" =>  dout(27 downto 24) <= "1011";
      when "100100" =>  dout(27 downto 24) <= "1011";      when "100101" =>  dout(27 downto 24) <= "1101";
      when "100110" =>  dout(27 downto 24) <= "1101";      when "100111" =>  dout(27 downto 24) <= "1000";
      when "101000" =>  dout(27 downto 24) <= "1100";      when "101001" =>  dout(27 downto 24) <= "0001";
      when "101010" =>  dout(27 downto 24) <= "0011";      when "101011" =>  dout(27 downto 24) <= "0100";
      when "101100" =>  dout(27 downto 24) <= "0111";      when "101101" =>  dout(27 downto 24) <= "1010";
      when "101110" =>  dout(27 downto 24) <= "1110";      when "101111" =>  dout(27 downto 24) <= "0111";
      when "110000" =>  dout(27 downto 24) <= "1010";      when "110001" =>  dout(27 downto 24) <= "1001";
      when "110010" =>  dout(27 downto 24) <= "1111";      when "110011" =>  dout(27 downto 24) <= "0101";
      when "110100" =>  dout(27 downto 24) <= "0110";      when "110101" =>  dout(27 downto 24) <= "0000";
      when "110110" =>  dout(27 downto 24) <= "1000";      when "110111" =>  dout(27 downto 24) <= "1111";
      when "111000" =>  dout(27 downto 24) <= "0000";      when "111001" =>  dout(27 downto 24) <= "1110";
      when "111010" =>  dout(27 downto 24) <= "0101";      when "111011" =>  dout(27 downto 24) <= "0010";
      when "111100" =>  dout(27 downto 24) <= "1001";      when "111101" =>  dout(27 downto 24) <= "0011";
      when "111110" =>  dout(27 downto 24) <= "0010";      when "111111" =>  dout(27 downto 24) <= "1100";
      when others   =>  dout(27 downto 24) <= "1100";
    end case;

   
    case din(35 downto 30) is
      when "000000" =>  dout(23 downto 20) <= "1100";      when "000001" =>  dout(23 downto 20) <= "1010";
      when "000010" =>  dout(23 downto 20) <= "0001";      when "000011" =>  dout(23 downto 20) <= "1111";
      when "000100" =>  dout(23 downto 20) <= "1010";      when "000101" =>  dout(23 downto 20) <= "0100";
      when "000110" =>  dout(23 downto 20) <= "1111";      when "000111" =>  dout(23 downto 20) <= "0010";
      when "001000" =>  dout(23 downto 20) <= "1001";      when "001001" =>  dout(23 downto 20) <= "0111";
      when "001010" =>  dout(23 downto 20) <= "0010";      when "001011" =>  dout(23 downto 20) <= "1100";
      when "001100" =>  dout(23 downto 20) <= "0110";      when "001101" =>  dout(23 downto 20) <= "1001";
      when "001110" =>  dout(23 downto 20) <= "1000";      when "001111" =>  dout(23 downto 20) <= "0101";
      when "010000" =>  dout(23 downto 20) <= "0000";      when "010001" =>  dout(23 downto 20) <= "0110";
      when "010010" =>  dout(23 downto 20) <= "1101";      when "010011" =>  dout(23 downto 20) <= "0001";
      when "010100" =>  dout(23 downto 20) <= "0011";      when "010101" =>  dout(23 downto 20) <= "1101";
      when "010110" =>  dout(23 downto 20) <= "0100";      when "010111" =>  dout(23 downto 20) <= "1110";
      when "011000" =>  dout(23 downto 20) <= "1110";      when "011001" =>  dout(23 downto 20) <= "0000";
      when "011010" =>  dout(23 downto 20) <= "0111";      when "011011" =>  dout(23 downto 20) <= "1011";
      when "011100" =>  dout(23 downto 20) <= "0101";      when "011101" =>  dout(23 downto 20) <= "0011";
      when "011110" =>  dout(23 downto 20) <= "1011";      when "011111" =>  dout(23 downto 20) <= "1000";
      when "100000" =>  dout(23 downto 20) <= "1001";      when "100001" =>  dout(23 downto 20) <= "0100";
      when "100010" =>  dout(23 downto 20) <= "1110";      when "100011" =>  dout(23 downto 20) <= "0011";
      when "100100" =>  dout(23 downto 20) <= "1111";      when "100101" =>  dout(23 downto 20) <= "0010";
      when "100110" =>  dout(23 downto 20) <= "0101";      when "100111" =>  dout(23 downto 20) <= "1100";
      when "101000" =>  dout(23 downto 20) <= "0010";      when "101001" =>  dout(23 downto 20) <= "1001";
      when "101010" =>  dout(23 downto 20) <= "1000";      when "101011" =>  dout(23 downto 20) <= "0101";
      when "101100" =>  dout(23 downto 20) <= "1100";      when "101101" =>  dout(23 downto 20) <= "1111";
      when "101110" =>  dout(23 downto 20) <= "0011";      when "101111" =>  dout(23 downto 20) <= "1010";
      when "110000" =>  dout(23 downto 20) <= "0111";      when "110001" =>  dout(23 downto 20) <= "1011";
      when "110010" =>  dout(23 downto 20) <= "0000";      when "110011" =>  dout(23 downto 20) <= "1110";
      when "110100" =>  dout(23 downto 20) <= "0100";      when "110101" =>  dout(23 downto 20) <= "0001";
      when "110110" =>  dout(23 downto 20) <= "1010";      when "110111" =>  dout(23 downto 20) <= "0111";
      when "111000" =>  dout(23 downto 20) <= "0001";      when "111001" =>  dout(23 downto 20) <= "0110";
      when "111010" =>  dout(23 downto 20) <= "1101";      when "111011" =>  dout(23 downto 20) <= "0000";
      when "111100" =>  dout(23 downto 20) <= "1011";      when "111101" =>  dout(23 downto 20) <= "1000";
      when "111110" =>  dout(23 downto 20) <= "0110";      when "111111" =>  dout(23 downto 20) <= "1101";
      when others   =>  dout(23 downto 20) <= "1101";
    end case;

  
    case din(29 downto 24) is
      when "000000" =>  dout(19 downto 16) <= "0010";      when "000001" =>  dout(19 downto 16) <= "1110";
      when "000010" =>  dout(19 downto 16) <= "1100";      when "000011" =>  dout(19 downto 16) <= "1011";
      when "000100" =>  dout(19 downto 16) <= "0100";      when "000101" =>  dout(19 downto 16) <= "0010";
      when "000110" =>  dout(19 downto 16) <= "0001";      when "000111" =>  dout(19 downto 16) <= "1100";
      when "001000" =>  dout(19 downto 16) <= "0111";      when "001001" =>  dout(19 downto 16) <= "0100";
      when "001010" =>  dout(19 downto 16) <= "1010";      when "001011" =>  dout(19 downto 16) <= "0111";
      when "001100" =>  dout(19 downto 16) <= "1011";      when "001101" =>  dout(19 downto 16) <= "1101";
      when "001110" =>  dout(19 downto 16) <= "0110";      when "001111" =>  dout(19 downto 16) <= "0001";
      when "010000" =>  dout(19 downto 16) <= "1000";      when "010001" =>  dout(19 downto 16) <= "0101";
      when "010010" =>  dout(19 downto 16) <= "0101";      when "010011" =>  dout(19 downto 16) <= "0000";
      when "010100" =>  dout(19 downto 16) <= "0011";      when "010101" =>  dout(19 downto 16) <= "1111";
      when "010110" =>  dout(19 downto 16) <= "1111";      when "010111" =>  dout(19 downto 16) <= "1010";
      when "011000" =>  dout(19 downto 16) <= "1101";      when "011001" =>  dout(19 downto 16) <= "0011";
      when "011010" =>  dout(19 downto 16) <= "0000";      when "011011" =>  dout(19 downto 16) <= "1001";
      when "011100" =>  dout(19 downto 16) <= "1110";      when "011101" =>  dout(19 downto 16) <= "1000";
      when "011110" =>  dout(19 downto 16) <= "1001";      when "011111" =>  dout(19 downto 16) <= "0110";
      when "100000" =>  dout(19 downto 16) <= "0100";      when "100001" =>  dout(19 downto 16) <= "1011";
      when "100010" =>  dout(19 downto 16) <= "0010";      when "100011" =>  dout(19 downto 16) <= "1000";
      when "100100" =>  dout(19 downto 16) <= "0001";      when "100101" =>  dout(19 downto 16) <= "1100";
      when "100110" =>  dout(19 downto 16) <= "1011";      when "100111" =>  dout(19 downto 16) <= "0111";
      when "101000" =>  dout(19 downto 16) <= "1010";      when "101001" =>  dout(19 downto 16) <= "0001";
      when "101010" =>  dout(19 downto 16) <= "1101";      when "101011" =>  dout(19 downto 16) <= "1110";
      when "101100" =>  dout(19 downto 16) <= "0111";      when "101101" =>  dout(19 downto 16) <= "0010";
      when "101110" =>  dout(19 downto 16) <= "1000";      when "101111" =>  dout(19 downto 16) <= "1101";
      when "110000" =>  dout(19 downto 16) <= "1111";      when "110001" =>  dout(19 downto 16) <= "0110";
      when "110010" =>  dout(19 downto 16) <= "1001";      when "110011" =>  dout(19 downto 16) <= "1111";
      when "110100" =>  dout(19 downto 16) <= "1100";      when "110101" =>  dout(19 downto 16) <= "0000";
      when "110110" =>  dout(19 downto 16) <= "0101";      when "110111" =>  dout(19 downto 16) <= "1001";
      when "111000" =>  dout(19 downto 16) <= "0110";      when "111001" =>  dout(19 downto 16) <= "1010";
      when "111010" =>  dout(19 downto 16) <= "0011";      when "111011" =>  dout(19 downto 16) <= "0100";
      when "111100" =>  dout(19 downto 16) <= "0000";      when "111101" =>  dout(19 downto 16) <= "0101";
      when "111110" =>  dout(19 downto 16) <= "1110";      when "111111" =>  dout(19 downto 16) <= "0011";
      when others   =>  dout(19 downto 16) <= "0011";
    end case;

  
    case din(23 downto 18) is
      when "000000" =>  dout(15 downto 12) <= "0111";      when "000001" =>  dout(15 downto 12) <= "1101";
      when "000010" =>  dout(15 downto 12) <= "1101";      when "000011" =>  dout(15 downto 12) <= "1000";
      when "000100" =>  dout(15 downto 12) <= "1110";      when "000101" =>  dout(15 downto 12) <= "1011";
      when "000110" =>  dout(15 downto 12) <= "0011";      when "000111" =>  dout(15 downto 12) <= "0101";
      when "001000" =>  dout(15 downto 12) <= "0000";      when "001001" =>  dout(15 downto 12) <= "0110";
      when "001010" =>  dout(15 downto 12) <= "0110";      when "001011" =>  dout(15 downto 12) <= "1111";
      when "001100" =>  dout(15 downto 12) <= "1001";      when "001101" =>  dout(15 downto 12) <= "0000";
      when "001110" =>  dout(15 downto 12) <= "1010";      when "001111" =>  dout(15 downto 12) <= "0011";
      when "010000" =>  dout(15 downto 12) <= "0001";      when "010001" =>  dout(15 downto 12) <= "0100";
      when "010010" =>  dout(15 downto 12) <= "0010";      when "010011" =>  dout(15 downto 12) <= "0111";
      when "010100" =>  dout(15 downto 12) <= "1000";      when "010101" =>  dout(15 downto 12) <= "0010";
      when "010110" =>  dout(15 downto 12) <= "0101";      when "010111" =>  dout(15 downto 12) <= "1100";
      when "011000" =>  dout(15 downto 12) <= "1011";      when "011001" =>  dout(15 downto 12) <= "0001";
      when "011010" =>  dout(15 downto 12) <= "1100";      when "011011" =>  dout(15 downto 12) <= "1010";
      when "011100" =>  dout(15 downto 12) <= "0100";      when "011101" =>  dout(15 downto 12) <= "1110";
      when "011110" =>  dout(15 downto 12) <= "1111";      when "011111" =>  dout(15 downto 12) <= "1001";
      when "100000" =>  dout(15 downto 12) <= "1010";      when "100001" =>  dout(15 downto 12) <= "0011";
      when "100010" =>  dout(15 downto 12) <= "0110";      when "100011" =>  dout(15 downto 12) <= "1111";
      when "100100" =>  dout(15 downto 12) <= "1001";      when "100101" =>  dout(15 downto 12) <= "0000";
      when "100110" =>  dout(15 downto 12) <= "0000";      when "100111" =>  dout(15 downto 12) <= "0110";
      when "101000" =>  dout(15 downto 12) <= "1100";      when "101001" =>  dout(15 downto 12) <= "1010";
      when "101010" =>  dout(15 downto 12) <= "1011";      when "101011" =>  dout(15 downto 12) <= "0001";
      when "101100" =>  dout(15 downto 12) <= "0111";      when "101101" =>  dout(15 downto 12) <= "1101";
      when "101110" =>  dout(15 downto 12) <= "1101";      when "101111" =>  dout(15 downto 12) <= "1000";
      when "110000" =>  dout(15 downto 12) <= "1111";      when "110001" =>  dout(15 downto 12) <= "1001";
      when "110010" =>  dout(15 downto 12) <= "0001";      when "110011" =>  dout(15 downto 12) <= "0100";
      when "110100" =>  dout(15 downto 12) <= "0011";      when "110101" =>  dout(15 downto 12) <= "0101";
      when "110110" =>  dout(15 downto 12) <= "1110";      when "110111" =>  dout(15 downto 12) <= "1011";
      when "111000" =>  dout(15 downto 12) <= "0101";      when "111001" =>  dout(15 downto 12) <= "1100";
      when "111010" =>  dout(15 downto 12) <= "0010";      when "111011" =>  dout(15 downto 12) <= "0111";
      when "111100" =>  dout(15 downto 12) <= "1000";      when "111101" =>  dout(15 downto 12) <= "0010";
      when "111110" =>  dout(15 downto 12) <= "0100";      when "111111" =>  dout(15 downto 12) <= "1110";
      when others   =>  dout(15 downto 12) <= "1110";
    end case;

    
    case din(17 downto 12) is
      when "000000" =>  dout(11 downto 8) <= "1010";      when "000001" =>  dout(11 downto 8) <= "1101";
      when "000010" =>  dout(11 downto 8) <= "0000";      when "000011" =>  dout(11 downto 8) <= "0111";
      when "000100" =>  dout(11 downto 8) <= "1001";      when "000101" =>  dout(11 downto 8) <= "0000";
      when "000110" =>  dout(11 downto 8) <= "1110";      when "000111" =>  dout(11 downto 8) <= "1001";
      when "001000" =>  dout(11 downto 8) <= "0110";      when "001001" =>  dout(11 downto 8) <= "0011";
      when "001010" =>  dout(11 downto 8) <= "0011";      when "001011" =>  dout(11 downto 8) <= "0100";
      when "001100" =>  dout(11 downto 8) <= "1111";      when "001101" =>  dout(11 downto 8) <= "0110";
      when "001110" =>  dout(11 downto 8) <= "0101";      when "001111" =>  dout(11 downto 8) <= "1010";
      when "010000" =>  dout(11 downto 8) <= "0001";      when "010001" =>  dout(11 downto 8) <= "0010";
      when "010010" =>  dout(11 downto 8) <= "1101";      when "010011" =>  dout(11 downto 8) <= "1000";
      when "010100" =>  dout(11 downto 8) <= "1100";      when "010101" =>  dout(11 downto 8) <= "0101";
      when "010110" =>  dout(11 downto 8) <= "0111";      when "010111" =>  dout(11 downto 8) <= "1110";
      when "011000" =>  dout(11 downto 8) <= "1011";      when "011001" =>  dout(11 downto 8) <= "1100";
      when "011010" =>  dout(11 downto 8) <= "0100";      when "011011" =>  dout(11 downto 8) <= "1011";
      when "011100" =>  dout(11 downto 8) <= "0010";      when "011101" =>  dout(11 downto 8) <= "1111";
      when "011110" =>  dout(11 downto 8) <= "1000";      when "011111" =>  dout(11 downto 8) <= "0001";
      when "100000" =>  dout(11 downto 8) <= "1101";      when "100001" =>  dout(11 downto 8) <= "0001";
      when "100010" =>  dout(11 downto 8) <= "0110";      when "100011" =>  dout(11 downto 8) <= "1010";
      when "100100" =>  dout(11 downto 8) <= "0100";      when "100101" =>  dout(11 downto 8) <= "1101";
      when "100110" =>  dout(11 downto 8) <= "1001";      when "100111" =>  dout(11 downto 8) <= "0000";
      when "101000" =>  dout(11 downto 8) <= "1000";      when "101001" =>  dout(11 downto 8) <= "0110";
      when "101010" =>  dout(11 downto 8) <= "1111";      when "101011" =>  dout(11 downto 8) <= "1001";
      when "101100" =>  dout(11 downto 8) <= "0011";      when "101101" =>  dout(11 downto 8) <= "1000";
      when "101110" =>  dout(11 downto 8) <= "0000";      when "101111" =>  dout(11 downto 8) <= "0111";
      when "110000" =>  dout(11 downto 8) <= "1011";      when "110001" =>  dout(11 downto 8) <= "0100";
      when "110010" =>  dout(11 downto 8) <= "0001";      when "110011" =>  dout(11 downto 8) <= "1111";
      when "110100" =>  dout(11 downto 8) <= "0010";      when "110101" =>  dout(11 downto 8) <= "1110";
      when "110110" =>  dout(11 downto 8) <= "1100";      when "110111" =>  dout(11 downto 8) <= "0011";
      when "111000" =>  dout(11 downto 8) <= "0101";      when "111001" =>  dout(11 downto 8) <= "1011";
      when "111010" =>  dout(11 downto 8) <= "1010";      when "111011" =>  dout(11 downto 8) <= "0101";
      when "111100" =>  dout(11 downto 8) <= "1110";      when "111101" =>  dout(11 downto 8) <= "0010";
      when "111110" =>  dout(11 downto 8) <= "0111";      when "111111" =>  dout(11 downto 8) <= "1100";
      when others   =>  dout(11 downto 8) <= "1100";
    end case;


    case din(11 downto 6) is
      when "000000" =>  dout(7 downto 4) <= "1111";      when "000001" =>  dout(7 downto 4) <= "0011";
      when "000010" =>  dout(7 downto 4) <= "0001";      when "000011" =>  dout(7 downto 4) <= "1101";
      when "000100" =>  dout(7 downto 4) <= "1000";      when "000101" =>  dout(7 downto 4) <= "0100";
      when "000110" =>  dout(7 downto 4) <= "1110";      when "000111" =>  dout(7 downto 4) <= "0111";
      when "001000" =>  dout(7 downto 4) <= "0110";      when "001001" =>  dout(7 downto 4) <= "1111";
      when "001010" =>  dout(7 downto 4) <= "1011";      when "001011" =>  dout(7 downto 4) <= "0010";
      when "001100" =>  dout(7 downto 4) <= "0011";      when "001101" =>  dout(7 downto 4) <= "1000";
      when "001110" =>  dout(7 downto 4) <= "0100";      when "001111" =>  dout(7 downto 4) <= "1110";
      when "010000" =>  dout(7 downto 4) <= "1001";      when "010001" =>  dout(7 downto 4) <= "1100";
      when "010010" =>  dout(7 downto 4) <= "0111";      when "010011" =>  dout(7 downto 4) <= "0000";
      when "010100" =>  dout(7 downto 4) <= "0010";      when "010101" =>  dout(7 downto 4) <= "0001";
      when "010110" =>  dout(7 downto 4) <= "1101";      when "010111" =>  dout(7 downto 4) <= "1010";
      when "011000" =>  dout(7 downto 4) <= "1100";      when "011001" =>  dout(7 downto 4) <= "0110";
      when "011010" =>  dout(7 downto 4) <= "0000";      when "011011" =>  dout(7 downto 4) <= "1001";
      when "011100" =>  dout(7 downto 4) <= "0101";      when "011101" =>  dout(7 downto 4) <= "1011";
      when "011110" =>  dout(7 downto 4) <= "1010";      when "011111" =>  dout(7 downto 4) <= "0101";
      when "100000" =>  dout(7 downto 4) <= "0000";      when "100001" =>  dout(7 downto 4) <= "1101";
      when "100010" =>  dout(7 downto 4) <= "1110";      when "100011" =>  dout(7 downto 4) <= "1000";
      when "100100" =>  dout(7 downto 4) <= "0111";      when "100101" =>  dout(7 downto 4) <= "1010";
      when "100110" =>  dout(7 downto 4) <= "1011";      when "100111" =>  dout(7 downto 4) <= "0001";
      when "101000" =>  dout(7 downto 4) <= "1010";      when "101001" =>  dout(7 downto 4) <= "0011";
      when "101010" =>  dout(7 downto 4) <= "0100";      when "101011" =>  dout(7 downto 4) <= "1111";
      when "101100" =>  dout(7 downto 4) <= "1101";      when "101101" =>  dout(7 downto 4) <= "0100";
      when "101110" =>  dout(7 downto 4) <= "0001";      when "101111" =>  dout(7 downto 4) <= "0010";
      when "110000" =>  dout(7 downto 4) <= "0101";      when "110001" =>  dout(7 downto 4) <= "1011";
      when "110010" =>  dout(7 downto 4) <= "1000";      when "110011" =>  dout(7 downto 4) <= "0110";
      when "110100" =>  dout(7 downto 4) <= "1100";      when "110101" =>  dout(7 downto 4) <= "0111";
      when "110110" =>  dout(7 downto 4) <= "0110";      when "110111" =>  dout(7 downto 4) <= "1100";
      when "111000" =>  dout(7 downto 4) <= "1001";      when "111001" =>  dout(7 downto 4) <= "0000";
      when "111010" =>  dout(7 downto 4) <= "0011";      when "111011" =>  dout(7 downto 4) <= "0101";
      when "111100" =>  dout(7 downto 4) <= "0010";      when "111101" =>  dout(7 downto 4) <= "1110";
      when "111110" =>  dout(7 downto 4) <= "1111";      when "111111" =>  dout(7 downto 4) <= "1001";
      when others   =>  dout(7 downto 4) <= "1001";
    end case;

 
    case din(5 downto 0) is
      when "000000" =>  dout(3 downto 0) <= "1110";      when "000001" =>  dout(3 downto 0) <= "0000";
      when "000010" =>  dout(3 downto 0) <= "0100";      when "000011" =>  dout(3 downto 0) <= "1111";
      when "000100" =>  dout(3 downto 0) <= "1101";      when "000101" =>  dout(3 downto 0) <= "0111";
      when "000110" =>  dout(3 downto 0) <= "0001";      when "000111" =>  dout(3 downto 0) <= "0100";
      when "001000" =>  dout(3 downto 0) <= "0010";      when "001001" =>  dout(3 downto 0) <= "1110";
      when "001010" =>  dout(3 downto 0) <= "1111";      when "001011" =>  dout(3 downto 0) <= "0010";
      when "001100" =>  dout(3 downto 0) <= "1011";      when "001101" =>  dout(3 downto 0) <= "1101";
      when "001110" =>  dout(3 downto 0) <= "1000";      when "001111" =>  dout(3 downto 0) <= "0001";
      when "010000" =>  dout(3 downto 0) <= "0011";      when "010001" =>  dout(3 downto 0) <= "1010";
      when "010010" =>  dout(3 downto 0) <= "1010";      when "010011" =>  dout(3 downto 0) <= "0110";
      when "010100" =>  dout(3 downto 0) <= "0110";      when "010101" =>  dout(3 downto 0) <= "1100";
      when "010110" =>  dout(3 downto 0) <= "1100";      when "010111" =>  dout(3 downto 0) <= "1011";
      when "011000" =>  dout(3 downto 0) <= "0101";      when "011001" =>  dout(3 downto 0) <= "1001";
      when "011010" =>  dout(3 downto 0) <= "1001";      when "011011" =>  dout(3 downto 0) <= "0101";
      when "011100" =>  dout(3 downto 0) <= "0000";      when "011101" =>  dout(3 downto 0) <= "0011";
      when "011110" =>  dout(3 downto 0) <= "0111";      when "011111" =>  dout(3 downto 0) <= "1000";
      when "100000" =>  dout(3 downto 0) <= "0100";      when "100001" =>  dout(3 downto 0) <= "1111";
      when "100010" =>  dout(3 downto 0) <= "0001";      when "100011" =>  dout(3 downto 0) <= "1100";
      when "100100" =>  dout(3 downto 0) <= "1110";      when "100101" =>  dout(3 downto 0) <= "1000";
      when "100110" =>  dout(3 downto 0) <= "1000";      when "100111" =>  dout(3 downto 0) <= "0010";
      when "101000" =>  dout(3 downto 0) <= "1101";      when "101001" =>  dout(3 downto 0) <= "0100";
      when "101010" =>  dout(3 downto 0) <= "0110";      when "101011" =>  dout(3 downto 0) <= "1001";
      when "101100" =>  dout(3 downto 0) <= "0010";      when "101101" =>  dout(3 downto 0) <= "0001";
      when "101110" =>  dout(3 downto 0) <= "1011";      when "101111" =>  dout(3 downto 0) <= "0111";
      when "110000" =>  dout(3 downto 0) <= "1111";      when "110001" =>  dout(3 downto 0) <= "0101";
      when "110010" =>  dout(3 downto 0) <= "1100";      when "110011" =>  dout(3 downto 0) <= "1011";
      when "110100" =>  dout(3 downto 0) <= "1001";      when "110101" =>  dout(3 downto 0) <= "0011";
      when "110110" =>  dout(3 downto 0) <= "0111";      when "110111" =>  dout(3 downto 0) <= "1110";
      when "111000" =>  dout(3 downto 0) <= "0011";      when "111001" =>  dout(3 downto 0) <= "1010";
      when "111010" =>  dout(3 downto 0) <= "1010";      when "111011" =>  dout(3 downto 0) <= "0000";
      when "111100" =>  dout(3 downto 0) <= "0101";      when "111101" =>  dout(3 downto 0) <= "0110";
      when "111110" =>  dout(3 downto 0) <= "0000";      when "111111" =>  dout(3 downto 0) <= "1101";
      when others   =>  dout(3 downto 0) <= "1101";
    end case;
    
    
end process;   
  end mainbody;
  
  
     
  
    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

    
    entity data_change is
        port (
              din		:in std_logic_vector (31 downto 0);
              dout		:out std_logic_vector (47 downto 0)
 
             );
    end data_change;
    
    architecture mainbody of data_change is
    begin
    
   process(din)

 begin
    dout<= din(1-1) & din(32-1) & din(31-1) & din(30-1) & din(29-1) & din(28-1) &
     din(29-1) & din(28-1) & din(27-1) & din(26-1) & din(25-1) & din(24-1) & 
     din(25-1) & din(24-1) & din(23-1) & din(22-1) & din(21-1) & din(20-1) &  
     din(21-1) & din(20-1) & din(19-1) & din(18-1) & din(17-1) & din(16-1) & 
     din(17-1) & din(16-1) & din(15-1) & din(14-1) & din(13-1) & din(12-1) & 
     din(13-1) & din(12-1) & din(11-1) & din(10-1) & din(9-1) & din(8-1) & 
     din(9-1) & din(8-1) & din(7-1) & din(6-1) & din(5-1) & din(4-1) &
     din(5-1) & din(4-1) & din(3-1) & din(2-1) & din(1-1) & din(32-1);



end process;
end mainbody;




    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

    
    entity key_generate is
        port (
              keyin		:in std_logic_vector (55 downto 0);
              keyout		:out std_logic_vector (55 downto 0);
              counter : in std_logic_vector(3 downto 0)
 
             );
    end key_generate;
    
    
    architecture mainbody of key_generate is
    begin
    
   process(keyin)
   
   
   
     begin

    case counter is

      --1
      when "0001" =>  keyout<= keyin(54 downto 28) & keyin (55)           & keyin(26 downto  0) & keyin (27);
      --1
      when "0010" =>  keyout<= keyin(54 downto 28) & keyin (55)           & keyin(26 downto  0) & keyin (27);
    --2
      when "0011" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    --2
      when "0100" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    --2
      when "0101" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    --2
      when "0110" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    -- 2
      when "0111" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    -- 2
      when "1000" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    --1
      when "1001" =>  keyout<= keyin(54 downto 28) & keyin (55)           & keyin(26 downto  0) & keyin (27);
    --2
      when "1010" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    --2
      when "1011" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    --2
          when "1100" => keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    --2
      when "1101" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    --2
      when "1110" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
    --2
      when "1111" =>  keyout<= keyin(53 downto 28) & keyin (55 downto 54) & keyin(25 downto  0) & keyin (27 downto 26);
     --1
      when "0000" =>  keyout<= keyin(54 downto 28) & keyin (55)           & keyin(26 downto  0) & keyin (27);
      when others  =>  keyout<= keyin;
    end case;

end process;
end mainbody;





--the essential module 
----------------------------------------------------------------------------
----------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity data_generate is
    port (clk		:in std_logic;
          reset		:in std_logic;
          counter: in std_logic_vector(3 downto 0);  -- keyin and counter determine the key being used 
          key_in	:in std_logic_vector (55 downto 0);
          din		:in std_logic_vector (63 downto 0);
          dinvld     :in std_logic;	
          dout		:out std_logic_vector (63 downto 0);
          doutvld	:out std_logic;
          key_out: out std_logic_vector (55 downto 0)
       
         );
end data_generate;


architecture mainbody of data_generate is




component key_generate port(

              keyin		:in std_logic_vector (55 downto 0);
              keyout		:out std_logic_vector (55 downto 0);
              counter : in std_logic_vector(3 downto 0)
                    );
    end component;
    
    component keychange2 port(             
              keyin		:in std_logic_vector (55 downto 0);
              keyout		:out std_logic_vector (47 downto 0)
      );
end component;

component S_change port(             
              din		:in std_logic_vector (47 downto 0);
              dout		:out std_logic_vector (31 downto 0)) ;
end component;

component P_change port(           
               din		:in std_logic_vector (31 downto 0);
              dout		:out std_logic_vector (31 downto 0));
end component;
 
 
 component data_change port(
                 din		:in std_logic_vector (31 downto 0);
              dout		:out std_logic_vector (47 downto 0)
 
 );
end component;          
   

  
  --signal data_R_32	:std_logic_vector (31 downto 0) := "0x00000000F";
  signal data_R_48	:std_logic_vector (47 downto 0) := x"000000000000";
  signal data_before_S	:std_logic_vector (47 downto 0) := x"000000000000";
  signal data_after_S	:std_logic_vector (31 downto 0) := x"00000000";
  signal data_R	:std_logic_vector (31 downto 0) := x"00000000";   --?32?
  signal data_L	:std_logic_vector (31 downto 0) := x"00000000";   -- ?32?
    signal data_R1	:std_logic_vector (31 downto 0) := x"00000000";   --?32?
  signal data_L1	:std_logic_vector (31 downto 0) := x"00000000";   -- ?32?
    signal data_R2 :std_logic_vector (31 downto 0) := x"00000000";   --?32?
  --signal data_L2	:std_logic_vector (31 downto 0) := x"00000000";   -- ?32?
  signal data_after_P	:std_logic_vector (31 downto 0) := x"00000000";
  signal data_new_R	:std_logic_vector (31 downto 0) := x"00000000";
 
  signal key_56	:std_logic_vector (55 downto 0) := x"00000000000000";
   signal key_R_56	:std_logic_vector (55 downto 0) := x"00000000000000";
  signal key_R_48	:std_logic_vector (47 downto 0) := x"000000000000";
 
 signal dinvld1,dinvld2,dinvld3 :std_logic := '0';

begin
  
data_R <= din(63 downto 32);
data_L <= din(31 downto 0);

  process (clk, reset)

  begin
    if reset='1' then
     
      dout  <= x"0000000000000000";
      doutvld <= '0';
  
    elsif clk'event and clk='1' then

        if (dinvld ='1') then 
          --cipher function f(R,K) 
        data_before_S <= data_R_48 xor key_R_48;   
           --R'= L xor f(R,K)
           data_L1 <= data_L;
        data_new_R<= data_after_P xor data_L1;   
            --dout = L' and R'   
            data_R1<= data_R;
            data_R2<= data_R1;
    dout <=  data_new_R & data_R2;
           --delay 3 cycle
       end if;
        dinvld1 <= dinvld;
        dinvld2 <= dinvld1;
        doutvld <= dinvld2;
        key_out <= key_R_56; --key??????
     -- else
        --dout <= x"0000000000000000";
       -- doutvld<= dinvld;
     -- end if;
    end if;
    
    end process;  

  --entity1:  IP_change port map (din, data_after_IP);                 
  entity2: data_change port map (data_R, data_R_48);
  
  entity3: S_change port map (data_before_S, data_after_S);
  entity4: P_change port map (data_after_S, data_after_P);
 -- entity5: LP_change port map(data_after_P, data_after_LP);
  
 --entity5: key_change port map(keyin,key_56);
  entity6: key_generate port map(key_in,key_R_56,counter);
  entity7: keychange2 port map(key_R_56,key_R_48);
  
 


end mainbody;







