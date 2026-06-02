return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml" },
    root_markers = { ".git" },
    settings = {
        yaml = {
            -- see for more schemas: https://www.reddit.com/r/neovim/comments/ze9gbe/kubernetes_auto_completion_support_in_neovim/
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "workflows/*.{yml,yaml}",
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
                "*gitlab-ci*.{yml,yaml}",
                kubernetes = {
                    "**/k8s/**/*.yaml",
                    "**/kubernetes/**/*.yaml",
                    "**/deploy/**/*.yaml",
                    "**/manifests/**/*.yaml",
                },
            },

            kubernetes = { enabled = true },
            validate = true,
            completion = true,
        },
    },
}
