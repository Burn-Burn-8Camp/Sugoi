module UsersHelper
  def rank_icon(rank_name)
    if rank_name == "general"
        # content_tag()
      "<i class='far fa-address-book's></i>" 
    else
      "other"
    end      
  end
end
