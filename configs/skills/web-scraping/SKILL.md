---
name: web-scraping
description: Web scraping strategies and Firecrawl MCP usage for extracting data from websites
---

## Firecrawl MCP Overview

Firecrawl is a powerful web scraping tool. Use it instead of `webfetch` for:
- Scraping multiple pages
- Extracting structured data
- Handling JavaScript-rendered content
- Batch operations

## Available Tools

### 1. `firecrawl_scrape` - Single Page
Best for extracting content from one URL.

```json
{
  "url": "https://example.com",
  "formats": ["markdown"],
  "onlyMainContent": true
}
```

### 2. `firecrawl_batch_scrape` - Multiple Pages
Efficient scraping of multiple URLs with rate limiting.

```json
{
  "urls": ["https://example1.com", "https://example2.com"],
  "options": {
    "formats": ["markdown"],
    "onlyMainContent": true
  }
}
```

### 3. `firecrawl_map` - Discover URLs
Map a website to find all indexed URLs before scraping.

```json
{
  "url": "https://example.com",
  "search": "blog",
  "limit": 100
}
```

### 4. `firecrawl_search` - Web Search
Search the web and optionally extract content from results.

```json
{
  "query": "your search query",
  "limit": 5,
  "scrapeOptions": {
    "formats": ["markdown"]
  }
}
```

### 5. `firecrawl_crawl` - Deep Crawl
Crawl entire websites with depth control.

```json
{
  "url": "https://example.com/blog",
  "maxDepth": 2,
  "limit": 50
}
```

### 6. `firecrawl_extract` - Structured Data
Extract specific data using LLM with schema.

```json
{
  "urls": ["https://example.com/product"],
  "prompt": "Extract product information",
  "schema": {
    "type": "object",
    "properties": {
      "name": { "type": "string" },
      "price": { "type": "number" }
    }
  }
}
```

## When to Use Each Tool

| Task | Tool |
|------|------|
| Get content from one page | `firecrawl_scrape` |
| Scrape list of known URLs | `firecrawl_batch_scrape` |
| Find all URLs on a site | `firecrawl_map` |
| Search web for information | `firecrawl_search` |
| Scrape entire section of site | `firecrawl_crawl` |
| Extract structured data | `firecrawl_extract` |

## Best Practices

1. **Start with `map`** to discover URLs before scraping
2. **Use `onlyMainContent: true`** to reduce noise
3. **Set reasonable limits** to avoid overwhelming sites
4. **Use `markdown` format** for cleaner output
5. **Check `firecrawl_check_crawl_status`** for async operations

## Firecrawl vs WebFetch

| Aspect | Firecrawl | WebFetch |
|--------|-----------|----------|
| Multiple pages | Yes (batch) | No |
| JavaScript rendering | Yes | Limited |
| Structured extraction | Yes (with schema) | No |
| Rate limiting | Built-in | Manual |
| Search capability | Yes | No |
