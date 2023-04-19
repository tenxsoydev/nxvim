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

![dots-preview1](https://user-images.githubusercontent.com/34311583/232096580-60a1f07f-9bff-4925-9327-9413c752ea6f.png)

## Getting Started

At present, first-hand instructions are only provided for Linux. However, following along on other platforms should be fairly straightforward since there is not much wizardy involved.

### Prerequisites

1. Prevent interferences with current Neovim files

   ```sh
   # Make a backup
   mv ~/.config/nvim ~/.config/nvim.bak \
   && mv ~/.local/share/nvim ~/.local/share/nvim.bak

   # Or remove them
   mv ~/.config/nvim ~/.config/nvim.bak \
   && mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. Clone the repository into neovims `stdpath("config")`

   ```sh
   git clone https://github.com/tenxsoydev/nxvim.git ~/.config/nvim
   ```

<br>

### Dependencies

Probably, most necessities are already installed.

1. Neovim >= 0.9
2. Packages

   - TL;DR: for a deb. based system

     ```sh
     sudo apt install git curl unzip xsel ripgrep fd-find sqlite3 libsqlite3-dev
     ```

   - TL;DR: for an arch based system

     ```
     sudo pacman -S git curl unzip xsel ripgrep fd sqlite
     ```

3. Client support for modules communicating with nvim api objects

   - For Node and Python installation, use your preferred method or refer to the corresponding documentation.
   - Node client for neovim

     ```
     npm install -g neovim
     ```

   - Python client for neovim

     ```
     pip install pynvim
     ```

4. Fonts
   - [Nerd font][20]
   - [Unicode font][30] (If none is installed by default, noto font packages are usually also available via your distros package manager).
   - `fc-cache -fv` helps to update font info cache files when new fonts have been added manually.

### Post installation

- Frist run

  Launch `nvim` and let lazy do it's magic, loading all modules used in this config. There may be warnings regarding missing dependencies. Just hit return on them for now. Once all tasks have been completed, restart nvim <kbd>ZQ</kbd> `nvim`.

- Last steps
  - Run `:UpdateRemotePlugins` to make sure command line fuzzy search works correctly, as it utilizes some python.
  - Add language servers / formatters. E.g.:
    - Add the `lua` LSP `LSPInstall` `lua_ls`
    - Also install the formatter used for this config `NullLsInstall` `stylua`
  - Have fun using it!

<br>

## Showcase

![preview-crop](https://user-images.githubusercontent.com/34311583/232096844-7d95ac69-e7de-4921-ad94-8f94dea6ac5a.png)

<details><summary><h3>Quick and dirty demos <sub><sup>Toggle visibility...</sup></sub></h3></summary>

- Candies like animated auto window widths, dimming of unfocused windows and smooth scrolling.

  https://user-images.githubusercontent.com/34311583/218597414-10b06f59-7cc9-4c95-9de7-2734859484a1.mov

<br>

- Coding completions; writing aids; a command-palette with error tolerant typehead completion for commands settings and variables.

  https://user-images.githubusercontent.com/34311583/218597463-c00e55e2-b29e-4c9c-8ef5-1764983e2a0b.mov

<br>
</details>

## Acknowledgements

Just like most other neovim configurations, this one includes a collection of plugins. It wouldn't be imaginable without the contributions of so many developers in the open source space. Kudos to every author who contributed to the modules used in this configuration.

- modules = { [nxvim/lua/nxvim/init.lua][70] }

## Disclaimer

> Currently, this is rather my personal daily driver then a general-use product. Making it public was driven by colleagues and friends who were interested in getting a share of this config and then liked using it. Getting surprisingly positive feedback even from my grumpiest colleague, led me to believe that this configuration might well have utility for others. However, **it may never reach the level and support of a general-use project**.

<br>

Of course, you are free to use and modify it. ★ the project if you have found inspiring parts, want to show support or better stay up to date.

### License

The config as a whole is licensed under GPLv3. Please refer to the LICENSE files for detailed information.

[10]: https://github.com/MordechaiHadad/bob
[20]: https://github.com/ryanoasis/nerd-fonts/#patched-fonts
[30]: https://github.com/googlefonts/noto-emoji
[40]: https://github.com/kovidgoyal/kitty
[50]: https://github.com/tobealive/dots/tree/tooltime/.config/kitty
[60]: https://github.com/neovide/neovide/
[70]: https://github.com/tenxsoydev/nxvim/blob/main/lua/nxvim/init.lua#L15
