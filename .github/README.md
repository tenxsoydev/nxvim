<br />
<div align="center">
  <p>🇳 🇽 🇻 🇮 🇲</p>
  <p><em>PDE that leverages 100+ extensions in a fast and structured configuration.</em></p>
  <div>
    <a href="https://github.com/tenxsoydev/nxvim#getting-started">
      <img
        alt="Getting Started"
        src="https://img.shields.io/badge/%20Getting%20Started-%20.svg?&style=for-the-badge&logo=ApacheRocketMQ&color=7A88CF&logoColor=C0CAF5&labelColor=414868"
      />
    </a>
    <!-- <a href="https://github.com/tenxsoydev/nxvim/blob/main/LICENSE-GPL"> -->
    <!--   <img src="https://img.shields.io/github/license/tenxsoydev/nxvim?style=for-the-badge&amp&logo=GNU&label=License&color=FFB86C&labelColor=343746" alt="License"> -->
    <!-- </a> -->
    <a href="https://github.com/tenxsoydev/nxvim/pulse">
      <img
        alt="Last Commit"
        src="https://img.shields.io/github/last-commit/tenxsoydev/nxvim?style=for-the-badge&logo=github&color=6183bb&logoColor=c0caf5&labelColor=414868"
      />
    </a>
    <a href="https://github.com/neovim/neovim">
      <img
        alt="Neovim Nightly"
        src="https://img.shields.io/badge/Neovim-nightly-%20.svg?style=for-the-badge&color=BB9AF7&logo=Neovim&logoColor=C0CAF5&labelColor=414868"
      />
    </a>
  </div>
</div>

<br>

## Quick and dirty demos

- Candies like animated auto window widths, dimming of unfocused windows and smooth scrolling.

  https://user-images.githubusercontent.com/34311583/218597414-10b06f59-7cc9-4c95-9de7-2734859484a1.mov

<br>

- Coding completions; writing aids; a command-palette with error tolerant typehead completion for commands settings and variables.

  https://user-images.githubusercontent.com/34311583/218597463-c00e55e2-b29e-4c9c-8ef5-1764983e2a0b.mov

<br>

## Getting Started

At present, first-hand instructions are only provided for Linux. Since there is not much wizardry involved and many of the steps are universal, following along on other platforms should be fairly straightforward.

To prevent interferences with current Neovim files...

```sh
# ...either back them up:
mv ~/.config/nvim ~/.config/nvim.bak && mv ~/.local/share/nvim ~/.local/share/nvim.bak
# ...or remove them:
rm -r ~/.config/nvim ~/.local/share/nvim
```

Clone the repository into neovims `stdpath("config")`

```sh
git clone https://github.com/tenxsoydev/nxvim.git ~/.config/nvim
```

<details open>
<summary><h3>Dependencies <sub><sup><sub>Toggle visibility...</sub></sup></sub></h3></summary>

Probably, most necessities are already installed.

1. Neovim nightly (statuscol support)
   - [bob][10] is a good way to keep the latest and/or nightly version up to date.
2. Packages
   - TL;DR: for a deb. based system: `sudo apt install git curl unzip xsel ripgrep fd-find sqlite3 libsqlite3-dev`
   - TL;DR: for an arch based system: `sudo pacman -S git curl unzip xsel ripgrep fd sqlite`
3. Client support for modules communicating with nvim api objects
   - For Node and Python installation, use your preferred method or refer to the corresponding documentation.
   - Node client for neovim `npm install -g neovim`
   - Python client for neovim `pip install pynvim`
4. Fonts
   - [Nerd font][20]
   - [Unicode font][30] (If none is installed by default, noto font packages are usually also available via your distros package manager).
   - `fc-cache -fv` helps to update font info cache files when new fonts have been added manually.

</details>

<details open>
<summary><h3>Post installation <sub><sup><sub>Toggle visibility...</sub></sup></sub></h3></summary>

#### Frist run

Launch `nvim` and let lazy do it's magic, loading all modules used in this config. There may be warnings regarding missing dependencies. Just hit return on them for now. Once all tasks have been completed, restart nvim <kbd>ZQ</kbd> `nvim`.

#### Last steps

- Run `:UpdateRemotePlugins` to make sure command line fuzzy search works correctly, as it utilizes some python.
- Programming language support
  - The mason plugins allow an effortless setup of language support for your projects
    - Let's start off by adding the `lua` LSP that'll help to work with this config
    - `:LSPInstall` `lua_ls`
  - To add additional formatters and linters we'll use null-ls
    - Let's also install the formatter used for this config
    - `NullLsInstall` `stylua`
- Have fun using it!

</details>

<br>
<details>
<summary><h3>Usage Recommendations (optional) <sub><sup><sub>Toggle visibility...</sub></sup></sub></h3></summary>

- The recommended terminal is [kitty][40]. A feature-rich, GPU accelerated terminal with its core written in `C`.
- The config is optimized for use with the official dracula colorscheme in a "pseudo-transparent" style.
- For usage inside a terminal any used colorscheme should be matched with the colorscheme of the terminal.
  - In case you are interested in the one used on the screenshots: [dots/tooltime/.config/kitty][50]
- Alternatively, a graphically enriched - but functionally slightly compromised - experience using [neovide][60] with multigrid enabled might be worth the trade-off for you.
- An easy way to improve ergonomics in a keyboard-focused environment is by remapping the positions of frequently used keys. One doesn't need a programmable keyboard to do this, as keyboard settings in any desktop environment support simple modifications. For instance, one could make the Caps Lock key behave as an additional Escape key and use Shift+Caps Lock for the regular Caps Lock function. Moreover, if not using macOS, swapping the more frequently used Control key with Alt can provide a more comfortable, Mac-command-key-like experience.

**Note on Performance**

- On low-spec systems, performance can be improved
  - Disable font ligature rendering (e.g. with kitty: add `disable_ligatures always` to `kitty.conf`)
  - Change `animation.fps = 30 -- instead of 60` in `plugins/windows.lua`.

</details>

<br>

## Acknowledgements

Just like most other neovim configurations, this one includes a collection of plugins. It wouldn't be imaginable without the contributions of so many developers in the open source space. Kudos to every author who contributed to the modules used in this configuration.

- modules = { [nxvim/lua/nxvim/init.lua][70] }

<br>

## Disclaimer

> Currently, this is rather my personal daily driver then a general-use product. Making it public was driven by colleagues and friends who were interested in getting a share of this config and then liked using it. Getting surprisingly positive feedback even from my grumpiest colleague, led me to believe that this configuration might well have utility for others. However, **it may never reach the level and support of a general-use project**.

<br>

Of course, you are free to use and modify it. Share a ★ if you don't consider it robbery and feel free to reach out if you experience any issues.

### License

The config as a whole is licensed under GPLv3. Please refer to the LICENSE files for detailed information.

[10]: https://github.com/MordechaiHadad/bob
[20]: https://github.com/ryanoasis/nerd-fonts/#patched-fonts
[30]: https://github.com/googlefonts/noto-emoji
[40]: https://github.com/kovidgoyal/kitty
[50]: https://github.com/tobealive/dots/tree/tooltime/.config/kitty
[60]: https://github.com/neovide/neovide/
[70]: https://github.com/tenxsoydev/nxvim/blob/main/lua/nxvim/init.lua#L15
