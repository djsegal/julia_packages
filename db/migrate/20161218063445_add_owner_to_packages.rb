class AddOwnerToPackages < ActiveRecord::Migration[5.0]
  def change
    add_reference :packages, :owner, polymorphic: true
  end
end
