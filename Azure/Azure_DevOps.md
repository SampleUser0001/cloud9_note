# Azure DevOps

- [Azure DevOps](#azure-devops)
  - [ssh-key登録](#ssh-key登録)
    - [鍵作成](#鍵作成)
    - [公開鍵登録](#公開鍵登録)
    - [~/.ssh/config](#sshconfig)
    - [参考](#参考)
  - [プルリクエストのフォーマットファイル登録](#プルリクエストのフォーマットファイル登録)
    - [参考](#参考-1)
  - [プルリクエストのコンフリクト検出](#プルリクエストのコンフリクト検出)
    - [コンフリクトが発生するプルリクエストが存在する場合](#コンフリクトが発生するプルリクエストが存在する場合)
    - [プルリクエスト作成 -\> マージ -\> コンフリクトが発生するプルリクエストを作成する](#プルリクエスト作成---マージ---コンフリクトが発生するプルリクエストを作成する)
  - [squashコミットとプルリクエストのCherry-pick](#squashコミットとプルリクエストのcherry-pick)
  - [Branch Security](#branch-security)
  - [Branch Policy](#branch-policy)

## ssh-key登録

### 鍵作成

``` bash
# azure_ssh_key_path=~/.ssh/azure_devops_ittimfn_rsa
ssh-keygen -t rsa -b 4096 -f ${azure_ssh_key_path} -C "Azureアカウントのメールアドレス"
ssh-add ${azure_ssh_key_path}

# 公開鍵の値をクリップボードにコピー
cat ${azure_ssh_key_path}.pub | xsel --clipboard --input
```

### 公開鍵登録

1. User settings -> SSH public Keys
2. New Key
3. 任意の名前、公開鍵をコピペ -> Add

### ~/.ssh/config

```
Host ssh.dev.azure.com
  HostName ssh.dev.azure.com
  User git
  IdentityFile ~/.ssh/azure_devops_ittimfn_rsa
  IdentitiesOnly yes
```

### 参考

- [SSH キー認証を使用する:Azure DevOps:Microsoft](https://learn.microsoft.com/ja-jp/azure/devops/repos/git/use-ssh-keys-to-authenticate?view=azure-devops)

## プルリクエストのフォーマットファイル登録

デフォルトブランチの下記ディレクトリにMarkdownファイルを配置する。  
```.azuredevops/pull_request_template/${任意のファイル名}```

PullRequest作成時、Descriptionの右に「Add a template」が出現する。  
作成時しか選択できないので、選択せずにPullRequestを作成してしまった場合は、ファイルからコピペする。

### 参考

- [テンプレートを使用して pull request の説明を改善する:Azure DevOps:Microsoft](https://learn.microsoft.com/ja-jp/azure/devops/repos/git/pull-request-templates?view=azure-devops)

## プルリクエストのコンフリクト検出

### コンフリクトが発生するプルリクエストが存在する場合

2つ目以降のプルリクエストのConflictsタブには何も出ない。  
実際にマージ時にConflictが発生する。戻せない？

### プルリクエスト作成 -> マージ -> コンフリクトが発生するプルリクエストを作成する

プルリクエストのConflictsタブに表示される。

## squashコミットとプルリクエストのCherry-pick

1. プルリクエストマージ時にsquashを選択すると、コミットが1つになる。
2. マージしたプルリクエストをcherry-pickすると、1つにされたコミットが分解される。
3. 再度1つにするかどうかは作成したプルリクエストをマージするタイミングで選択できる。

## Branch Security

1. Repos -> Branches
2. Allタブ -> ブランチ右ハンバーガー -> Branch Security

## Branch Policy

1. Project Setting(左下) -> Repositories -> リポジトリクリック
2. Policiesタブ -> Branch Policy -> ブランチクリック
3. Build Validation -> ハンバーガーメニュー -> Edit/View