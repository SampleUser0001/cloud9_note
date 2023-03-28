# Azure DevOps

- [Azure DevOps](#azure-devops)
  - [ssh-key登録](#ssh-key登録)
    - [鍵作成](#鍵作成)
    - [公開鍵登録](#公開鍵登録)
    - [~/.ssh/config](#sshconfig)
    - [参考](#参考)
  - [プルリクエストのフォーマットファイル登録](#プルリクエストのフォーマットファイル登録)
    - [参考](#参考-1)

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

### 参考

- [テンプレートを使用して pull request の説明を改善する:Azure DevOps:Microsoft](https://learn.microsoft.com/ja-jp/azure/devops/repos/git/pull-request-templates?view=azure-devops)