---
layout: post
title: "Utilizing TypeScript Interfaces to Guide GPT-4"
date: 2023-03-25 8:30:00 -0700
description: "Leveraging GPT-4's code-writing capabilities to constrain its output."
comments: true
---

Based on a suggestion from [Matt Brockman](https://twitter.com/badphilosopher), I've found that defining TypeScript interfaces within GPT-3 or GPT-4 prompts is an effective way to ensure that generated responses possess a desired shape.

Below is an example prompt that I implemented in a custom Chrome extension. It requests the LLM to deduce the user's current intended objective.

```
type HelpAssistantAnalysisResult = {
    // The user's consistent recent browsing goal
    goal: string;
    // How confident the analysis engine is in this goal
    confidence: "very low" | "low" | "med" | "high" | "very high";
    // Whether or not the user seems to have switched goals recently
    switched: boolean;
    // An array of up to 3 creative, specific, non-obvious ways the system recommends for the user to meet their current goal.
    // (Do not return generic suggestions like 'subscribe to a newsletter' or 'do a Google search', instead
    //  recommend specific actions that the user should consider.)
    advice: advice: Array<{
      text: string;
      probabilityOfBeingUseful: "very low" | "low" | "med" | "high" | "very high";
      creativity: "very low" | "low" | "med" | "high" | "very high";
      funLevel: "very low" | "low" | "med" | "high" | "very high";
    }>;
}

/*
A user has performed the following searches and visited the following sites recently:
${recentActions.join("\n")}
(They may or may not have changed goals half way through this session.)

The following function, assistantRecommendations, returns a HelpAssistantAnalysisResult object.

An example JSON output on the above history is:
{ "goal": "the user is trying to
```

The LLM consistently returns a JSON structure exhibiting the correct format and with reasonable completions.
(In practice, this specific experiment hasn't been the most interesting as a browser tool, but the prompting technique has been quite effective!)