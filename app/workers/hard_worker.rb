require 'sidekiq-scheduler'
class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    orders = Order.where(state: 'in_transit')
    orders.each{ |order| order.arrive!}
  end
end
