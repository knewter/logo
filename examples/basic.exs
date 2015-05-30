{:ok, logo} = Logo.Instance.start
logo
|> color({255, 0, 0})
|> pen_down
|> forward(400)
|> right(90)
|> forward(200)
|> right(180)
|> forward(400)
