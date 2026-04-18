-- JDTLS (Java LSP) configuration
local home = vim.env.HOME -- Get the home directory

local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/jdtls-workspace/" .. project_name

local system_os = ""

-- Determine OS
if vim.fn.has("mac") == 1 then
  system_os = "mac"
elseif vim.fn.has("unix") == 1 then
  system_os = "linux"
elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  system_os = "win"
else
  print("OS not found, defaulting to 'linux'")
  system_os = "linux"
end

-- Needed for debugging
local bundles = {
  vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
}

-- Needed for running/debugging unit tests
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    -- Eclipse jdtls location
    "-jar",
    home .. "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. system_os,
    "-data",
    workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  -- @TODO Если проект не имеет подпроектов, то вместо stttings.gradle нужно указать build.gradle
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "settings.gradle" }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      -- TODO Replace this with the absolute path to your main java version (JDTLS requires JDK 21 or higher)
      home = "/opt/homebrew/Cellar/openjdk/25.0.2/bin/",
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        -- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
        -- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
        runtimes = {
          {
            name = "JavaSE-1.8",
            path = "/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home/",
          },
          {
            name = "JavaSE-17",
            path = home .. "/Library/Java/JavaVirtualMachines/ms-17.0.18/Contents/home/",
          },
          {
            name = "JavaSE-21",
            path = "/opt/homebrew/Cellar/openjdk@21/21.0.10/Contents/home/",
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      format = {
        enabled = true,
        -- Formatting works by default, but you can refer to a specific file/URL if you choose
        -- settings = {
        --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
        --   profile = "GoogleStyle",
        -- },
      },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  },
  -- Needed for auto-completion with method signatures and placeholders
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    -- References the bundles defined above to support Debugging and Unit Testing
    bundles = bundles,
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
}

-- Needed for debugging
config["on_attach"] = function(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = "auto" })
  require("jdtls.dap").setup_dap_main_class_configs()
end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)
-- =======
-- -- Скачать плагины
-- -- https://open-vsx.org/extension/vscjava/vscode-java-debug
-- -- https://open-vsx.org/extension/vscjava/vscode-java-test
-- -- Распаковать их как zip архивы и извлечь соотвествующие jar
-- -- Потом поместить их в ~/.local/share/vscode/
-- -- Дальше смотри настройку по ссылке
-- -- https://github.com/mfussenegger/nvim-jdtls/blob/master/README.md
-- local bundles = {
--     vim.fn.glob("~/.local/share/vscode/com.microsoft.java.debug.plugin-*.jar", 1),
-- }
-- local java_test_bundles = vim.split(vim.fn.glob("~/.local/share/vscode/test/server/*.jar", 1), "\n")
-- local excluded = {
--     "com.microsoft.java.test.runner-jar-with-dependencies.jar",
--     "jacocoagent.jar",
-- }
-- for _, java_test_jar in ipairs(java_test_bundles) do
--     local fname = vim.fn.fnamemodify(java_test_jar, ":t")
--
--     if not vim.tbl_contains(excluded, fname) then
--         table.insert(bundles, java_test_jar)
--     end
-- end
-- -- See `:help vim.lsp.start` for an overview of the supported `config` options.
-- --
-- local config = {
--     name = "jdtls",
--
--     -- `cmd` defines the executable to launch eclipse.jdt.ls.
--     -- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
--     --
--     -- As alternative you could also avoid the `jdtls` wrapper and launch
--     -- eclipse.jdt.ls via the `java` executable
--     -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--     cmd = { "jdtls" },
--
--     -- `root_dir` must point to the root of your project.
--     -- See `:help vim.fs.root`
--     root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),
--
--     -- Here you can configure eclipse.jdt.ls specific settings
--     -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--     -- for a list of options
--     settings = {
--         java = {
--             -- Custom eclipse.jdt.ls options go here
--             configuration = {
--                 runtimes = {
--                     {
--                         name = "JavaSE-21",
--                         path = "/opt/homebrew/Cellar/openjdk@21/21.0.10/",
--                     },
--                     {
--                         name = "JavaSE-17",
--                         path = "/Users/arcady/Library/Java/JavaVirtualMachines/ms-17.0.18/Contents/Home",
--                     },
--                 },
--             },
--         },
--     },
--
--     -- This sets the `initializationOptions` sent to the language server
--     -- If you plan on using additional eclipse.jdt.ls plugins like java-debug
--     -- you'll need to set the `bundles`
--     --
--     -- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
--     --
--     -- If you don't plan on any eclipse.jdt.ls plugins you can remove this
--     init_options = {
--         bundles = {},
--     },
-- }
-- config["init_option"] = {
--     bundles = bundles,
-- }
-- require("jdtls").start_or_attach(config)
-- >>>>>>> 2f2a9397ec19415d3d2ac2046f0afc1a34dc3356
