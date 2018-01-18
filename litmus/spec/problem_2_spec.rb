$LOAD_PATH.unshift File.expand_path '.'
require 'spec_helper'

describe 'Problem 2:' do
  it 'http://superstar.admin.com/connect.php should show successful connection' do
    response = request_to_connect_php
    expect(response.code.to_i).to be_equal(200)
    expect(response.body).to include('Connected successfully')
  end
end
