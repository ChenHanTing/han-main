# side project

### 規劃

1. 導覽列
   - 左邊：各網站連結
   - 右邊：登入、登出、註冊、翻譯
2. 靜態網站
   - 提供每日恭讀的禪行週報、佛曲、心得體悟
   - 樂透產生器、九宮格（弟弟學校作業）
   - BMI 計算機（使用form_tag）
   - 名字表單（使用原生form）
   - 其他頁面（將好看的版型收編）
   - 個人頁面：內含筆記連結

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/resume.jpg)

4. Devise
   - 註冊欄位：email, username, password, password_confirm, admin、頭像（drag and drop）
   - 參考網址：
     - https://github.com/plataformatec/devise
     - 使用 username 或 email 登入：https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign_in-using-their-username-or-email-address
     - 在導覽列下面寫篩選條件，依照使用者、創建時間 create_at、更新時間update_at。

6. 全域功能

   - 網站需要國際化，預計先設定繁體中文與英文

   - 使用ahoy：https://github.com/ankane/ahoy

     ahoy 會新增兩個表：Events, Visits，以紀錄使用者進行的行為

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/ahoy_events.jpg)

7. 實驗室版

   - 目的：給研究所同學用

   - 具發文、按讚、留言功能、開放/關閉討論

   - `new`, `create`, `delete`行為使用JS

   - 在`index`頁面可以看到封面照片

   - 在`LabForum`的`model`定義常數

     參考網址[1]：http://simple-form-bootstrap.plataformatec.com.br/documentation

     參考網址[2]：https://stackoverflow.com/questions/4110866/ruby-on-rails-where-to-define-global-constant

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/lab_forum.jpg)

8. 代辦清單
   - 功能：只能看自己發文、解決/未解決狀態切換
   - 具發文功能
   - 練習`RESTful API`及`Form`

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/todolists.jpg)

9. 聊天室
   - 參考範例實作，並沒有太多變化
   - 練習使用 websocket 及 redis

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/chatroom.jpg)

10. blazer
    - 功能：最高權限使用者能使用Blazer，透過query指令查看資料庫
    - 目的：查看資料庫、將ahoy所記錄資訊畫成圖表
    - 規劃：加入排程執行動作

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/blazer.jpg)

11. API
    - 功能：將姓與名拼起來，若錯誤則吐出錯誤訊息及伺服器錯誤
    - 規劃：將Token概念加入並實作
    - 使用ping
    - 使用`Token`辨識devise user

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/api_failure.jpg)

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/api_success.jpg)

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/ping.jpg)

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/sign_in.jpg)

