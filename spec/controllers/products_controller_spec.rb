require 'spec_helper'

describe Spree::ProductsController do
  let!(:product) { create(:product, :available_on => 1.year.from_now) }

  it "allows admins to view non-active products" do
    controller.stub :current_spree_user => stub(:spree_admin? => true)
    get :show, :id => product.to_param
    response.status.should == 200
  end

  it "cannot view non-active products" do
    controller.stub :current_spree_user => stub(:spree_admin? => false)
    get :show, :id => product.to_param
    response.status.should == 404
  end
end
