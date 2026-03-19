-- ==========================================================================
-- NEOVIM BASIC CONFIGURATION (init.lua)
-- ==========================================================================

-- Load options first (global settings)
require("core.options")

-- Load key mappings
require("core.mappings")

-- Load automation and highlights
require("core.autocommands")

-- Load custom user commands
require("commands")

-- Plugins
require("core.lazy")
