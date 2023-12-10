# Azure DevOps API

- [Azure DevOps API](#azure-devops-api)
  - [リポジトリIDを取得する](#リポジトリidを取得する)
  - [プルリクエストの情報を取得する](#プルリクエストの情報を取得する)
    - [値取得](#値取得)
  - [参考](#参考)

## リポジトリIDを取得する

``` bash
organization=
project=
Azure_DevOps_Token=
curl -s -u git:${Azure_DevOps_Token} https://dev.azure.com/${organization}/${project}/_apis/git/repositories?api-version=7.0 | jq -r '.value[] | [.name, .id] | @csv'
```

## プルリクエストの情報を取得する

``` bash
organization=
project=
Azure_DevOps_Token=
repository_id=
pullrequest_id=
curl -s -u git:${Azure_DevOps_Token} https://dev.azure.com/${organization}/${project}/_apis/git/repositories/${repository_id}/pullrequests/${pullrequest_id}?api-version=7.0
```

### 値取得

```bash
# リポジトリ名
jq '.repository | .project | .name ' -r

# プルリクエストID
jq '.pullRequestId' -r

jq '.sourceRefName' -r
jq '.targetRefName' -r
jq '.title' -r

```

## 参考

- [公式](https://learn.microsoft.com/ja-jp/rest/api/azure/devops/?view=azure-devops-rest-7.1)