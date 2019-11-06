class Application

  @@items = ["Apples","Carrots","Pears"]
  
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    
    elsif req.path.match(/add/)
      item = req.params["q"]
      if @@cart.include?(item) == false
        @@cart << item
        resp.write "added Figs"
      elsif @@items.include?(item) == false
        resp.write "We don't have that item"
      else
        resp.write "#{item} already in your cart.\n"  
      end
    
    elsif req.path.match(/cart/)
      if @@cart.count == 0
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    else
        resp.write "We don't have that item"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
  
end
