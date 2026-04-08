# File Input And Upload Safety

## Use For

- camera, gallery, and document intake in Flutter apps
- validating file type, size, and upload boundaries before network transfer
- reducing exposure when user-provided files cross into storage or backend systems

## Default Decisions

- validate before upload
  Check allowed type, size, and count before the network request starts.
- trust content rules, not only file extensions
  Do not assume `.jpg` means safe image input.
- temporary local handling
  Keep user files in the narrowest scope needed and clean up temporary copies.
- central upload client
  Route uploads through a shared service so auth, retry, headers, and logging policies stay consistent.

## Decision Switches

- if the backend can issue short-lived upload URLs, prefer them over long-lived static secrets in the client
- if uploaded files can contain sensitive personal data, reduce previews, caching, and logging
- if metadata is unnecessary, strip or avoid retaining it where feasible
- if the feature accepts many files or large files, pair this pack with upload-progress and failure handling rules

## Example 1: Validate Picked Image Before Preview

```dart
class UnsupportedFileFailure extends AppFailure {
  const UnsupportedFileFailure();
}

class FileTooLargeFailure extends AppFailure {
  const FileTooLargeFailure();
}

class PickedImageGuard {
  static const maxBytes = 5 * 1024 * 1024;
  static const allowedExtensions = {'jpg', 'jpeg', 'png'};

  Future<Result<File>> validate(XFile file) async {
    final extension = file.name.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(extension)) {
      return const FailureResult(UnsupportedFileFailure());
    }

    final bytes = await file.length();
    if (bytes > maxBytes) {
      return const FailureResult(FileTooLargeFailure());
    }

    return Success(File(file.path));
  }
}
```

Why:

- invalid input is rejected before preview or upload
- the feature owns a clear validation policy

## Example 2: Centralized Upload

```dart
class ReceiptUploadService {
  ReceiptUploadService(this._dio);

  final Dio _dio;

  Future<void> uploadReceipt(File file) async {
    final formData = FormData.fromMap({
      'receipt': await MultipartFile.fromFile(
        file.path,
        filename: 'receipt.jpg',
      ),
    });

    await _dio.post('/receipts', data: formData);
  }
}
```

Why:

- upload policy stays in one network boundary
- widgets do not touch multipart details or auth headers

## Review Checklist

- file type, size, and count are checked before upload
- sensitive uploads are excluded from logs and analytics payloads
- upload URLs or auth headers are obtained from app-controlled services
- temporary files are removed when they are no longer needed
- server-side validation still exists even if the client validates first

## Anti-Patterns

- trusting file extensions alone
- logging absolute file paths, signed URLs, or upload headers
- uploading directly from widgets
- storing sensitive captures in long-lived caches without a product reason
