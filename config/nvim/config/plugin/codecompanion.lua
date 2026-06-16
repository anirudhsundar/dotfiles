require("codecompanion").setup({
  interactions = {
    inline = {
      keymaps = {
        accept_change = {
          modes = { n = "ga" },
          description = "Accept the suggested change",
        },
        reject_change = {
          modes = { n = "gr" },
          opts = { nowait = true },
          description = "Reject the suggested change",
        },
      },
    },
    chat = {
      adapter = {
        name = "opencode",
        model = "Arm-proxy-Work/gpt-5.4",
      },
    },
  },
})
