-- HOME

hl.monitor({
    output = "desc:Acer Technologies VG242Y P TL7EE0033E00",
    mode = "1920x1080",
    position = "0x0",
    scale = "1",
})

hl.monitor({
    output = "desc:AOC 25G3ZM WKRN9HA006774",
    mode = "1920x1080",
    position = "1920x0",
    scale = "1",
})

hl.monitor({
    output = "desc:ASUSTek COMPUTER INC VG248 LALMQS189709",
    mode = "1920x1080",
    position = "3840x0",
    scale = "1",
})

hl.workspace_rule({
    workspace = "1",
    monitor = "desc:Acer Technologies VG242Y P TL7EE0033E00",
})

hl.workspace_rule({
    workspace = "2",
    monitor = "desc:AOC 25G3ZM WKRN9HA006774",
})

hl.workspace_rule({
    workspace = "3",
    monitor = "desc:ASUSTek COMPUTER INC VG248 LALMQS189709",
})

-- WORK

hl.monitor({
    output = "desc:BOE 0x0CF2",
    mode = "1920x1080",
    position = "0x0",
    scale = "1",
})

hl.monitor({
    output = "desc:HP Inc. HP V27ie G5 3CM41508QM",
    mode = "1920x1080",
    position = "1920x0",
    scale = "1",
})

hl.monitor({
    output = "desc:HP Inc. HP 27fw 3CM9441FLX",
    mode = "1920x1080",
    position = "3840x0",
    scale = "1",
})

hl.workspace_rule({
  workspace = "1",
  monitor = "desc:HP Inc. HP V27ie G5 3CM41508QM",
})

hl.workspace_rule({
  workspace = "2",
    monitor = "desc:desc:HP Inc. HP 27fw 3CM9441FLX",
})

hl.workspace_rule({
  workspace = "0",
  monitor = "desc:BOE 0x0CF2",
})
