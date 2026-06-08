module alarm_module(
    input clk,
    input alarm_on,
    input key_led,
    input unlock_on,
    output reg piezo
);

reg [15:0] cnt;
reg [3:0] beep_count;
reg alarm_prev;
reg alarm_done;

always @(posedge clk)
begin
    cnt <= cnt + 1;

    alarm_prev <= alarm_on;

    if(alarm_on && !alarm_prev)
    begin
        beep_count <= 0;
        alarm_done <= 0;
    end

    if(alarm_on && !alarm_done)
    begin
        if(cnt == 16'd500)
        begin
            cnt <= 0;
            piezo <= ~piezo;

            if(piezo)
            begin
                beep_count <= beep_count + 1;

                if(beep_count == 4)
                begin
                    alarm_done <= 1;
                    piezo <= 0;
                end
            end
        end
    end
    else if(unlock_on)
    begin
        piezo <= cnt[9];
    end
    else if(key_led)
    begin
        piezo <= cnt[11];
    end
    else
    begin
        piezo <= 0;
    end
end

endmodule