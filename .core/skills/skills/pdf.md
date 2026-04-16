# Document Analysis & Extraction Specialist

## Purpose & Domain
Expertise in managing, manipulating, and extracting information from Portable Document Format (PDF) files. This covers a wide range of operations including content extraction (text, tables, images), document structure modification (merging, splitting, rotating), and advanced document creation and security.

## Professional Workflow
1. **Requirement Assessment**: Identify the nature of the PDF (digital-native vs. scanned), the required output format (text, table, image, or new PDF), and any security constraints (encryption/passwords).
2. **Strategy Selection**:
    - **Digital-native**: Direct extraction of text and structured data.
    - **Scanned**: Optical Character Recognition (OCR) workflow (conversion to images followed by text recognition).
3. **Core Operations**:
    - **Extraction**: Isolate specific elements like text blocks, tabular data, or embedded images.
    - **Manipulation**: Perform structural changes such as merging multiple files, splitting a single file into parts, or rotating pages for correct orientation.
    - **Creation**: Generate new documents from scratch or from existing content, applying styling, layouts, and metadata.
    - **Security & Integrity**: Implement encryption, password protection, or digital watermarking.
4. **Data Refinement**: Clean and structure extracted data (especially tables) for downstream consumption in formats like CSV, Excel, or databases.
5. **Verification**: Validate that the extracted content maintains its intended meaning and that structural changes haven't corrupted the document.

## Core Principles & Standards
- **Layout Awareness**: When extracting text or tables, prioritize preserving the visual and logical layout of the original document to ensure data integrity.
- **Structural Integrity**: Ensure that operations like merging or splitting do not inadvertently alter the document's internal hierarchy or metadata.
- **Data Precision**: Use specialized methods for table extraction to handle complex grid structures and merged cells accurately.
- **OCR Quality**: For scanned documents, ensure high-resolution image conversion before performing character recognition to minimize errors.
- **Security Best Practices**: Apply appropriate levels of encryption and access controls based on the sensitivity of the document content.
- **Metadata Management**: Properly handle and preserve document metadata (author, title, subject) during all processing stages.

## Decision Logic
- **Extraction Method**: Choose between direct text extraction (for digital files) and OCR-based workflows (for scanned/image-based files).
- **Data Type Focus**: Decide between extracting raw text (for search/indexing) or structured tables (for data analysis/processing).
- **Transformation Type**: Determine if the task requires structural modification (merging/splitting), content enhancement (watermarking/rotation), or document generation.
- **Security Level**: Determine the necessity and strength of encryption based on the document's classification and intended use.
