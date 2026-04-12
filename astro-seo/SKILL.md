---
name: astro-seo
description: >
  Audits and improves SEO for Astro sites — the `<Seo>` component and JSON-LD
  graph from `@jdevalk/astro-seo-graph`, per-collection sitemaps with git-based
  lastmod, auto-generated Open Graph images, IndexNow submission, schema
  endpoints and a schema map for agent discovery, build-time HTML validation
  (single H1, duplicate title/description detection, schema validation),
  content-collection Zod schemas that enforce SEO field lengths, robots.txt,
  redirects via `_redirects`, FuzzyRedirect on 404, and performance defaults
  (static HTML, zero-JS baseline, No-Vary-Search, font preloading, CDN cache
  headers). Use this skill when the user asks to audit, improve, or set up SEO
  on an Astro site, or mentions "astro seo", "set up SEO for my astro site",
  "JSON-LD graph", "sitemap", "IndexNow", "OG images", "schema endpoints",
  "NLWeb", or when working in an Astro project and discussing `<head>`
  metadata, structured data, or search engine indexing.
---

# Astro SEO

Audits and improves the SEO setup of an Astro site against the full stack described in [Astro SEO: the definitive guide](https://joost.blog/astro-seo-complete-guide/). The skill covers nine areas — technical foundation, structured data, content, site structure, performance, sitemaps and indexing, agent discovery, redirects, and analytics — and produces drop-in code for anything missing or weak.

The opinionated spine of this skill is [`@jdevalk/astro-seo-graph`](https://github.com/jdevalk/seo-graph). Most of the fixes route through it. If the project doesn't use it yet, installing it is the first recommendation.

## Workflow

1. **Detect the project** — confirm this is an Astro site and understand its shape.
2. **Audit** — score nine categories and produce actionable findings.
3. **Improve** — generate or modify files to close the gaps.
4. **Readability pass** — invoke `readability-check` on any prose the skill generated (titles, descriptions, schema `description` fields, FAQ entries).
5. **Verify** — run the build, check validations pass, remind the user about non-file tasks (Search Console, Bing Webmaster Tools, IndexNow key verification).

---

## Phase 0: Detect the project

Confirm the basics before auditing:

- `astro.config.mjs` / `astro.config.ts` exists.
- `package.json` has `astro` as a dependency.
- Content collections in `src/content/` (or legacy `src/pages/` markdown).
- Deployment target — Cloudflare Pages, Vercel, Netlify, static host? Redirects and cache headers differ.
- Does the project already use `@jdevalk/astro-seo-graph`? If yes, check version and which features are wired.

Ask only what you can't detect. Don't ask the user what the site is about — read `astro.config.mjs` and the homepage content.

---

## Phase 1: Audit

Score each category out of 10. For each, give 2–4 specific findings that quote the actual code or config.

### 1. `<Seo>` component and head metadata (/10)

- Single component for all head metadata, or scattered across layouts?
- Uses `@jdevalk/astro-seo-graph`'s `<Seo>` component, or hand-rolled?
- Canonical URLs derived from `site` config with tracking params stripped?
- `robots` meta includes `max-snippet:-1`, `max-image-preview:large`, `max-video-preview:-1`?
- Canonical omitted when `noindex` is true?
- Twitter tags suppressed when they duplicate Open Graph?
- `hreflang` present if multilingual?

### 2. Structured data / JSON-LD graph (/10)

- Single flat `Article` object, or a linked `@graph` with multiple entities?
- Entities wired with `@id` references?
- `WebSite`, `Blog`/`WebPage`, `Person`/`Organization`, `BlogPosting`/`Article`, `BreadcrumbList`, `ImageObject` all present where relevant?
- Trust signals: `publishingPrinciples`, `copyrightHolder`, `copyrightYear`, `knowsAbout`, `SearchAction`?
- Validates in [Rich Results Test](https://search.google.com/test/rich-results) and [ClassySchema](https://classyschema.org/Visualisation)?

### 3. Content collections and SEO schema (/10)

- Content collections defined with Zod schemas?
- `seoSchema` from `@jdevalk/astro-seo-graph` enforcing title (5–120) and description (15–160) lengths?
- Required fields (`publishDate`, `title`, `excerpt`) enforced at build time?
- Markdown-stripped `articleBody` exposed in schema endpoints (up to 10K chars)?

### 4. Open Graph images (/10)

- Every page has an OG image, or many missing?
- 1200×675 (Google Discover minimum 1200px wide, 16:9 ratio)?
- Generated at build time via satori + sharp, or manual?
- JPEG (social platforms don't reliably support WebP/AVIF)?
- Route derives OG URL from the slug automatically?

### 5. Sitemaps and indexing (/10)

- `@astrojs/sitemap` installed?
- Split per-collection via `chunks` option (`sitemap-posts-0.xml`, `sitemap-videos-0.xml`, etc.)?
- `lastmod` populated from git commit timestamps, not frontmatter dates or CI file timestamps?
- IndexNow integrated and submitting on each build?
- IndexNow key verification route at `/[key].txt`?
- `robots.txt` references sitemap index and schema map?

### 6. Agent discovery (/10)

- Schema endpoints (`/schema/*.json`) exposing corpus-wide JSON-LD?
- Schema map (`/schemamap.xml`) listing all endpoints?
- `<link rel="nlweb">` pointing to a conversational endpoint?
- `Schemamap:` directive in robots.txt?

### 7. Performance (/10)

- Static output by default (no SSR on pages that don't need it)?
- Zero client-side JS unless an island requires it?
- Astro `<Image>` component used for all content images (responsive srcset, WebP, lazy, async)?
- Primary web font preloaded in woff2?
- `<ClientRouter />` with `defaultStrategy: 'viewport'` for prefetch?
- Hashed assets under `/_astro/` serve `Cache-Control: public, max-age=31536000, immutable`?
- `No-Vary-Search` response header stripping UTM parameters from cache key?

### 8. Redirects and error handling (/10)

- `public/_redirects` (or equivalent) maintained for every URL that ever existed and moved?
- 301 not 302 for permanent moves?
- `FuzzyRedirect` component from `@jdevalk/astro-seo-graph` wired into the 404 page?
- 404 page itself returns a 404 status, not 200?

### 9. Build-time validation and content quality (/10)

- `seoGraph()` integration running on each build?
- H1 validation enabled (warns on zero or multiple `<h1>` per page)?
- Duplicate title/description detection across built pages?
- JSON-LD schema validation on every page?
- Content pieces audited for readability — lead sentences per paragraph, sentences under 20 words, transitions? (This is where we'll chain in `readability-check`.)

---

## Phase 2: Improve

Based on the audit, produce the concrete code. Always ask before overwriting. Key drop-ins:

### Install `@jdevalk/astro-seo-graph`

```sh
npm install @jdevalk/astro-seo-graph
```

Wire the integration:

```js
// astro.config.mjs
import seoGraph from '@jdevalk/astro-seo-graph/integration';

export default defineConfig({
    site: 'https://example.com',
    integrations: [
        seoGraph({
            validateH1: true,
            validateDuplicateMeta: true,
            validateSchema: true,
            indexNow: {
                key: 'REPLACE_WITH_GENERATED_KEY',
                host: 'example.com',
                siteUrl: 'https://example.com',
            },
        }),
    ],
});
```

### `BaseHead.astro`

Replace whatever head metadata the project has with a single `<Seo>` call. The component handles title, description, canonical, Open Graph, Twitter, JSON-LD graph, and extra links in one place.

### Content collection schema

```ts
// src/content/config.ts
import { defineCollection, z } from 'astro:content';
import { seoSchema } from '@jdevalk/astro-seo-graph';

export const collections = {
    blog: defineCollection({
        schema: ({ image }) => z.object({
            title: z.string(),
            excerpt: z.string(),
            publishDate: z.coerce.date(),
            seo: seoSchema(image).optional(),
        }),
    }),
};
```

### Per-collection sitemap + git lastmod

```js
import sitemap from '@astrojs/sitemap';
import { execSync } from 'node:child_process';

function gitLastmod(filePath) {
    try {
        const log = execSync(`git log -1 --format="%cI" -- "${filePath}"`, { encoding: 'utf-8' }).trim();
        return log ? new Date(log) : null;
    } catch { return null; }
}

sitemap({
    entryLimit: 1000,
    chunks: {
        posts: (item) => isBlogPost(new URL(item.url).pathname) ? item : undefined,
    },
    serialize: (item) => {
        // attach gitLastmod for the source file that produced this URL
        return item;
    },
});
```

### OG image route

Stand up `/og/[...slug].jpg` using satori + sharp. If the project already has one, check it outputs 1200×675 JPEG.

### Schema endpoints and schema map

```ts
// src/pages/schema/post.json.ts
import { createSchemaEndpoint } from '@jdevalk/astro-seo-graph';
export const GET = createSchemaEndpoint({ entries: () => getCollection('blog'), mapper: /* ... */ });
```

Plus `/schemamap.xml` listing every endpoint, and `Schemamap:` in robots.txt.

### Redirects and FuzzyRedirect

- Seed `public/_redirects` from the audit.
- Add `<FuzzyRedirect>` to the 404 page.
- Confirm the 404 page returns a 404 status (platform-specific).

### Performance headers

On Cloudflare Pages, add `public/_headers`:

```text
/_astro/*
  Cache-Control: public, max-age=31536000, immutable

/*
  No-Vary-Search: key-order, params=("utm_source" "utm_medium" "utm_campaign" "utm_content" "utm_term")
```

Adapt to the deployment target.

---

## Phase 2.5: Readability pass

Invoke the `readability-check` skill on every piece of prose the skill generated or modified: page titles, meta descriptions, schema `description` fields, FAQ entries, and any blog post frontmatter `excerpt` values you wrote.

SEO titles and descriptions are short but consequential — a long passive opening sentence in a meta description wastes the 160 characters Google shows in results. Apply the ⚠ and ✗ fixes directly. Skip the pass for technical strings (URLs, schema `@id` values, enum values).

If the project has a blog or docs content collection, note that the same `readability-check` skill can audit individual posts — mention this to the user as a follow-up, but don't audit the entire content corpus yourself.

---

## Phase 3: Verify

- Run `npm run build`. If `seoGraph()` is wired, this also runs H1 validation, duplicate-meta detection, and schema validation — surface any warnings.
- Spot-check the built HTML: one page's `<head>` should now be clean, canonical correct, JSON-LD graph present and linked.
- Run the homepage through [Rich Results Test](https://search.google.com/test/rich-results) and [ClassySchema](https://classyschema.org/Visualisation).
- Confirm `/sitemap-index.xml` exists and references per-collection sitemaps.
- If IndexNow is wired, confirm the key verification route returns the key at `/[key].txt`.
- Remind the user about tasks that can't be automated:
  - Register the site in [Google Search Console](https://search.google.com/search-console) and [Bing Webmaster Tools](https://www.bing.com/webmasters).
  - Submit the sitemap index in both.
  - Generate an IndexNow key and commit it to config.
  - Install [Plausible](https://plausible.io/) or equivalent privacy-friendly analytics.

---

## Output format

```markdown
## Astro SEO audit: [site name]

### Score
| Category                              | Score |
|---------------------------------------|------:|
| 1. `<Seo>` component and head         |  x/10 |
| 2. Structured data / JSON-LD graph    |  x/10 |
| 3. Content collections and schema     |  x/10 |
| 4. Open Graph images                  |  x/10 |
| 5. Sitemaps and indexing              |  x/10 |
| 6. Agent discovery                    |  x/10 |
| 7. Performance                        |  x/10 |
| 8. Redirects and error handling       |  x/10 |
| 9. Build-time validation and content  |  x/10 |
| **Total**                             | xx/90 |

### Findings
[Grouped by category. Quote actual code/config. Be specific.]

### Files generated or changed
[List with short description of each.]

### Next steps
[Non-file tasks: GSC, Bing Webmaster Tools, IndexNow key generation, analytics.]
```

---

## Key principles

- **Opinionated defaults over optionality.** The guide picks a stack; this skill applies it. Don't offer five alternatives when one works.
- **`@jdevalk/astro-seo-graph` is the spine.** Route the `<Seo>` component, schema endpoints, IndexNow, FuzzyRedirect, and build validation through it unless the user has a strong reason to hand-roll.
- **Topics, not keyphrases.** When reviewing content, focus on topical coverage and readability, not keyword density.
- **Static, CDN-served HTML is the baseline.** Don't add SSR to solve problems static builds already don't have.
- **Agent discovery matters now.** Schema endpoints, schema map, NLWeb tags — the crawler is no longer the only consumer.
