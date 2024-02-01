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
    - [画面遷移](#画面遷移)
  - [Branch Policy](#branch-policy)
    - [概要](#概要)
    - [画面遷移](#画面遷移-1)
  - [Branch Control](#branch-control)
  - [Pipeline Permission](#pipeline-permission)
  - [プルリクエストApprove後にpushした場合](#プルリクエストapprove後にpushした場合)
    - [実行結果](#実行結果)
  - [Timezoneの設定](#timezoneの設定)
  - [プルリクエストマージの際にブランチが削除されないように設定する](#プルリクエストマージの際にブランチが削除されないように設定する)
    - [参考](#参考-2)
  - [ロールにユーザを登録する](#ロールにユーザを登録する)
  - [マニュアルURL](#マニュアルurl)

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

作成したブランチに対して各ロールができる/できないことを設定する。  
重要なのはContribute(マージの許可)とForcePush(Denyにする)。

### 画面遷移

1. Repos -> Branches
2. Allタブ -> ブランチ右ハンバーガー -> Branch Security

## Branch Policy

### 概要

**Q. Branch Policyは何を設定するメニューですか？**

ChatGPT 4による回答。

Azure DevOpsの「Branch Policy」は、特定のブランチに対して適用される一連のルールや要件を設定するためのメニューです。これらのポリシーは、コード品質の保持、コードレビューの強制、コードの統合プロセスの管理など、開発プロセスの一貫性と品質を確保するために使用されます。主なBranch Policyの設定項目には以下のようなものがあります：

1. **Require a Minimum Number of Reviewers**: このポリシーを有効にすると、プルリクエストが完了する前に特定の数のレビューアによる承認が必要になります。これにより、コードレビューの品質を保証します。

2. **Check for Linked Work Items**: このポリシーでは、プルリクエストが完了する前に、関連するワークアイテムへのリンクが必要になります。これにより、コードの変更とワークアイテムの追跡を関連付けることができます。

3. **Check for Comment Resolution**: このポリシーを有効にすると、プルリクエスト内のすべてのコメントが解決されるまでマージができなくなります。

4. **Enforce a Merge Strategy**: 特定のマージ戦略（例：スクワッシュマージ、リベースマージ）を強制します。これにより、コードベースの整合性と履歴の清潔さを保つことができます。

5. **Build Validation**: プルリクエストがマージされる前に、自動ビルドとテストが成功することを要求します。これにより、新たにマージされるコードが既存のコードベースと互換性があり、問題を引き起こさないことを保証します。

6. **Require Branch to be Up to Date**: プルリクエストがマージされる前に、対象のブランチが最新の状態に保たれていることを要求します。

これらのポリシーは、チームやプロジェクトのニーズに応じてカスタマイズし、プルリクエストのプロセスを効果的に管理するために設定されます。Branch Policyは、コードの品質を維持し、開発プロセスを標準化するための重要なツールです。

### 画面遷移

1. Project Setting(左下) -> Repositories -> リポジトリクリック
2. Policiesタブ -> Branch Policy -> ブランチクリック
3. Build Validation -> ハンバーガーメニュー -> Edit/View

## Branch Control

Azure PipelineでAgentサーバにビルド結果を配置することを認めるかどうかの設定。

1. Project Setting -> Pipelines -> Service Connections
2. 対象のサービスを選択
3. Approvals and checks

## Pipeline Permission

AgentサーバでPipelineの実行を認めるか。

1. Project Settings -> Pipelines -> Agent Pools
2. 対象のAgent Poolを選択
3. Securityタブクリック
4. Pipeline PermissionにPipelineを追加

## プルリクエストApprove後にpushした場合

下記の操作を行ったときの挙動を記載する。

1. プルリクエストを作成する。
2. Approve設定する。
3. targetブランチにpushする。

### 実行結果

- Approveは解除されない。
- targetブランチが更新されたことはプルリクエストのログに出力される。
    - Approve設定したこともログに出力されるため、Approve後にpushされた場合は確認できる。

## Timezoneの設定

プルリクエストのマージ時のタイムゾーンはデフォルトだとUTCになる。  
設定変更を行う。

1. Organization Homeを開く。
2. Organization Settings（左下）をクリックする。
3. Overview -> Time zoneを変更する。

## プルリクエストマージの際にブランチが削除されないように設定する

ForcePushをDenyにすればOK。
[BranchSecurity](#branch-security)を参照。

### 参考

- [ブランチ ポリシーと設定 : Azure DevOps](https://learn.microsoft.com/ja-jp/azure/devops/repos/git/branch-policies?view=azure-devops&tabs=browser)

## ロールにユーザを登録する

1. Azure DevOps Top
2. Organization Setting
3. Security - Permissions
4. Users タブ
5. ユーザ選択 -> Member ofタブ

## マニュアルURL

- [https://learn.microsoft.com/ja-jp/azure/devops/?view=azure-devops](https://learn.microsoft.com/ja-jp/azure/devops/?view=azure-devops)