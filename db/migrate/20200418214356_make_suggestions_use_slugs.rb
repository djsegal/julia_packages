class MakeSuggestionsUseSlugs < ActiveRecord::Migration[6.0]
  def self.up
    add_column :suggestions, :package_slug, :string
    add_column :suggestions, :category_slug, :string
    add_column :suggestions, :sub_category_slug, :string

    Suggestion.all.each do |suggestion|
      suggestion.update!(
        package_slug: suggestion.package.slug,
        category_slug: suggestion.category.slug,
        sub_category_slug: suggestion.sub_category.slug
      )
    end

    remove_reference :suggestions, :package
    remove_reference :suggestions, :category
    remove_reference :suggestions, :sub_category
  end

  def self.down
    add_reference :suggestions, :package, index: true
    add_reference :suggestions, :category, index: true
    add_reference :suggestions, :sub_category, index: true

    Suggestion.all.each do |suggestion|
      suggestion.update!(
        package: Package.friendly.find(suggestion.package_slug),
        category: Category.friendly.find(suggestion.category_slug),
        sub_category: Category.friendly.find(suggestion.sub_category_slug)
      )
    end

    remove_column :suggestions, :package_slug, :string
    remove_column :suggestions, :category_slug, :string
    remove_column :suggestions, :sub_category_slug, :string
  end
end
