---
name: address-pr-comments
description: Given a PR number, looks for the comments with :thumbsup: and :eyes: reactions to evaluate comments and plan changes accordingly.
---

# Context
Given a PR number, look for the the comments with :thumbsup: and :eyes: reactions. Evaluate the rationale of the ones with :eyes: reactions and reason if they make sense and why (or not). Plan changes for the ones with :thumbsup: reactions. This command should run on the same branch of the target PR, so the agent can make changes to the codebase if needed. If not on the correct branch, the agent should switch to the correct branch before making any changes.

# What the agent should do
1. Check if the PR branch and the current branch are the same. If not, switch to the PR branch.
2. Look for the comments with :thumbsup: and :eyes: reactions in the PR
3. Evaluate the rationale of the comments with :eyes: reactions and reason if they make sense and why (or not).
4. Plan changes for the comments with :thumbsup: reactions.
5. Print the evaluation and the plan for changes in a clear and concise manner.
6. DON'T COMMIT THE FINAL CHANGES WITHOUT USER PERMISSION!
7. If the user gives permission to commit the changes, commit the changes with a clear and concise commit message that summarizes the changes made.