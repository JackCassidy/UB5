require "spec_helper"

describe InfilesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/infiles")).to route_to("infiles#index")
    end

    it "routes to #new" do
      expect(get("/infiles/new")).to route_to("infiles#new")
    end

    it "routes to #show" do
      expect(get("/infiles/1")).to route_to("infiles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/infiles/1/edit")).to route_to("infiles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/infiles")).to route_to("infiles#create")
    end

    it "routes to #update" do
      expect(put("/infiles/1")).to route_to("infiles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/infiles/1")).to route_to("infiles#destroy", :id => "1")
    end

  end
end
