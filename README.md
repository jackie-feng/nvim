## neovim 配置

### 安装

```
# 安装 neovim
brew install neovim

# 安装 `packer.nvim`
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# clone 本仓库配置
git clone https://github.com/jackie-feng/nvim.git ~/.config/nvim

# 安装插件
# 进入 nvim, 输入 PackerSync 完成插件安装
:PackerSync

# telescope 插件依赖 `ripgrep`
brew install ripgrep
```

LSP 配置

详见 `lua > lsp > setup.lua`

```
# ruby
gem install solargraph

# golang
go install golang.org/x/tools/gopls@latest
```

安装字体 [更多安装方式](https://github.com/ryanoasis/nerd-fonts/blob/master/readme_cn.md#%E5%AD%97%E4%BD%93%E5%AE%89%E8%A3%85)
```
# nvim-web-devicons 所依赖的字体
brew install --cask font-meslo-lg-nerd-font
```

快捷键 `lua > keybindings.lua`
