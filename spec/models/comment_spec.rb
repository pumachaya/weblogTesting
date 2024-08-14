require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Test validations
  it 'is valid with a commenter and body' do
    sample_post = Post.create!(title: "Sample Post", body: "Sample body", author: "Sample Author")
    comment = Comment.new(commenter: "Chayanis", body: "This is a comment", post: sample_post)
    expect(comment).to be_valid
  end

  it 'is invalid without a commenter' do
    sample_post = Post.create!(title: "Sample Post", body: "Sample body", author: "Sample Author")
    comment = Comment.new(commenter: nil, body: "This is a comment", post: sample_post)
    expect(comment).to be_invalid
    expect(comment.errors[:commenter]).to include("can't be blank")
  end

  it 'is invalid without a body' do
    sample_post = Post.create!(title: "Sample Post", body: "Sample body", author: "Sample Author")
    comment = Comment.new(commenter: "Chayanis", body: nil, post: sample_post)
    expect(comment).to be_invalid
    expect(comment.errors[:body]).to include("can't be blank")
  end

  # Test associations
  it 'belongs to a post' do
    sample_post = Post.create!(title: "Sample Post", body: "Sample body", author: "Sample Author")
    comment = Comment.create!(commenter: "Chayanis", body: "This is a comment", post: sample_post)
    expect(comment.post).to eq(sample_post)
  end
end