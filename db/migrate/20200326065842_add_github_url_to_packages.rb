class AddGithubUrlToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :github_url, :string
  end
end
