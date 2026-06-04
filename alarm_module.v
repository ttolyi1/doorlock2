module alarm_module(
input clk,
input alarm_on,
input key_led,
input unlock_on,
output reg piezo
);

reg [15:0] cnt;
reg [3:0] beep_count;

always @(posedge clk)
begin
cnt <= cnt + 1;

```
if(alarm_on)
begin
    if(beep_count < 5)
    begin
        if(cnt == 16'd500)
        begin
            cnt <= 0;
            piezo <= ~piezo;

            if(piezo == 1'b1)
                beep_count <= beep_count + 1;
        end
    end
    else
    begin
        piezo <= 1'b0;
    end
end
else
begin
    beep_count <= 0;

    if(unlock_on)
        piezo <= cnt[9];
    else if(key_led)
        piezo <= cnt[11];
    else
        piezo <= 1'b0;
end
```

end

endmodule
