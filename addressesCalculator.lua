#!/usr/bin/lua
function validateInputs(param1, param2)
	if (param1 == nil or param2 == nil) then
		print('program requires two parameters');
	else
		local R = {ERROR = "error", IPV4 = "IPV4 provided", IPV6 = "IPV6 provided", STRING = "STRING"}
		if (type(param1) ~= "string" or type(param2) ~= "string") then return R.ERROR end	
		local pieces = {param1:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")}
		local pieces2 = {param2:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")}
		local diff = 0;
		local diffTable = {};
		if (#pieces == 4) then
			for _,val in pairs(pieces) do
				if tonumber(val) > 255 then return R.STRING end
			end
			if (#pieces2 == 4) then
				local counter = 1;
				for _,val in pairs(pieces2) do
					if tonumber(val) > 255 then return R.STRING end
					part1 = tonumber(pieces[counter]);
					part2 = tonumber(pieces2[counter]);
					if(counter ~= 1) then
						if(tonumber(pieces[counter]) > (tonumber(pieces2[counter]))) then
							if(tonumber(pieces[counter-1]) > (tonumber(pieces2[counter-1]))) then
							print("second address must be greater than the first one")	
							return;
							end
						end
					end
					counter = counter + 1;
					table.insert(diffTable, part1 - part2);
				end
				for _,val in pairs(diffTable) do
					diff = diff * 256;
					diff = diff + val;
				end;
				print(math.abs(diff));
			else
				print('Second value must be IPV4');
				return;
			end
			return; 
		else
			print('First value must be IPV4');
			return;
		end
	end
end
print(validateInputs(arg[1], arg[2]))
