# frozen_string_literal: true

Kaminari.configure do |config|
  # config.default_per_page = 25 # 1ページ辺りの項目数
  # config.max_per_page = nil    # 1ページ辺りの最大数
  config.window = 1            # ex 値が2の場合 .. 2 3 (4) 5 6 ..
  # config.outer_window = 0      # ex 値が2の場合 .. (4) .. 99 100
  # config.left = 0              # ...になったときの左側の表示数
  # config.right = 0             # ...になったときの右側の表示数
  # config.page_method_name = :page # メソッド名
  # config.param_name = :page    # ページネーションのパラメーターの名前
  # config.max_pages = nil
  # config.params_on_first_page = false
end
