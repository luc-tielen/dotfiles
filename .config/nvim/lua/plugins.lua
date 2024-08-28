local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local is_bootstrap = not (vim.uv or vim.loop).fs_stat(lazypath)
vim.opt.rtp:prepend(lazypath)
if is_bootstrap then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})

	-- When we are bootstrapping a configuration, it doesn't
	-- make sense to execute the rest of the init.lua.
	--
	-- You'll need to restart nvim, and then it will work.
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Lazy completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Plugins
require("lazy").setup({
	-- Colorscheme:
	{
		"atelierbram/Base2Tone-vim",
		-- "rainglow/vim",
		lazy = false,
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme crackpot-contrast")
			vim.cmd("colorscheme Base2Tone_EveningDark")
			require("theme")
		end,
	},
	-- Statusline:
	{
		"glepnir/galaxyline.nvim",
		config = function()
			require("statusline")
		end,
	},
	-- LSP:
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and tools to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Additional neovim lua configuration, makes nvim development amazing
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local on_attach = function(event)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
				end

				nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
			end

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = on_attach,
			})

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable LSP servers
			local servers = {
				lua_ls = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
					diagnostics = { disable = { "missing-fields" } },
				},
				-- clangd = {},
				rust_analyzer = {},
				-- TODO fix hls = { haskell = { formattingProvider = "fourmolu" } },
				tsserver = {
					root_dir = require("lspconfig.util").root_pattern("package.json"),
				},
				-- TODO turn tailwindcss lsp only on for following filetypes:
				-- tailwindcss = {
				--   filetypes = { "astro", "html", "mdx", "css", "javascriptreact", "typescriptreact" }
				-- },
				pyright = {},
			}

			-- require('lspconfig.configs').eclair = {
			--   default_config = {
			--     cmd = { 'eclair', 'lsp' },
			--     filetypes = { 'eclair' },
			--     root_dir = lsp_util.find_git_ancestor,
			--     single_file_support = true,
			--   }
			-- }

			-- TODO
			-- local lsp_util = require("lspconfig.util")
			-- Eclair LSP is "special" because it is not available via Mason yet.
			-- require('lspconfig.configs').eclair = {
			--   default_config = {
			--     cmd = { '/home/luc/personal/eclair-lsp-server/dist/index.js', '--stdio' },
			--     filetypes = { 'eclair' },
			--     root_dir = lsp_util.find_git_ancestor,
			--     single_file_support = true,
			--   }
			-- }

			-- Ensure servers and tools are installed
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, { "stylua" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = { "isort", "black" },
				-- You can use a sub-list to tell conform to run *until* a formatter is found.
				javascript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
			},
		},
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"roobert/tailwindcss-colorizer-cmp.nvim",
		},
		config = function()
			local cmp = require("cmp")
			local compare = require("cmp").config.compare
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp", keyword_length = 2, group_index = 1, max_item_count = 30 },
					-- { name = 'buffer', keyword_length = 4 },  -- disabled, too spammy / got in the way
					{ name = "path" },
					--{ name = 'luasnip' },
				}),
				sorting = {
					priority_weight = 1.0,
					comparators = {
						compare.locality,
						compare.recently_used,
						compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
						compare.offset,
						compare.order,
					},
				},
				performance = {
					throttle = 550,
					fetching_timeout = 80,
					debounce = 500, -- wrong field?
					trigger_debounce_time = 500,
				},
				matching = {
					disallow_fuzzy_matching = true,
					disallow_fullfuzzy_matching = true,
					disallow_partial_fuzzy_matching = true,
					disallow_partial_matching = true,
					disallow_prefix_unmatching = false,
				},
			})

			local tw_color_cmp = require("tailwindcss-colorizer-cmp")
			tw_color_cmp.setup({ color_square_width = 2 })
			cmp.config.formatting = {
				format = tw_color_cmp.formatter,
			}
		end,
	},
	-- Treesitter:
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"lua",
				"vim",
				"comment",
				"c",
				"cpp",
				"go",
				"python",
				"rust",
				"llvm",
				"typescript",
				"tsx",
				"javascript",
				"astro",
				"prisma",
				"haskell",
				"bash",
				"terraform",
			},
			auto_install = true,
			highlight = { enable = true, disable = {} },
			indent = { enable = false, disable = { "python" } },
			context_commentstring = { enable = true },
			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
		},
		dependencies = {
			"julienhenry/tree-sitter-souffle",
			"lyxell/nvim-treesitter-souffle",
			"nvim-treesitter/playground",
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)

			--   url = "~/.local/share/nvim/site/pack/packer/start/tree-sitter-souffle",
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.souffle = {
				install_info = {
					--  change this path to wherever you installed julienhenry/tree-sitter-souffle
					url = "~/.config/nvim/pack/plugins/start/tree-sitter-souffle", -- TODO fix url
					files = { "src/parser.c" },
				},
			}
			parser_config.eclair = {
				install_info = {
					url = "~/personal/tree-sitter-eclair",
					files = { "src/parser.c" },
				},
			}
		end,
	},
	-- Fuzzy finder:
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x", -- Update this as newer releases come out.
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local telescope_actions = require("telescope.actions")
			local telescope_previewers = require("telescope.previewers")
			telescope.setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = telescope_actions.close,
							["<C-j>"] = telescope_actions.move_selection_next,
							["<C-k>"] = telescope_actions.move_selection_previous,
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
					file_previewer = telescope_previewers.vim_buffer_cat.new,
					grep_previewer = telescope_previewers.vim_buffer_vimgrep.new,
					qflist_previewer = telescope_previewers.vim_buffer_qflist.new,
				},
			})

			local load_telescope_plugins = function()
				telescope.load_extension("ui-select")
				-- TODO telescope.load_extension('fzf')
				--telescope.load_extension('fzy_native')
			end
			if not pcall(load_telescope_plugins) then
				print("Failed to load Telescope plugins!")
			end

			-- Keybindings
			vim.keymap.set(
				"n",
				"<C-p>",
				":Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>",
				{ noremap = true }
			)
			vim.keymap.set("n", "<leader>p", ":Telescope projects<cr>", { noremap = true })
			vim.keymap.set("n", "<leader>g", ":Telescope live_grep<cr>", { noremap = true })
			vim.keymap.set("n", "<leader>*", "*#:Telescope grep_string<cr>", { noremap = true })
			vim.keymap.set("n", "<leader>b", ":Telescope git_branches<cr>", { noremap = true })
			vim.keymap.set("n", "<leader>d", ":Telescope diagnostics<cr>", { noremap = true })
			vim.keymap.set("n", "<leader>a", ":lua vim.lsp.buf.code_action()<cr>", { noremap = true })
		end,
	},
	-- Git related plugins:
	"tpope/vim-fugitive",
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { hl = "GitGutterAdd", text = "|" },
				change = { hl = "GitGutterChange", text = "|" },
				delete = { hl = "GitGutterDelete", text = "|" },
				topdelete = { hl = "GitGutterDelete", text = "|" },
				changedelete = { hl = "GitGutterChange", text = "|" },
			},
		},
	},
	"rhysd/committia.vim",
	-- Projects / auto-cd to project root dir
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				detection_methods = { "pattern" }, -- { "pattern", "lsp" },
				patterns = { ".git", "_darcs", ".hg", ".bzr" },
			})
		end,
	},
	-- Text manipulation:
	"tpope/vim-surround",
	{
		"numToStr/Comment.nvim", -- TODO replace with existing nvim comment
		opts = {
			toggler = { line = "<leader>/" },
			opleader = { line = "<leader>/" },
		},
	},
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically:
	-- Icons:
	{ "kyazdani42/nvim-web-devicons", lazy = true },
	-- Lisp REPL, directly in neovim
	{
		"Olical/conjure",
		ft = { "fennel", "racket" },
		-- [Optional] cmp-conjure for cmp
		dependencies = {
			{
				"PaterJason/cmp-conjure",
				config = function()
					local cmp = require("cmp")
					local config = cmp.get_config()
					table.insert(config.sources, {
						name = "buffer",
						option = {
							sources = {
								{ name = "conjure" },
							},
						},
					})
					cmp.setup(config)
				end,
			},
			"Olical/aniseed",
		},
		config = function()
			require("conjure.main").main()
			require("conjure.mapping")["on-filetype"]()
		end,
		init = function()
			-- Set configuration options here
			vim.g["conjure#debug"] = true
		end,
	},
})
