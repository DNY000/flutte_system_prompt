# Báo cáo Audit Chi tiết — Folder 2 → 6

**Repo:** `DNY000/flutte_system_prompt` | **Ref:** `main` | **Ngày audit:** 2026-04-08

---

## Mục lục

- [Folder 2 — `agent/`](#folder-2--agent)
- [Folder 3 — `tools/`](#folder-3--tools)
- [Folder 4 — `docs/`](#folder-4--docs)
- [Folder 5 — `missions/`](#folder-5--missions)
- [Folder 6 — `playground/`](#folder-6--playground)

---

## Folder 2 — `agent/`

**Mục đích tổng quát:** Lớp điều phối (orchestration) của Flutter/mobile prompt OS — liên kết định tuyến (routing), kích hoạt skill, tải context và ràng buộc output contract thành một vòng thực thi duy nhất.

### Danh sách file

| # | File | Kích thước ước tính |
|---|------|---------------------|
| 1 | `agent/README.md` | ~60 dòng |
| 2 | `agent/SKILLS.md` | ~60 dòng |

---

### Phân tích từng file

#### `agent/README.md`

**Vai trò & mục đích:**
Tài liệu entry-point của layer agent. Mô tả:
- Bốn entry point chính (Skill index, PowerShell CLI, TypeScript runtime, `.promptos/` runtime state).
- Quy tắc "no duplication": định nghĩa skill **chỉ** sống trong `docs/ai/11-skills/skills/<id>/SKILL.md`.
- Agent roles (ask/plan/execute/review) là *profiles* kết hợp skill, không phải `skill_id` riêng trong `routes.json`.
- Ghi chú về Hermes-style loop (tính năng tương lai).

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Bảng entry-point rõ ràng, phân tầng logic |
| Maintainability | ✅ Ràng buộc "no duplication" rõ — dễ enforce |
| Bảo mật | ✅ Không chứa secret hay logic xử lý — rủi ro thấp |
| Chuẩn hóa | ⚠️ Chưa có version header hay "last updated" |

**Điểm mạnh:**
- Định hướng kiến trúc rõ: tách biệt orchestration (agent) vs. định nghĩa (docs).
- Ghi chú future roadmap (Hermes loop) giữ tầm nhìn dài hạn mà không làm lộn xộn hiện tại.

**Điểm yếu:**
- Không có ngày cập nhật — khó biết khi nào bảng entry-point lỗi thời.
- "Future" Hermes section chưa có link ticket/issue để theo dõi tiến độ.

**Đề xuất cải tiến:**

| Ưu tiên | Hành động |
|---------|-----------|
| P2 | Thêm dòng `> Last updated: YYYY-MM-DD` ở đầu file |
| P2 | Gắn link issue/milestone cho Hermes-style loop future section |
| P3 | Thêm quickstart 2-3 bước (resolve → build → run) ngay trong file này để giảm hành trình tìm hiểu |

---

#### `agent/SKILLS.md`

**Vai trò & mục đích:**
Trang điều hướng (Table of Contents) duy nhất cho toàn bộ skill registry. Phân 3 nhóm:
1. **Core skills** (6): intent-router, context-loader, memory-curator, mcp-orchestrator, quality-grader, source-validator.
2. **Specialist skills** (19): Flutter & mobile delivery.
3. **AI-system skills** (3): prompt-architect, agent-architect, eval-designer.

Mỗi entry là link trực tiếp đến `docs/ai/11-skills/skills/<id>/SKILL.md`.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Phân nhóm rõ, bảng markdown dễ scan |
| Maintainability | ⚠️ Link thủ công — thêm skill mới cần cập nhật 3+ nơi (đây, `routes.json`, skill-registry.md) |
| Bảo mật | ✅ Không có rủi ro bảo mật trực tiếp |
| Chuẩn hóa | ⚠️ Không có cơ chế kiểm tra link tự động (stale link) |

**Điểm mạnh:**
- Single source of navigation: người mới chỉ cần đây để biết các skill tồn tại.
- Format nhất quán với `routes.json` (cùng `skill_id`).

**Điểm yếu:**
- Tổng 28 skill nhưng không có mô tả một dòng → phải click từng link để biết skill làm gì.
- Dễ xảy ra drift nếu thêm skill trong `docs/ai/11-skills` mà quên cập nhật đây.

**Đề xuất cải tiến:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Thêm cột "Mô tả ngắn" (1 dòng) vào mỗi bảng |
| P1 | Thêm check trong CI (`validate-manifest`) để phát hiện skill có `SKILL.md` nhưng thiếu trong `SKILLS.md` |
| P2 | Thêm header version/date như `README.md` |

---

### Tổng kết Folder 2

| Hạng mục | Điểm |
|----------|------|
| Cấu trúc | 4/5 |
| Maintainability | 3/5 |
| Bảo mật | 5/5 |
| Chuẩn hóa | 3/5 |
| **Tổng** | **15/20** |

---

## Folder 3 — `tools/`

**Mục đích tổng quát:** Công cụ thực thi runtime cho hệ thống prompt — gồm PowerShell CLI (`prompt-cli/`) và TypeScript runtime (`prompt-runtime-ts/`). Đây là "bộ máy thực thi" của toàn bộ hệ thống.

### Danh sách file

#### `tools/prompt-cli/`

| # | File | Vai trò tóm tắt |
|---|------|-----------------|
| 1 | `README.md` | Tài liệu CLI đầy đủ |
| 2 | `aiprompt.ps1` | CLI chính (737 dòng PowerShell) |
| 3 | `routes.json` | Manifest định tuyến — source of truth |
| 4 | `flutter-domains.json` | Domain map Flutter cho context loading |
| 5 | `run-evals.ps1` | Chạy eval gates |
| 6 | `evals/benchmark-dataset.json` | Golden route resolution cases |
| 7 | `evals/route-regression.json` | Route regression test cases |
| 8 | `evals/contract-compliance.json` | Contract compliance checks |
| 9 | `evals/multilingual-routing-benchmark.json` | Benchmark đa ngôn ngữ |
| 10 | `evals/quality-thresholds.json` | Ngưỡng chất lượng theo route family |
| 11 | `evals/task-quality-rubric.md` | Rubric chấm điểm output |
| 12 | `evals/telemetry-schema.json` | Schema log telemetry |
| 13 | `evals/trend-baseline.json` | Baseline trend metric |

#### `tools/prompt-runtime-ts/`

| # | File | Vai trò tóm tắt |
|---|------|-----------------|
| 14 | `package.json` | Node.js manifest (TypeScript runtime) |
| 15 | `tsconfig.json` | TypeScript compiler config |
| 16 | `package-lock.json` | Lockfile dependency |
| 17 | `src/types.ts` | Định nghĩa type hệ thống |
| 18 | `src/router.ts` | Logic định tuyến (score pattern, resolve) |
| 19 | `src/skills.ts` | Skill precedence resolution |
| 20 | `src/commands.ts` | Command policies & alignment |
| 21 | `src/index.ts` | CLI entry point TypeScript |
| 22 | `src/normalize.ts` | Text normalization (ASCII fold) |
| 23 | `src/paths.ts` | Path resolution cho manifest |
| 24 | `src/validate-manifest.ts` | Manifest validation gate |
| 25 | `src/router.test.ts` | Unit test cho router |
| 26 | `src/skills.test.ts` | Unit test cho skill precedence |

---

### Phân tích từng file

#### `tools/prompt-cli/README.md`

**Vai trò:** Tài liệu đầy đủ nhất trong repo — hướng dẫn install, mọi command (list-routes, resolve, show-route, build), ví dụ Flutter decision, eval gates và TypeScript runtime.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Phân section rõ, ví dụ code block đầy đủ |
| Maintainability | ⚠️ Ví dụ đường dẫn Windows (`.\aiprompt.ps1`) vs macOS (`pwsh ./aiprompt.ps1`) — cần giữ đồng bộ khi thêm lệnh mới |
| Bảo mật | ✅ Không expose secret |
| Chuẩn hóa | ✅ Nhất quán với routes.json và PowerShell script |

**Điểm mạnh:** Tài liệu onboarding tốt nhất repo, cover đủ từ install đến eval gates.

**Điểm yếu:** Thiếu "quick start" 30-giây ở đầu file (hiện phải đọc nhiều section để bắt đầu nhanh).

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P2 | Thêm "Quick Start (30s)" section ngay sau install |
| P3 | Thêm ví dụ output JSON mẫu cho `resolve -Json` để người mới hiểu cấu trúc |

---

#### `tools/prompt-cli/aiprompt.ps1`

**Vai trò:** CLI chính 737 dòng — xử lý 5 command: `help`, `list-routes`, `resolve`, `show-route`, `build`. Thực hiện scoring bằng token overlap + ASCII folding, load context file từ routes/domains manifest, build prompt package, hỗ trợ Clipboard và file output.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ `Set-StrictMode`, `$ErrorActionPreference = 'Stop'`, hàm phân tách rõ |
| Maintainability | ⚠️ 737 dòng đơn file — hàm dài, khó unit test riêng lẻ trong PowerShell |
| Bảo mật | ✅ Không exec shell động; không eval user input |
| Chuẩn hóa | ✅ Parity algorithm với TypeScript router (`scorePattern`) — đã tài liệu hóa |

**Điểm mạnh:**
- `Set-StrictMode -Version Latest` + `$ErrorActionPreference = 'Stop'` — tốt cho debug sớm.
- Parity intent rõ ràng với TS router.
- Hỗ trợ đa platform (Windows + macOS via `pwsh`).

**Điểm yếu:**
- 737 dòng trong một file duy nhất → khó test từng function riêng.
- Không có Pester test hoặc test PowerShell nào cho aiprompt.ps1.
- Đường dẫn hardcode Windows backslash (`'docs\ai'`) trong một số chỗ — có thể gặp vấn đề trên Unix dù đã có `Join-Path`.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Thêm Pester test cho hàm scoring và route resolution |
| P2 | Tách module: `router.psm1`, `builder.psm1` để dễ test và maintain |
| P2 | Kiểm tra và thay thế hardcode backslash bằng `Join-Path` nhất quán |
| P3 | Thêm `#Requires -Version 7.0` hoặc check version PowerShell rõ ràng |

---

#### `tools/prompt-cli/routes.json`

**Vai trò:** Source of truth duy nhất cho toàn bộ route manifest — định nghĩa `routeId`, `taskType`, `primaryIntent`, `outputContract`, `taskPrompt`, `skills[]`, `riskLevel`, `queryPatterns[]`, và `contextFiles[]` tùy chọn.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Schema nhất quán, tất cả field bắt buộc có mặt |
| Maintainability | ✅ Validated bởi `validate-manifest.ts` — CI gate tốt |
| Bảo mật | ✅ Chỉ là data config, không chứa logic |
| Chuẩn hóa | ✅ `primaryIntent` theo taxonomy chuẩn từ `routing-rules.md` |

**Điểm mạnh:**
- Mỗi route được validate tự động (file tồn tại, skill có SKILL.md, contract khớp docs).
- Cấu trúc phẳng JSON dễ query và extend.

**Điểm yếu:**
- Không có JSON Schema file (`.schema.json`) đi kèm — IDE không tự validate.
- `queryPatterns` dạng string thô — không có cơ chế kiểm tra overlap/conflict giữa các route.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Tạo `routes.schema.json` và thêm `$schema` field → IDE autocomplete + validation |
| P2 | Thêm check trong `validate-manifest` để cảnh báo khi 2 route có pattern giống hệt nhau |
| P3 | Thêm field `description` ngắn cho mỗi route để IDE/docs tự render |

---

#### `tools/prompt-cli/flutter-domains.json`

**Vai trò:** Domain map Flutter — ánh xạ `domainId` → `sectionId`, `sectionIndex`, `routeHints`, `queryPatterns`, `files[]`. Dùng bởi `aiprompt.ps1` khi build context package theo domain.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Schema nhất quán |
| Maintainability | ⚠️ Không có validation tự động (file domain có tồn tại không?) |
| Bảo mật | ✅ Config data thuần túy |
| Chuẩn hóa | ⚠️ Chưa có JSON Schema đi kèm |

**Điểm mạnh:** Tách biệt domain mapping khỏi route manifest — dễ mở rộng.

**Điểm yếu:** `files[]` trong mỗi domain chưa được kiểm tra tự động bởi `validate-manifest` → dễ stale khi tái cấu trúc docs.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Mở rộng `validate-manifest.ts` để kiểm tra `files[]` trong `flutter-domains.json` |
| P2 | Tạo `flutter-domains.schema.json` |

---

#### `tools/prompt-cli/run-evals.ps1`

**Vai trò:** Script chạy toàn bộ eval gates: route regression, multilingual routing, contract compliance, doc sync, threshold/baseline sanity. Là "CI guard" chính của hệ thống prompt.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ `Set-StrictMode`, phân hàm rõ, thu thập lỗi vào list rồi báo cáo cuối |
| Maintainability | ⚠️ Phụ thuộc PowerShell — CI runner cần có `pwsh` |
| Bảo mật | ✅ Không exec dynamic, đọc file local |
| Chuẩn hóa | ✅ Tích hợp với `.github/workflows/prompt-evals.yml` |

**Điểm mạnh:** Comprehensive — kiểm tra từ route → contract → doc sync → threshold.

**Điểm yếu:**
- Không có exit code theo convention (0/1) — cần verify.
- Không có timeout khi gọi `aiprompt.ps1` từng query (eval chậm nếu thêm nhiều case).

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Verify và document exit code convention (0 = pass, 1 = fail) |
| P2 | Thêm timeout per-query (`-TimeoutSec`) khi gọi `Resolve-RouteId` |
| P3 | Thêm summary report format (pass/fail count, % pass rate) để CI log dễ đọc |

---

#### `tools/prompt-cli/evals/route-regression.json`

**Vai trò:** Golden test cases — mỗi `(query, expectedRouteId)` là một case regression đảm bảo route resolution không bị phá vỡ khi thay đổi `queryPatterns`.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Schema đơn giản, rõ intent |
| Maintainability | ✅ Dễ thêm case mới |
| Bảo mật | ✅ Test data, không rủi ro |
| Chuẩn hóa | ✅ `suite` field để định danh |

**Điểm mạnh:** Là safety net khi refactor queryPatterns.

**Điểm yếu:** Chưa có coverage metric — không biết bao nhiêu % route được cover.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Thêm check trong `run-evals.ps1` để cảnh báo các route chưa có golden case |
| P2 | Thêm trường `notes` tùy chọn để ghi lý do chọn query này |

---

#### `tools/prompt-cli/evals/contract-compliance.json`

**Vai trò:** Kiểm tra mỗi `routeId` → `outputContract` map có nhất quán không giữa `routes.json` và `output-contracts.md`.

**Đề xuất:** P2 — Thêm case cho contract có section nhưng không route nào dùng (orphan contract detection).

---

#### `tools/prompt-cli/evals/multilingual-routing-benchmark.json`

**Vai trò:** Benchmark routing với query đa ngôn ngữ — đảm bảo normalize text hoạt động với tiếng Việt, tiếng Nhật, v.v.

**Điểm mạnh:** Hiếm thấy trong hệ thống prompt — rất có giá trị cho globalization.

**Đề xuất:** P2 — Thêm nhiều case Vietnamese hơn vì đây là ngữ cảnh sử dụng chính.

---

#### `tools/prompt-cli/evals/quality-thresholds.json`

**Vai trò:** Định nghĩa ngưỡng chất lượng tối thiểu theo route family (`decision`: 2.8, `implementation`: 3.0, v.v.) và `minimumCriterionFloor: 2.0`.

**Điểm mạnh:** Tách ngưỡng khỏi logic → dễ điều chỉnh không cần sửa code.

**Điểm yếu:** `manualQualityAverage: null` trong trend-baseline — chưa được đo thực tế.

**Đề xuất:** P1 — Thiết lập quy trình rubric scoring thực tế và điền `manualQualityAverage`.

---

#### `tools/prompt-cli/evals/task-quality-rubric.md`

**Vai trò:** Rubric chấm điểm output (0–4) theo 7 tiêu chí, có trọng số theo route family.

**Điểm mạnh:** Rubric rõ ràng, có scale và pass guidance.

**Điểm yếu:** Chưa có ví dụ cụ thể cho mỗi điểm số (ví dụ: "điểm 2 decision quality trông như thế nào").

**Đề xuất:** P2 — Thêm ít nhất 1 ví dụ mẫu cho điểm 2 và 4 mỗi tiêu chí.

---

#### `tools/prompt-cli/evals/telemetry-schema.json`

**Vai trò:** JSON Schema cho log entry telemetry — định nghĩa `requiredFields` và `optionalFields`.

**Điểm yếu:** Là schema mô tả, chưa có validator tích hợp để check log thực tế tuân thủ không.

**Đề xuất:** P3 — Tích hợp telemetry schema validation vào `run-evals.ps1`.

---

#### `tools/prompt-cli/evals/trend-baseline.json`

**Vai trò:** Lưu baseline metric theo version — `routeRegressionPassRate: 1.0`, `contractCompliancePassRate: 1.0`, `manualQualityAverage: null`.

**Điểm yếu:** `manualQualityAverage: null` — chưa được điền sau first scoring cycle.

**Đề xuất:** P1 — Sau khi chạy rubric scoring lần đầu, điền `manualQualityAverage`.

---

#### `tools/prompt-runtime-ts/package.json`

**Vai trò:** Node.js manifest — định nghĩa scripts (`build`, `check`, `test`, `validate-manifest`), devDependencies (`typescript ~6.0.2`, `@types/node ~22.19.17`).

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ `"private": true` — không publish nhầm; `"type": "module"` nhất quán với ESM |
| Maintainability | ✅ Tilde range (`~`) pin minor version |
| Bảo mật | ✅ Chỉ devDependencies, không runtime deps |
| Chuẩn hóa | ✅ Script names nhất quán với docs |

**Điểm mạnh:** Dependency tối thiểu (chỉ TS + @types/node) — zero attack surface runtime.

**Điểm yếu:** TypeScript `~6.0.2` là phiên bản rất mới — cần verify stability.

**Đề xuất:** P2 — Thêm `"engines": { "node": ">=20" }` để pin Node version requirement.

---

#### `tools/prompt-runtime-ts/tsconfig.json`

**Vai trò:** TypeScript compiler config — `strict: true`, `target: ES2020`, `module: NodeNext`, `outDir: dist`.

**Chất lượng:** ✅ Strict mode bật, `NodeNext` module resolution phù hợp ESM. `skipLibCheck: true` là pragmatic nhưng có thể ẩn type error từ thư viện.

**Đề xuất:** P3 — Cân nhắc tắt `skipLibCheck` khi TS version ổn định để bắt lỗi sớm hơn.

---

#### `tools/prompt-runtime-ts/src/types.ts`

**Vai trò:** Central type definitions — `RouteDef`, `RoutesManifest`, `RouteMatch`, `RuntimeCommand`, `CommandPolicy`, `RuntimeExplain`, `RuntimeResult`.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Type-only file, không logic |
| Maintainability | ✅ Single source of truth cho type system |
| Bảo mật | ✅ Không rủi ro |
| Chuẩn hóa | ✅ `RiskLevel` là union type, không magic string |

**Điểm mạnh:** Kiến trúc type-first tốt — thay đổi shape data → compile error ngay.

**Điểm yếu:** `contextFiles?: string[]` trong `RouteDef` là `optional` — nếu logic phụ thuộc vào nó cần defensive check.

**Đề xuất:** P3 — Thêm JSDoc comment ngắn cho từng interface.

---

#### `tools/prompt-runtime-ts/src/router.ts`

**Vai trò:** Logic routing cốt lõi — `scorePattern()`, `bestScoresPerRoute()`, `topRouteCandidates()`, `resolveRoute()`. Parity với PowerShell `aiprompt.ps1`.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Pure functions, không side effect |
| Maintainability | ✅ Mỗi function có JSDoc, logic nhỏ |
| Bảo mật | ✅ Không exec, không dynamic eval |
| Chuẩn hóa | ✅ Thuật toán được document trong `routing-algorithm.md` |

**Điểm mạnh:** Pure functions dễ test, không mutation. Tie-breaking rõ ràng (manifest order).

**Điểm yếu:** `scorePattern` scoring formula (`matches * 10 - penalty`) chưa có test cho edge case (empty query, unicode input).

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Thêm test case: empty query, unicode query, single-token query |
| P2 | Extract scoring constants (1000, 10) thành named constants |

---

#### `tools/prompt-runtime-ts/src/skills.ts`

**Vai trò:** `resolveSkillsByPrecedence()` — merge skill lists theo thứ tự project > global > built-in, dedup bằng `Set`.

**Chất lượng:** ✅ Logic đơn giản, có test đầy đủ, JSDoc rõ.

**Điểm mạnh:** Dedup-by-first-occurrence đúng behavior được document và test.

**Điểm yếu:** Không validate `skillId` format (không whitespace, lowercase-kebab).

**Đề xuất:** P3 — Thêm assertion hoặc warning khi `skillId` không match `[a-z0-9-]+`.

---

#### `tools/prompt-runtime-ts/src/commands.ts`

**Vai trò:** `COMMAND_POLICIES[]` — ánh xạ command (`ask/plan/review/execute/ship-check`) với preferred task types và contracts. `evaluateCommandRouteAlignment()` sinh warnings/hints. `parseCommand()` validate input.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Data-driven policies, logic tách biệt |
| Maintainability | ✅ Thêm command mới = thêm 1 entry trong array |
| Bảo mật | ✅ `parseCommand` throw khi invalid command |
| Chuẩn hóa | ✅ Policies nhất quán với `command-routing-map.md` |

**Điểm yếu:** Không có unit test cho `evaluateCommandRouteAlignment`.

**Đề xuất:** P1 — Thêm test cho `evaluateCommandRouteAlignment` (case warning vs. hint).

---

#### `tools/prompt-runtime-ts/src/index.ts`

**Vai trò:** CLI entry point — parse args, load manifest, resolve route, resolve skills, build `RuntimeResult`, output JSON.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Tách rõ parse / resolve / output |
| Maintainability | ⚠️ Arg parsing thủ công (không dùng `commander` hay yargs) — dễ bug khi thêm flag |
| Bảo mật | ✅ Không exec dynamic, path được resolve qua `paths.ts` |
| Chuẩn hóa | ✅ Usage string đầy đủ |

**Điểm yếu:** `usage()` throws Error — không phải `process.exit(1)`. Có thể bị bắt nhầm ở cấp trên.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P2 | Dùng `process.stderr.write(usageMsg)` + `process.exit(1)` thay vì throw trong `usage()` |
| P2 | Xem xét migrate sang `parseArgs` (Node.js built-in) để tránh manual indexOf |
| P3 | Thêm `--version` flag |

---

#### `tools/prompt-runtime-ts/src/normalize.ts`

**Vai trò:** `normalizeText()` — NFD decompose → strip accents → lowercase → replace non-alphanum bằng space → trim.

**Chất lượng:** ✅ Pure function, không side effect. Xử lý tiếng Việt/accent đúng qua NFD.

**Điểm mạnh:** Minimal và đúng kỹ thuật.

**Điểm yếu:** Không có test riêng cho normalize (chỉ tested gián tiếp qua router tests).

**Đề xuất:** P2 — Thêm unit test trực tiếp cho `normalizeText` (input tiếng Việt, CJK, emoji).

---

#### `tools/prompt-runtime-ts/src/paths.ts`

**Vai trò:** `defaultRoutesManifestPath()` — resolve path đến `routes.json` từ `dist/` directory. `resolveRoutesManifestPath()` — ưu tiên CLI flag > env `PROMPT_ROUTES_MANIFEST` > default.

**Chất lượng:** ✅ Resolution chain rõ ràng, document trong README. `fileURLToPath(import.meta.url)` đúng với ESM.

**Điểm yếu:** Không validate path tồn tại ở đây (validation ở `index.ts` khi `readFileSync`).

**Đề xuất:** P3 — Thêm test cho `resolveRoutesManifestPath` với các kịch bản env variable.

---

#### `tools/prompt-runtime-ts/src/validate-manifest.ts`

**Vai trò:** Comprehensive manifest validator — check: duplicate routeId, empty queryPatterns, file tồn tại (taskPrompt, contextFiles, skill SKILL.md), contract section trong output-contracts.md, doc table sync, taskPrompt prefix, rubric/threshold file tồn tại.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Collect-all-errors pattern (không fail fast) — báo đủ lỗi một lần |
| Maintainability | ✅ Mỗi check là block riêng, dễ thêm/bỏ |
| Bảo mật | ✅ Chỉ đọc file, không write |
| Chuẩn hóa | ✅ Exit code 1 khi fail — CI friendly |

**Điểm mạnh:** Là safety net quan trọng nhất toàn hệ thống — ngăn broken references.

**Điểm yếu:** Không validate `flutter-domains.json` files[] — xem phần flutter-domains.json.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Mở rộng để validate `flutter-domains.json` files[] tồn tại |
| P1 | Thêm check `agent/SKILLS.md` có list đủ tất cả skill trong routes.json không |
| P2 | Thêm unit test cho `parseContractDocTable` và `parseContractSectionNames` |

---

#### `tools/prompt-runtime-ts/src/router.test.ts` và `skills.test.ts`

**Vai trò:** Unit tests sử dụng Node.js built-in `node:test` — không cần test framework external.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Mini-manifest pattern (không phụ thuộc file system) |
| Maintainability | ✅ Assert rõ ràng, test name descriptive |
| Bảo mật | ✅ Không rủi ro |
| Chuẩn hóa | ✅ `node:test` + `node:assert/strict` — zero dep |

**Điểm mạnh:** Zero external test dependency — chạy ngay với Node.js.

**Điểm yếu:** Coverage thấp — `commands.ts` và `normalize.ts` chưa có test.

**Đề xuất:** P1 — Thêm test cho `commands.ts` và `normalize.ts`.

---

### Tổng kết Folder 3

| Hạng mục | Điểm |
|----------|------|
| Cấu trúc | 5/5 |
| Maintainability | 3/5 |
| Bảo mật | 5/5 |
| Chuẩn hóa | 4/5 |
| **Tổng** | **17/20** |

---

## Folder 4 — `docs/`

**Mục đích tổng quát:** Toàn bộ knowledge base của hệ thống — system prompt, routing rules, skill definitions, memory, templates, guides Flutter, roadmap, releases. Đây là "não" của hệ thống — chiếm ~80% tổng số file repo.

### Cấu trúc thư mục

```
docs/ai/
├── 00-core/          (24 files) — Core engine rules
├── 01-context/       (1 file)   — Project context
├── 02-tasks/         (24 files) — Task prompts per route
├── 03-memory/        (6 files)  — Memory layer
├── 04-templates/     (4 files)  — Output templates
├── 05-index/         (1 file)   — Query index
├── 06-examples/      (1 file)   — Route examples
├── 07-references/    (1 file)   — Source map
├── 08-guides/        (~50 files)— Flutter & AI system guides
├── 09-roadmap/       (7 files)  — Dev roadmap & task backlog
├── 10-releases/      (2 files)  — Changelog
├── 11-skills/        (~35 files)— Skill definitions
└── README.md + prompt-system-blueprint.md
```

---

### Phân tích theo subfolder

#### `docs/ai/00-core/` — Core Engine (24 files)

**Tổng quan:** Đây là lớp quan trọng nhất — định nghĩa behavior của AI agent ở mức thấp nhất.

| File | Vai trò | Chất lượng |
|------|---------|------------|
| `system-prompt.md` | System prompt gốc — identity, global rules, execution order, output format | ✅ Rõ ràng, có numbered execution order |
| `rules.md` | Ruleset đầy đủ | ✅ Comprehensive |
| `rules_1k.md` | Bản rút gọn 1K token | ✅ Cho context ngắn |
| `rules_4k.md` | Bản rút gọn 4K token | ✅ |
| `rules_10k.md` | Bản đầy đủ 10K token | ✅ |
| `routing-rules.md` | Phân loại intent, route schema, taxonomy | ✅ Nguồn tham chiếu cho routes.json |
| `routing-algorithm.md` | Thuật toán scoring chi tiết | ✅ Parity reference cho PS và TS |
| `decision-engine.md` | Logic decision cho task phức tạp | ✅ |
| `answer-policies.md` | Policy trả lời: depth, format, assumptions | ✅ |
| `output-contracts.md` | Định nghĩa tất cả output contracts | ✅ Source of truth cho contracts |
| `output-rules.md` | Rules format output | ✅ |
| `skill-registry.md` | Registry và activation rules | ✅ |
| `skill-contracts.md` | Contract chi tiết từng skill | ✅ |
| `skill-precedence-policy.md` | Policy precedence skill | ✅ |
| `context-loading-rules.md` | Rules tải context | ✅ |
| `memory-write-policy.md` | Policy ghi memory | ✅ |
| `mcp-research-policy.md` | Policy dùng MCP/research | ✅ |
| `observability-policy.md` | Policy logging/observability | ✅ |
| `operating-model.md` | Mô hình vận hành tổng thể | ✅ |
| `response-depth-policy.md` | Policy độ sâu response | ✅ |
| `token-rules.md` | Rules quản lý token budget | ✅ |
| `prompt-versioning-policy.md` | Policy versioning prompt | ✅ |
| `prompt-release-checklist.md` | Checklist release prompt | ✅ |
| `self-analysis-protocol.md` | Protocol tự phân tích | ✅ |

**Điểm mạnh:**
- Phân chia policy theo chức năng rõ ràng (không nhồi tất cả vào 1 file).
- Có 3 phiên bản token-tiered (1K/4K/10K) của rules — linh hoạt cho các context size khác nhau.
- Cross-reference giữa các file (routing-algorithm.md ↔ routing-rules.md ↔ routes.json).

**Điểm yếu:**
- Không có index/summary của 00-core để người mới biết đọc file nào trước.
- Không có "version" header để biết file nào là mới nhất so với rules.md variants.
- Thiếu date/version trong nhiều file — khó audit khi nào file được cập nhật lần cuối.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Tạo `00-core/INDEX.md` mô tả mục đích và thứ tự đọc 24 files |
| P2 | Thêm `> Version: X.Y | Updated: YYYY-MM-DD` header vào mỗi file |
| P2 | Liên kết rõ 3 phiên bản rules (1K/4K/10K) với nhau và với rules.md chính |
| P3 | Kiểm tra consistency: rules trong `rules.md` có được phản ánh đủ trong bản 1K/4K không |

---

#### `docs/ai/01-context/project-context.md`

**Vai trò:** Context cụ thể của project — dùng khi build prompt package cho các task cần project-aware decisions.

**Đề xuất:** P2 — Ensure được cập nhật khi thêm feature/module mới vào hệ thống.

---

#### `docs/ai/02-tasks/` — Task Prompts (24 files)

**Tổng quan:** Mỗi file tương ứng 1 `taskPrompt` trong `routes.json`. Đây là "instruction set" cho từng loại task.

| File | Route | Vai trò |
|------|-------|---------|
| `design.md` | design-screen, design-system | Instruction thiết kế UI/UX |
| `code.md` | code-implement | Instruction viết code |
| `architecture.md` | architecture | Instruction thiết kế architecture |
| `testing.md` | test-plan | Instruction viết test |
| `security.md` | security-audit | Instruction security audit |
| `performance.md` | performance-audit | Instruction performance audit |
| `ci-cd.md` | ci-cd | Instruction CI/CD |
| `debug-triage.md` | debug-triage | Instruction debug |
| `research.md` | research | Instruction research |
| `ba.md` | ba | Business analyst instructions |
| `flutter-framework-decision.md` | flutter-framework-decision | Decision framework API |
| `flutter-widget-decision.md` | widget-decision | Decision widget selection |
| `state-management-decision.md` | state-management-decision | Decision state management |
| `package-selection.md` | package-selection | Package selection instructions |
| `custom-vs-package.md` | custom-vs-package | Custom vs. package decision |
| `pattern-selection.md` | pattern-selection | Design pattern selection |
| `code-organization.md` | code-organization | Code organization instructions |
| `module-design.md` | module-design | Module design instructions |
| `add-to-app.md` | add-to-app | Add-to-app integration |
| `plugin-authoring.md` | plugin-authoring | Plugin authoring instructions |
| `offline-sync.md` | offline-sync | Offline sync instructions |
| `web-desktop-strategy.md` | web-desktop-strategy | Web/desktop platform |
| `agent-system.md` | agent-system | AI agent system design |
| `ai-evals.md` | ai-evals | AI eval design |
| `class-split-decision.md` | class-split-decision | Class split decision |
| `prompt-system.md` | prompt-system | Prompt system design |

**Chất lượng tổng thể:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Mỗi file focused vào 1 task type |
| Maintainability | ⚠️ Không có template chuẩn cho task prompt → format có thể khác nhau giữa các file |
| Bảo mật | ✅ Text instructions, không rủi ro |
| Chuẩn hóa | ⚠️ Validate bởi `validate-manifest` (file tồn tại), nhưng chưa kiểm tra internal format |

**Điểm mạnh:** Tách biệt hoàn toàn instruction set theo task — thay đổi 1 task không ảnh hưởng others.

**Điểm yếu:**
- Không có template chuẩn cho structure của task prompt file.
- Không có test tự động kiểm tra task prompt có section bắt buộc không.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Tạo `task-prompt-template.md` với sections bắt buộc |
| P2 | Thêm validate trong CI để check task prompt có section header chuẩn |
| P2 | Thêm date/version header mỗi file |

---

#### `docs/ai/03-memory/` — Memory Layer (6 files)

| File | Vai trò |
|------|---------|
| `decisions.md` | Log các quyết định kiến trúc đã đưa ra |
| `patterns.md` | Patterns đã được dùng và validate |
| `mistakes.md` | Lỗi đã gặp để tránh lặp lại |
| `modules.md` | Module knowledge base |
| `glossary.md` | Thuật ngữ dùng trong hệ thống |
| `memory-governance.md` | Rules quản lý memory layer |
| `incident-to-memory-loop.md` | Quy trình từ incident → memory update |

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Tách biệt theo loại memory |
| Maintainability | ⚠️ Phụ thuộc vào AI agent tự update — không có human review process |
| Bảo mật | ✅ Text content, không rủi ro |
| Chuẩn hóa | ⚠️ `memory-governance.md` định nghĩa rules nhưng không có enforcement mechanism |

**Điểm mạnh:** `incident-to-memory-loop.md` là pattern enterprise-grade hiếm thấy.

**Điểm yếu:** Không có định kỳ memory pruning/audit để loại bỏ outdated entries.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P2 | Thêm quarterly memory audit process vào `memory-governance.md` |
| P2 | Thêm `lastVerified` field vào entries trong `decisions.md` và `patterns.md` |

---

#### `docs/ai/04-templates/` — Output Templates (4 files)

| File | Vai trò |
|------|---------|
| `master-prompt-template.md` | Template tổng hợp prompt đầy đủ |
| `request-template.md` | Template cho request chuẩn |
| `route-resolution-template.md` | Template route resolution output |
| `contract-shells.md` | Shell templates cho các output contract |

**Điểm mạnh:** Template-driven approach giúp output nhất quán.

**Điểm yếu:** Chưa có version trong template name → khó migrate khi thay đổi format.

**Đề xuất:** P2 — Đổi tên theo convention `<template-name>-v<N>.md` để track version.

---

#### `docs/ai/05-index/query-index.md`

**Vai trò:** Index tra cứu query → route nhanh, supplement cho `routes.json`.

**Đề xuất:** P2 — Kiểm tra xem có thể auto-generate từ `routes.json` queryPatterns để luôn in sync.

---

#### `docs/ai/06-examples/route-examples.md`

**Vai trò:** Ví dụ route resolution cụ thể — giúp người mới hiểu routing behavior.

**Đề xuất:** P2 — Thêm ví dụ output JSON thực tế (output của CLI) bên cạnh query.

---

#### `docs/ai/07-references/source-map.md`

**Vai trò:** Map nguồn tài liệu → route/skill — dùng khi `IncludeReferences` flag.

**Đề xuất:** P3 — Verify source-map còn accurate sau mỗi restructure docs.

---

#### `docs/ai/08-guides/` — Flutter & AI Guides (~50 files)

**Tổng quan:** Knowledge base chuyên sâu chia thành:
- `flutter/` — 8 sections: app-architecture, data-and-backend, deployment, domains, packages-and-plugins, performance, platform-integration, security, testing-and-debugging, ui.
- `ai-systems/` — 6 files: agent-orchestration, context-memory-and-mcp, evals-and-regression, examples, prompt-optimization, index.
- `flutter-complete-rulebook.md` — Rulebook tổng hợp.
- `flutter-decision-handbook.md` — Handbook decision.
- `mobile-gap-analysis.md` — Gap analysis mobile.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Hierarchy rõ: section → index → leaf docs |
| Maintainability | ⚠️ ~50 files, cần process review định kỳ khi Flutter API thay đổi |
| Bảo mật | ⚠️ `security/` section — cần verify không có outdated security advice |
| Chuẩn hóa | ✅ Mỗi section có `index.md` + `examples.md` |

**Điểm mạnh:**
- Comprehensive coverage của Flutter ecosystem.
- Pattern nhất quán: index + examples cho mỗi section.
- `mobile-gap-analysis.md` — self-aware về những gì còn thiếu.

**Điểm yếu:**
- Không có "last reviewed against Flutter version X.Y" trong mỗi guide → dễ outdated.
- `security/` guides cần review tần suất cao hơn (security landscape thay đổi nhanh).

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P0 | Thêm Flutter version metadata vào mỗi section index.md |
| P1 | Schedule review định kỳ (quarterly) cho `security/` section |
| P1 | Tạo `08-guides/flutter/REVIEW-LOG.md` để track lần review cuối mỗi section |
| P2 | Validate links nội bộ không bị broken sau restructure |

---

#### `docs/ai/09-roadmap/` — Roadmap (7 files)

| File | Vai trò |
|------|---------|
| `completion-master-plan.md` | Master plan tổng thể |
| `pass-01.md` ~ `pass-05.md` | Từng pass/iteration của development |
| `task-backlog.md` | Backlog task chờ xử lý |

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Phân iteration rõ |
| Maintainability | ⚠️ Roadmap trong file markdown không đồng bộ với GitHub Issues |
| Bảo mật | ✅ Không rủi ro |
| Chuẩn hóa | ⚠️ Không có status field rõ (done/in-progress/blocked) |

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P2 | Migrate `task-backlog.md` sang GitHub Issues/Projects để có tracking tốt hơn |
| P2 | Thêm status (✅/🔄/⛔) vào mỗi task trong pass files |

---

#### `docs/ai/10-releases/` — Releases (2 files)

| File | Vai trò |
|------|---------|
| `CHANGELOG.md` | Log thay đổi theo version |
| `release-baseline-template.md` | Template cho release note |

**Điểm mạnh:** Có CHANGELOG — tốt cho traceability.

**Điểm yếu:** Không có process tự động generate CHANGELOG từ commit message (e.g., conventional commits).

**Đề xuất:** P2 — Áp dụng Conventional Commits + tự động generate CHANGELOG khi release.

---

#### `docs/ai/11-skills/` — Skill Definitions (~35 files)

**Cấu trúc:**
```
11-skills/
├── README.md
├── skill-catalog.md       — Catalog L1/L2/L3
├── agents/                — 4 agent role files
├── commands/              — command-routing-map.md + README
├── hooks/                 — README
├── plugins/               — plugin-schema.json + README
└── skills/                — 28 folders, mỗi folder 1 SKILL.md
```

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ One-folder-per-skill — không duplicate |
| Maintainability | ✅ `validate-manifest` check SKILL.md tồn tại |
| Bảo mật | ✅ |
| Chuẩn hóa | ✅ Convention `skills/<id>/SKILL.md` nhất quán |

**Điểm mạnh:** Kiến trúc "no duplication" được enforce tốt qua validate-manifest.

**Điểm yếu:**
- `hooks/` và `plugins/` chỉ có README — chưa có implementation.
- `plugin-schema.json` chưa được validate trong CI.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P2 | Thêm validate `plugin-schema.json` trong `validate-manifest.ts` |
| P3 | Implement hooks system (nếu cần) hoặc mark rõ là "future" |

---

### Tổng kết Folder 4

| Hạng mục | Điểm |
|----------|------|
| Cấu trúc | 5/5 |
| Maintainability | 3/5 |
| Bảo mật | 4/5 |
| Chuẩn hóa | 3/5 |
| **Tổng** | **15/20** |

---

## Folder 5 — `missions/`

**Mục đích tổng quát:** Định nghĩa task có phạm vi — goal, constraints, route hint, success criteria và optional eval cases. Là bridge giữa high-level intent và hệ thống routing/prompt.

### Danh sách file

| # | File |
|---|------|
| 1 | `missions/README.md` |
| 2 | `missions/example-mission.yaml` |

---

### Phân tích từng file

#### `missions/README.md`

**Vai trò:** Hướng dẫn ngắn về cách dùng `missions/` — put one mission per file, naming convention `<mission-id>.yaml`, link đến canonical routing và example.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Ngắn gọn, đủ ý |
| Maintainability | ✅ Chỉ là guidance, không logic |
| Bảo mật | ✅ |
| Chuẩn hóa | ⚠️ Chưa định nghĩa rõ schema YAML bắt buộc |

**Điểm mạnh:** Ngắn, đúng trọng tâm — không bloat với thông tin không cần.

**Điểm yếu:**
- Không có JSON/YAML Schema file cho missions.
- Không giải thích lifecycle: mission được consume bởi CLI như thế nào (chỉ note "canonical routing still lives in docs/ai").

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Tạo `missions/mission.schema.yaml` định nghĩa các field bắt buộc/tùy chọn |
| P2 | Thêm section "How a mission flows into the CLI" với ví dụ command |
| P2 | Thêm ví dụ mission thực tế hơn (ví dụ: offline sync module) |

---

#### `missions/example-mission.yaml`

**Vai trò:** Example mission duy nhất — `goal: "Design and review a Flutter login screen with Material 3"`, route hint `design-screen`, constraints, `definition_of_done`, `optional_eval_cases`.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ YAML sạch, field hợp lý |
| Maintainability | ✅ Dễ copy-paste để tạo mission mới |
| Bảo mật | ✅ |
| Chuẩn hóa | ⚠️ Chưa được validate bởi bất kỳ tool nào |

**Điểm mạnh:** `definition_of_done` field — tốt cho acceptance criteria rõ ràng.

**Điểm yếu:**
- `primary_route_hint: design-screen` nhưng không được validate với routes.json.
- `optional_eval_cases` reference đến eval file nhưng không check file tồn tại.
- Thiếu field: `priority`, `assignee`, `status`, `created_at`.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Validate `primary_route_hint` tồn tại trong `routes.json` khi parse mission |
| P1 | Validate `optional_eval_cases` paths tồn tại |
| P2 | Thêm field `status: draft|active|completed` và `created_at` |
| P3 | Thêm thêm 2-3 mission example cho các route type khác (code, architecture, security) |

---

### Tổng kết Folder 5

| Hạng mục | Điểm |
|----------|------|
| Cấu trúc | 4/5 |
| Maintainability | 3/5 |
| Bảo mật | 5/5 |
| Chuẩn hóa | 2/5 |
| **Tổng** | **14/20** |

---

## Folder 6 — `playground/`

**Mục đích tổng quát:** Môi trường thử nghiệm — experiments, demos, scratch prompts. Không phải release artifact.

### Danh sách file

| # | File |
|---|------|
| 1 | `playground/README.md` |
| 2 | `playground/showcase-route-resolve.md` |

---

### Phân tích từng file

#### `playground/README.md`

**Vai trò:** Định nghĩa mục đích playground và suggested use cases — thử queryPatterns mới, draft mission YAML, giữ showcase nhỏ gọn.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Ngắn, rõ mục đích |
| Maintainability | ✅ Guidance ổn định không cần cập nhật thường xuyên |
| Bảo mật | ✅ Tuyên bố rõ "not a release artifact" |
| Chuẩn hóa | ⚠️ Không có template/format cho file playground |

**Điểm mạnh:** Ranh giới rõ: "Playground ≠ production" — giảm nguy cơ merge nhầm code thử nghiệm.

**Điểm yếu:**
- Không có link từ playground → missions/ khi showcase "trở thành stable".
- Không định nghĩa "small" là bao nhiêu dòng/section.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P2 | Thêm quy trình "graduate to missions/": "Khi showcase stable, tạo mission YAML và link ở đây" |
| P3 | Thêm naming convention cho file playground (ví dụ: `experiment-<topic>-YYYY-MM.md`) |

---

#### `playground/showcase-route-resolve.md`

**Vai trò:** Demo workflow end-to-end: `resolve` query → `build` prompt package → TypeScript runtime với `--command plan`.

**Chất lượng:**

| Tiêu chí | Đánh giá |
|----------|----------|
| Cấu trúc | ✅ Step-by-step rõ ràng |
| Maintainability | ⚠️ Commands hardcode đường dẫn tương đối — dễ out-of-date nếu restructure |
| Bảo mật | ✅ Không chứa secret hay sensitive info |
| Chuẩn hóa | ⚠️ Không có expected output — người dùng không biết kết quả đúng trông như thế nào |

**Điểm mạnh:** Cover đủ 3 execution paths (PowerShell, PowerShell + flags, TypeScript) trong 1 file.

**Điểm yếu:**
- Thiếu expected output mẫu cho từng command.
- Không có "Prerequisites" section (cần Node.js version gì, pwsh version gì).
- TypeScript command thiếu `--explain` flag example — tính năng hữu ích chưa được showcase.

**Đề xuất:**

| Ưu tiên | Hành động |
|---------|-----------|
| P1 | Thêm expected JSON output mẫu sau mỗi command |
| P1 | Thêm "Prerequisites" section với version requirements |
| P2 | Thêm Step 4: TypeScript với `--explain` flag để showcase top candidates |
| P3 | Thêm Step 5: validate-manifest run để đóng vòng workflow |

---

### Tổng kết Folder 6

| Hạng mục | Điểm |
|----------|------|
| Cấu trúc | 4/5 |
| Maintainability | 3/5 |
| Bảo mật | 5/5 |
| Chuẩn hóa | 2/5 |
| **Tổng** | **14/20** |

---

## Tổng kết toàn bộ Audit

### Bảng điểm tổng hợp

| Folder | Cấu trúc | Maintainability | Bảo mật | Chuẩn hóa | Tổng |
|--------|----------|-----------------|---------|------------|------|
| Folder 2: `agent/` | 4/5 | 3/5 | 5/5 | 3/5 | **15/20** |
| Folder 3: `tools/` | 5/5 | 3/5 | 5/5 | 4/5 | **17/20** |
| Folder 4: `docs/` | 5/5 | 3/5 | 4/5 | 3/5 | **15/20** |
| Folder 5: `missions/` | 4/5 | 3/5 | 5/5 | 2/5 | **14/20** |
| Folder 6: `playground/` | 4/5 | 3/5 | 5/5 | 2/5 | **14/20** |
| **Tổng** | **22/25** | **15/25** | **24/25** | **14/25** | **75/100** |

---

### Top Priority Actions (P0/P1)

| Ưu tiên | Hành động | Folder |
|---------|-----------|--------|
| **P0** | Thêm Flutter version metadata vào `docs/ai/08-guides/flutter/` section indexes | `docs/` |
| **P1** | Tạo `routes.schema.json` cho `routes.json` validation trong IDE | `tools/` |
| **P1** | Thêm column mô tả ngắn vào `agent/SKILLS.md` | `agent/` |
| **P1** | Mở rộng `validate-manifest` để check `flutter-domains.json` files[] và `SKILLS.md` sync | `tools/` |
| **P1** | Tạo `missions/mission.schema.yaml` và validate `primary_route_hint` trong CLI | `missions/` |
| **P1** | Thêm expected output mẫu vào `playground/showcase-route-resolve.md` | `playground/` |
| **P1** | Thêm test cho `commands.ts`, `normalize.ts`, `validate-manifest` functions | `tools/` |
| **P1** | Tạo `docs/ai/00-core/INDEX.md` | `docs/` |
| **P1** | Điền `manualQualityAverage` sau rubric scoring cycle đầu tiên | `tools/` |
| **P1** | Thêm Pester test cho `aiprompt.ps1` scoring functions | `tools/` |

---

### Nhận định chung

**Điểm mạnh nổi bật của toàn hệ thống:**
1. **Kiến trúc "no-duplication"** được enforce tốt qua `validate-manifest`.
2. **Bảo mật cao** — không có secret, không exec dynamic, không runtime deps.
3. **Parity rõ ràng** giữa PowerShell và TypeScript router.
4. **Coverage tools toàn diện**: eval gates, rubric, telemetry schema, trend baseline.

**Điểm yếu hệ thống cần ưu tiên:**
1. **Test coverage thấp**: `aiprompt.ps1` không có Pester test; `commands.ts`, `normalize.ts` chưa có unit test.
2. **Chuẩn hóa chưa đồng đều**: missions/ và playground/ thiếu schema validation.
3. **Maintainability guide docs**: không có version/date header — khó audit lần cập nhật cuối.
4. **Routing quality không được đo thực tế** (`manualQualityAverage: null`).

---

*Báo cáo được tạo tự động bởi Copilot Coding Agent — 2026-04-08*
