return {
    "live-share.nvim",
    lazy = true,
    cmd = { "LiveShareHostStart", "LiveShareJoin", "TSJJoin" },
    after = function()
        require("live-share.provider").register("lan", {
            command = function(_, port, service_url)
                return string.format(
                    [[printf 'tcp://localhost:%d\n' > %s; sleep infinity]],
                    port, service_url)
            end,
            pattern = "tcp://[%w._-]+:%d+",
        })
        require("live-share").setup({
            username = "ignacy",
            port = 2137,
            service = "lan"
        })
    end
}

