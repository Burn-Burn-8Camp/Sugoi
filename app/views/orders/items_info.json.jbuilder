json.array! @items do |item|
	json.id item.id
	json.name item.name
	json.price item.price
	json.quantity item.quantity
	json.rate item.comment ? item.comment.rate : 0
end