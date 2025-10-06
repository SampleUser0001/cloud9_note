# SpringBootでパスワードを暗号化する

- [SpringBootでパスワードを暗号化する](#springbootでパスワードを暗号化する)

## 質問

``` txt
SpringBootでパスワードを暗号化してDBに保存して認証する場合、テーブルにアクセスする方法はこれで、ログインIDはこのカラムで、パスワードはこの項目で、暗号化方式はこれで、暗号化に使う項目とソルトはこれ・・・みたいなことを設定ファイルに書くだけでできたりしませんか？
```

## 回答

短答：
「設定ファイルだけ」で既存テーブルの列名やソルトの列まで柔軟に指定して“ノーコード”で認証…は、Spring Security では基本できません。**最小限のJavaConfig（数十行）**は必要です。
ただしやることはシンプルで、「SQL と PasswordEncoder を Bean で差し替える」だけです。設定ファイルは主に DataSource などの接続情報に使います。

---

### 典型解（既存のユーザーテーブルをそのまま使う）

* 方式：`JdbcUserDetailsManager` を使い、**ユーザー取得SQL**と**権限取得SQL**を差し替える
* パスワード：**BCrypt**（塩はハッシュ内に埋め込まれるので別カラム不要・推奨）

#### application.yml（接続だけ設定）

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/appdb
    username: appuser
    password: secret
    driver-class-name: org.postgresql.Driver
  # JPAを使うならdialect等は適宜
```

#### セキュリティ設定（最小構成・Spring Security 6+）

```java
// src/main/java/com/example/security/SecurityConfig.java
package com.example.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import javax.sql.DataSource;
import org.springframework.security.provisioning.JdbcUserDetailsManager;

@Configuration
public class SecurityConfig {

  @Bean
  SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    http
      .authorizeHttpRequests(auth -> auth
        .requestMatchers("/login", "/css/**", "/js/**").permitAll()
        .anyRequest().authenticated()
      )
      .formLogin(Customizer.withDefaults())
      .logout(Customizer.withDefaults());
    return http.build();
  }

  // パスワードは {bcrypt} 付きでも無しでもOK（無しなら下のエンコーダ一本で）
  @Bean
  PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder(); // コストはデフォルト 10。必要に応じて new BCryptPasswordEncoder(12) など
  }

  // 既存テーブルに合わせてクエリを差し替える
  @Bean
  JdbcUserDetailsManager jdbcUserDetailsManager(DataSource dataSource) {
    JdbcUserDetailsManager mgr = new JdbcUserDetailsManager(dataSource);
    // 例: users(id, login_id, password_hash, enabled)
    mgr.setUsersByUsernameQuery("""
      SELECT login_id AS username, password_hash AS password, enabled
      FROM users
      WHERE login_id = ?
    """);
    // 例: user_roles(user_id, role) / users.id と結合
    mgr.setAuthoritiesByUsernameQuery("""
      SELECT u.login_id AS username, r.role AS authority
      FROM user_roles r
      JOIN users u ON r.user_id = u.id
      WHERE u.login_id = ?
    """);
    return mgr;
  }
}
```

#### 使う列の対応関係（上の例）

* ログインID列：`users.login_id`
* パスワード列：`users.password_hash`（**BCrypt**のハッシュ）
* 有効フラグ：`users.enabled`（`boolean` / `tinyint` など）
* 権限列：`user_roles.role`（値は `ROLE_USER` 等）

> ※ BCrypt は**毎回ランダムソルトを内部に保持**するため、**ソルト専用カラムは不要**です。
> 既存のレガシー形式（別カラムのソルト）をどうしても使うなら、**独自 `PasswordEncoder` 実装**や独自認証プロバイダが必要になり、設定ファイルだけでは完結しません（非推奨）。

---

### ほぼ“設定だけ”でやりたい場合の代替

* **Spring Security 既定スキーマ**（`users` / `authorities`）に**テーブル構造を合わせられる**なら、`JdbcUserDetailsManager` のクエリ差し替えすら不要になります（それでも `PasswordEncoder` の Bean は必要）。
* 逆に**列名やテーブルを変えたまま**行きたいなら、上記の**JavaConfig数十行**が最短・定番です。

---

### パスワードの作成例（BCrypt）

```java
var encoder = new org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder();
System.out.println(encoder.encode("plain-password"));
// => $2a$10$... のような文字列（ソルト入り）
```

DB の `password_hash` にはこの値を保存します。`{bcrypt}` プレフィックスを付けたい場合は
`{bcrypt}$2a$10$...` のように保存しておくと、`DelegatingPasswordEncoder` を使う構成でも識別できます。

---

### まとめ

* **完全に設定ファイルだけ**で「好きな列名・好きなソルト列」を指定して認証…は×。
* 実務的には **`JdbcUserDetailsManager` にクエリを2本設定**＋**`PasswordEncoder` を1本用意**で終わり。
* ソルト列は不要（**BCrypt 推奨**）。レガシーなソルト列を使うなら**独自実装が必要**。

必要なら、あなたの既存スキーマ（テーブル名・列名）に合わせて、即動くクエリと設定をこちらで書き起こします。
