require("codecompanion").setup({
interactions = {
  chat = {
    adapter = {
      name = "opencode",
      model = "Arm-proxy-Work/gpt-5.4",
    },
  },
},
})
