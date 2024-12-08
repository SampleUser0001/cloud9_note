# Gson

- [Gson](#gson)
  - [pom.xml](#pomxml)
  - [通常の読み込み](#通常の読み込み)

## pom.xml

``` xml
    <!-- Gson -->
    <dependency>
        <groupId>com.google.code.gson</groupId>
        <artifactId>gson</artifactId>
        <version>2.11.0</version>
    </dependency>
```

## 通常の読み込み

``` json
{
    "auth": "https://account.box.com/api/oauth2/authorize",
    "token" : "https://api.box.com/oauth2/token"
}
```

``` java
package ittimfn.tool.oauth2.common.model;

import java.io.FileReader;

import com.google.gson.Gson;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class EndpointModel {

    public EndpointModel(String jsonpath) {
        Gson gson = new Gson();

        try (FileReader reader = new FileReader(jsonpath)) {
            // JSONファイルをUserオブジェクトにマッピング
            EndpointModel endpoint = gson.fromJson(reader, EndpointModel.class);
            this.auth = endpoint.getAuth();
            this.token = endpoint.getToken();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to read json file : " + jsonpath);
        }
    }
    private String auth;
    private String token;
}

```

