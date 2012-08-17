require "spec_helper"

describe EventMessagesController do
  describe "routing" do

    it "routes to #index" do
      get("/event_messages").should route_to("event_messages#index")
    end

    it "routes to #new" do
      get("/event_messages/new").should route_to("event_messages#new")
    end

    it "routes to #show" do
      get("/event_messages/1").should route_to("event_messages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/event_messages/1/edit").should route_to("event_messages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/event_messages").should route_to("event_messages#create")
    end

    it "routes to #update" do
      put("/event_messages/1").should route_to("event_messages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/event_messages/1").should route_to("event_messages#destroy", :id => "1")
    end

  end
end
