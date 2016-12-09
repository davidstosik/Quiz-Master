require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the QuestionsHelper. For example:
#
# describe QuestionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#markdown' do
    it "calls Redcarpet's #render method" do
      expect_any_instance_of(Redcarpet::Markdown).to receive(:render) { '' }
      helper.markdown('simple text')
    end
    it 'returns safe HTML' do
      expect(helper.markdown('simple text')).to be_html_safe
    end
    it 'outputs simple text in a paragraph' do
      expect(helper.markdown('simple text')).to eq("<p>simple text</p>\n")
    end
    it 'escapes HTML tags' do
      expect(helper.markdown('<em>text</em>')).to eq("<p>&lt;em&gt;text&lt;/em&gt;</p>\n")
    end
    it 'converts Markdown to HTML' do
      expect(helper.markdown('**bold**')).to eq("<p><strong>bold</strong></p>\n")
    end
    it 'converts one new line to a break tags' do
      expect(helper.markdown("new\nline")).to eq("<p>new<br>\nline</p>\n")
    end
    it 'converts two consecutive new lines to a pnew paragraph' do
      expect(helper.markdown("new\n\nline")).to eq("<p>new</p>\n\n<p>line</p>\n")
    end
  end
end
