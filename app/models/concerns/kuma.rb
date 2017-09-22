module Kuma
  require 'flickraw'
  require 'yoshida'

  Dotenv.load
  FlickRaw.api_key = ENV["FLICKER_API_KEY"]
  FlickRaw.shared_secret = ENV["FLICKER_API_SECRET"]

  KUMA_TITLES01 = %W(くま クマ 熊 ベアー BEAR くまくま KUMA)
  KUMA_TITLES02 = %W(人生 日和 生活 大会 会議 画像 戦争 ごはん 学校 ダンス 協会 集団 牧場 大回転 温泉 暴走 元気 体操 精神 パワー カラオケ 会談 踊り)
  KUMA_TITLES03 = %W(くま くま？ くま！ くまー くまっ くまーーー くまʕ•ᴥ•ʔ くま(ᵔᴥᵔ) くま(￣(工)￣) くまฅʕ•ᴥ•ʔฅ)

  KUMA_CONTENTS01 = %W(最近は この人は あなたは くま会議で くまも歩けば 今日も一日 今日は いつものように 今回は この日はずっと 見れば見るほど よい気分なので これを見て そういえば 実を言うと いつも思うのだけど やっぱり そうは言っても それでもなお それって実は くまが歌うと くまが出てきて 皆さんご一緒に くまパワーで)
  KUMA_CONTENTS02 = %W(たのしい ねむい おいしい おもしろい おそろしい かなしい うれしい おいしそう おなかがへった 踊りたい 食べたい 逃げたい 歌をうたう ダンスダンスダンス クマトルネード 冬眠する くまごはん 転がり続ける めでたい レッツ 毛皮が暑い ハングリー 満腹 熊野詣で 熊本県 くま生活 くまの生き様 くま根性 くまの一念 くま大会 ハチミツ食べる シャケを狩る お嬢さんお逃げなさい)
  KUMA_CONTENTS03 = %W|くま くま？ くま！ くまー くまっ くまーーー くまʕ•ᴥ•ʔ くま(ᵔᴥᵔ) くま(￣(工)￣) くま・・・ くまくま！ く、くまー くまฅʕ•ᴥ•ʔฅ くまʕ´•ᴥ•`ʔ くまʕ￫ᴥ￩ʔ くまʕ•ɷ•ʔฅ くまʕ•̀ω•́ʔ✧ くまʕ·ᴥ·ʔ♡*:.✧ くまーฅ(•̀㉨•́)ฅ くま？ʕ•㉦•ʔ くま！ʕ◕‧̫◕ʔ
 くまー۶ฅﻌｰ`.｡o くま！ʕ•̀ω•́ʔ✧ くま…ʕ•ﻌ•;ʔ くまーʕ´•ﻌ•`ʔ くまฅʕ•̫͡•ʔฅ くま！ʕ•̬͡•ʔ|

  def kuma_title
    random = Random.new
    title = KUMA_TITLES01[random.rand(KUMA_TITLES01.length)] + KUMA_TITLES02[random.rand(KUMA_TITLES02.length)] + KUMA_TITLES03[random.rand(KUMA_TITLES03.length)]
    return title
  end
  def kuma_title_turezure
    random = Random.new
    title = Yoshida::Text.word + KUMA_TITLES03[random.rand(KUMA_TITLES03.length)]
    return title
  end
  def kuma_title_panda
  random = Random.new
  title = KUMA_TITLES01[random.rand(KUMA_TITLES01.length)] + KUMA_TITLES02[random.rand(KUMA_TITLES02.length)] + KUMA_TITLES03[random.rand(KUMA_TITLES03.length)]
  title.gsub!(/くま/, "ぱんだ")
  title.gsub!(/クマ/, "パンダ")
  title.gsub!(/熊/, "大熊")
  title.gsub!(/KUMA/, "PANDA")
  title.gsub!(/BEAR/, "PANDA")
  return title
  end

  def kuma_content
    random = Random.new
    content = KUMA_CONTENTS01[random.rand(KUMA_CONTENTS01.length)] + KUMA_CONTENTS02[random.rand(KUMA_CONTENTS02.length)] + KUMA_CONTENTS03[random.rand(KUMA_CONTENTS03.length)] + " " + KUMA_CONTENTS01[random.rand(KUMA_CONTENTS01.length)] + KUMA_CONTENTS02[random.rand(KUMA_CONTENTS02.length)] + KUMA_CONTENTS03[random.rand(KUMA_CONTENTS03.length)]
    return content
  end
  def kuma_content_turezure
    content = Yoshida::Text.sentences.join
    content.gsub!(/。/, "くま。")
    return content
  end
  def kuma_content_panda
    random = Random.new
    content = KUMA_CONTENTS01[random.rand(KUMA_CONTENTS01.length)] + KUMA_CONTENTS02[random.rand(KUMA_CONTENTS02.length)] + KUMA_CONTENTS03[random.rand(KUMA_CONTENTS03.length)] + " " + KUMA_CONTENTS01[random.rand(KUMA_CONTENTS01.length)] + KUMA_CONTENTS02[random.rand(KUMA_CONTENTS02.length)] + KUMA_CONTENTS03[random.rand(KUMA_CONTENTS03.length)]
    content.gsub!(/くま/, "ぱんだ")
    content.gsub!(/クマ/, "パンダ")
    content.gsub!(/く、くまー/, "パ、パンダー")
    return content
  end

  def kuma_image
    word = "くま, クマ, 熊, bear" # 検索タグ
    random = Random.new
    images = flickr.photos.search(tags: word, sort: "relevance", per_page: 100, tag_mode: "all")
    image = images[random.rand(images.length)]
    url = FlickRaw.url image
    return url
  end
  def kuma_image_turezure
    word = "神社, 寺" # 検索タグ
    random = Random.new
    images = flickr.photos.search(tags: word, sort: "relevance", per_page: 100, tag_mode: "all")
    image = images[random.rand(images.length)]
    url = FlickRaw.url image
    return url
  end
  def kuma_image_panda
    word = "パンダ, ぱんだ, panda" # 検索タグ
    random = Random.new
    images = flickr.photos.search(tags: word, sort: "relevance", per_page: 100, tag_mode: "all")
    image = images[random.rand(images.length)]
    url = FlickRaw.url image
    return url
  end
end
