# frozen_string_literal: true

class ChangeReviewsCountAndAvailabilityInBooks < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up   { migrate_up }
      dir.down { migrate_down }
    end
  end

  private

  # ---- up side ----
  def migrate_up
    change_reviews_count_up
    change_availability_up
    enforce_title_constraints_up # ← 追加
  end

  def change_reviews_count_up
    change_column :books, :reviews_count,
                  "integer USING COALESCE(NULLIF(reviews_count, '')::integer, 0)"
    change_column_default :books, :reviews_count, from: nil, to: 0
    execute 'UPDATE books SET reviews_count = 0 WHERE reviews_count IS NULL'
    change_column_null :books, :reviews_count, false
  end

  def change_availability_up
    change_column :books, :availability, <<~SQL.squish
      boolean USING CASE
        WHEN availability IN ('1','t','true','TRUE','True') THEN true
        WHEN availability IN ('0','f','false','FALSE','False') THEN false
        ELSE true
      END
    SQL
    change_column_default :books, :availability, from: nil, to: true
    execute 'UPDATE books SET availability = TRUE WHERE availability IS NULL'
    change_column_null :books, :availability, false
  end

  def enforce_title_constraints_up
    execute <<~SQL.squish
      UPDATE books
      SET title = 'Untitled'
      WHERE title IS NULL OR length(btrim(title)) = 0;
    SQL

    # 空白のみ禁止のCHECK
    add_check_constraint :books,
                         'length(btrim(title)) > 0',
                         name: 'books_title_not_blank'

    # NOT NULL 付与
    change_column_null :books, :title, false
  end

  # ---- down side ----
  def migrate_down
    change_reviews_count_down
    change_availability_down
    enforce_title_constraints_down # ← 追加
  end

  def change_reviews_count_down
    change_column_null :books, :reviews_count, true
    change_column_default :books, :reviews_count, from: 0, to: nil
    change_column :books, :reviews_count, :text
  end

  def change_availability_down
    change_column_null :books, :availability, true
    change_column_default :books, :availability, from: true, to: nil
    change_column :books, :availability, :text
  end

  def enforce_title_constraints_down
    change_column_null :books, :title, true
    remove_check_constraint :books, name: 'books_title_not_blank'
  end
end
