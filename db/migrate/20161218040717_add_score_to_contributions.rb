class AddScoreToContributions < ActiveRecord::Migration[5.0]
  def change
    add_column :contributions, :score, :integer
  end
end
