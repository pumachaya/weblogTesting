require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with valid attributes' do
    sample_post = Post.new(title: 'Sample Title', body: 'Sample Body', author: 'Sample Author')
    expect(sample_post).to be_valid
  end

  it 'is not valid without a title' do
    sample_post = Post.new(body: 'Sample Body', author: 'Sample Author')
    expect(sample_post).not_to be_valid
  end

  it 'is not valid without a body' do
    sample_post = Post.new(title: 'Sample Title', author: 'Sample Author')
    expect(sample_post).not_to be_valid
  end

  it 'is not valid without an author' do
    sample_post = Post.new(title: 'Sample Title', body: 'Sample Body')
    expect(sample_post).not_to be_valid
  end
end