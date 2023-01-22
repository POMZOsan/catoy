# catoy :cat2: 
### **https://catoy.site**
![service_top](https://user-images.githubusercontent.com/100008647/206474834-a6e8409a-26f3-433d-b5a6-dd88bf244a29.jpg)

## :paw_prints:サービス概要
猫ちゃんが気に入るおもちゃを見つけられない飼い主に  
猫ちゃんのおもちゃのレビューを共有し  
レビューから猫ちゃんの性格に合うおもちゃを見つけられるサービス  

## :paw_prints:メインのターゲットユーザー
* 猫ちゃんを飼っている人
* 猫ちゃんが気に入るおもちゃが欲しい人  

## :paw_prints:ユーザーが抱える課題
猫ちゃんのために色々とおもちゃを買ってみるが、なかなか猫ちゃんが気に入るおもちゃに出会えない  

## :paw_prints:解決方法
他の飼い主さんが買ったおもちゃのレビューと猫ちゃんの性格から、自分の猫ちゃんに合ったおもちゃを見つける事ができる  

## :paw_prints:サービス作成の背景 
私自身、猫を１匹飼っています。愛猫の為におすすめのおもちゃを調べては購入していました。しかし、ランキング１位のおもちゃを買ってみても猫様は遊んでくれず、じっとみているだけ...。  
最終的にそのおもちゃは知人に譲渡することになりました...。  
我が家にはそんなおもちゃがたくさんあります。  
猫ちゃんの性格別におすすめのおもちゃを紹介してくれるサービスがあったら、飼い主のお財布にも優しいし、使われないおもちゃも増えないし、猫様も大満足で遊んでくれてストレス解消になるのではないかと思い、このサービスを作ろうと思いました。  

## :paw_prints:catoyの機能
|レビュー一覧|レビュー詳細|
|:--:|:--:|
|<img width="500" src="https://user-images.githubusercontent.com/100008647/213901778-2c79b225-3fdf-41f7-a30d-a93c540aa854.png">|<img width="500" alt="レビュー詳細" src="https://user-images.githubusercontent.com/100008647/213901796-ce1b984a-b21b-49bf-a025-2192997d5476.png">|
|レビュー作成1|レビュー作成2:商品選択|
|<img width="500" alt="レビュー作成1" src="https://user-images.githubusercontent.com/100008647/213901805-f23333d1-9259-41ac-912c-80bb9b353928.png">|<img width="500" alt="モーダル表示" src="https://user-images.githubusercontent.com/100008647/213901816-d0cf9412-a350-453d-b07d-3d7f6db80cb9.png">|
|レビュー作成3:商品選択後|ユーザー詳細|
|<img width="500" alt="商品選択後" src="https://user-images.githubusercontent.com/100008647/213901829-9ea5f89d-2a2c-4f31-892f-e91efbc2367d.png">|<img width="500" alt="ユーザープロフィール" src="https://user-images.githubusercontent.com/100008647/213901842-1888fff3-4b8f-4a1d-ba47-1795b4fb71e3.png">|
|ランキング|レビュー検索|
|<img width="500" alt="ランキング機能" src="https://user-images.githubusercontent.com/100008647/213901857-5df11a74-4fa9-49f3-9cfd-a0569274225a.png">|<img width="500" alt="検索機能" src="https://user-images.githubusercontent.com/100008647/213901867-1642e8a3-5f5b-4c38-b2c4-9098ec9fd739.png">|
|管理者画面：ログイン|管理者画面：レビュー管理|
|<img width=“500” alt="admin_login" src="https://user-images.githubusercontent.com/100008647/213902568-3996284f-f700-492d-82f2-870e5431f89c.png">|<img width=“500” alt="reviews" src="https://user-images.githubusercontent.com/100008647/213902572-03e8a604-d033-4797-a06a-78cc5ac2590a.png">|
|管理者画面:おもちゃ管理|管理者画面：おもちゃ新規登録|
|<img width=“500” alt="toy" src="https://user-images.githubusercontent.com/100008647/213902566-6d5ef98f-87bd-4156-b41d-0b0c33060e00.png">|<img width=“500” alt="new_toy" src="https://user-images.githubusercontent.com/100008647/213902569-98718708-bfa2-4135-9e26-5ed4c7c9997c.png">|

その他の機能
* ユーザーログイン/新規登録/Twitterログイン
* お気に入り機能/コメント機能
* レビュー編集・削除
* 管理者画面：ユーザー管理
など

* * *  
## 使用技術
### バックエンド
* Ruby 3.1.2
* Ruby on Rails 6.1.6
* Node 16.14.0
### フロントエンド
* HTML/SCSS/JavaScript
* Vue.js 2.6.14
* TailwindCSS
  * daisyUI
### インフラ
* heroku
* Amazon S3
### 外部API
* Rakuten Ichiba API
* Twitter API  

* * *

## 画面遷移図
[figma](https://www.figma.com/file/0kEgh0YdCD7u3VnJ7Mcmpn/Catoy?node-id=0%3A1)  

## ER図
[diagrams.net](https://drive.google.com/file/d/18-ioA02iYqlv4fGvVUwO3ZK2ExQRgBEU/view?usp=sharing)  
[![Image from Gyazo](https://i.gyazo.com/8b4884bd63cc6af0b619e71dce184c3c.png)](https://gyazo.com/8b4884bd63cc6af0b619e71dce184c3c)
