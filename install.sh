#!/bin/bash

# ==========================================
# 🎯 FPOS - Flutter Prompt OS Installer
# ==========================================

echo "🚀 Bắt đầu cài đặt Flutter Prompt OS (FPOS)..."

# Kiểm tra xem có phải project Flutter không (cảnh báo nhẹ)
if [ ! -f "pubspec.yaml" ]; then
    echo "⚠️ Cảnh báo: Không tìm thấy pubspec.yaml. Bạn có chắc đây là thư mục gốc của dự án Flutter không?"
fi

# Tạo thư mục tạm để tải hệ thống
TMP_DIR=$(mktemp -d)
echo "📥 Đang tải các cấu hình hệ thống từ GitHub..."

# Git clone ẩn đi toàn bộ dự án vào thư mục tạm
git clone --depth 1 "https://github.com/DNY000/flutte_system_prompt.git" "$TMP_DIR" > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "❌ Lỗi: Không thể tải mã nguồn từ GitHub. Vui lòng kiểm tra kết nối mạng."
    rm -rf "$TMP_DIR"
    exit 1
fi

echo "📦 Đang tích hợp FPOS vào dự án của bạn..."

# Sao chép các tệp cần thiết
cp "$TMP_DIR/.cursorrules" . 2>/dev/null
cp -r "$TMP_DIR/docs" . 2>/dev/null
cp "$TMP_DIR/MASTER_PROMPT.md" . 2>/dev/null

# Dọn dẹp thư mục tạm
rm -rf "$TMP_DIR"

echo "✅ Cài đặt FPOS hoàn tất thành công!"
echo "👉 Hướng dẫn tiếp theo:"
echo "   - Nếu bạn dùng Cursor IDE: Hãy mở lại dự án (Restart) để .cursorrules hoạt động."
echo "   - Nếu bạn dùng AI khác: Mở file MASTER_PROMPT.md để lấy nội dung System Prompt."
