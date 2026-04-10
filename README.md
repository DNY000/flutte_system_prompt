# 🎯 Flutter Prompt Operating System (FPOS)

### *Kỷ luật thép dành cho ứng dụng Flutter chuẩn Enterprise*

Flutter Prompt OS là một bộ khung prompt có độ chính xác cao và nền tảng kiến thức được thiết kế để biến bất kỳ AI nào (Cursor, Claude, GPT) thành một **Chuyên gia Kiến trúc sư Flutter (Senior Lead Flutter Architect)**. Hệ thống này đúc kết nhiều năm kinh nghiệm phát triển các hệ thống lớn thành một quy chuẩn hoạt động rõ ràng.

---

## 🚀 Kiến trúc Cốt lõi (Steel Core)

Hệ thống này không chỉ là một tập hợp các câu lệnh (prompt); nó là một **Hệ điều hành (Operating System)** dành riêng cho lập trình với AI, đảm bảo các tiêu chuẩn:

*   **🛡️ Bảo mật Cấp cao nhất**: Chi tiết triển khai SSL Pinning, luồng xác thực PKCE, và ngăn chặn vượt rào RLS.
*   **🏗️ Kiến trúc Phân tầng**: Tách biệt hoàn toàn UI/Domain/Data đi kèm cơ chế lưu trữ trạng thái bằng Hydrated.
*   **⚡ Hiệu suất Tối ưu**: Tối ưu hóa mạnh mẽ cho engine Impeller và nền tảng web WebAssembly (Wasm).
*   **🤖 Mô hình AI-First**: Tích hợp các pattern thiết kế như Agentic function calling và Generative UI.
*   **🌍 Công nghệ Mới nhất**: Chuẩn hóa để dùng với **Supabase 2.0+**, **Firebase 2026 Ready**, và thư viện đa ngôn ngữ **Slang i18n**.

---

## 🛠️ Hướng dẫn Cài đặt & Cách sử dụng

### Cách 1: Tích hợp Tự động (Dành cho Cursor IDE)
Cách này phù hợp và khuyên dùng khi bạn đang sử dụng **Cursor IDE** để lập trình.
1. Khởi động **Cursor** và Mở thư mục (`Open Folder`) chứa mã nguồn này.
2. File cấu hình `.cursorrules` có sẵn sẽ tự động thực thi. AI của Cursor sẽ lập tức học được mọi quy tắc và kỷ luật kiến trúc chuẩn mực của repo này mà không cần bạn phải làm thêm gì.

### Cách 2: Tích hợp Thủ công (Dành cho Claude / ChatGPT / v.v...)
Sử dụng khi bạn thao tác trên giao diện web hoặc các IDE khác không hỗ trợ `.cursorrules`.
1. Mở file [MASTER_PROMPT.md](./MASTER_PROMPT.md) trong thư mục gốc.
2. Sao chép toàn bộ nội dung trong file.
3. Dán nội dung đó vào **System Prompt** của AI (nếu hỗ trợ) hoặc dùng chính nội dung đó làm tín hiệu khởi động (câu lệnh mở đầu) trong khung chat với AI trước khi bạn yêu cầu tạo code/sửa tính năng.

---

## 📂 Danh mục Hệ thống (System Inventory)

| Phân hệ (Module) | Vị trí thư mục | Trọng tâm |
| :--- | :--- | :--- |
| **Data & Backend** | `docs/ai/08-guides/flutter/data-and-backend/` | Tích hợp Firebase, Supabase, Kiến trúc Offline-First. |
| **Security** | `docs/ai/08-guides/flutter/security/` | SSL Pinning, Xác thực Sinh trắc học, Hardening. |
| **Architecture** | `docs/ai/08-guides/flutter/app-architecture/` | Kiến trúc BLoC, Riverpod, Bảo toàn dữ liệu (Persistence). |
| **Performance** | `docs/ai/08-guides/flutter/performance/` | Wasm, Impeller, Tối ưu DevTools. |
| **Monetization** | `docs/ai/08-guides/flutter/domains/` | Nền tảng thanh toán Stripe, RevenueCat. |

---

## 🛡️ Giấy phép
Mã nguồn được phân phối dưới giấy phép **MIT License**. Bạn có toàn quyền sử dụng, chỉnh sửa để xây dựng các dự án Flutter tốt, bảo mật và nhanh hơn.

---
*Phát triển và bảo trì bởi Agentic Coding Team.*
