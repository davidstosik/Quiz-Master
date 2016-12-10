class AddTitleToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :title, :string, null: false, default: ''
  end
end
