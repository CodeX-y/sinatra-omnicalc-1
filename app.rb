require "sinatra"
require "sinatra/reloader"

get("/") do
  erb(:calc_square)
end

get("/square/new") do
  erb(:calc_square)
end

get("/square_root/new") do
  erb(:calc_square_root)
end

get("/payment/new") do
  erb(:calc_payment)
end

get("/random/new") do
  erb(:calc_random)
end

get("/square/results") do
  @num = params.fetch("user_number").to_f
  @squared = @num ** 2
  
  erb(:square_results)
end

get("/square_root/results") do
  @num = params.fetch("user_number").to_f
  @square_root = Math.sqrt(@num)
  
  erb(:square_root_results)
end

get("/random/results") do
  @min = params.fetch("user_min").to_f
  @max = params.fetch("user_max").to_f
  @random = rand(@min..@max)
  
  erb(:random_results)
end

helpers do
  def to_s_currency(number)
    whole, decimal = sprintf('%.2f', number).split('.')
    whole_with_commas = whole.chars.to_a.reverse.each_slice(3).map(&:join).join(',').reverse
    "$#{whole_with_commas}.#{decimal}"
  end
end

get("/payment/results") do
  @apr = params.fetch("user_apr").to_f
  @years = params.fetch("user_years").to_i
  @pv = params.fetch("user_pv").to_f

  # Convert APR from a percentage to a decimal and divide by 12 for the monthly rate
  @r = (@apr / 100) / 12

  # Convert years to months
  @n = @years * 12

  # Calculate and round the payment amount
  @p = (@r * @pv) / (1 - ((1 + @r) ** (-@n)))
  @apr = @apr.round(4)
  @p = to_s_currency(@p.round(2))
  @pv = to_s_currency(@pv)

  erb(:payment_results)
end
