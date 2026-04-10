# 🎯 Flutter Prompt Operating System (FPOS)

### *Kỷ luật thép dành cho ứng dụng Flutter chuẩn Enterprise*

## 📖 1. Giới thiệu

Flutter Prompt OS (FPOS) là một bộ khung prompt có độ chính xác cao và hệ thống tri thức (knowledge base) chuyên biệt. Nó được thiết kế với mục đích **biến mọi AI (Cursor, Claude, ChatGPT...) thành một Chuyên gia Kiến trúc sư Flutter (Senior Lead Flutter Architect)**.

Hệ thống này không chỉ cung cấp những câu lệnh đơn giản, mà là một quy chuẩn làm việc (Operating System cho AI), chứa đựng những năm kinh nghiệm triển khai các dự án quy mô lớn. Đặc biệt tập trung vào:
*   **Bảo mật**: SSL Pinning, kiến trúc xác thực PKCE.
*   **Kiến trúc**: Phân tầng rạch ròi, kết hợp lưu trữ và khôi phục trạng thái.
*   **Hiệu suất**: Tối ưu engine Impeller và WebAssembly Wasm.

---

## ⚙️ 2. Hướng dẫn Cài đặt

Để hệ thống hoạt động, bạn chỉ cần đưa kho kiến thức của nhánh FPOS này vào dự án của mình. 

### Cách 1: Cài đặt tự động bằng dòng lệnh (Khuyên dùng)
Bạn không cần phải tải thủ công. Chỉ cần mở **Terminal** tại thư mục gốc dự án Flutter của bạn và chạy lệnh sau:

```bash
curl -fsSL https://raw.githubusercontent.com/DNY000/flutte_system_prompt/main/install.sh | bash
```
*(Lệnh này sẽ tự động tải file `.cursorrules`, file `MASTER_PROMPT.md` và thư mục `docs/` cấu trúc dự án về cho bạn).*

### Cách 2: Tích hợp thủ công cho Cursor IDE
1. Hãy chắc chắn bạn đã cài đặt phần mềm **Cursor**.
2. **Clone** repository này hoặc di chuyển toàn bộ nội dung mã nguồn vào thư mục dự án Flutter của bạn.
3. Mở thư mục dự án của bạn bằng Cursor IDE.
4. Xong! File ẩn `.cursorrules` sẽ tự động thực thi cài đặt quy tắc vào nội bộ AI.

### Cách 3: Dành cho công cụ chat như ChatGPT, Claude, Gemini...
1. Truy cập vào file [MASTER_PROMPT.md](./MASTER_PROMPT.md) hoặc thư mục bạn vừa tải bằng lệnh ở trên.
2. Sao chép (Copy) toàn bộ văn bản trong file `MASTER_PROMPT.md`.
3. Bạn đã "cài đặt" thành công. (Xem phần cách dùng để biết tiếp theo phải làm gì).

---

## 🛠️ 3. Cách Sử dụng

Cách dùng cực kỳ đơn giản sau khi bạn đã thiết lập (cài đặt) thành công ở mục trên.

### Với Cursor IDE
Bạn sử dụng công cụ chat (`Cmd/Ctrl + L` hoặc `Cmd/Ctrl + K`) và yêu cầu lập trình chức năng như bình thường. Chẳng hạn: 
- *"Tạo một màn hình đăng nhập với chuẩn FPOS."*
- Hệ thống sẽ tự tra cứu kho tài liệu ở thư mục `/docs/ai/` để viết code.

### Với AI Web (ChatGPT, Claude...)
1. Khởi tạo đoạn chat mới.
2. Tại tin nhắn đầu tiên hoặc ô thiết lập **System Prompt**, dán (paste) toàn bộ nội dung của [MASTER_PROMPT.md](./MASTER_PROMPT.md) mà bạn vừa copy ở mục Cài đặt.
3. Ở tin nhắn thứ hai, đưa ra yêu cầu của bạn (ví dụ: *"Hãy viết giúp tôi luồng xác thực sử dụng Supabase theo chuẩn trên"*).
4. AI sẽ lập tức đóng vai **Flutter Architect** để phục vụ dự án của bạn.

---

## 📂 Danh mục Hệ thống (System Inventory)

Các tài liệu hướng dẫn chuyên sâu để AI tham khảo khi làm việc đã được phân loại trong mục `docs`:
- **Data & Backend**: `docs/ai/08-guides/flutter/data-and-backend/` (Firebase, Supabase...)
- **Security**: `docs/ai/08-guides/flutter/security/` (Bảo mật, SSL Pinning...)
- **Architecture**: `docs/ai/08-guides/flutter/app-architecture/` (BLoC, Riverpod...)

---

## 🛡️ Giấy phép
Mã nguồn FPOS được phân phối dưới giấy phép **MIT License**. Bạn có toàn quyền sử dụng và điều chỉnh.

*Phát triển bởi Agentic Coding Team.*
