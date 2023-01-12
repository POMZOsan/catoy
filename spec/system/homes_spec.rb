require 'rails_helper'

RSpec.describe "Homes", type: :system do
  describe '/' do
    it 'shows site explanation' do
      visit root_path
      expect(page).to have_content "What's catoy?"
      expect(page).to have_content "catoyは猫ちゃんが気に入るおもちゃを見つけられない飼い主さんに"
      expect(page).to have_content "猫のおもちゃのレビューを共有し"
      expect(page).to have_content "レビューから猫ちゃんの性格に合うおもちゃを見つけられるサービスです"

      expect(page).to have_content "Happy?"
      expect(page).to have_content "猫ちゃんはそのおもちゃに満足していますか？"
      expect(page).to have_content "もし満足していないならcatoyで猫ちゃんが気に入るおもちゃを探してみましょう!"

      expect(page).to have_content "Shopping!"
      expect(page).to have_content "気になるレビューがありましたか？"
      expect(page).to have_content "catoyではレビューから商品サイトでおもちゃを買うことができます"

      expect(page).to have_content "Review!"
      expect(page).to have_content "おもちゃのレビューを投稿してみましょう！"
      expect(page).to have_content "あなたのレビューが他の飼い主さんを助けるかもしれません！"
    end

    describe '/kiyaku' do
      it 'shows 利用規約' do
        visit kiyaku_path
        expect(page).to have_content "利用規約"
        expect(page).to have_content "この利用規約（以下，「本規約」といいます。）は、catoy（以下，「当社」といいます。）がこのウェブサイト上で提供するサービス（以下，「本サービス」といいます。）の利用条件を定めるものです。登録ユーザーの皆さま（以下，「ユーザー」といいます。）には，本規約に従って，本サービスをご利用いただきます。"
        expect(page).to have_content "第1条（適用）"
        expect(page).to have_content "第2条（利用登録）"
        expect(page).to have_content "第3条（ユーザーIDおよびパスワードの管理）"
        expect(page).to have_content "第4条（禁止事項）"
        expect(page).to have_content "第5条（本サービスの提供の停止等）"
        expect(page).to have_content "第6条（利用制限および登録抹消）"
        expect(page).to have_content "第7条（退会）"
        expect(page).to have_content "第8条（保証の否認および免責事項）"
        expect(page).to have_content "第9条（サービス内容の変更等）"
        expect(page).to have_content "第10条（利用規約の変更）"
        expect(page).to have_content "第11条（個人情報の取扱い）"
        expect(page).to have_content "第12条（通知または連絡）"
        expect(page).to have_content "第13条（権利義務の譲渡の禁止）"
        expect(page).to have_content "第14条（準拠法・裁判管轄）"
        expect(page).to have_content "2022年11月03日 制定"
      end

      describe '/privacy_policy' do
        it 'shows プライバシーポリシー' do
          visit privacy_policy_path
          expect(page).to have_content "プライバシーポリシー"
          expect(page).to have_content "catoy（以下，「当社」といいます。）は，本ウェブサイト上で提供するサービス（以下,「本サービス」といいます。）における，ユーザーの個人情報の取扱いについて，以下のとおりプライバシーポリシー（以下，「本ポリシー」といいます。）を定めます。"
          expect(page).to have_content "お客様から取得する情報"
          expect(page).to have_content "お客様の情報を利用する目的"
          expect(page).to have_content "安全管理のために講じた措置"
          expect(page).to have_content "第三者提供"
          expect(page).to have_content "アクセス解析ツール"
          expect(page).to have_content "プライバシーポリシーの変更"
          expect(page).to have_content "2022年11月03日 制定"
        end
      end
    end

  end

end
