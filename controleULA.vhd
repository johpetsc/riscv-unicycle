library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;

entity controleULA is 
	port(
		opin		:	in std_logic_vector(31 downto 0);
		ALUOp		:	in std_logic_vector(1 downto 0);
		
		opout	:	out std_logic_vector(3 downto 0)
	);
end controleULA;

architecture rtl of controleULA is
	signal aux	:	std_logic_vector(3 downto 0);
	signal func :  std_logic_vector(3 downto 0);

	begin
		opout <= aux;
		func <= opin(30) & opin(14 downto 12);
	proc_ctrl_ula:	process (func, ALUOp, aux)

	begin
		if(ALUOp = "00") then -- LW e SW
			aux <= "";
		elsif(ALUOp = "01") then --beq
			aux <= "";
		else
			case func is
				when "0000"	=>	aux	<= "0000"; -- ADD
				when "1000"	=>	aux	<=	"0001"; -- SUB	
				when "0111"	=>	aux	<=	"0010"; -- AND
				when "0110"	=> aux   <= "0011"; -- OR
				when "0100"	=> aux 	<= "0100"; -- XOR
				when "0001"	=> aux 	<= "0101"; -- SLL
				when "0101"	=> aux 	<= "0110"; -- SRL
				when "1101"	=> aux	<= "0111"; -- SRA
				when "0010"	=>	aux	<= "1000"; -- SLT
				when "0011"	=> aux 	<= "1001"; -- SLTU
				when ""	=> aux 	<= "1010"; -- SGE
				when ""	=> aux 	<= "1011"; -- SGEU
				when ""	=> aux 	<= "1100"; -- SEQ
				when ""	=> aux 	<= "1101"; -- SNE
			end case;
		end if;
	end process;
end rtl;