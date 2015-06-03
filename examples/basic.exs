import Logo.Instance

{:ok, logo} = Logo.Instance.start
logo
|> move_to({300, 300})
|> color({255, 0, 0})
|> pen_down
|> forward(400)
|> right(90)
|> forward(200)
|> right(180)
|> forward(400)

Logo.Window.start(logo)
