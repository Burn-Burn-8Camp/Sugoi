json.array! @store_items do |item_arr|
	json.store_name item_arr.first.store.name
	json.items item_arr do |item|
		json.id item.id
		json.name item.name
		json.price item.price
		json.quantity item.quantity
		json.image_url item.product.image_url
		json.product_id item.product.slug
		json.rate item.comment ? item.comment.rate : 0
		json.content item.comment ? item.comment.content : ''
	end
end

