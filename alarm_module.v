module alarm_module(
    input clk,
    input alarm_on,
    input key_led,
    input unlock_on,
    output reg piezo
);

reg [15:0] tone_cnt;
reg [3:0] beep_cnt;
reg alarm_prev;
reg alarm_active;

always @(posedge clk)
begin

    if(alarm_on && !alarm_prev)
    begin
        alarm_active <= 1'b1;
        beep_cnt <= 4'd0;
        tone_cnt <= 16'd0;
    end

    alarm_prev <= alarm_on;

    if(alarm_active)
    begin
        tone_cnt <= tone_cnt + 1;

        if(tone_cnt >= 16'd100)
        begin
            tone_cnt <= 16'd0;
            piezo <= ~piezo;

            if(piezo)
            begin
                beep_cnt <= beep_cnt + 1;

                if(beep_cnt >= 4'd9)
                begin
                    alarm_active <= 1'b0;
                    piezo <= 1'b0;
                end
            end
        end
    end
    else if(unlock_on)
    begin
        piezo <= tone_cnt[5];
    end
    else if(key_led)
    begin
        piezo <= tone_cnt[7];
    end
    else
    begin
        piezo <= 1'b0;
    end

end

endmodule
