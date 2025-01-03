---@param on boolean
require "util.configure".wo(function(on)
                              return {
                                number = not on,
                                signcolumn = on and "no" or "yes",
                                fillchars = on and "eob: " or "",
                              }
                            end, "User", "AlphaReady")
