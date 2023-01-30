module keyboard(
	input clk,
	input clrn,
	input [19:0] rdaddr,
	input ps2_clk,
	input ps2_data,
	input we,
	output [7:0] key_code,
	output [7:0] dbg_key,
	output [7:0] dbg_data,
	output [7:0] dbg_code
);

	assign dbg_key = count;
	assign dbg_data = tail;
	assign dbg_code = cur_key;

	reg [7:0] buffer [35:0];
	wire [7:0] tail;
	
	assign tail = buffer[32];
	
	wire sign_shift;
	wire sign_caps;
	wire sign_ctrl;
	wire [7:0] cur_key;
	wire [7:0] key_count;
	wire [7:0] ascii_key;
	wire ready;
	
	mykeyboard mykey(clk, clrn, ps2_clk, ps2_data, key_count, cur_key, ascii_key, sign_shift, sign_caps, sign_ctrl, ready);
	
	reg [7:0] count = 8'b00000000;
	
	// write to the buffer
	always @ (posedge ps2_clk)
	begin
		
		buffer[33] <= sign_shift;
		buffer[34] <= sign_caps;
		
		if (count == 1)
		begin
			if (cur_key != 8'h00 && cur_key != 8'hf0 && cur_key != 8'h12 && cur_key != 8'h59 && cur_key != 8'h58)
			begin
				count <= count + 1;
				buffer[tail] <= cur_key;
				if (buffer[32] == 8'h1f)
				begin
					buffer[32] <= 0;
				end
				else 
				begin
					buffer[32] <= buffer[32] + 1;
				end
			end
		end
		else if (count == 8'h0a)
		begin
			count <= 0;
		end
		else
		begin
			count <= count + 1;
		end
	end
	
	// read to the cpu
	assign key_code = buffer[rdaddr];

endmodule


module mykeyboard(input clk,
	input clrn,
	input ps2_clk,
	input ps2_data,
	output reg [7:0] key_count,
	output reg [7:0] cur_key,
	output reg [7:0] ascii_key,
	output reg sign_shift,
	output reg sign_caps,
	output reg sign_ctrl,
	output ready_
	);

// add your definitions here
reg [7:0] lastdata;
wire [7:0] keydata;
reg last = 0;
wire [7:0] ascii;
wire [7:0] ascii_b;
wire ready;
reg nextdata_n;
wire overflow;
reg start = 0; 

//scancode to ascii conversion, will be initialized by the testbench
scancode_rom myram(cur_key, clk, ascii);
sancode_ram_b myram_b(cur_key, clk, ascii_b);

//PS2 interface, you may need to specify the inputs and outputs
ps2_keyboard mykey(clk, clrn, ps2_clk, ps2_data, keydata, ready, nextdata_n, overflow);

assign ready_ = ready;

initial
	sign_caps = 0;

// add you code here
always @ (posedge ps2_clk)
begin
    if (start == 0)
    begin
        cur_key <= 0;
        lastdata <= 0;
        start <= 1;
    end
	 
    if (clrn == 0)
    begin
        key_count <= 0;
    end
    else if (ready == 1)
    begin
        nextdata_n <= 0;
		  
		  if ((keydata == 8'h12 || keydata == 8'h59) && lastdata != 8'hf0 && sign_shift == 0 && last == 0)
		  begin
				sign_shift <= 1;
		  end
		  
		  if (keydata == 8'h58 && lastdata != 8'hf0)
		  begin
				if (sign_caps == 0)
				begin
					sign_caps <= 1;
				end
				else if (sign_caps == 1)
				begin
					sign_caps <= 0;
				end
		  end
		  
		  if (keydata == 8'h14 && lastdata != 8'hf0 && sign_ctrl == 0)
		  begin
				sign_ctrl <= 1;
		  end
		  
        if (keydata == 8'hf0)
        begin
				cur_key <= keydata;
            lastdata <= keydata;
        end
        else if (lastdata == 8'hf0)
        begin
				if (keydata == 8'h12 || keydata == 8'h59)
				begin
					sign_shift <= 0;
					last <= 1;
				end
				else if (keydata == 8'h14)
				begin
					sign_ctrl <= 0;
				end
				cur_key <= 0;
				lastdata <= 0;
        end
        else
        begin
				if (last == 1 && (keydata == 8'h12 || keydata == 8'h59))
				begin
					last <= 0;
					lastdata <= 0;
					cur_key <= 0;
				end
				else
				begin
            if (keydata != cur_key)
            begin
                key_count <= key_count + 1;
            end
            lastdata <= cur_key;
            cur_key <= keydata;
				end
        end
    end
    else
    begin
        nextdata_n <= 1;
    end
end

always @ (posedge ps2_clk)
begin
	if (sign_shift == 1 || sign_caps == 1)
	begin
		ascii_key <= ascii_b;
	end
	else
		ascii_key <= ascii;
end

endmodule


//standard ps2 interface
module ps2_keyboard(clk,clrn,ps2_clk,ps2_data,data,ready,nextdata_n,overflow);
    input clk,clrn,ps2_clk,ps2_data;
	 input nextdata_n;
    output [7:0] data;
    output reg ready;
    output reg overflow;     // fifo overflow  
    // internal signal, for test
    reg [9:0] buffer;        // ps2_data bits
    reg [7:0] fifo[7:0];     // data fifo
	 reg [2:0] w_ptr,r_ptr;   // fifo write and read pointers	
    reg [3:0] count;  // count ps2_data bits
    // detect falling edge of ps2_clk
    reg [2:0] ps2_clk_sync;
    
    always @(posedge clk) begin
        ps2_clk_sync <=  {ps2_clk_sync[1:0],ps2_clk};
    end

    wire sampling = ps2_clk_sync[2] & ~ps2_clk_sync[1];
    
    always @(posedge clk) begin
        if (clrn == 0) begin // reset 
            count <= 0; w_ptr <= 0; r_ptr <= 0; overflow <= 0; ready<= 0;
        end 
		else if (sampling) begin
            if (count == 4'd10) begin
                if ((buffer[0] == 0) &&  // start bit
                    (ps2_data)       &&  // stop bit
                    (^buffer[9:1])) begin      // odd  parity
                    fifo[w_ptr] <= buffer[8:1];  // kbd scan code
                    w_ptr <= w_ptr+3'b1;
                    ready <= 1'b1;
                    overflow <= overflow | (r_ptr == (w_ptr + 3'b1));
                end
                count <= 0;     // for next
            end else begin
                buffer[count] <= ps2_data;  // store ps2_data 
                count <= count + 3'b1;
            end      
        end
        if ( ready ) begin // read to output next data
				if(nextdata_n == 1'b0) //read next data
				begin
				   r_ptr <= r_ptr + 3'b1; 
					if(w_ptr==(r_ptr+1'b1)) //empty
					     ready <= 1'b0;
				end           
        end
    end

    assign data = fifo[r_ptr];
endmodule 