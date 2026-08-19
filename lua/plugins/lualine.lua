return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-mini/mini.icons',
    {
      "letieu/harpoon-lualine",
      dependencies = {
        {
          "ThePrimeagen/harpoon",
          branch = "harpoon2",
        }
      },
    }
  },
  config = function()
    -- harpoon-lualine caps the marks it shows at #indicators, so build a
    -- fixed-size list of formatters that render the mark's file name.
    local function indicators(fmt)
      local list = {}
      for i = 1, 9 do
        list[i] = function(item)
          return fmt(i, vim.fn.fnamemodify(item.value, ':t'))
        end
      end
      return list
    end

    require('lualine').setup({
      sections = {
        lualine_c = {
          'filename',
          {
            'harpoon2',
            indicators = indicators(function(i, name) return i .. ' ' .. name end),
            active_indicators = indicators(function(i, name) return '[' .. i .. ' ' .. name .. ']' end),
          },
        }
      }
    })
  end,
}
