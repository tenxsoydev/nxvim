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

#

<br />
<div align="center"><sub>Objective: just to provide an enhanced modal text editing experience that elicits the occasional thought of "nice".</sub></div>
<br />
<a target="_blank"
   href="https://user-images.githubusercontent.com/34311583/221439282-ac9e327e-e109-4559-a951-46b4c8d8f1c0.png">
<img alt="Preview Structure & Self Documentating"
      src="https://user-images.githubusercontent.com/34311583/221439282-ac9e327e-e109-4559-a951-46b4c8d8f1c0.png" />
</a>
<br />
<br />
<a target="_blank"
   href="https://user-images.githubusercontent.com/34311583/223553097-9c9aefdd-93c3-4afd-b413-14d2a635b1dd.png">
<img alt="Preview Structure & Self Documentating"
      src="https://user-images.githubusercontent.com/34311583/223552967-02239346-d6f4-4dc0-b65f-bc13dcbe0535.png" />
</a>
<br />
<br />

<details>
<summary><h3>Quick and dirty demos <sub><sup>Click to expand...</sup></sub></h3></summary>

- Candies that make a GUI-like TUI are animated auto window widths, dimming of unfocused windows and smooth scrolling.

  https://user-images.githubusercontent.com/34311583/218597414-10b06f59-7cc9-4c95-9de7-2734859484a1.mov

<br>

- Among all regular suspects like coding completions and writing aids it includes several helpers like a command-palette with error tolerant as-you-type-completion for commands, settings & variables.

  https://user-images.githubusercontent.com/34311583/218597463-c00e55e2-b29e-4c9c-8ef5-1764983e2a0b.mov

<br>
</details>

## Getting Started

At present, first-hand instructions are only provided for Linux. However, the configuration runs on all platforms.
Since there is not much wizardry involved and many of the steps are universal, following along on other platforms should be fairly straightforward.

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

<details>
<summary><h3>Dependencies <sub><sup>Click to expand...</sup></sub></h3></summary>

Probably, most of the necessary components are already installed.

1. neovim nightly (statuscol support)
   - <a target="_blank" href="https://github.com/MordechaiHadad/bob">bob</a> is a good way to keep the latest and/or nightly version up to date.
2. Packages
   - TL;DR: for a deb. based system: `sudo apt install git curl unzip xsel ripgrep fd-find sqlite3 libsqlite3-dev`
   - TL;DR: for an arch based system: `sudo pacman -S git curl unzip xsel ripgrep fd sqlite`
   - git
   - curl
   - unzip
   - xsel (linux only)
   - ripgrep
   - fd
   - sqlite
3. Client support for modules communicating with nvim api objects
   - use your preferred method or refer to the corresponding docs to ensure node and python are installed
   - node client for neovim `npm install -g neovim`
   - python client for neovim `pip install pynvim`
4. Fonts
   - <a target="_blank" href="https://github.com/ryanoasis/nerd-fonts/#patched-fonts">nerd font</a>
   - <a target="_blank" href="https://github.com/googlefonts/noto-emoji">unicode font</a> (If none is installed by default, noto font packages are usually also available via your distros package manager)
   - `fc-cache -fv` helps to update font info cache files when new fonts have been added manually

</details>

<details>
<summary><h3>Post installation <sub><sup>Click to expand...</sup></sub></h3></summary>

#### Frist run

Launch `nvim` and let <a target="_blank" href="https://github.com/folke/lazy.nvim">lazy</a> do its magic, automatically loading all the modules utilized in this config. You may encounter some warnings regarding missing dependencies. Just hit return on them for now. Once all tasks have been completed, restart nvim <kbd>ZQ</kbd> `nvim`.

#### Last steps

- Run `:UpdateRemotePlugins` mainly to make sure command line fuzzy search works correctly, as it utilizes some python
- Programming language support
  - The <a target="_blank" href="https://github.com/williamboman/mason-lspconfig.nvim">mason</a> plugins allow an effortless setup of language support for your projects
    - you can start off by adding the `lua` LSP that'll help to work with this config
    - `:LSPInstall` `lua_ls`
  - To add additional formatters and linters we'll use <a target="_blank" href="https://github.com/jose-elias-alvarez/null-ls.nvim">null-ls</a>
    - let's also install the formatter used for this config
    - `NullLsInstall` `stylua`

**Note on Performance**

- On low-spec systems, performance can be improved by changing `animation.fps = 30 -- instead of 60` in `plugins/windows.lua` and - in case of using terminals with font ligature rendering support - disabling them (e.g. with kitty: by adding `disable_ligatures always` to your `kitty.conf`)
</details>

<details>
<summary><h3>Usage Recommendations (optional) <sub><sup>Click to expand...</sup></sub></h3></summary>

- My best experience has been with [kitty](https://github.com/kovidgoyal/kitty). A feature-rich, GPU accelerated terminal with its core written in `C`.
- It's optimized for use with the official dracula colorscheme in a "pseudo-transparent" style.
- For usage inside a terminal any used colorscheme should be matched with the colorscheme of the terminal.
  - In case you are interested in the one used on the screenshots: <a target="_blank" href="https://github.com/tobealive/dots/tree/tooltime/.config/kitty">tobealive/dots/tooltime/.config/kitty</a>
- Alternatively, a graphically enriched - but functionally slightly compromised - experience using [neovide](https://github.com/neovide/neovide/) with multigrid enabled might be worth the trade-off for you.
- A dead-simple hack for improving ergonomics in keyboard-driven development is to remap the positions of dominantly used keys. One does not need a programmable keyboard to do this, as keyboard settings in any desktop environment support simple modifications. For example, one could make Caps behave as an additional Escape key and use Shift+Caps for regular Caps Lock. Additionally, swapping the more frequently used Control key with Alt can provide an easier-on-the-finger-joints, Mac-command-key-like experience.
</details>

<br>

## Acknowledgements

Just like most other neovim configurations, this one includes a collection of plugins. It wouldn't be imaginable without the contributions of so many developers in the open source space. Kudos to every author who contributed to the modules used in this configuration.

- modules = { [nxvim/lua/nxvim/init.lua](https://github.com/tenxsoydev/nxvim/blob/main/lua/nxvim/init.lua#L15) }

<br>

## Disclaimer

> Currently, this is rather my personal daily driver then a general-use product. Making it public was driven by colleagues and friends who were interested in getting a share of this config and then liked using it. Getting surprisingly positive feedback even from my grumpiest colleague, led me to believe that this configuration might well have utility for others. However, **it may never reach the level and support of a general-use project**.

<br>

Of course, you are free to use and modify it. Share a ★ if you don't consider it robbery and feel free to reach out if you experience any issues.

<br>

Those who are seeking tools that can turn Neovim into a full-fledged IDE, have great support and a thriving community should consider the following repositories:

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-ide](https://github.com/ldelossa/nvim-ide)

### License

The config as a whole is licensed under GPLv3. Please refer to the LICENSE files for detailed information.
