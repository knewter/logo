defmodule Logo.Window do
  @moduledoc """
  A window to draw our logo program within.
  """

  @title 'Logo'
  @side 5.0

  require Record
  Record.defrecordp :wx, Record.extract(:wx, from_lib: "wx/include/wx.hrl")
  Record.defrecordp :wxClose, Record.extract(:wxClose, from_lib: "wx/include/wx.hrl")
  Record.defrecordp :wxCommand, Record.extract(:wxCommand, from_lib: "wx/include/wx.hrl")
  Record.defrecordp :wxKey, Record.extract(:wxKey, from_lib: "wx/include/wx.hrl")
  Record.defrecordp :wxPaint, Record.extract(:wxPaint, from_lib: "wx/include/wx.hrl")

  defmodule State do
    defstruct pixels: []
  end

  def start(config) do
    do_init(config)
  end

  def init(config) do
    :wx.batch(fn() -> do_init(config) end)
  end

  def do_init(_config) do
    wx = :wx.new
    frame = :wxFrame.new(wx, -1, @title, size: {1000, 1000})
    panel = :wxPanel.new(frame, [])

    main_sizer = :wxBoxSizer.new(:wx_const.wx_vertical)
    sizer = :wxStaticBoxSizer.new(:wx_const.wx_vertical, panel)
    win = :wxPanel.new(panel, [style: :wx_const.wx_full_repaint_on_resize])

    :wxPanel.connect(win, :paint, [:callback])
    :wxPanel.connect(win, :size)

    :wxSizer.add(sizer, win, [flag: :wx_const.wx_expand, proportion: 1])
    :wxSizer.add(main_sizer, sizer, [flag: :wx_const.wx_expand, proportion: 1])
    :wxPanel.setSizer(panel, main_sizer)
    :wxFrame.show(frame)
    receive do
      :ok -> :ok
      after 1000 ->
        dc = :wxPaintDC.new(win)
        draw(:ok, dc)
    end
    receive do
      :ok -> :ok
    end
    :wxPaintDC.destroy(dc)
  end

  def draw(state, dc) do
    do_draw(state, dc)
  end

  def do_draw(_state, dc) do
    canvas = :wxGraphicsContext.create(dc)
    brush = :wxBrush.new({255, 0, 0, 255})
    draw_square(canvas, 10, 10, brush)
  end

  def draw_square(canvas, x, y, brush) do
    :wxGraphicsContext.setBrush(canvas, brush)
    :wxGraphicsContext.setPen(canvas, :wx_const.wx_black_pen)
    true_x = @side * x
    true_y = @side * y
    :wxGraphicsContext.drawRectangle(canvas, true_x, true_y, @side, @side)
    :ok
  end
end
