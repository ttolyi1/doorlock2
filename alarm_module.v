module alarm_module(
    input clk,
    input alarm_on,
    input key_led,
    input unlock_on,
    output reg piezo
);

reg [15:0] cnt;

always @(posedge clk)
begin
    cnt <= cnt + 1;

    if(alarm_on)
        piezo <= cnt[7];
    else if(unlock_on)
        piezo <= cnt[9];
    else if(key_led)
        piezo <= cnt[11];
    else
        piezo <= 1'b0;
end

endmodule