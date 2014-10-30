require "spec_helper"

describe ProteinsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/proteins")).to route_to("proteins#index")
    end

    it "routes to #new" do
      expect(get("/proteins/new")).to route_to("proteins#new")
    end

    it "routes to #show" do
      expect(get("/proteins/1")).to route_to("proteins#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/proteins/1/edit")).to route_to("proteins#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/proteins")).to route_to("proteins#create")
    end

    it "routes to #update" do
      expect(put("/proteins/1")).to route_to("proteins#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/proteins/1")).to route_to("proteins#destroy", :id => "1")
    end

  end
end
