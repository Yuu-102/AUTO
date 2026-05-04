#!/bin/bash

# 設定警告門檻 (例如 80%)
THRESHOLD=80

echo "--- 磁碟空間檢查報告 ($(date +'%Y-%m-%d %H:%M:%S')) ---"

# 使用 df 檢查實體磁碟 (-h: 易讀格式, -x: 排除虛擬檔案系統)
df -h -x tmpfs -x devtmpfs | while read -r line; do
    # 跳過標題列
    [[ "$line" =~ "Filesystem" ]] && continue

    # 取得使用百分比 (去掉 % 符號)
    usage=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    # 取得掛載點名稱
    mount_point=$(echo "$line" | awk '{print $6}')

    if [ "$usage" -ge "$THRESHOLD" ]; then
        # 空間不足，顯示紅色警告
        echo -e "\e[31m[危險] 掛載點 $mount_point 使用率已達 $usage%\e[0m"
    else
        # 空間足夠，顯示綠色正常
        echo -e "\e[32m[正常] 掛載點 $mount_point 使用率為 $usage%\e[0m"
    fi
done

echo "------------------------------------------------"
