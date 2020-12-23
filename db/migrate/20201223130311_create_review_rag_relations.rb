class CreateReviewRagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :review_rag_relations do |t|
      t.references :review, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
