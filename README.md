# nxvim

## Preface

> Note before use: this is rather my personal daily driver(and the accumulation of procrastinated time that felt somewhat productive) then a general-use product. Making it public was driven by colleagues and friends who were interested in getting a share of this config and then liked using it. When I came to think that it might really be useful to others was when even my grumpiest colleague gave surprisingly positive feedback. However, **it may never reach the level and support of a general-use project** and it's propagation will be limited to giving attributions in credits.

Those who are seeking tools that can turn Neovim into a full-fledged IDE, which are developed by brilliant programmers, have great support and a thriving community should consider the following repositories:

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-ide](https://github.com/ldelossa/nvim-ide)

## Acknowledgements

Just like most other neovim configurations, this one includes a collection of plugins. It wouldn't be imaginable without the contributions of so many developers in the open source space. Kudos to every author who contributed to the modules used in this configuration.

- modules = { [nxvim/lua/nxvim/init.lua](https://github.com/tenxsoydev/nxvim/blob/main/lua/nxvim/init.lua#L17) }

## Preview

<table>
  <tr align="center">
    <td width="400">
    <a target="_blank" href="https://user-images.githubusercontent.com/34311583/218542267-17aec35d-1469-4576-8f75-bec75c976ba9.png">
      <img alt="Preview" src="https://user-images.githubusercontent.com/34311583/218542267-17aec35d-1469-4576-8f75-bec75c976ba9.png">
    </a>
    </td>
    <td width="400">
    <a target="_blank" href="https://user-images.githubusercontent.com/34311583/218549911-5b302057-1020-426e-87cb-ebb567f18f5c.png">
      <img alt="Preview Structure & Self Documentating" src="https://user-images.githubusercontent.com/34311583/218549911-5b302057-1020-426e-87cb-ebb567f18f5c.png">
    </a>
    </td>
  </tr>
    <tr align="center">
    <td width="400">
    <sup><sub>Preview</sub></sup>
    </td>
    <td width="400">
    <sup><sub>It aims to be structured and self-documenting.</sub></sup>
    </td>
  </tr>
  <tr align="center">
    <td colspan="2">
    <a target="_blank" href="https://user-images.githubusercontent.com/34311583/218537322-e340b834-eb62-44f4-b991-4cabffd71010.png">
      <img alt="Preview Primary Screen" src="https://user-images.githubusercontent.com/34311583/218537322-e340b834-eb62-44f4-b991-4cabffd71010.png">
    </a>
    </td>
  </tr>
</table>

### Some previews in moving pictures

- Candies that make a GUI-like TUI are animated auto window widths; dimming of unfocused windows and smooth scrolling.

  https://user-images.githubusercontent.com/34311583/218597414-10b06f59-7cc9-4c95-9de7-2734859484a1.mov

- Several helpers like a command-palette with as-you-type-completions with error tolerance for commands, settings & variables. Also, all regular suspects like coding completions and writing aids.

  https://user-images.githubusercontent.com/34311583/218597463-c00e55e2-b29e-4c9c-8ef5-1764983e2a0b.mov

## Getting Started

To prevent interferences with current Neovim files...

```sh
# ...either back them up:
mv ~/.config/nvim ~/.config/nvim.bak && mv ~/.local/share/nvim ~/.local/share/nvim.bak
# ...or remove them:
rm -r ~/.config/nvim ~/.local/share/nvim
```

#### Dependencies

Probably most stuff is already installed.

1. neovim nightly - _statuscol support_
   - <a target="_blank" href="https://github.com/MordechaiHadad/bob">bob</a> is a good way to keep your latest and/or nightly version up to date
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

#### Frist run

Once all dependencies have been installed, launch `nvim` and let <a target="_blank" href="https://github.com/folke/lazy.nvim">lazy</a> do its magic automatically loading all of the modules utilized in this config.
During this initial run, you may encounter some warnings regarding missing dependencies. Just hit return on them for now. Once all tasks have been completed, restart nvim <kbd>ZQ</kbd> `nvim`.

#### Post installation

- Run `:UpdateRemotePlugins` mainly to make sure command line fuzzy search works correctly, as it utilizes some python
- Programming language support
  - The <a target="_blank" href="https://github.com/williamboman/mason-lspconfig.nvim">mason</a> plugins allow an effortless setup of language support for your projects
    - you can start off by adding the `lua` LSP that'll help to work with this config
    - `:LSPInstall` `lua_ls`
  - To add additional formatters and linters we'll use <a target="_blank" href="https://github.com/jose-elias-alvarez/null-ls.nvim">null-ls</a>
    - let's also install the formatter used for this config
    - `NullLsInstall` `stylua`

#### Personal Usage Recommendations

- My best experience has been with [kitty](https://github.com/kovidgoyal/kitty). A feature-rich, GPU accelerated terminal with its core written in `C`.
- It's optimized for use with the official dracula colorscheme in a "pseudo-transparent" style.
- For the best experience match it with the colorscheme of your terminal
  - in case you are interested in the one used on the screenshots: <a target="_blank" href="https://github.com/tobealive/dots/tree/tooltime/.config/kitty">tobealive/dots/tooltime/.config/kitty</a>
- Alternatively, a graphically enriched - but functionally slightly compromised - experience using [neovide](https://github.com/neovide/neovide/) with multigrid enabled might be worth the trade-off for you.

**Note on Performance**

- On low spec systems, performance can be improved by changing `animation.fps = 30 -- instead of 60` in `plugins/windows.lua` and - in case of using kitty - adding `disable_ligatures always` to your `kitty.conf`.

## License

The config as a whole is licensed under GPLv3. Please refer to the LICENSE files for detailed information.
