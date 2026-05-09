# Adding an Internet Search Tool to pi

If you mean an **internet/web search tool** for pi, the cleanest way is to build a **pi extension** that registers a custom tool with `pi.registerTool()`.

## Best approach

Use an **extension** when you want:

- the LLM to call the search tool directly
- structured parameters
- API integration
- optional custom rendering or result shaping

Use a **skill** instead if you just want documented scripts/workflows the model can invoke. Since you asked for a “tool”, use an extension.

## Minimal plan

1. Pick a search backend:
   - Brave Search API
   - SerpAPI
   - Tavily
   - your own internal search endpoint

2. Create an extension file:
   - global: `~/.pi/agent/extensions/web-search.ts`
   - or project-local: `.pi/extensions/web-search.ts`

3. Register a tool with `pi.registerTool()`

4. Reload pi with `/reload`

## Example extension

Path:

```ts
~/.pi/agent/extensions/web-search.ts
```

Code:

```typescript
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Type } from "@sinclair/typebox";

type BraveResult = {
  title?: string;
  url?: string;
  description?: string;
};

export default function (pi: ExtensionAPI) {
  pi.registerTool({
    name: "web_search",
    label: "Web Search",
    description: "Search the internet for recent information, documentation, and web pages.",
    promptSnippet: "Search the web for current information and return relevant results.",
    promptGuidelines: [
      "Use this tool when the user asks for internet/web search, current events, recent docs, or information not likely in local files.",
    ],
    parameters: Type.Object({
      query: Type.String({ description: "The search query" }),
      count: Type.Optional(Type.Number({ description: "Number of results to return" })),
    }),

    async execute(_toolCallId, params, signal) {
      const apiKey = process.env.BRAVE_SEARCH_API_KEY;
      if (!apiKey) {
        return {
          content: [
            {
              type: "text",
              text: "BRAVE_SEARCH_API_KEY is not set.",
            },
          ],
          details: {},
          isError: true,
        };
      }

      const count = Math.min(Math.max(params.count ?? 5, 1), 10);

      const url = new URL("https://api.search.brave.com/res/v1/web/search");
      url.searchParams.set("q", params.query);
      url.searchParams.set("count", String(count));

      const response = await fetch(url.toString(), {
        method: "GET",
        headers: {
          "Accept": "application/json",
          "X-Subscription-Token": apiKey,
        },
        signal,
      });

      if (!response.ok) {
        const text = await response.text();
        return {
          content: [
            {
              type: "text",
              text: `Search request failed: ${response.status} ${response.statusText}\n${text}`,
            },
          ],
          details: {},
          isError: true,
        };
      }

      const data = await response.json() as {
        web?: { results?: BraveResult[] };
      };

      const results = data.web?.results ?? [];

      if (results.length === 0) {
        return {
          content: [
            {
              type: "text",
              text: `No results found for: ${params.query}`,
            },
          ],
          details: { results: [] },
        };
      }

      const text = results
        .map((r, i) =>
          `${i + 1}. ${r.title ?? "Untitled"}\n${r.url ?? ""}\n${r.description ?? ""}`.trim()
        )
        .join("\n\n");

      return {
        content: [
          {
            type: "text",
            text,
          },
        ],
        details: { results },
      };
    },
  });
}
```

## Set your API key

For Brave Search:

```bash
export BRAVE_SEARCH_API_KEY=your_key_here
```

Then start pi, or if already open:

```text
/reload
```

## What pi does by default

Pi does **not** include internet search by default, even if you connect it to GPT/OpenAI.

By default, pi exposes local coding tools such as:

- `read`
- `write`
- `edit`
- `bash`

Those tools work on local files and shell commands, not the public web.

So if you want internet search inside pi, you need one of the following:

- a custom extension tool
- a skill wrapping a search script or API
- a third-party pi package that already implements search

## How pi will use it

Once loaded, the model can call `web_search` when the user asks things like:

- “search the web for the latest React 19 docs”
- “find current pricing for X”
- “look up recent issues about Y”

Because you added:

- `description`
- `promptSnippet`
- `promptGuidelines`

…the tool becomes easier for the model to discover and use correctly.

## Recommended improvements

### 1. Add page-content fetching

Search results alone are often not enough. Add a second tool like:

- `fetch_web_page`
- input: `url`
- output: cleaned page text

That gives pi a two-step workflow:
1. search
2. fetch/read the chosen page

### 2. Support multiple providers

You can make the tool backend configurable via env vars:

- `BRAVE_SEARCH_API_KEY`
- `SERPAPI_API_KEY`
- `TAVILY_API_KEY`

### 3. Add result limiting and summaries

Return:
- top 5 results
- short snippets
- raw structured results in `details`

### 4. Handle rate limits/timeouts

Wrap errors clearly so the model understands what failed.

## Browser support vs search API support

There is an important difference between **search** and **browser automation**.

### Search API

This is the simpler approach. Pi is not opening a browser. Instead, your tool calls an online API such as:

- Brave Search API
- Tavily
- SerpAPI

The flow is:

1. tool sends search query
2. service returns JSON
3. tool formats results for pi

### Browser automation

Browser support is also possible in pi, but it is usually added through an extension, skill, or package.

That browser layer may:

- launch local Chrome/Chromium with Playwright or Puppeteer
- connect to a remote browser
- use a hosted browser automation service
- talk to Chrome through a browser automation API

So when people say pi can use "Chrome", they often mean:

- pi calls a custom tool
- the tool controls a browser automation layer
- the browser layer returns page text, links, screenshots, or interaction results

This is different from a pure search API integration.

### Practical distinction

Use a **search API tool** when you want:

- fast web search
- current information lookup
- low setup complexity

Use a **browser tool** when you want:

- open rendered pages
- click buttons
- fill forms
- log in
- inspect JavaScript-heavy sites
- take screenshots

## Brave account and billing

For a Brave Search setup, you would generally need:

1. a Brave developer/account setup
2. an API key
3. possibly a paid plan, depending on Brave's current pricing and quota policy

This is not the same as simply installing and using the Brave browser locally.
You are using the **Brave Search API service**, so you should expect API access requirements and possible usage costs.

Typical setup flow:

1. sign up for Brave Search API access
2. generate an API key
3. export it in your shell
4. let the pi extension read `BRAVE_SEARCH_API_KEY`

## Alternative: build it as a skill

A **skill** is useful if you want pi to use scripts like:

```bash
./search.js "query"
./content.js https://example.com
```

That works well too, but it’s not as seamless as a real extension tool.  
For a first-class “search tool”, prefer the extension route.

## Existing option

The skills docs mention a community repo:

- **Pi Skills**: `badlogic/pi-skills` includes web search-related skills

So if you don’t want to build from scratch, you could install an existing package or use it as a reference.

## Short version

To add an internet search tool to pi:

1. create a TypeScript extension in `~/.pi/agent/extensions/`
2. call `pi.registerTool(...)`
3. make the tool hit a search API with `fetch()`
4. return text results in `content`
5. `/reload`

Key takeaways:

- pi does **not** have built-in internet search by default
- connecting pi to GPT does **not** automatically add web search
- Brave-style skills usually use a **search API**, not a full browser
- Chrome/browser workflows are possible, but usually through browser automation tools or remote browser services
- Brave Search likely requires account setup, an API key, and possibly a paid plan

## Next step

If you want, generate a complete production-ready extension with:

- `web_search`
- `fetch_web_page`
- env-based provider selection
- better error handling
- optional result rendering
