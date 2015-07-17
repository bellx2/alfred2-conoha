# alfred2-conoha

Alfred 2用でConoHaVPSのコントロールパネルを開くWorkflowです。
また、電源状態についてもコントロールパネルを開かずにわかります

## 前提

+ Alfred2のWorkflowを実行するためにはPowerPackが必要です。
+ ConoHaVPS契約とAPIキーが事前に必要です。

## インストール方法

ConoHa.workflowをダウンロードするとAlfred2で開きますので「import」を押します

## 利用方法

Alfred2より以下のコマンドを使うことができます

### conoha setup / APIキーの設定
> Conoha setup [APIUser] [APIPassword]

設定はローカルのAlfred環境設定に書き込まれます。Dropbox同期には非対応です。

### conoha / VPS一覧
> Conoha

表示されたVM名をクリックするとコントロールパネルが開きます

