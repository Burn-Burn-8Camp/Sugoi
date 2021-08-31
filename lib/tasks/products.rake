namespace :items do
	desc "Generate fake products"
	task :fake => :environment do
		50.times do |i|
			product = FactoryBot.create(:product)
			puts "create product: #{i + 1} - #{product.name}"
		end
	puts "done!"
	end
end
# 做一個rake 命令 來產生50筆假資料