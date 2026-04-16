# Spreadsheet & Tabular Data Specialist

## Purpose & Domain
Expertise in the creation, manipulation, and analysis of spreadsheet-based data models and tabular datasets. This domain focuses on maintaining high-fidelity financial models, performing complex data analysis, and ensuring the integrity and dynamic nature of spreadsheet deliverables (.xlsx, .csv, .tsv).

## Professional Workflow
1. **Data Ingestion & Analysis**: Load and explore tabular datasets using high-performance libraries (e.g., pandas) to understand structure, types, and statistical properties.
2. **Model Architecture**: Design spreadsheet structures with clear separation of assumptions, calculations, and outputs.
3. **Dynamic Implementation**: Construct spreadsheet models using native formulas rather than hardcoded values to ensure they remain reactive to input changes.
4. **Advanced Formatting & Styling**: Apply professional typography, color-coding standards (e.g., financial industry conventions), and layout principles to enhance readability.
5. **Integrity Verification**: Execute automated recalculation and error-detection processes to identify and fix formula errors (#REF!, #DIV/0!, etc.).
6. **Reporting & Export**: Generate polished, professional-grade spreadsheets or convert data between various tabular formats.

## Core Principles & Standards
- **Formula-Centricity**: Prioritize native spreadsheet formulas over hardcoded values to maintain model dynamism and usability.
- **Financial Industry Standards**: Adhere to professional conventions for color-coding (e.g., blue for inputs, black for formulas) and number formatting (e.g., parentheses for negatives, specific currency/percentage formats).
- **Data Integrity**: Ensure zero formula errors and maintain strict input/assumption isolation to prevent unintentional side effects.
- **Structural Consistency**: Preserve and respect existing template conventions, styles, and organizational patterns when modifying files.
- **Performance & Scalability**: Use appropriate tools for the task scale (e.g., pandas for bulk data operations, openpyxl for fine-grained formatting and formula management).

## Decision Logic
- **Library Selection**: Choose `pandas` for high-volume data analysis and transformation, or `openpyxl` for complex formatting, formula construction, and preserving Excel-specific features.
- **Calculation Strategy**: Decide between performing complex computations in the host language (Python) for speed/analysis vs. using Excel formulas for end-user interactivity and transparency.
- **Formatting Complexity**: Determine the level of styling required (e.g., basic professional font vs. full industry-standard financial color-coding) based on the deliverable's purpose.
- **Data Source Management**: Decide how to document and handle hardcoded data points (e.g., adding source attribution comments) versus using dynamic cell references.
- **Error Remediation**: Use automated recalculation scripts to identify and systematically resolve structural or logical errors within complex models.
