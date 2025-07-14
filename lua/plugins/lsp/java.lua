

return {
    "nvim-java/nvim-java",

    -- config = false,
    -- dependencies = {
    --     {
    --         "neovim/nvim-lspconfig",
    --         opts = {
    --             servers = {
    --                 -- Your JDTLS configuration goes here
    --                 jdtls = {
    --                     -- settings = {
    --                     --   java = {
    --                     --     configuration = {
    --                     --       runtimes = {
    --                     --         {
    --                     --           name = "JavaSE-23",
    --                     --           path = "C:/Program Files/Amazon Corretto/jdk21.0.6_7/bin/java.exe",
    --                     --         },
    --                     --       },
    --                     --     },
    --                     --   },
    --                     -- },
    --                 },
    --             },
    --             setup = {
    --               jdtls = function()
    --                 -- Your nvim-java configuration goes here
    --                 require("java").setup({
    --                   root_markers = {
    --                     "settings.gradle",
    --                     "settings.gradle.kts",
    --                     "pom.xml",
    --                     "build.gradle",
    --                     "mvnw",
    --                     "gradlew",
    --                     "build.gradle",
    --                     "build.gradle.kts",
    --                   },
    --                 })
    --               end,
    --             },
    --         },
    --     },
    -- },
}
