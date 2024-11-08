return {
    "nomnivore/ollama.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    -- All the user commands added by the plugin
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    keys = {
        -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
        {
            "<leader>oo",
            ":<c-u>lua require('ollama').prompt()<cr>",
            desc = "ollama prompt",
            mode = { "n", "v" },
        },

        -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
        {
            "<leader>oG",
            ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
            desc = "ollama Generate Code",
            mode = { "n", "v" },
        },
    },

    ---@type Ollama.Config
    opts = {
        model = "llama3.2",
        url = "http://127.0.0.1:11434",
        serve = {
            on_start = false,
            command = "ollama",
            args = { "serve" },
            stop_command = "pkill",
            stop_args = { "-SIGTERM", "ollama" },
        },
        -- View the actual default prompts in ./lua/ollama/prompts.lua
        prompts = {
            Sample_Prompt = {
                prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
                input_label = "> ",
                model = "mistral",
                action = "display",
            },
            Generate_Docstring = {
                prompt =
                    [[
                    Generate a Python docstring in reStructuredText format for the following function. If any parameters or return types are missing type hints, add appropriate ones.
 
The docstring should include:
1. A short description of what the function does.
2. A "Parameters" section with `:param:` and `:type:` if needed, for each parameter.
3. A "Returns" section with `:return:` and `:rtype:` if needed, for the return value.
4. A "Raises" section with `:raises:` if the function raises any exceptions.
 
Function:
$sel]],
                input_label = "> ",
                model = "llama3.2",
                action = "display",
            },
            Todo_to_docstring = {
                prompt = [[
                    Replace the Todo in the code with appropriate text for this docstring. It has to follow the format.
                    Code: $sel
                ]],
                input_label = "> ",
                model = "llama3.2",
                action = "display",
            }

        }
    }
}
