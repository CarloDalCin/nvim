-- Handler personalizzati per llama-server locale
local function local_llm_streaming_handler(chunk, ctx, F)
    if not chunk then
        return ctx.assistant_output
    end

    local tail = chunk:sub(-1, -1)
    if tail:sub(1, 1) ~= "}" then
        ctx.line = ctx.line .. chunk
    else
        ctx.line = ctx.line .. chunk
        local status, data = pcall(vim.fn.json_decode, ctx.line)

        -- Gestisci formato OpenAI/llama-server
        if status and data then
            local content = ""
            if data.choices and data.choices[1] and data.choices[1].delta and data.choices[1].delta.content then
                content = data.choices[1].delta.content
            elseif data.choices and data.choices[1] and data.choices[1].message and data.choices[1].message.content then
                content = data.choices[1].message.content
            end

            if content and content ~= "" then
                ctx.assistant_output = ctx.assistant_output .. content
                F.WriteContent(ctx.bufnr, ctx.winid, content)
            end
        end
        ctx.line = ""
    end
    return ctx.assistant_output
end

local function local_llm_parse_handler(chunk)
    -- Gestisci formato OpenAI/llama-server
    if chunk.choices and chunk.choices[1] and chunk.choices[1].message then
        return chunk.choices[1].message.content
    end
    return ""
end

local function local_llm_completion_handler(chunk, ctx, F)
    if not chunk then
        return ctx.assistant_output
    end

    local status, data = pcall(vim.fn.json_decode, chunk)
    if status and data and data.choices and data.choices[1] then
        local content = ""
        if data.choices[1].delta and data.choices[1].delta.content then
            content = data.choices[1].delta.content
        elseif data.choices[1].message and data.choices[1].message.content then
            content = data.choices[1].message.content
        end

        if content and content ~= "" then
            ctx.assistant_output = ctx.assistant_output .. content
            if F and F.WriteContent then
                F.WriteContent(ctx.bufnr, ctx.winid, content)
            end
        end
    end

    return ctx.assistant_output
end

return {
    "Kurama622/llm.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim"
    },
    cmd = {
        "LLMSessionToggle",
        "LLMSelectedTextHandler",
        "LLMAppHandler"
    },
    config = function()
        local tools = require("llm.tools")
        require("llm").setup({
            prompt = "You are a professional programmer.",

            -- Configurazione per llama-server locale
            url = "http://localhost:8080/v1/chat/completions",
            model = "deepseek-coder",
            api_type = "ollama",

            -- Handler personalizzati per modello locale
            streaming_handler = local_llm_streaming_handler,
            parse_handler = local_llm_parse_handler,

            fim = true,
            enable_completion = true,

            ---------------- App handlers per AI tools ---------------
            app_handler = {
                -- Configurazione per il code completion
                Completion = {
                    handler = tools.completion_handler,
                    opts = {
                        backend = "llm",
                        style = "blink.cmp",
                        url = "http://localhost:8080/v1/chat/completions",
                        model = "deepseek-coder",
                        api_type = "ollama",

                        parse_handler = local_llm_parse_handler,

                        -- Parametri ottimizzati per modello locale
                        n_completions = 1,
                        context_window = 512,
                        max_tokens = 128,
                        temperature = 0.1,
                        top_p = 0.9,

                        -- Comportamento del trigger
                        auto_trigger = true,
                        only_trigger_by_keywords = false,

                        -- Timing ottimizzato
                        timeout = 30,
                        throttle = 1500,
                        debounce = 600,

                        -- Parametri aggiuntivi
                        stream = true,
                        stop = { "\n\n", "```", "//", "#", "/*" },
                    },
                },

                -- Handler per traduzione (esempio)
                WordTranslate = {
                    handler = tools.flexi_handler,
                    prompt = "Translate the following text to Italian, please only return the translation",
                    opts = {
                        url = "http://localhost:8080/v1/chat/completions",
                        model = "local-model",
                        api_type = "ollama",
                        parse_handler = local_llm_parse_handler,
                        exit_on_move = true,
                        enter_flexible_window = false,
                    },
                },

                -- Handler per ottimizzazione codice
                OptimCompare = {
                    handler = tools.side_by_side_handler,
                    prompt =
                    "Optimize the following code for better performance and readability. Only return the optimized code without explanations.",
                    opts = {
                        url = "http://localhost:8080/v1/chat/completions",
                        model = "local-model",
                        api_type = "ollama",
                        parse_handler = local_llm_parse_handler,
                    },
                },
            },

            ---------------- set your keymaps for interaction ---------------
            keys = {
                ["Input:Submit"] = { mode = "n", key = "<cr>" },
                ["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" },
                ["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" },
            },
        })
    end,
    keys = {
        { "<leader>ac", mode = "n", "<cmd>LLMSessionToggle<cr>",            desc = "Toggle LLM Chat" },
        { "<leader>ao", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>",  desc = "Optimize Code" },
        { "<leader>cp", mode = "n", "<cmd>LLMAppHandler Completion<cr>",    desc = "Toggle LLM Completion" },
        { "<leader>tr", mode = "x", "<cmd>LLMAppHandler WordTranslate<cr>", desc = "Translate Text" },
    },
}
