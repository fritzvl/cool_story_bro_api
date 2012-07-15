require 'spec_helper'

describe "Story Model" do
  let(:story) { Story.new }
  it 'can be created' do
    story.should_not be_nil
  end
end
