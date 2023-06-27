# Azure DevOps API

- [Azure DevOps API](#azure-devops-api)
  - [リポジトリIDを取得する](#リポジトリidを取得する)
  - [参考](#参考)

## リポジトリIDを取得する

``` bash
organization=
project=
curl -s -u git:${Azure_DevOps_Token} https://dev.azure.com/ittimfn/SampleProject/_apis/git/repositories?api-version=7.0 | jq -r '.value[] | [.name, .id] | @csv'
```

## 参考

- [公式](https://learn.microsoft.com/ja-jp/rest/api/azure/devops/?view=azure-devops-rest-7.1)