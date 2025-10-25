# view_pr.nvim 👀

NeoVim plugin to instantly open the GitHub Pull Request associated with the line of code you’re looking at.

---

## Why use this? 🤔

Ever found yourself staring at a piece of code thinking:

> “Which PR changed this? What was the discussion behind it?”

`view_pr.nvim` gives you that context.

- Jump straight to the PR in GitHub from any line of code
- Understand the reasoning behind changes
- Save time flipping between Neovim and your browser

---

## Features ✨

- Open the GitHub PR for the current line with a single command
- Optional key mapping for lightning-fast access
- Lightweight and fast

---

## Installation 💾

Using [Lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "johnnyBira/view_pr.nvim",
  keys = {
    { "<leader>go", "<cmd>ViewPR<CR>", desc = "View PR on current line", silent = true },
  },
}
```

---

## Usage 🛠️

Once installed:

- Run `:GitHubViewPR` while on the line you care about
- Or press `<leader>gp` if you’ve configured the key map above

It will open the associated GitHub PR in your default browser (via `xdg-open` or `open` on macOS).

---

## Requirements ✅

- Git must be installed
- GitHub CLI (`gh`) is required
- Neovim 0.7+
- A Git repository with remotes pointing to GitHub

> Use `:checkhealth view_pr` to ensure all dependencies are available 🔍

---

## Contributing 🤝

Found a bug, or want a feature? Pull requests are welcome! 💌

---

## License 📄

BEER-WARE License

Happy coding! 🍻
