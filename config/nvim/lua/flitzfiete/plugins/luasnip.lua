local ls = require("luasnip")

local M = {}

M.setup = function()
    ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
    })

    -- JS/TS/Svelte/Vue
    local jsSnippets = {
        ls.parser.parse_snippet("clg", "console.log($0)"),
        ls.parser.parse_snippet("imp", "import $2 from '$1'$0"),
        ls.parser.parse_snippet("imd", "import { $2 } from '$1'$0"),
    }

    ls.add_snippets("typescript", jsSnippets)
    ls.add_snippets("javascript", jsSnippets)
    ls.add_snippets("svelte", jsSnippets)
    ls.add_snippets("vue", jsSnippets)

    -- Vue
    ls.add_snippets("vue", {
        ls.parser.parse_snippet("defineProps", "defineProps<{\n  $0\n}>()"),
        ls.parser.parse_snippet("props", "const props = defineProps<{\n  $0\n}>()"),
        ls.parser.parse_snippet("script", '<script ${1:lang="ts"}${2: setup}>\n  $0\n</script>'),
        ls.parser.parse_snippet("style", '<style ${1:lang="scss"}${2: scoped}>\n  $0\n</style>'),
    })

    -- PHP
    ls.add_snippets("php", {
        ls.parser.parse_snippet("class", "class $1\n{\n    $0\n}"),
        ls.parser.parse_snippet("pubf", "public function $1($2): $3\n{\n    $0\n}"),
        ls.parser.parse_snippet("prif", "private function $1($2): $3\n{\n    $0\n}"),
        ls.parser.parse_snippet("prof", "protected function $1($2): $3\n{\n    $0\n}"),
        ls.parser.parse_snippet("testt", "public function test_$1()\n{\n    $0\n}"),
        ls.parser.parse_snippet("testa", "/** @test */\npublic function $1()\n{\n    $0\n}"),
    })

    -- takes care to not jump around in the document by tabbing
    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            if ls.session.current_nodes[vim.api.nvim_get_current_buf()] and not ls.session.jump_active then
                ls.unlink_current()
            end
        end,
    })
end

return M
