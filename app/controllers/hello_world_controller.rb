class HelloWorldController < ApplicationController
  def index
    @hello_world_props = { name: "Stranger" }
    # 預設變數hash
    @count = {init: 3}
    # 變數只能是hash
  end
end
