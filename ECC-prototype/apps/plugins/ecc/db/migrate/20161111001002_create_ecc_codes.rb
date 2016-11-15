class CreateEccCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :plugins_ecc_codes do |t|
      t.string :code_title, :null => false
      t.text :code_content, :null => false
      t.integer :org_id, :null => false, index: true
      t.datetime :code_year, :null => false
      t.datetime :date_pub, :null => false, :default => Time.now
    end
  end
end
