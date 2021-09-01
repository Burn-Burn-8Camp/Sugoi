module UsersHelper
  def rank_icon(rank_name)
    if rank_name == "sliver"
      "success"
    else
      "other"
    end      
  end
end
