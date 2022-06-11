# Github

- [Github](#github)
  - [sshでgit pushする](#sshでgit-pushする)
    - [参考](#参考)
  - [Githubの認証をトークンに変更する](#githubの認証をトークンに変更する)
    - [概要](#概要)
    - [手順](#手順)
    - [参考](#参考-1)

## sshでgit pushする

キーは設定済の前提で・・・

``` bash
GITHUB_USERNAME=
GITHUB_REPOSITORY=
git remote set-url origin git@github.com:$GITHUB_USERNAME/$GITHUB_REPOSITORY.git
git push origin master
```

### 参考

- [GitHubでssh接続する手順~公開鍵・秘密鍵の生成から~:Qiita](https://qiita.com/shizuma/items/2b2f873a0034839e47ce)

## Githubの認証をトークンに変更する

### 概要

Github の認証をプライベートトークンに変更する。  
Github のパスワード認証が使用できなくなるらしい。

### 手順

1. Github → 右上のユーザアイコン → Settings → Developer settings → Personal access tokensをクリック。
2. Generate new tokenをクリック。
3. 名前と権限を設定 → Generate tokenをクリック。
4. トークンが発行される。以後、トークンをパスワードとして扱う。
5. 設定対象のgit アカウントのコンソールで下記を入力。

    ```bash
    git config --global credential.helper store
    ```

6. 認証を行う。パスワード入力時に、手順4で表示されているトークンを入力する。
7. 終了。

### 参考

- [Gigazine:GitHubがGit操作時のパスワード認証を廃止、今後はトークンによる認証が必須に](https://gigazine.net/news/20201219-github-token-git-operations/)
- [The GitHub Blog : Token authentication requirements for Git operations](https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/)
- [GitHub Docks :個人アクセストークンを使用する](https://docs.github.com/ja/free-pro-team@latest/github/authenticating-to-github/creating-a-personal-access-token)
- [Qiita:Gitのパスワードを保存する方法](https://qiita.com/is_mgmt_dept/items/81dc4558c0478e533e03)