module alarm_module(
    input clk,
    input alarm_on,      // 경보 상태
    input key_led,       // 키 입력 감지
    input unlock_on,     // 잠금 해제 상태

    output reg piezo
);

reg [15:0] cnt;

always @(posedge clk)
begin
    cnt <= cnt + 1;

    // 경보음 (가장 높은 우선순위)
    if(alarm_on)
    begin
        piezo <= cnt[7];
    end

    // 잠금 해제 알림음
    else if(unlock_on)
    begin
        piezo <= cnt[9];
    end

    // 키 입력 비프음
    else if(key_led)
    begin
        piezo <= cnt[11];
    end

    // 무음
    else
    begin
        piezo <= 1'b0;
    end
end

endmodule