![image](https://github.com/ChenHanTing/side-project/blob/master/note-pic/ping_auth.jpg)

### 部署

deploy@140.**************.219 的詳細資料

```text
全名 []: hanting
房間號碼 []: as********6
工作電話 []: 0983168969
住家電話 []: 0229913688
其它 []:

Your identification has been saved in /home/deploy/.ssh/id_rsa.
Your public key has been saved in /home/deploy/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:ryhW/TNFoUHG+3phxnLiWIKXFup8F6QPHrMCI3EeBpw han@jvdiamondtech.com
The key's randomart image is:
+---[RSA 2048]----+
| . .     oo      |
|  E      .o .    |
|   .       + .   |
|  . +   . + .    |
|   = . +S= +     |
|  . + + @.= O    |
|   . * + %.X .   |
|    o +.=.O .    |
|   . ..o.. +     |
+----[SHA256]-----+


```

部署指令

```text
sudo su deploy
cap production deploy:check

sudo su hanting
cap production hanting:check
```

遇到問題：

1. 沒有非最高權限的密碼：自己設定

2. Capistrano mkdir permission denied：https://stackoverflow.com/questions/24470520/capistrano-mkdir-permission-denied

3. ERROR linked file `/shared/config/database.yml` does not exist：https://ruby-china.org/topics/16259

4. Rails佈署到ubuntu流程：https://motion-express.com/blog/%E5%B0%87rails%E4%BD%88%E7%BD%B2(deploy)%E5%88%B0vps%E4%B8%8A

目前進度：

1. 在 `user@EE911-PC03:/var/www/side-project` 資料夾裡面有以下這些檔案

   ````shell
   user@EE911-PC03:/var/www/side-project
   
   drwxrwxr-x 5 hanting hanting 4096 12月 28 09:55 ./
   drwxr-xr-x 4 hanting hanting 4096 12月 28 07:59 ../
   lrwxrwxrwx 1 hanting hanting   45 12月 28 09:55 current -> /var/www/side-project/releases/20191228015507/
   drwxrwxr-x 3 hanting hanting 4096 12月 28 10:04 releases/
   drwxrwxr-x 7 hanting hanting 4096 12月 28 09:55 repo/
   -rw-rw-r-- 1 hanting hanting  103 12月 28 09:55 revisions.log
   drwxrwxr-x 7 hanting hanting 4096 12月 28 08:23 shared/
   ````

   website only show "welcome to nginx"

   在`current`資料夾無法跑`rails db:create`

### 修網站

外觀修正

- alert, notice 提示套用Bootstrap：[https://wualnz.com/Rails-%E7%94%A8-Bootstrap-%E5%BF%AB%E9%80%9F%E5%AE%A2%E8%A3%BD%E5%8C%96-alert-notice-flash-message%E5%BF%AB%E9%96%83%E8%A8%8A%E6%81%AF/](https://wualnz.com/Rails-用-Bootstrap-快速客製化-alert-notice-flash-message快閃訊息/)
- 導覽列與內文拉開距離：https://stackoverflow.com/questions/26867846/what-is-the-best-way-to-add-some-space-after-bootstrap-navbar/26867920
- 按鈕：https://www.bestcssbuttongenerator.com/
- Flex：https://getbootstrap.com/docs/4.4/utilities/flex/
- Enum 使用方法：https://sipsandbits.com/2018/04/30/using-database-native-enums-with-rails/
- Box shadow：https://www.peeayecreative.com/how-to-match-divi-box-shadows-with-css/
- Vscode 不留空白設定：https://stackoverflow.com/questions/30884131/remove-trailing-spaces-automatically-or-with-a-shortcut
- ArgumentError: '0' is not a valid status：https://stackoverflow.com/questions/48509715/argumenterror-in-new-for-an-enum-parameter-in-rails-5-1
- Heroku
  - 查詢pg名字： https://devcenter.heroku.com/articles/heroku-postgresql
  - 重置db：https://stackoverflow.com/questions/4820549/how-to-empty-a-heroku-database
- Add column to table：https://stackoverflow.com/questions/4834809/adding-a-column-to-an-existing-table-in-a-rails-migration
- 驗證：https://ihower.tw/rails/activerecord-lifecycle.html
- rails g model, resource, scaffold：http://www.korenlc.com/rails-generate-model-vs-resourse-vs-scaffold/ 
- Inverse_of 雙向關聯：https://rails.ruby.tw/association_basics.html
- 啟用Heroku Redis：https://learningsky.io/node-js-express-heroku-redis/
- Readme 加入圖片的方法：[https://medium.com/@stephyang/%E5%9C%A8github%E7%9A%84readme-md%E5%8A%A0%E5%85%A5%E5%9C%96%E7%89%87%E5%8F%8Agif%E7%9A%84%E6%96%B9%E6%B3%95-7282a4a63141](https://medium.com/@stephyang/在github的readme-md加入圖片及gif的方法-7282a4a63141)

實作網站

- 實作聊天室：https://iridakos.com/programming/2019/04/04/creating-chat-application-rails-websockets
- Ruby Design Pattern：https://refactoring.guru/design-patterns

Action Cable

- gorails：https://gorails.com/episodes/tagged/ActionCable
- 範例：
  - https://github.com/PENGZhaoqing/RailsChat
  - https://www.sitepoint.com/create-a-chat-app-with-rails-5-actioncable-and-devise/
  - https://scotch.io/tutorials/asynchronous-chat-with-rails-and-actioncable

### Devise

#### 問題1. 

打api出現問題，轉址到一般登入畫面：

````text
Started POST "/users/sign_in" for 127.0.0.1 at 2020-01-08 08:28:44 +0800
Processing by Auth::SessionsController#create as */*
  Parameters: {"user"=>{"login"=>"chenhanhanhan", "password"=>"[FILTERED]"}, "session"=>{"user"=>{"login"=>"chenhanhanhan", "password"=>"[FILTERED]"}}}
  User Load (0.5ms)  SELECT  `users`.* FROM `users` WHERE `users`.`id` = 2 ORDER BY `users`.`id` ASC LIMIT 1
  ↳ /Users/chenhanting/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/activerecord-5.2.4.1/lib/active_record/log_subscriber.rb:98
Redirected to http://api.lvh.me:3001/?locale=zh-TW

Filter chain halted as :require_no_authentication rendered or redirected
Completed 302 Found in 6ms (ActiveRecord: 0.5ms)
````

解答：

If you currently signed in, the devise does not allow some actions like sign up for a new users. You can try to overriding methods, which comes from Devise::RegistrationsController:

````ruby
prepend_before_action :require_no_authentication, only: :cancel 
````

參考資料：https://github.com/plataformatec/devise/issues/4524

#### 問題2. 

目前遇到`Rails.cache.read`讀不到`Rails.cache.write`的內容物

解法：創`tmp/caching-dev.txt`即可

關鍵字：`cache_store`

在`config/environments/development.rb`設定檔

````ruby
  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end
````

以上可以使用redis進行設定，讓Cache存進redis，就不用新開`tmp/caching-dev.txt`檔案

### 預計做

- 實作PNG轉JPG網站：https://png2jpg.com/
- 實作此廣告網站的畫面：
  - 參考範例：https://www.myvisionadvices.com/tw_official_pa2_sf/index.php?placement_id=1400558827&flight_id=1000021713&banner_id=w9s804dd578q7c2shjgbsr0q&hcountry_id=TAIWAN&hcity_id=Taipei&network=&keyword=&ad=&sitetarget=&apid=91738&cid=1184235
  - 切版範例參考（來自同事的codepen）：https://codepen.io/EvanSun/pens/public/?cursor=ZD0wJm89MSZwPTEmdj0zNDgwMDIyNw==

### 珍藏文章

1. console CRUD：https://ithelp.ithome.com.tw/articles/10188185
2. active record （query）: https://rails.ruby.tw/active_record_querying.html
3. active record（驗證） : https://rails.ruby.tw/active_record_validations.html
4. blog with comment : https://web-crunch.com/lets-build-with-ruby-on-rails-blog-with-comments/

### 參考資料

- 好用的偵錯工具：http://james1239090-blog.logdown.com/posts/738014-debug-on-ruby-on-rails-debug-mode

- 在rails app放上網站 icon：https://discoposse.com/2018/09/04/setting-your-favicon-in-ruby-on-rails-apps/

  快速製作網站 icon : https://logomakr.com/1jHFqR (png檔)

  png to ico : https://convertico.com/

- font-awesome : https://github.com/bokmann/font-awesome-rails

- git reset的三種模式，以及若做壞了怎麼辦？https://dotblogs.com.tw/wasichris/2016/04/29/225157

- toggle button 的參考資料（實用）：https://stackoverflow.com/questions/39594248/how-to-add-a-switch-toggle-button-to-simple-form-in-rails

- Ruby Bootstrap大全：https://fullscreen.github.io/bh/

- 請看如何使用devise（重要）：https://andyyou.github.io/2015/04/04/devise/

- Bootstrap 頁面

  - https://github.com/BlackrockDigital/startbootstrap-blog-post
  - https://startbootstrap.com/templates/blog-post/

- new, build, create, save方法詳述 : http://rubyer.me/blog/262/

