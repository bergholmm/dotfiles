local hooks = require "core.hooks"

-- Install custom plugins
-- local customPlugins = require "core.customPlugins"
--
customPlugins.add(function(use)
   use {
      "ntpeters/vim-better-whitespace",
      event = "BufRead",
      opt = true,
   }
end)

-- hooks.add("install_plugins", function(use)
--    -- use {
--    --    "ntpeters/vim-better-whitespace",
--    --    event = "BufRead",
--    --    opt = true,
--    -- },
--    use {
--      "mg979/vim-visual-multi",
--      event = "BufRead",
--      opt = true,
--    },
-- end)
