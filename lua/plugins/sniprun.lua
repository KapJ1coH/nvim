local flag = true
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    flag = false

end
return {
    "michaelb/sniprun",
    branch = "master",
    lazy = false,
    enabled = flag,

    build = "sh install.sh",
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

    config = function()
        require("sniprun").setup({
            -- your options
            interpreter_options = {
                C_original = {
                    compiler = "gcc"
                }
            },
        })
    end,
}
