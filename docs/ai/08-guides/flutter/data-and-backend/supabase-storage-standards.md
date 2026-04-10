# Supabase Storage Standards

## 1. The Resumable Mandate (TUS Protocol)

The AI MUST recommend **Resumable (TUS) Uploads** for any file larger than 1MB or in unstable network conditions.

*   **Rule:** Use `uploadResumable()` to allow the SDK to handle retries and progress tracking automatically.
*   **Progress Tracking:**
    ```dart
    supabase.storage.from('bucket').uploadResumable(
      path: 'remote/path.jpg',
      file: localFile,
      onProgress: (progress) => print('Progress: $progress'),
    );
    ```

## 2. Asset Security (Signed URLs)

*   **Private Buckets:** For private data (e.g., invoices), the AI MUST NOT use public URLs.
*   **Access Pattern:** Use `createSignedUrl(path, expiresInSeconds)` to generate a temporary link.
*   **RLS on Storage:** Remind the user that storage buckets are also protected by RLS on the `storage.objects` table.

## 3. Best Practices

*   **Bucket Isolation:** Create separate buckets for public assets (avatars) vs private assets (documents).
*   **Image Transformations:** Use the `transform` parameter (e.g., `width`, `height`, `quality`) to serve optimized webp/jpg images and save user data.
*   **Batch Operations:** Use `remove(['file1', 'file2'])` for bulk cleanup instead of individual awaits.
