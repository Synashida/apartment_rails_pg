# apartment_rails_pg

Apartment Gemを使った実装のサンプルです。
DBはPostgreSQLを利用しています。
RackサーバのPowを利用してサブドメイン動作を確認しています。

# コード要点
Gemfile
gem 'apartment'
gem 'pg'

bundle install
bundle exec rails g scaffold tenant subdomain:string
bundle exec rails g apartment:install
vi config/initializers/apartment.rb
　Tenantモデルを除外し、subdomainをテナントのキーに利用する設定を追加
　（ダウンロード後のconfig/initializers/apartment.rbを参照してください）
bundle exec rails g shop name:string
bundle exec rake db:create
bundle exec rake db:migrate

これで動作確認ができたらサンプルの環境設定は完了

Tenantのsubdomain登録作成直後にApartmentを実行して、subdomain用のスキーマの作成実行
app/controllers/tenants_controller.rb のdef createメソッド内に
Apartment::Tenant.create(@tenant.subdomain)の記述があります。
ここでsubdomain用のスキーマをApartmentGemに作成させるようにさせています。

# ダウンロード後の環境構築手順
1.Powのインストール
curl get.pow.cx | sh
cd ~/.pow
ln -s ダウンロードしたプロジェクトのパス/apartment_rails_pg-master apartment_rails_pg-master

2.apartment_rails_pg-masterの環境構築
cd apartment_rails_pg-master
vi config/database.yml
  usernameとpasswordをご自身の環境に合わせてください
bundle install --path vendor/bundle
bundle exec rake db:create
bundle exec rake db:migrate

3.動作確認
http://apartment_rails_pg-master.dev/tenants/
　New Tenant -> Subdomainにtestと入力し、Create Tenantボタンをクリック
　Tenant was successfully created.の後で
http://test.apartment_rails_pg-master.dev/shops/
　にアクセスができることを確認
　New Shop -> Test Shopを入力 -> Create Shopをクリック
http://apartment_rails_pg-master.dev/tenants/
　に戻り、New Tenant -> Subdomainにnew_tenantと入力し、Create Tenantボタンをクリック
　Tenant was successfully created.の後で
http://new_tenant.apartment_rails_pg-master.dev/shops/
　にアクセスし、Shopが未登録であることを確認

PGAdminかpsqlコンソールでaparment_sample_pg_developmentにログインし、
スキーマにtestとnew_tenantのそれぞれが新規作成されていることを確認できれば
正しく実行できていることがわかります。
