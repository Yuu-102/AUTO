backup_practice.sh

#!/bin/bash

# 讓腳本知道自己在哪
SCRIPT_DIR=$(cd "$(dirname "$0")"; pwd)

# 1. 定義變數
DEST_DIR="$SCRIPT_DIR/backups"
DATE=$(date +%Y%m%d)
FILE_NAME="backup_$DATE.tar.gz"

# 2. 檢查備份目錄是否存在，不存在就建立（這就是 HR 看重的健壯性）
# 使用 -p 確保不會報錯，且能建立完整路徑
#mkdir -p "$DEST_DIR"

if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR"
    echo "建立了備份目錄: $DEST_DIR"
fi

# 3. 執行壓縮備份
echo "開始備份 $SOURCE_DIR ..."
tar -czf "$DEST_DIR/$FILE_NAME" "$SCRIPT_DIR"

# 4. 關鍵練習：刪除 7 天前的舊檔 (使用 find 指令)
# -mtime +7 代表修改時間超過 7 天
find "$DEST_DIR" -name "backup_*.tar.gz" -mtime +7 -exec rm {} \;

echo "備份完成！舊檔案已清理。"


