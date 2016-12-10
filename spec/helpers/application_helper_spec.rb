require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#markdown' do
    it "calls Redcarpet's #render method" do
      expect_any_instance_of(Redcarpet::Markdown).to receive(:render) { '' }
      helper.markdown('simple text')
    end
    it 'initializes Markdown only once' do
      expect(Redcarpet::Markdown).to receive(:new).once.and_call_original
      helper.markdown('simple text')
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
    it 'converts two consecutive new lines to a new paragraph' do
      expect(helper.markdown("new\n\nline")).to eq("<p>new</p>\n\n<p>line</p>\n")
    end
  end

  describe '#navbar_links' do
    it 'returns questions, quiz and random' do
      expect(helper.navbar_links.keys).to eq [:questions, :quiz, :random]
    end
    it 'returns a URI for each link' do
      helper.navbar_links.each do |_, item|
        expect(item[:uri]).not_to be_blank
      end
    end
    context 'when on specific controller#action' do
      before do
        allow(helper).to receive(:controller_name) { controller_name }
        allow(helper).to receive(:action_name) { action_name }
      end

      context 'Questions#[any]' do
        let(:controller_name) { 'questions' }
        it "sets 'questions' as the active item" do
          expect(helper.navbar_links.select { |_, item| item[:active] }.keys).to eq [:questions]
        end
      end

      context 'Quiz#[any but random]' do
        let(:controller_name) { 'quiz' }
        it "sets 'quiz' as the active item" do
          expect(helper.navbar_links.select { |_, item| item[:active] }.keys).to eq [:quiz]
        end
      end

      context 'Quiz#random' do
        let(:controller_name) { 'quiz' }
        let(:action_name) { 'random' }
        it "sets 'random' as the active item" do
          expect(helper.navbar_links.select { |_, item| item[:active] }.keys).to eq [:random]
        end
      end
    end
  end
end
