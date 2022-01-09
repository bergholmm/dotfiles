local hooks = require "core.hooks"

hooks.add("install_plugins", function(use)
   use {
      "ntpeters/vim-better-whitespace",
      event = "BufRead",
      opt = true,
   }

   use {
     "mg979/vim-visual-multi",
     event = "BufRead",
     opt = true,
   }

  use {
    "easymotion/vim-easymotion",
    event = "BufRead",
    opt = true,
  }

  use {
    "christoomey/vim-sort-motion",
    event = "BufRead",
    opt = true,
  }

  use {
    "godlygeek/tabular",
    event = "BufRead",
    opt = true,
  }

  use {
    "metakirby5/codi.vim",
    event = "BufRead",
    opt = true,
  }

end)
