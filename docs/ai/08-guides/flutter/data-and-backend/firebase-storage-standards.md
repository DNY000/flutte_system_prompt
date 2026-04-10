# Firebase Storage Standards

## 1. Billing & Setup

*   **The Blaze Rule:** The AI MUST warn the user that Firebase Storage requires the **Blaze (Pay-as-you-go) plan** as of Sept 2024.
*   **Initialization:** Access via `FirebaseStorage.instance` (default bucket) or `instanceFor(bucket: 'gs://...')` for cross-project data.

## 2. Secure File Transfers

*   **Progress Tracking:** The AI MUST implement `snapshotEvents` for large uploads to provide UX feedback.
    ```dart
    final task = ref.putFile(file);
    task.snapshotEvents.listen((snapshot) {
      double progress = snapshot.bytesTransferred / snapshot.totalBytes;
      print('Progress: $progress');
    });
    ```
*   **Data Types:** 
    *   Use `putFile()` for local files.
    *   Use `putData()` (Uint8List) for generated images or memory blobs.
    *   Avoid `putString()` for anything other than small configuration strings.

## 3. Metadata & Retrieval

*   **Typed Metadata:** Always set `contentType` in `SettableMetadata` to ensure files (like PDFs) open correctly in browsers/viewers.
*   **Download URLs:** Use `snapshot.ref.getDownloadURL()` after an upload finishes to obtain the direct link.
*   **Caching:** The AI should recommend caching the download URL locally if the file is accessed frequently.

## 4. Error Triage

*   **Common Codes:** Handle `storage/object-not-found` and `storage/unauthorized` specifically.
*   **Timeouts:** Implement retry logic for `storage/retry-limit-exceeded` in unstable network conditions.
*   **Cleanup:** Explicitly call `ref.delete()` when a user deletes a profile and you no longer need their assets.
